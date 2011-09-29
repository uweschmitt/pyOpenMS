from Cython.Compiler.CmdLine import parse_command_line
from Cython.Compiler.Main import create_default_resultobj, CompilationSource
from Cython.Compiler import Pipeline
from Cython.Compiler.Scanning import FileSourceDescriptor
from Cython.Compiler.Nodes import *
from Cython.Compiler.ExprNodes import *

import sys, os, re


##### here come parsing functions and classes ################################

def has(node, lines, what):
    """ look for 'what' in comment according to 'node'. 
        'lines' are the line of the file """
    parts = lines[node.pos[1]-1].split("#")
    return  len(parts)>1 and what in parts[1]


def normalize_indent(fragment, indent=0):
    """ removes common indent in all lines so that the first line is without 
        indent  """
    lines = [ l for l in fragment.split("\n") if l.strip() ]
    indent_first_line = len(lines[0])-len(lines[0].lstrip())
    return "\n".join(4*indent*" "+line[indent_first_line:] for line in lines)


class Type(object):

    CTYPES=["int", "long", "double", "float", "char", "void"]
    LIBCPPTYPES = ["vector", "string", "list" ]

    def __init__(self, basetype, is_ptr=False, is_ref=False, 
                       template_args=None):
        self.basetype = "void" if basetype is None else basetype
        self.is_ptr = is_ptr
        self.is_ref = is_ref
        self.template_args = template_args

def cython_repr(type_):
    """ returns cython type representation """

    if type_.basetype in Type.CTYPES or type_.basetype in Type.LIBCPPTYPES:
       rv = type_.basetype
    else:
        rv = "_"+type_.basetype
    if type_.template_args is not None:
        rv += "[%s]" %  ",".join(cython_repr(t) for t in type_.template_args)

    if type_.is_ptr:
        rv +=" * "
    elif type_.is_ref:
        rv +=" & "
    return rv

def cpp_repr(type_):
    """ returns C++ type representation """

    rv = type_.basetype
    if type_.template_args is not None:
        rv += "<%s>" %  ",".join(cpp_repr(t) for t in type_.template_args)

    if type_.is_ptr:
        rv +=" * "
    elif type_.is_ref:
        rv +=" & "
    return rv

def python_repr(type_):
    """ returns Python representation, that is the name the module
        will expose to its users """
    return type_.basetype


class Enum(object):

    def __init__(self, node, lines):
        self.name = node.name
        self.items = []
        self.line_number = node.pos[1]
        self.file_name   = node.pos[0].filename
        self.wrap = has(node, lines, "wrap")

        current_value = 0
        for item in node.items:
            if item.value is not None:
                current_value = item.value.constant_result
            self.items.append((item.name, current_value))
            current_value += 1

    def __str__(self):
        res = "enum %s : " % self.name
        res += ", ".join("%s: %d" % (i, v) for (i,v) in self.items )
        return res


class CPPClass(object):

    # allows only one instantiation tuple in comments.
    # if you want more:
    #    - make factory from __init__
    #    - return individual classes
    #    - further todo: individual Python names for distinct instances
    #      (maybe via comment:  inst PyClassOne=<B,C> 


    def __init__(self, node, lines):
        self.name = node.name
        self.line_number = node.pos[1]
        self.file_name   = node.pos[0].filename
        self.wrap = has(node, lines, "wrap")

        self.instances = dict() # maps template args to instantiation types

        targs = None
        if node.templates is not None:
            # parse comment
            m = re.search("inst\W*=\W*<(.*)>", lines[self.line_number-1])
            if self.wrap and not m:
                raise Exception("need inst=<A,..> arg for template class")
            instargs = m.group(1).split(",")
            # template nesting not supported:
            ttargs=None
            targs = [ Type(t.strip(), False, False, ttargs) for t in instargs ]
            self.instances = dict( zip(node.templates, targs) )

        self.type_ = Type(self.name, False, False, targs)
        self.cpp_repr = cpp_repr(self.type_)
        self.cython_repr = cython_repr(self.type_)
        self.python_repr = python_repr(self.type_)

        self.methods = []

        for att in node.attributes:
            if not has(att, lines, "ignore"):
                self.methods.append(CPPMethod(att, lines, self.instances))

    def __str__(self):
        rv = ["class %s: " % cpp_repr(self.type_)]
        rv += ["     "+str(method) for method in self.methods]
        return "\n".join(rv)
        


def parse_type(base_type, decl, instances): 
    """ extracts type information from node in parse tree """
    targs = None
    if isinstance(base_type, TemplatedTypeNode):
        targs = []
        for arg in base_type.positional_args:
            if isinstance(arg, CComplexBaseTypeNode):
                decl = arg.declarator
                is_ptr = isinstance(decl, CPtrDeclaratorNode)
                is_ref = isinstance(decl, CReferenceDeclaratorNode)
                name = arg.base_type.name
                ttype = instances.get(name, Type(name, is_ptr, is_ref, None))
                targs.append(ttype)
            elif isinstance(arg, NameNode):
                name = arg.name
                targs.append(instances.get(name, Type(name)))
            else:   
                raise Exception("%s,%d: can not handle template arg of type %r"\
                                % (self.file_name, self.line_number, arg))
             
        base_type = base_type.base_type_node

    is_ptr = isinstance(decl, CPtrDeclaratorNode)
    is_ref = isinstance(decl, CReferenceDeclaratorNode)
    return instances.get(base_type.name, Type(base_type.name, is_ptr, 
                                              is_ref, targs))
    

class CPPMethod(object):
    
    def __init__(self, node, lines, instances):
  
        self.line_number = node.pos[1]
        self.file_name   = node.pos[0].filename

        decl = node.declarators[0]
        self.result_type = parse_type(node.base_type, decl, instances)
        
        if isinstance(decl.base, CFuncDeclaratorNode):
           decl = decl.base

        self.name = decl.base.name
        self.args = []
        for arg in decl.args:
            argdecl = arg.declarator
            if isinstance(argdecl, CReferenceDeclaratorNode) or \
               isinstance(argdecl, CPtrDeclaratorNode):
                argname = argdecl.base.name
            else:
                argname = argdecl.name
            self.args.append((argname, 
                              parse_type(arg.base_type, argdecl, instances)))

    def __str__(self):
        rv = cpp_repr(self.result_type)
        rv += " " + self.name
        argl = [ cpp_repr(type_)+" "+str(name) for name, type_ in self.args ]
        return rv + "("+ ", ".join(argl) + ")"


def parse(path):

    """ reads pxd file and extracts *SINGLE* class """

    options, sources = parse_command_line(["--cplus", path])

    path = os.path.abspath(path)
    basename = os.path.basename(path)
    name, ext = os.path.splitext(basename)

    source_desc = FileSourceDescriptor(path, basename)
    source = CompilationSource(source_desc, name , os.getcwd())
    result = create_default_resultobj(source, options)

    context = options.create_context()
    pipeline = Pipeline.create_pyx_pipeline(context, options, result)
    tree = pipeline[0](source) # only parser

    if hasattr(tree.body, "stats"):
        for s in tree.body.stats:
            if isinstance(s, CDefExternNode):
                body = s.body
                break
    else:
        body = tree.body.body

    lines = open(path).readlines()

    if isinstance(body, CEnumDefNode):
            return Enum(body, lines)

    return CPPClass(body, lines)

##### here come code generation functions and classes ########################

class Code(object):

    def __init__(self, *a):
        self.lines = list(a)

    def addCode(self, code, indent):
        self.lines.append( (code, indent) )
        return self

    def add(self, line):
        self.lines.append(line)
        return self

    def __iadd__(self, line):
        self.lines.append(line)
        return self

    def print_(self, indent=0, out=sys.stdout):
        for l in self.lines:
            if isinstance(l, tuple):
                Code.print_(l[0], indent+l[1], out)
            else:
                print >> out, "%s%s" % (indent*"    ", l)
        return self


class Generator(object):

    def __init__(self):
        self.classes_to_wrap = dict()
        self.cimports = []

    def parse_all(self, sourcelist):

        for source in sourcelist:
            p = parse(source)
            dirname = os.path.dirname(source)
            basename = os.path.basename(source)
            filename, _ = os.path.splitext(basename)
            pxdpath = ".".join( [f for f in os.path.split(dirname) if f ] 
                               +[filename,] 
                              )
            cid = cython_repr(Type(p.name))
            self.cimports.append("from %s cimport %s as %s" % (pxdpath, p.name, cid))
            
            if p.wrap:
                self.classes_to_wrap[p.name] = p

    def generate_code_for(self, className):
        c = Code()
        obj = self.classes_to_wrap[className]
        if isinstance(obj, CPPClass):
            c.addCode(self.generate_code_for_class(obj), indent=0)

        return c

    def generate_import_statements(self):
        c = Code()
        c+= "from libcpp.vector cimport *"
        c+= "from libcpp.string cimport *"
        c+= "from cython.operator cimport address as addr, dereference as deref"

        for statement in self.cimports:
            c+= statement
        return c

    def generate_code_for_class(self, clz):
        c = Code()
        c+= "cdef class %s:                     " % clz.python_repr
        c+= "    cdef %s * inst                 " % clz.cython_repr
        c+= "    def __cinit__(self):           "
        c+= "        self.inst = new %s()       " % clz.cython_repr
        c+= "    def __dealloc__(self):         "
        c+= "        del self.inst              "
        c+= "    cdef replaceInstance(self, %s * inst): " % clz.cython_repr
        c+= "        del self.inst              "
        c+= "        self.inst=inst             "

        for method in clz.methods:
            # do not wrap constructors:
            if method.name == clz.name: 
                continue 
            c.addCode(self.generate_code_for_method(clz, method), indent=1)

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

        if type_.basetype in self.classes_to_wrap:
            return python_repr(type_), co, "deref(%s.inst)" %py_argname, cl

        if type_.basetype == "bool":
            # cython has no bool, so bool -> int
            return "int", co, py_argname, cl

        if type_.basetype == "string":
            # cython method declares char * which is how python strings can
            # be declared
            input_type_decl = "char *"  
            tempvar = "_%s_as_str" % py_argname
            co += "cdef string * %s = new string(%s)" % (tempvar, py_argname)
            cl += "del %s"                            % tempvar
            call_arg  = "deref(%s)"                         % tempvar
            return input_type_decl, co, call_arg, cl
        
        elif type_.basetype=="vector":
            input_type_decl = ""                      # any iterable
            assert len(type_.template_args)==1, \
                                        "vector takes only one template arg"
            targ = type_.template_args[0]
            loopvar = "_v%03d" % argpos
            cid = cython_repr(type_)
            pid = python_repr(type_)
             
            # iterate over the python input and build temp vector.
            if targ.basetype in self.classes_to_wrap:
                tempvec = "_%s_as_vec" % py_argname
                co +=   "cdef %s * %s = new %s()  " % (cid, tempvec, cid)
                co +=   "cdef %s %s               " % (pid, loopvar)
                co +=   "for %s in %s:            " % (loopvar, py_argname)
                co +=   "    deref(%s).push_back(deref(%s.inst))" \
                                                    % (tempvec, loopvar)
            else:
                co +=   "cdef %s * %s = new %s()  " % (cid, tempvec, cid)
                co +=   "for _v in %s:            " % (loopvar, py_argname)
                co +=   "    deref(%s).push_back(_v)" % tempvec

            call_arg = "deref(%s)" % tempvec
            # delete temp vector 
            cl += "del %s" % tempvec
            return input_type_decl, co, call_arg, cl

        raise Exception(cython_repr(type_) + "not supported yet")


    def result_conversion(self, result_type, result_name):

        """ if a c++ method is called, the codegenerator introduces a variable
            for the return value.
            this variable has name 'result_name' and is of type 'result_type'.

            here we generate code which transforms this c++ type to a matching
            python type.

            the result is just code which performs this transformation 
            including a return statement for the result. 
            
        """
        
        cid = cython_repr(result_type)
        pid = python_repr(result_type)

        if result_type.basetype in ["int", "long", "double", "float"]:
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" % cid)
            return Code("return "+result_name)

        if result_type.basetype == "char":
            # char* is automatically converted by cython to python string
            return Code("return "+result_name)

        if result_type.basetype == "string":
            # char* is automatically converted by cython to python string
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" % cid)
            return Code("return %s.c_str()" %result_name)

        if result_type.basetype in self.classes_to_wrap:
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" % cid)
            # construct python wrapping class and return this :
            co = Code()
            py_name = "_%s_py" % result_name
            co += "%s = %s()                     " % (py_name, pid)
            co += "%s.replaceInstance(new %s(%s))" % (py_name,cid,result_name)
            co += "return %s                     " % py_name
            return co

        if result_type.basetype == "vector":
            if result_type.is_ptr:
                raise Exception("can not handel return type %r" 
                                 % cython_repr(result_type))

            assert len(result_type.template_args) == 1
            targ = result_type.template_args[0]
            py_targ = python_repr(targ)
            cy_targ = cython_repr(targ)

            # build python list from vector
            co = Code()
            if targ.basetype in self.classes_to_wrap:
                co+= "_rv = list()"
                co+= "for _i in range(%s.size()):" % result_name
                co+= "    _res = %s()            " % py_targ
                co+= "    _res.replaceInstance(new %s(%s.at(_i)))"  \
                                                   % (cy_targ, result_name)
                co+= "    _rv.append(_res)"
                co+= "return _rv"
            else:
                raise Exception("this case is not handeld yet")
            return co
            
        raise Exception("do not know how to convert result of type %s" % cid)
        
    def generate_code_for_operator(self, clz, method):

        """ generates python methods for wrapping operators """

        if method.name=="operator[]":
            assert len(method.args) == 1
            argname, type_ = method.args[0]
            assert type_.basetype in ["int", "long"]
            assert not type_.is_ptr and type_.template_args is None

            co = Code()
            rt = cython_repr(method.result_type)
            co += "def __getitem__(self, int idx):" 
            co += "    cdef %s _res = deref(self.inst)[idx]" % rt

            resconv = self.result_conversion(method.result_type, "_res")
            co.addCode(resconv, indent=1)
            return co

        else:
            raise Exception("wrapping of %r not supported yet" % method.name)


    def collect_input_conversion_stuff(self, clz, method):

        input_conversion = Code()
        conversion_cleanup  = Code()
        python_args = ["self"]
        call_args = []
        for pos, (name, type_) in enumerate(method.args):
            name = name or "abcdefhijklmno"[pos]
            input_type_decl, conversion_code, call_arg, cleanup_code = \
                             self.input_conversion(clz, pos, name, type_)

            python_args.append("%s %s" % (input_type_decl, name) )
            call_args.append(call_arg)

            input_conversion.addCode(conversion_code, indent = 0)
            conversion_cleanup.addCode(cleanup_code,  indent = 0)

        return input_conversion, conversion_cleanup, python_args, call_args

    def generate_code_for_method(self, clz, method):


        if method.name.startswith("operator"):
            return self.generate_code_for_operator(clz, method)

        inp_conversion, conv_cleanup, python_args, call_args = \
            self.collect_input_conversion_stuff(clz, method)

        inputsig = ", ".join(python_args)
        callsig  = ", ".join(call_args)
        name = method.name

        # declare function
        c = Code()
        c+="def %(name)s (%(inputsig)s):   " % locals()

        # perform input conversiond
        c.addCode(inp_conversion, indent=1)

        # call c++ method
        c+="    _result = self.inst.%(name)s(%(callsig)s) " % locals()

        # cleanup temp variables from input conversion
        c.addCode(conv_cleanup, indent=1)
      
        # return result, void functions return "self" for fluent interface
        if method.result_type.basetype == "void":
            c+="    return self"
        else: 
            resconv =self.result_conversion( method.result_type, "_result")
            c.addCode(resconv, indent=1)

        return c
    

if __name__ == "__main__":
    import sys
    g = Generator()
    g.parse_all(sys.argv[1:])

    c = Code()
    c.addCode(g.generate_import_statements(), indent=0)
    for clz_name in ["Peak1D", "Precursor", "MSSpectrum", "MSExperiment",
                    "InstrumentSettings", "ChromatogramTools", 
                    "MzXMLFile", "MzMLFile", "MzDataFile" ]:

       c.addCode(g.generate_code_for(clz_name), indent=0)
    c.print_() 
