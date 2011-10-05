#encoding: utf-8

from Types import *
from PXDParser import CPPClass, CPPMethod, Enum, parse
import sys
import os
from   string import Template


class Code(object):

    """ class to collect code lines,
        code can be nested.
    """

    def __init__(self, *a):
        self.lines = list(a)

    def addCode(self, code, indent):
        self.lines.append((code, indent))
        return self

    def add(self, line):
        self.lines.append(line)
        return self

    def resolve(_self, **parameters):
        # in some situtations **parameters contains a key "self", which 
        # lets this method crash unless we use something else as "self" for
        # the first arg
        _self.lines = [ Template(l).substitute(parameters) for l in _self.lines ]

    def addFile(self, file_, indent=0):
        c = Code()
        for l in file_:
            c += l.rstrip()
        self.addCode(c, indent)

    def __iadd__(self, line):
        return self.add(line)

    def write(self, out, indent=0):
        for l in self.lines:
            if isinstance(l, tuple):
                # nested code
                code, sub_indent = l
                code.write(out, indent + sub_indent)
            else:
                print >> out, "%s%s" % (indent * "    ", l)
        return self


class Generator(object):

    def __init__(self):
        self.classes_to_wrap = dict()
        self.cimports = []
        self.enums = set()

    def parse_all(self, sourcelist):
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

    def generate_code_for(self, className):
        c = Code()
        obj = self.classes_to_wrap[className]
        if isinstance(obj, CPPClass):
            c.addCode(self.generate_code_for_class(obj), indent=0)
        elif isinstance(obj, Enum):
            c.addCode(self.generate_code_for_enum(obj), indent=0)

        return c

    def generate_import_statements(self):
        c = Code()
        c += "from cython.operator cimport dereference  as deref" 
        c += "from cython.operator cimport address      as address" 
        c += "from cython.operator cimport preincrement as preincrement"
        c += "from libcpp.vector cimport *"
        c += "from libcpp.string cimport *"

        for pxdpath, name, cy_id in self.cimports:
            c += "from $pxdpath cimport $name as $cy_id" 
            c.resolve(pxdpath = pxdpath, name = name, cy_id = cy_id)
        return c

    def generate_code_for_enum(self, enum):

        # as python has no enums, we simulate them by
        # declaring a class which only hass class attributes
        # coresponding to the enum values. eg
        #
        # cdef class TestEnum:
        #      In = 0
        #      Out = 1

        c = Code()
        c += "cdef class %s:         " % enum.py_repr
        for name, value in enum.items:
            c += "    $name=$value" 
            c.resolve(name = name, value = value) 
        return c

    def generate_code_for_class(self, clz):
        c = Code()

        c += "cdef class $py_repr:                       " 
        c += "    cdef $cy_repr * inst                   " 
        c += "    cdef _new_inst(self):                  "
        c += "       self.inst = new $cy_repr()          " 
        c += "    cdef _set_inst(self, $cy_repr * inst): " 
        c += "        if self.inst != NULL:              "
        c += "            del self.inst                  "
        c += "        self.inst = inst                   "
        c += "    def __init__(self, _new_inst = True):  "
        c += "        if _new_inst:                      "
        c += "           self._new_inst()                "
        c += "    def __dealloc__(self):                 "
        c += "        if self.inst != NULL:              "
        c += "            del self.inst                  "

        c.resolve(**clz.__dict__)

        for name, methods in clz.methods.items():
            # do not wrap constructors:
            if name == clz.name:
                c.addCode(self.generate_constructor(clz, methods), indent = 1)
            else:
                c.addCode(self.generate_code_for_method(clz, methods), indent=1)
        return c

    def generate_constructor(self, clz, methods):
        return Code()

    def input_conversion(self, clz, argpos, py_argname, type_):
        """
           the generated python methods take python args as input
           which have to be converted (in most cases) for calling
           the c++ method.

           this function handles one argument

           argpos     is the position of the argument
           py_argname is the name of the argument
           type_      is the type which the c++ method expects for
                      this argument.

           we generate and return in this order:

              - input_type_decl: type decl for the python method
              - conversion code: code which transforms python arg
                                 to c++ arg
              - what value to pass to the c++ method
              - cleanup_code   : code for cleanup after the c++
                                 method is called
        """

        co = Code()   # conversion code
        cl = Code()   # cleanup code

        if type_.is_ptr:
            raise Exception("ptr type '%s' not supported" % cpp_repr(type_))

        if type_.basetype in Type.CTYPES:
            # nothing to do
            return cpp_repr(type_), co, py_argname, cl

        if type_.basetype in self.enums:
            return "int", co, "<%s>%s" % (cy_repr(type_), py_argname), cl

        if type_.basetype in self.classes_to_wrap:
            return py_repr(type_), co, "deref(%s.inst)" % py_argname, cl

        if type_.basetype == "bool":
            # cython has no bool, so bool -> int
            return "int", co, py_argname, cl

        if type_.basetype == "string":
            # cython method declares char * which is how python strings can
            # be declared
            input_type_decl = "char *"
            tempvar = "_%s_%d_as_str" % (py_argname, argpos)
        
            co += "cdef string * $tempvar = new string($py_argname)" 
            co.resolve(tempvar = tempvar, py_argname = py_argname)

            cl += "del $tempvar"
            cl.resolve(tempvar = tempvar)

            call_arg = "deref(%s)" % tempvar
            return input_type_decl, co, call_arg, cl

        if type_.basetype == "vector":
            input_type_decl = ""                      # any iterable
            assert len(type_.template_args) == 1, \
                                        "vector takes only one template arg"
            targ = type_.template_args[0]
            loopvar = "_v_%d" % argpos

            cy_type = cy_repr(type_)
            py_arg_type = py_repr(targ)

            # iterate over the python input and build temp vector.
            if targ.basetype in self.classes_to_wrap:
                tempvec = "_%s_%d_as_vec" % (py_argname, argpos)

                co += "cdef $cy_type * $tempvec = new $cy_type()" 
                co += "cdef $py_arg_type $loopvar" 
                co += "for $loopvar in $py_argname: " 
                co += "    deref($tempvec).push_back(deref($loopvar.inst))"

            else:
                co += "cdef $cy_type * $tempvec = new $cy_type()"
                co += "for $loopvar in $py_argname: " 
                co += "    deref($tempvec).push_back($loopvar)" 

            co.resolve(**locals())
            call_arg = "deref(%s)" % tempvec
            # delete temp vector
            cl += "del %s" % tempvec
            return input_type_decl, co, call_arg, cl

        raise Exception(cy_repr(type_) + "not supported yet")

    def result_conversion(self, result_type, result_name):

        """ if a c++ method is called, the codegenerator introduces a variable
            for the return value.
            this variable has name 'result_name' and is of type 'result_type'.

            here we generate code which transforms this c++ type to a matching
            python type.

            the result is just code which performs this transformation
            including a return statement for the result.
        """

        cy_type = cy_repr(result_type)
        py_type = py_repr(result_type)

        if result_type.basetype in ["int", "long", "double", "float"]:
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" % cy_type)
            return Code("return " + result_name)

        if result_type.basetype == "char":
            # char* is automatically converted by cython to python string
            return Code("return " + result_name)

        if result_type.basetype == "string":
            # char* is automatically converted by cython to python string
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" % cy_type)
            return Code("return %s.c_str()" % result_name)

        if result_type.basetype in self.enums:
            return Code("return <int>%s" % result_name)

        if result_type.basetype in self.classes_to_wrap:
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" % cy_type)
            # construct python wrapping class and return this :
            co = Code()
            py_res = "_%s_py" % result_name

            co += "$py_res = $py_type(False) " 
            co += "$py_res._set_inst(new $cy_type($result_name))" 
            co += "return $py_res"
            co.resolve(**locals())
            return co

        if result_type.basetype == "vector":
            if result_type.is_ptr:
                raise Exception("can not handel return type %r"
                                 % cy_repr(result_type))

            assert len(result_type.template_args) == 1
            targ = result_type.template_args[0]
            py_targ = py_repr(targ)
            cy_targ = cy_repr(targ)

            # build python list from vector
            co = Code()
            if targ.basetype in self.classes_to_wrap:
                co += "_rv = list()"
                co += "for _i in range($result_name.size()):" 
                co += "    _res = $py_targ(False) " 
                co += "    _res._set_inst(new $cy_targ($result_name.at(_i)))"
                co += "    _rv.append(_res)"
                co += "return _rv"
                co.resolve(**locals())
            else:
                raise Exception("this case is not handeld yet")
            return co

        raise Exception("do not know how to convert result of type %s" % cy_type)

    def generate_code_for_operator(self, clz, method):

        """ generates python methods for wrapping operators """

        if method.name == "operator[]":
            assert len(method.args) == 1
            argname, type_ = method.args[0]
            assert type_.basetype in ["int", "long"]
            assert not type_.is_ptr and type_.template_args is None

            co = Code()
            res_type = cy_repr(method.result_type)
            co += "def __getitem__(self, int idx):"
            co += "    cdef $res_type _res = deref(self.inst)[idx]" 
            co.resolve(res_type=res_type)

            resconv = self.result_conversion(method.result_type, "_res")
            co.addCode(resconv, indent=1)
            return co

        else:
            raise Exception("wrapping of %r not supported yet" % method.name)

    def collect_input_conversion_stuff(self, clz, method):

        """ iterates over delcared arguments and builds/collects:
            - signature of generated python method
            - conversion code for python args -> c++ args
            - the cpp_call_signature which depends on input conversion
              results.
            - cleanup code after the c++ method call
        """

        input_conversion = Code()
        conversion_cleanup = Code()
        python_args = ["self"]
        call_args = []
        for pos, (name, type_) in enumerate(method.args):
            name = name or "abcdefhijklmno"[pos]
            input_type_decl, conversion_code, call_arg, cleanup_code = \
                             self.input_conversion(clz, pos, name, type_)

            python_args.append("%s %s" % (input_type_decl, name))
            call_args.append(call_arg)

            input_conversion.addCode(conversion_code, indent=0)
            conversion_cleanup.addCode(cleanup_code,  indent=0)

        py_signature = ", ".join(python_args)
        cpp_call_signature = ", ".join(call_args)

        return input_conversion, conversion_cleanup, py_signature,\
               cpp_call_signature

    def generate_code_for_method(self, clz, methods):

        if len(methods) != 1:
            raise Exception("overloading not supported yet")

        method = methods[0]

        if method.name.startswith("operator"):
            return self.generate_code_for_operator(clz, method)

        inp_conversion, conv_cleanup, py_sig, cpp_sig = \
            self.collect_input_conversion_stuff(clz, method)

        name = method.name

        # declare function
        c = Code()
        c += "def %(name)s (%(py_sig)s):   " % locals()

        # perform input conversiond
        c.addCode(inp_conversion, indent=1)

        # call c++ method
        if method.result_type.basetype == "void":
            c += "    self.inst.%(name)s(%(cpp_sig)s)          " % locals()
        else:
            c += "    _result = self.inst.%(name)s(%(cpp_sig)s)" % locals()

        # cleanup temp variables from input conversion
        c.addCode(conv_cleanup, indent=1)

        # return result, void functions return "self" for fluent interface
        if method.result_type.basetype == "void":
            c += "    return self"
        else:
            resconv = self.result_conversion(method.result_type, "_result")
            c.addCode(resconv, indent=1)

        return c
