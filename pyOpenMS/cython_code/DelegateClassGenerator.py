from Cython.Compiler.CmdLine import parse_command_line
from Cython.Compiler.Main import compile_single, CompilationOptions, run_pipeline, create_default_resultobj, CompilationSource
from Cython.Compiler import Pipeline
from Cython.Compiler.Scanning import FileSourceDescriptor
from Cython.Compiler.Nodes import *
from Cython.Compiler.ExprNodes import *

import sys
from PXDAnalyzer import Enum, CPPClass, CPPMethod, parse, Type
from pprint import pprint
import os, re

def has(node, lines, what):

    parts = lines[node.pos[1]-1].split("#")
    return  len(parts)>1 and what in parts[1]



def normalizeIndent(fragment, indent=0):
        
    lines = [ l for l in fragment.split("\n") if l.strip() ]
    indent_first_line = len(lines[0])-len(lines[0].lstrip())
    return "\n".join(indent*"    " + line[indent_first_line:] for line in lines)

def CID(type_):

        if type_.basetype in Type.CTYPES or type_.basetype in Type.LIBCPPTYPES:
           rv = type_.basetype
        else:
            rv = "_"+type_.basetype
        if type_.templateargs is not None:
            rv += "[%s]" %  ",".join(CID(t) for t in type_.templateargs)

        if type_.isptr:
            rv +=" * "
        elif type_.isref:
            rv +=" & "
        return rv

def CppID(type_):

        rv = type_.basetype
        if type_.templateargs is not None:
            rv += "<%s>" %  ",".join(CppID(t) for t in type_.templateargs)

        if type_.isptr:
            rv +=" * "
        elif type_.isref:
            rv +=" & "
        return rv

def PID(type_):
        return type_.basetype

class Enum(object):

    def __init__(self, parseNode, lines):
        self.name = parseNode.name
        self.items = []
        self.lineNumber = parseNode.pos[1]
        self.fileName   = parseNode.pos[0].filename
        self.wrap = has(parseNode, lines, "wrap")

        current_value = 0
        for item in parseNode.items:
            if item.value is not None:
                current_value = item.value.constant_result
            self.items.append((item.name, current_value))
            current_value += 1

    def __str__(self):
        res = "enum %s : " % self.name
        res += ", ".join("%s: %d" % (i, v) for (i,v) in self.items )
        return res


class Type(object):

    CTYPES=["int", "long", "double", "float", "char", "void"]
    LIBCPPTYPES = ["vector", "string", "list" ]

    def __init__(self, basetype, isptr, isref, templateargs):
        self.basetype = "void" if basetype is None else basetype
        self.isptr = isptr
        self.isref = isref
        self.templateargs = templateargs



class CPPClass(object):

    # allows only one instantiation tuple in comments.
    # if you want more:
    #    - make factory from __init__
    #    - return individual classes
    #    - further todo: individual Python names for distinct instances
    #      (maybe via comment:  inst PyClassOne=<B,C> 


    def __init__(self, parseNode, lines):
        self.name = parseNode.name
        self.lineNumber = parseNode.pos[1]
        self.fileName   = parseNode.pos[0].filename
        self.wrap = has(parseNode, lines, "wrap")

        self.instances = dict()

        #self.instanceName = self.name
        targs = None
        if parseNode.templates is not None:
            m = re.search("inst\W*=\W*<(.*)>", lines[self.lineNumber-1])
            if not m:
                raise Exception("need inst=<A,..> arg for template class")
            instargs = m.group(1).split(",")
            targs = [ Type(t.strip(), False, False, None) for t in instargs ]
            self.instances = dict( zip(parseNode.templates, targs) )
        

        self.type_ = Type(self.name, False, False, targs)
        self.CppID = CppID(self.type_)
        self.CID = CID(self.type_)
        self.PID = PID(self.type_)

        self.methods = []

        for att in parseNode.attributes:
            if not has(att, lines, "ignore"):
                self.methods.append(CPPMethod(att, lines, self.instances))

    """
    def isTemplateParameter(self, identifier):
        return self.templateArgs is not None and identifier in self.templateArgs

    def resolveInstance(self, identifier):
        i = self.templateArgs.index(identifier)
        return self.templateArgInstances[i]

    def resolveType(self, type_):
        if self.templateArgs is not None:
            if type_.basetype in self.templateArgs:
                return Type(self.resolveInstance(type_.basetype), type_.isptr, type_.isref, None)
        return type_
    """

    def __str__(self):
        rv = ["class %s: " % CppID(self.type_)]
        rv += ["     "+str(method) for method in self.methods]
        return "\n".join(rv)
        


def parseTypeFrom(base_type, decl, instances): # parseNode):
    targs = None
    if isinstance(base_type, TemplatedTypeNode):
       targs = []
       for arg in base_type.positional_args:
           if isinstance(arg, CComplexBaseTypeNode):
               #targs.append(arg.base_type.name)
               decl = arg.declarator
               isptr = isinstance(decl, CPtrDeclaratorNode)
               isref = isinstance(decl, CReferenceDeclaratorNode)
               name = arg.base_type.name
               ttype = instances.get(name, Type(name, isptr, isref, None))
               targs.append(ttype)
               
           elif isinstance(arg, NameNode):
               name = arg.name
               ttype = instances.get(name, Type(name, False, False, None))
               targs.append(ttype)
           else:   
               raise Exception("%s, %d: can not handle template arg of type %r" % (self.fileName, self.lineNumber, arg))
             
       base_type = base_type.base_type_node


    isptr = isinstance(decl, CPtrDeclaratorNode)
    isref = isinstance(decl, CReferenceDeclaratorNode)
    return instances.get(base_type.name, Type(base_type.name, isptr, isref, targs))



    

class CPPMethod(object):
    
    def __init__(self, parseNode, lines, instances):
  
        self.lineNumber = parseNode.pos[1]
        self.fileName   = parseNode.pos[0].filename

        decl = parseNode.declarators[0]
        self.result_type = parseTypeFrom(parseNode.base_type, decl, instances)
        
        if isinstance(decl.base, CFuncDeclaratorNode):
           decl = decl.base

        self.name = decl.base.name
        self.args = []
        for arg in decl.args:
            argdecl = arg.declarator
            if isinstance(argdecl, CReferenceDeclaratorNode) or isinstance(argdecl, CPtrDeclaratorNode):
               argname = argdecl.base.name
            else:
               argname = argdecl.name
            self.args.append(  (argname,  parseTypeFrom(arg.base_type, argdecl, instances)))

    def __str__(self):
        rv = CppID(self.result_type)
        rv += " " + self.name
        argl = [ CppID(type_)+" "+str(name) for name, type_ in self.args ]
        return rv + "("+ ", ".join(argl) + ")"


def parse(sourcePath):

    options, sources = parse_command_line(["--cplus", sourcePath])

    sourcePath = os.path.abspath(sourcePath)
    basename = os.path.basename(sourcePath)
    name, ext = os.path.splitext(basename)

    source_desc = FileSourceDescriptor(sourcePath, basename)
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

    lines = open(sourcePath).readlines()

    if isinstance(body, CEnumDefNode):
            return Enum(body, lines)


    return CPPClass(body, lines)






class Generator(object):

    def __init__(self):
        self.declaredTypes = dict()
        self.classesToWrap = list()
        self.includes = []

    def run_over_all(self, sourcelist):

        for source in sourcelist:
            p = parse(source)
            if p is not None:
                dirname = os.path.dirname(source)
                basename = os.path.basename(source)
                filename, _ = os.path.splitext(basename)
                pxdpath = ".".join( [f for f in os.path.split(dirname) if f ] +[filename,] )
                p.cimport = "from %s cimport %s as %s" % (pxdpath, p.name, CID(Type(p.name, False, False, None)))
                print p.cimport
                self.declaredTypes[p.name] = p
                if p.wrap:
                    self.classesToWrap.append(p.name)

    def generateCodeFor(self, className):
        obj = self.declaredTypes[className]
        if isinstance(obj, CPPClass):
            self.generateCodeForClass(obj)


    def generateCodeForClass(self, clz):
        hdrlines =  normalizeIndent("""
               cdef class %(PID)s:
                   cdef %(CID)s  * inst 
                   def __cinit__(self):
                       self.inst = new %(CID)s()

                   def __dealloc__(self):
                       del self.inst

                   cdef replaceInstance(self, %(CID)s * inst):
                       if self.inst:
                             del self.inst
                       self.inst = inst

                      """ % clz.__dict__)
        self.code = [ hdrlines ]
        for method in clz.methods:
            if method.name == clz.name: continue # do not wrap constructors
            self.generateCodeForMethod(method, clz)

        print "\n".join(self.code)


    def inputConversion(self, clz, argpos, argname, type_):

        #type_ = clz.resolveType(type_) # template args

        if type_.isptr:
            raise Exception("input type '%s' not supported" % CID(type_))

        if type_.basetype in Type.CTYPES:
            # nothing to do
            return CppID(type_), "", argname, ""

        if type_.basetype in self.classesToWrap:
            return PID(type_), "", "deref(%s.inst)" %argname, ""

        if type_.basetype == "bool":
            return "int", "", argname, ""

        if type_.basetype == "string":
            inputType = "char *"
            conversionCode =  "cdef string * _%s_as_str = new string(%s)" % (argname, argname)
            callArg = "deref(_%s_as_str)" % argname
            cleanupCode    =  "del _%s_as_str" % argname
            return inputType, conversionCode, callArg, cleanupCode
        
        elif type_.basetype=="vector":
            inputType = ""
            assert len(type_.templateargs)==1, "vector takes only one template arg"
            targ = type_.templateargs[0]
            tempvar = "_v%03d" % argpos
            if targ.basetype in self.classesToWrap:
                tempVar = "_%s_as_vec" % argname
                conversionCode =   "cdef %s * %s = new %s()" % (CID(type_), tempVar, CID(type_))
                conversionCode+= "\ncdef %s %s" % (PID(targ), tempvar)
                conversionCode+= "\nfor %s in %s:" % (tempvar, argname)
                conversionCode+= "\n    deref(%s).push_back(deref(%s.inst))" % (tempVar, tempvar)
            else:
                conversionCode =   "cdef %s * %s = new %s()" % (CID(type_), tempVar, CID(type_))
                conversionCode+= "\nfor _v in %s:" % (tempvar, argname)
                conversionCode+= "\n    deref(%s).push_back(_v)" % tempVar
            callArg = "deref(%s)" % tempVar
            
            cleanupCode = "del %s" % tempVar
            return inputType, conversionCode, callArg, cleanupCode

        raise Exception(CID(type_) + "not supported yet")


    def resultConversion(self, clz, result_type, result_name):

        #result_type = clz.resolveType(result_type)

        if result_type.basetype in ["int", "long", "double", "float"]:
            if result_type.isptr:
                raise Exception("can not handel return type %r" % CID(result_type))
            return "        return "+result_name

        if result_type.basetype == "char":
            # char* is automatically converted
            return "        return "+result_name

        if result_type.basetype == "string":
            # char* is automatically converted
            if result_type.isptr:
                raise Exception("can not handel return type %r" % CID(result_type))
            return "        return %s.c_str()" % result_name

        if result_type.basetype in self.classesToWrap:
            if result_type.isptr:
                raise Exception("can not handel return type %r" % CID(result_type))

            code= "        _%s_py = %s()\n" % (result_name, PID(result_type))
            code+="        _%s_py.replaceInstance(new %s(%s))\n" % (result_name, CID(result_type), result_name)
            code+="        return _%s_py" % result_name
            return code

        if result_type.basetype == "vector":
            if result_type.isptr:
                raise Exception("can not handel return type %r" % CID(result_type))

            assert len(result_type.templateargs) == 1
            targ = result_type.templateargs[0]

            code = "        _rv = list()\n"
            code+= "        for _i in range(%s.size()):\n" % result_name
            code+= "            _res = %s()\n" % PID(targ)
            code+= "            _res.replaceInstance(new %s(%s.at(_i)))\n"  % (CID(targ), result_name)
            code+= "            _rv.append(_res)\n"
            code+= "        return _rv"
            return code
            
        
        return "        return "+result_name
            
        

    def generateOperatorCode(self, clz, method):

        if method.name=="operator[]":
            assert len(method.args) == 1
            argname, type_ = method.args[0]
            assert type_.basetype in ["int", "long"]
            assert not type_.isptr and type_.templateargs is None
            self.code.append("    def __getitem__(self, int idx):")

            rt = CID(method.result_type)
            self.code.append("        cdef %s _res = deref(self.inst)[idx]" % rt)
            self.code.append(self.resultConversion(clz,  method.result_type, "_res"))


    def generateCodeForMethod(self, method, clz):

        handling = []

        if method.name.startswith("operator"):
            self.generateOperatorCode(clz, method)
            return

        # the "2" at the end causes an error in case the default name list is
        # not long enough
        for (argname, type_), (argpos, argdefault) in zip(method.args, enumerate("abcdefghijkl2")):
            argname = argname or argdefault
            inputType, conversionCode, callArg, cleanupCode = self.inputConversion(clz, argpos, argname, type_)
            handling.append((inputType, argname,  conversionCode, callArg, cleanupCode))

        
        inputsig = ", ".join( ["self"] + ["%s %s" % (inputType, argname) for (inputType, argname, _, _, _) in handling] )
        name = method.name
        argnames = ", ".join( callArg for (_, _, _, callArg,  _) in handling )

        declline = """    def %(name)s (%(inputsig)s):""" % locals()
        self.code.append(declline)

        for _, _, conversionCode, _, _ in handling:
            if conversionCode:
                for code in conversionCode.split("\n"):
                    self.code.append("        "+code)

        if method.result_type.basetype == "void":
            self.code.append("        self.inst.%(name)s(%(argnames)s) " % locals())
        
        else: 
            self.code.append("        _result = self.inst.%(name)s(%(argnames)s) " % locals())

        for _, _, _, _, cleanupCode in handling:
            if cleanupCode:
                for code in cleanupCode.split("\n"):
                    self.code.append("        "+code)
        
        
        if method.result_type.basetype == "void":
            self.code.append("        return self")
        else: 
            self.code.append(self.resultConversion(clz, method.result_type, "_result"))


        
        
        
        
    

if __name__ == "__main__":
    import sys
    g = Generator()
    g.run_over_all(sys.argv[1:])
    
    print "from libcpp.vector cimport *"
    print "from libcpp.string cimport *"
    print "from cython.operator cimport address as addr, dereference as deref"
    g.generateCodeFor("Peak1D")
    g.generateCodeFor("Precursor")
    g.generateCodeFor("MSSpectrum")
    g.generateCodeFor("MSExperiment")
    g.generateCodeFor("InstrumentSettings")
    g.generateCodeFor("MzXMLFile")
    #g.generateCodeFor("MzMLFile")
    #g.generateCodeFor("MzDataFile")
    g.generateCodeFor("ChromatogramTools")
