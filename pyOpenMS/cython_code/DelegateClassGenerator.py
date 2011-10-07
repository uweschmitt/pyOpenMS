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
        resolved = []
        for line in _self.lines:
            if type(line) == tuple:  # code, no text
                resolved.append(line)
            else:
                resolved.append(Template(line).substitute(parameters))
        _self.lines = resolved

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
        self.result_aliases = dict()
        self.input_aliases = dict()

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

    def add_result_alias(self, type_out, type_alias):
        self.result_aliases[type_out] = type_alias

    def add_input_alias(self, type_in, type_alias):
        self.input_aliases[type_in] = type_alias

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
            c.resolve(pxdpath=pxdpath, name=name, cy_id=cy_id)
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
        c += "cdef class %s:" % enum.name
        for name, value in enum.items:
            c += "    $name=$value"
            c.resolve(name=name, value=value)
        return c

    def generate_code_for_class(self, clz):
        c = Code()

        c += "cdef class $py_repr:                       "

        c += "    cdef $cy_repr * inst                   "
        c += "    cdef list  _cons_sig                   "

        c += "    cdef _set_inst(self, $cy_repr * inst): "
        c += "        if self.inst != NULL:              "
        c += "            del self.inst                  "
        c += "        self.inst = inst                   "

        c += "    def __dealloc__(self):                 "
        c += "        if self.inst != NULL:              "
        c += "            del self.inst                  "

        c.resolve(**clz.__dict__)

        # wrap constructors first as items in dict are not in insertion order:
        constructors = clz.methods.get(clz.name)
        if constructors:
            c.addCode(self.generate_constructor(clz, constructors), indent=1)

        for name, methods in clz.methods.items():
            # do not wrap constructors:
            if name == clz.name:
                continue
            c.addCode(self.generate_code_for_method(clz, name, methods),
                      indent=1)
        return c

    def generate_constructor(self, clz, methods):

        c = Code()
        c += 'def __init__(self, *a, **kw):                        '
        c += '    self._cons_sig = map(type, a)                    '
        c += '    if len(a)==0 and kw.get("_new_inst") is False:   '
        c += '        return                                       '

        for meth in methods:

            if len(meth.args) == 1:
                argtype = meth.args[0][1]
                if argtype.basetype == clz.name:
                    # copy cons ? not wrapped  !
                    continue

            name_defaults = []
            cleaned_args = []
            for i, arg in enumerate(meth.args):
                name, type_ = arg
                #  remove arg names in constructors !
                cleaned_args.append((None, type_))
                name_defaults.append("a[%d]" % i)

            meth.args = cleaned_args

            default_names = ["a[%d]" % i for i in range(len(meth.args))]
            inp_conversion, conv_cleanup, cy_decl, py_decl, cpp_sig = \
                  self.collect_input_conversion_stuff(clz, meth, default_names)

            py_sig = ", ".join(py_decl)
            cs = Code()
            cs += 'if self._cons_sig == [$py_sig]:     '
            cs.addCode(inp_conversion, indent=1)
            cs += '    self.inst = new $cy_type($cpp_sig)'
            cs.addCode(conv_cleanup, indent=1)
            cs += '    return                          '

            cy_type = cy_repr(clz.type_)
            cs.resolve(**locals())
            c.addCode(cs, indent=1)

        c += '    raise Exception("input args do not match declaration")'
        return c

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

              - input_ctype_decl: type decl for the cython method
              - conversion code: code which transforms python arg
                                 to c++ arg
              - what value to pass to the c++ method
              - cleanup_code   : code for cleanup after the c++
                                 method is called
        """

        co = Code()   # conversion code
        cl = Code()   # cleanup code

        # resolve alias if present:
        type_ = self.input_aliases.get(type_, type_)

        if type_.basetype == "char" and type_.is_ptr:
            return "char *", Code(), "<char *>" + py_argname, Code()

        if type_.is_ptr:
            raise Exception("ptr type '%s' not supported" % cpp_repr(type_))

        if type_.basetype in Type.CTYPES:
            # nothing to do
            casted = "<%s>%s" % (cpp_repr(type_), py_argname)
            return cy_repr(type_), co, casted, cl

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
            co.resolve(tempvar=tempvar, py_argname=py_argname)

            cl += "del $tempvar"
            cl.resolve(tempvar=tempvar)

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

            tempvec = "_%s_%d_as_vec" % (py_argname, argpos)
            # iterate over the python input and build temp vector.
            if targ.basetype in self.classes_to_wrap:
                co += "cdef $cy_type * $tempvec = new $cy_type()"
                co += "cdef $py_arg_type $loopvar"
                co += "for $loopvar in $py_argname: "
                co += "    deref($tempvec).push_back(deref($loopvar.inst))"
            else:
                co += "cdef $cy_type * $tempvec = new $cy_type()"
                co += "for $loopvar in $py_argname: "
                co += "    deref($tempvec).push_back($loopvar)"

            co.resolve(**locals())
            cl += "del %s" % tempvec
            call_arg = "deref(%s)" % tempvec
            return input_type_decl, co, call_arg, cl

        raise Exception(cy_repr(type_) + "not supported yet")

    def result_conversion(self, result_type, result_name):

        """ if a c++ method is called, the codegenerator introduces a variable
            for the return value.
            this variable has name 'result_name' and is of type 'result_type'.

            here we generate code which transforms this c++ type to a matching
            python type.

            returns:
                 - code for declaration of needed vars
                 - code for result conversion
                 - name of var with conversion result

        """

        result_type = self.result_aliases.get(result_type, result_type)

        cy_type = cy_repr(result_type)
        py_type = py_repr(result_type)

        d = Code()
        c = Code()

        if result_type.basetype in ["int", "long", "double", "float"]:
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" % cy_type)
            return d, c, result_name

        if result_type.basetype == "char":
            # char* is automatically converted by cython to python string
            return d, c, result_name

        if result_type.basetype == "string":
            # char* is automatically converted by cython to python string
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" % cy_type)
            return d, c, "%s.c_str()" % result_name

        if result_type.basetype in self.enums:
            return d, c, "<int>%s" % result_name

        if result_type.basetype in self.classes_to_wrap:
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" % cy_type)
            # construct python wrapping class and return this :
            py_res = "_%s_py" % result_name

            d += "cdef $py_type $py_res"
            d.resolve(py_type=py_type, py_res=py_res)

            c += "$py_res = $py_type(_new_inst=False) "
            c += "$py_res._set_inst(new $cy_type($result_name))"
            c.resolve(**locals())
            return d, c, py_res

        if result_type.basetype == "vector":
            if result_type.is_ptr:
                raise Exception("can not handel return type %r"
                                 % cy_repr(result_type))

            assert len(result_type.template_args) == 1
            targ = result_type.template_args[0]
            py_targ = py_repr(targ)
            cy_targ = cy_repr(targ)

            # build python list from vector
            if targ.basetype in self.classes_to_wrap:
                
                d += "_rv = list()"
                d += "cdef $cy_targ _res"
                d.resolve(cy_targ = cy_targ)

                c += "for _i in range($result_name.size()):"
                c += "    _res = $result_name.at(_i) "

                dd, cc, res_name = self.result_conversion(targ, "_res")

                d.addCode(dd, indent=0)
                c.addCode(cc, indent=1)

                c += "    _rv.append(%s)" % res_name
                c.resolve(**locals())
                return d, c, "_rv"

            else:
                msg = "result conv for %r is not handeld yet" % cy_repr(targ)
                raise Exception(msg)
            return co
        
        raise Exception("can not handle result of type %s" % cy_type)

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
            co += "    cdef $res_type _res = deref(self.inst)[idx]"
            co.resolve(res_type=res_type)

            decl, resconv, resname = self.result_conversion(method.result_type,
                                                            "_res")
            co.addCode(decl, indent=1)
            co.addCode(resconv, indent=1)
            co+="    return %s" % resname
            return co

        elif name == "operator":  # cast ops
            res = Code()
            for method in methods:
                name = method.annotations.get("name")
                if name is None:
                    raise Exception("you have to provide a python name for "
                                    "%s" % method)

                cy_type = cy_repr(method.result_type)
                co = Code()
                co += "def $name(self):"
                co += "    " + method.annotations.get("pre", "")
                co += "    cdef $cy_type _res = <$cy_type>deref(self.inst)"
                co.resolve(name=name, cy_type=cy_type)
                decl, resconv, resname = \
                             self.result_conversion(method.result_type, "_res")
                co.addCode(decl, indent=1)
                co.addCode(resconv, indent=1)
                co += "    return %s" % resname
                res.addCode(co, indent=0)
            return res

        else:
            raise Exception("wrapping of %r not supported yet" % method.name)

    def collect_input_conversion_stuff(self, clz, method, default_names):

        """ iterates over delcared arguments and builds/collects:
            - signature of generated python method
            - conversion code for python args -> c++ args
            - the cpp_call_signature which depends on input conversion
              results.
            - cleanup code after the c++ method call
        """

        input_conversion = Code()
        conversion_cleanup = Code()
        cython_decl = []
        python_types = []
        call_args = []
        for pos, (name, type_) in enumerate(method.args):
            name = name or default_names[pos]
            input_ctype_decl, conversion_code, call_arg, cleanup_code = \
                             self.input_conversion(clz, pos, name, type_)

            python_types.append(py_type_for_cpp_type(type_))
            cython_decl.append((input_ctype_decl, name))
            call_args.append(call_arg)

            input_conversion.addCode(conversion_code, indent=0)
            conversion_cleanup.addCode(cleanup_code,  indent=0)

        cpp_call_signature = ", ".join(call_args)

        return input_conversion, conversion_cleanup, cython_decl, \
               python_types, cpp_call_signature

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

        default_names = [chr(ord('a') + i) for i in range(len(method.args))]
        inp_conversion, conv_cleanup, cy_decl, py_decl, cpp_sig = \
                self.collect_input_conversion_stuff(clz, method, default_names)

        py_args = ["self"] + ["%s %s" % (t, n) for (t, n) in cy_decl]
        py_sig = ", ".join(py_args)

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
            decl, resconv, rv = self.result_conversion(method.result_type, 
                                                       "_result")
            resconv += "return %s" % rv
            c.addCode(decl, indent=1)
            c.addCode(resconv, indent=1)
        return c
