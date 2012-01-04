#encoding: utf-8

from Types import *
from PXDParser import CPPClass, Enum, parse
from CodeGenerator import Code
import os


def id_from(python_expression):
    # translate ()/[]. et al
    return python_expression.replace("(","_bl_") \
                            .replace(")","_br_") \
                            .replace("]","_Br_") \
                            .replace("[","_Br_") \
                            .replace(".","_dt_")\
                            .replace("'","_sq_")\
                            .replace('"',"_dq_")\
                            .replace(' ',"_")\
                            .replace(',',"_c_")\
                            .replace('*',"_ptr_")\
                            .replace('&',"_ref_")


class ToCppConverters(object):

    def __init__(self, classes_to_wrap):
        self.converters = set()
        self.classes_to_wrap = classes_to_wrap

    def get(self, from_, to, var):

        decl = Code()
        init = Code()
        cleanup = Code()

        # no extra functions for wrapped classes
        if from_ in self.classes_to_wrap:
            return decl, init, "deref(%s.inst)" % var, cleanup

        if from_ == "str" and to.matches("char", is_ptr=True):
           return decl, init, "PyString_AsString(%s)" % var, cleanup

        # basis types are not wrapped, maybe casted:
        if not to.is_ptr:
           if to.basetype in ["float", "double","int", "long", "bool"]:
               if from_ in ["float", "int", "long", "unsigned int", 
                                                            "unsigned long"]:
                   return decl, init, var, cleanup
           if to.is_enum and from_ in ["int", "long"]:
                   return decl, init, "<%s>%s" % (to.basetype, var), cleanup

        # register conversion class
 
        # IN ORDER TO AVOID COPYING AND GENERATRION OF DUPLICATE C++
        # CLASSES, THE CONVERTER CLASSES CONV() METHOD ALLWAYS HAS To RETURN
        # A POINTER !!!!

        py_name = id_from(from_)
        cpp_name = id_from(cy_repr(to))
        clz_name = "__Py_%s_to_%s" % (py_name, cpp_name)

        inst_name = "conv_"+var
        decl += "cdef $clz_name $inst_name"
        decl.resolve(**locals())

        init += "$inst_name = $clz_name($var)"
        init.resolve(**locals())

        cleanup += "$inst_name.post_process($var)"
        cleanup.resolve(inst_name=inst_name, var=var)

        self.converters.add((clz_name, from_, to))

        if to.is_ptr:
            return decl, init, "%s.conv()" % inst_name, cleanup
        else:
            return decl, init, "deref(%s.conv())" % inst_name, cleanup

    def __iter__(self):
        return iter(self.converters)

class ToPyConverters(object):

    def __init__(self, classes_to_wrap):
        self.converters = set()
        self.classes_to_wrap = classes_to_wrap

    def get(self, to, var):
   
        # basetypes are not converted, var -> var
        if not to.is_ptr  \
           and to.basetype in ["bool", "float", "double","int", "long"]:
                   return var
        if to.is_ptr and to.basetype=="char":
            return var
        if to.is_enum:
            return var

        # register conversion function 
        cpp_name = id_from(cy_repr(to))
        name = "conv_%s_to_py" % cpp_name 
        self.converters.add((name, to))
        return "%s(address(%s))" % (name, var)

    def __iter__(self):
        return iter(self.converters)

    def __len__(self):
        return len(self.converters)

    def pop(self):
        return self.converters.pop()
        


class Generator(object):

    def __init__(self):
        self.classes_to_wrap = dict()
        self.cimports = []
        self.enums = set()

        self.to_cpp_converters = ToCppConverters(self.classes_to_wrap)
        self.to_py_converters = ToPyConverters(self.classes_to_wrap)

    def parse_all(self, sourcelist):

        self.enums = set()
        for source in sourcelist:
            p = parse(source)
            dirname = os.path.dirname(source)
            basename = os.path.basename(source)
            filename, _ = os.path.splitext(basename)
            pxdpath = ".".join([f for f in os.path.split(dirname) if f]
                               + [filename, ]
                              )
            cy_type = cy_repr(Type(p.name))
            self.cimports.append((pxdpath, p.name, cy_type))
            if p.wrap:
                self.classes_to_wrap[p.name] = p
            if p.type_.is_enum:
                self.enums.add(p.type_.basetype)

        # enum types are not recognized when parsing
        # method ards !?
        for c in self.classes_to_wrap.values():
            if c.type_.is_enum : continue # enum has no methods
            for methods in  c.methods.values():
                for method in methods:
                    if method.result_type.basetype in self.enums:
                        method.result_type.is_enum = True
                    for name, type_ in method.args:
                        if type_.basetype in self.enums:
                            type_.is_enum = True
        

    def generate_code_for(self, className):
        c = Code()
        obj = self.classes_to_wrap[className]
        if isinstance(obj, CPPClass):
            c  += self.generate_code_for_class(obj)
        elif isinstance(obj, Enum):
            c  += self.generate_code_for_enum(obj)
        return c


    def generate_import_statements(self):
        c = Code()
        # the += operator is clever enough to adjust identation of
        # the following lines:
        c += """
             from cython.operator cimport dereference  as deref
             from cython.operator cimport address      as address
             from cython.operator cimport preincrement as preincrement
             from cpython.string  cimport *
             from libcpp.vector cimport *
             from libcpp.pair   cimport *
             from libcpp.string cimport *
             from libc.stdlib cimport free
             """
        for pxdpath, name, cy_id in self.cimports:
            c += "from $pxdpath cimport $name as $cy_id"
            c.resolve(pxdpath=pxdpath, name=name, cy_id=cy_id)
        return c

    def generate_startup(self):
        co = Code()
        co += self.generate_import_statements()
        co += self.generate_helper_functions()
        return co

    def generate_helper_functions(self):
        
        """ generates string representation of a python type 
            supports only ints, floats, strs and lists with
            these types """

        return Code().addFile("included_helpers.py", indent=0)

    def generate_code_for_enum(self, enum):

        # as python has no enums, we simulate them by
        # declaring a class which only hass class attributes
        # coresponding to the enum values. eg
        #
        # cdef class TestEnum:
        #      In = 0
        #      Out = 1

        c = Code()
        c += "cdef class %s:" % enum.name
        for name, value in enum.items:
            c += "    $name=$value"
            c.resolve(name=name, value=value)
        return c

    def generate_code_for_class(self, clz):

        print
        print "wrap", clz.cy_repr

        c = Code()

        # the += operator is clever enough to adjust identation of
        # the following lines such that 'cdef clas...' has no identation
        # and the relative identation of the following lines is preserved
        c += """
             cdef class $py_name:                       

                 cdef $cy_repr * inst                   

                 def __cinit__(self):
                     self.inst = NULL

                 cdef _set_inst(self, $cy_repr * inst): 
                     if self.inst != NULL:              
                         del self.inst                  
                     self.inst = inst                   

                 def __dealloc__(self):                 
                     if self.inst != NULL:              
                         del self.inst                  
             """

        c.resolve(**clz.__dict__)

        c>>1

        # wrap constructors first as items in dict are not in insertion order:
        constructors = clz.methods.get(clz.name)
        if constructors:
            co = self.generate_code_for_constructor(clz, constructors)
            c += co

        for name, methods in clz.methods.items():
            # do not wrap constructors:
            if name == clz.name:
                continue
            c += self.generate_code_for_method(clz, name, methods)

        c<<1
        return c

    def generate_code_for_constructor(self, clz, methods):

        """
             supports overloaded constructors.
             the cython cons tries to match the python args against
             the signatures of the declared c++ constructors
             and calls an appropriate "subconstructor" for the match.

             therefore we generate a constructor and some
             subconstructors.
        """

        c = Code()
        c += """
             def __init__(self, *a, **kw):                     
                 _cons_sig = map(__sig, a)                 
                 if len(a)==0 and kw.get("_new_inst") is False:
                     return                                    
             """

        sub_constructors = []

        cy_type = clz.cy_repr

        for meth in methods:

            if not meth.wrap:
                continue
            if len(meth.args) == 1:
                argtype = meth.args[0][1]
                if argtype.basetype == clz.name:
                    # copy cons ? not wrapped  !
                    continue

            print "    wrap ", str(meth)

            # python types which can be converted to the c++ cons arg types
            deep_py_types = [pysig_for_cpp_type(t) for n, t in meth.args]
            cy_decls = [cy_decl(t) for n, t in meth.args]

            py_sig = ", ".join('"%s"' % t for t in deep_py_types)

            nargs = len(meth.args)
            a_unresolved = ", ".join("a[%d]" % i for i in range(nargs))

            subcons= "__subcons_for_"+ (id_from(py_sig.strip('"')) or "nonarg")

            # generate code which matches input args against available cons
            # and call subsons in case of success:
            cs = Code()
            cs>>1
            cs += """ 
                  if _cons_sig == [$py_sig]: 
                      self.$subcons($a_unresolved)
                      return
                  """
            cs.resolve(**locals())
            cs<<1
            c += cs
            
            converters = [self.to_cpp_converters.get(py_type, cpptype, "a%d"%i)
                              for i, (py_type, (_, cpptype)) 
                              in enumerate(zip(cy_decls, meth.args))]

            if converters:
                # unzip 4-tuples
                decls, inits, expressions, cleanups = zip(*converters) 
            else:
                decls, inits, expressions, cleanups = Code(), Code(), [], Code()

            args = ", ".join(expressions)
            subcons_sig = ", ".join("%s a%d" % (decl, i) 
                                    for i, decl in enumerate(cy_decls))
            sc=Code()
           
            sc += "cdef $subcons(self, $subcons_sig):"
            sc>>1
            sc += decls
            sc += inits
            sc += "self.inst = new $cy_type($args)"
            sc += cleanups
            sc.resolve(**locals())
            sc<<1

            sub_constructors.append(sc)

        # called in case of no match:
        c += '    raise Exception("input args %s do not match declaration" % _cons_sig)'

        # __init__() done, now add subconstructors:
        for subcons in sub_constructors:
            c += subcons
    
        return c

    def generate_code_for_method(self, clz, name, methods):

        methods = [m for m in methods if m.wrap]

        if not methods:
            return Code()

        if name.startswith("operator"):
            return self.generate_code_for_operator(clz, name, methods)

        if len(methods) != 1:
            info = ", ".join(map(str, methods))
            raise Exception("overloading for %s not supported yet" % info)

        method = methods[0]
        args = method.args
        name = method.name

        print "    wrap", name

        # take names if declared, else use ai
        arg_names = [n or ("arg%d" % i) for i, (n,t) in enumerate(args)]
        arg_types = [t for (n,t) in args]

        # types for decl of python extension method
        cy_decls = [cy_decl(t) for t in arg_types]

        cy_sig = ["%s %s" % (t,n) for (t,n) in zip(cy_decls, arg_names)]
        c = Code()
        c += "def $name (self, $cy_sig):   " 

        c.resolve(name=name, cy_sig=", ".join(cy_sig))

        # determine needed converters
        converters = [self.to_cpp_converters.get(cy_type, cpptype, n)
                      for cy_type, cpptype, n
                      in zip(cy_decls, arg_types, arg_names)] 

        if converters:
            # unzip 4-tuples
            decls, inits, expressions, cleanups = zip(*converters) 
        else:
            decls, inits, expressions, cleanups = Code(), Code(), [], Code()
           
        c>>1
        c += decls
        c += inits

        # call c++ method
        args = ", ".join(expressions)
        if method.result_type.basetype == "void":
            c += "self.inst.$name($args)" 
        else:
            cast = method.annotations.get("result_cast", "")
            c += "_result = $cast self.inst.$name($args)" 
        c.resolve(**locals())

        c += cleanups

        # return result, void functions return "self" for fluent interface
        if method.result_type.basetype == "void":
            c += "return self"
        else:
            conv = self.to_py_converters.get(method.result_type, "_result")
            c += "return %s" % conv

        c<<1
        return c

    def generate_code_for_operator(self, clz, name, methods):

        """ generates python methods for wrapping operators """

        if name == "operator[]":
            assert len(methods) == 1, "no overloading for operator[]"
            method = methods[0]
            assert len(method.args) == 1, "wrong signature for operator[]"
            argname, type_ = method.args[0]
            assert type_.basetype in ["int", "long"]
            assert not type_.is_ptr and type_.template_args is None

            co = Code()
            res_type = cy_repr(method.result_type)
            co += "def __getitem__(self, int idx):"
            co += "    cdef $res_type _result = deref(self.inst)[idx]"
            co.resolve(res_type=res_type)

            conv = self.to_py_converters.get(method.result_type, "_result")
            co += "    return %s" % conv
            return co

        elif name == "operator" or name=="operator()":  # cast ops
            co = Code()
            for method in methods:
                pn = py_name(method.result_type)
                defaultName = "to"+pn[0].upper()+pn[1:]
                name = method.annotations.get("name", defaultName)
                if name is None:
                    raise Exception("you have to provide a python name for "
                                    "%s" % method)

                cy_type = cy_repr(method.result_type)

                co += "def $name(self):"
                co += "    " + method.annotations.get("pre", "")
                co += "    cdef $cy_type _result = <$cy_type>deref(self.inst)"
                co.resolve(name=name, cy_type=cy_type)
                conv = self.to_py_converters.get(method.result_type, "_result")
                co +="    return %s" % conv

            return co

        else:
            raise Exception("wrapping of %r not supported yet" % methods[0].name)

    def generate_converters(self):

        c = Code()
        c += self.generate_from_py_converters()
        c += self.generate_to_py_converters()

        return c

    def generate_to_py_converters(self):    

        c = Code()
        # pop as some of the called generators register needed converters
        # in self.to_py_converters

        while len(self.to_py_converters):
            name, type_ = self.to_py_converters.pop()
    
            if type_.basetype == "vector":
                c += self.generate_vector_to_py(name, type_)

            if type_.basetype == "pair":
                c += self.generate_pair_to_py(name, type_)

            if type_.basetype in self.classes_to_wrap:
                c += self.generate_wrapped_class_to_py(name, type_)

            elif type_.basetype == "string":
                c += self.generate_string_to_py()
        
        return c

    def generate_from_py_converters(self):
    
        c = Code()
        for name, type_py, type_cpp in list(self.to_cpp_converters):
            if type_cpp.basetype == "vector":
                c += self.generate_list_to_vector(name, type_py, type_cpp)

        c += self.generate_py_str_to_string()
        return c

    def generate_py_str_to_string(self):
        c = Code()
        c += """
             cdef class __Py_str_to_string: 
                 cdef string * inst 
                 def __cinit__(self):
                      inst = NULL
                 def __init__(self, str arg):
                      self.inst = new string(PyString_AsString(arg))
                 cdef string * conv(self):
                      return self.inst
                 def post_process(self, arg):
                      #print "dealloc", self
                      if self.inst:
                          #print "kill"
                          del self.inst
             """ 
        return c

    def generate_list_to_vector(self, name, type_py, type_cpp):
        
        assert type_py == "list", type_py
        targs = type_cpp.template_args
        assert len(targs) == 1

        targ_type = targs[0]
        cy_type  = cy_decl(targ_type)
        
        cy_vector = cy_repr(type_cpp.without_ref())
        
        decl, init, expr, cleanup = self.to_cpp_converters.get(cy_type, 
                                                           targ_type, "item")
        c = Code()
        c += """
             cdef class $name:
                 cdef $cy_vector * inst
                 def __cinit__(self):
                      inst = NULL
                 def __init__(self, list arg):
                      self.inst = new $cy_vector()
                      $decl
                      cdef $cy_type item
                      for item in arg:
                          $init
                          self.inst.push_back($expr)
                          $cleanup
                 cdef $cy_vector * conv(self):
                      return self.inst
                 def post_process(self, arg):
                      if $is_ref:
                          del arg[:]
                          for i in range(self.inst.size()):
                              arg.append($conv)
                      if self.inst:
                          del self.inst

             """
        conv = self.to_py_converters.get(targ_type, "self.inst.at(i)")
        is_ref = type_cpp.is_ref
        return c.resolve(**locals())
                        

    def generate_wrapped_class_to_py(self, name, type_):

        cy_type = cy_repr(type_)
        py_class = py_name(type_)
        cc = Code()
        cc += """
              cdef $name($cy_type * inst):      
                   cdef $py_class res = $py_class(_new_inst=False)
                   res._set_inst(new $cy_type(deref(inst)))
                   return res
              """
        return cc.resolve(name=name, cy_type=cy_type, py_class=py_class)
            
            
    def generate_string_to_py(self):

        cc = Code()
        cc += """
              cdef conv_string_to_py(string * str):          
                   return PyString_FromString(str.c_str())
              """
        return cc

    def generate_pair_to_py(self, name, type_):
        cc = Code()
        assert len(type_.template_args) == 2
        targ1 = type_.template_args[0]
        targ2 = type_.template_args[1]
        targ_cy_type1 = cy_repr(targ1)
        targ_cy_type2 = cy_repr(targ2)
        cy_type = cy_repr(type_)

        inner_conv1 = self.to_py_converters.get(targ1, "pair.first")
        inner_conv2 = self.to_py_converters.get(targ2, "pair.second")

        cc += """
              cdef $name($cy_type *pair):
                   return $inner_conv1, $inner_conv2
              """

        return cc.resolve(**locals())
            
    
    def generate_vector_to_py(self, name, type_):

        assert len(type_.template_args) == 1
        targ = type_.template_args[0]
        targ_cy_type = cy_repr(targ)
        cy_type = cy_repr(type_)

        inner_conv = self.to_py_converters.get(targ, "(item)")

        cc = Code()
        cc += """
              cdef $name($cy_type * vec):      
                  res = []
                  cdef $targ_cy_type item
                  for i in range(vec.size()):
                      item = vec.at(i)
                      res.append($inner_conv)
                  return res
              """
        
        return cc.resolve(**locals())
    
