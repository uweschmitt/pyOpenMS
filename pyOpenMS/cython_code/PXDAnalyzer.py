from Cython.Compiler.CmdLine import parse_command_line
from Cython.Compiler.Main import compile_single, CompilationOptions, run_pipeline, create_default_resultobj, CompilationSource
from Cython.Compiler import Pipeline
from Cython.Compiler.Scanning import FileSourceDescriptor
from Cython.Compiler.Nodes import *

import os.path, sys, re

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


def has(node, lines, what):

    parts = lines[node.pos[1]-1].split("#")
    return  len(parts)>1 and what in parts[1]
     

class CPPClass(object):

    def __init__(self, parseNode, lines):
        self.name = parseNode.name
        self.lineNumber = parseNode.pos[1]
        self.fileName   = parseNode.pos[0].filename
        # re.search("inst\W*=\W*<(.*)>", " inst = <a,b>")
        self.wrap = has(parseNode, lines, "wrap")

        self.templateArgs = None 
        self.templateArgInstances = None
        if parseNode.templates is not None:
            self.templateArgs = parseNode.templates
            m = re.search("inst\W*=\W*<(.*)>", lines[self.lineNumber-1])
            if not m:
                raise Exception("need inst=<A,..> arg for template class")
            self.templateArgInstances = [ name.strip() for name in m.group(1).split(",") ]
            

        self.methods = []

        for att in parseNode.attributes:
            if not has(att, lines, "ignore"):
                self.methods.append(CPPMethod(att, lines))

    def __str__(self):
        if self.templateArgInstances is not None:
            templateparam=  "["+ ", ".join( [ str(t) for t in self.templateArgInstances ]) + "] "
        else:
            templateparam=""
        rv = ["class %s %s: " % (self.name, templateparam) ]
        rv += ["     "+str(method) for method in self.methods]
        return "\n".join(rv)
        

class CPPMethod(object):

    def __init__(self, parseNode, lines):
        #import pdb; pdb.set_trace()
        self.rv         = parseNode.base_type.name
  
        self.lineNumber = parseNode.pos[1]
        self.fileName   = parseNode.pos[0].filename

        self.returnsPointer = False
        self.args = []

        assert len(parseNode.declarators) == 1
        desc = parseNode.declarators[0]
        if isinstance(desc, CPtrDeclaratorNode):
            self.returnsPointer = True
            self.name = desc.base.base.name
            for arg in desc.base.args:
                isptr = isinstance(arg.declarator, CPtrDeclaratorNode)
                self.args.append((arg.base_type.name or arg.base_type_node.name, isptr, None))
        elif isinstance(desc, CFuncDeclaratorNode):
            self.name = desc.base.name 
            for arg in desc.args:
                targs = None
                if isinstance(arg.base_type, TemplatedTypeNode):
                    isptr = isinstance(arg.declarator, CPtrDeclaratorNode)
                    targs = [ a.name for a in arg.base_type.positional_args ]
                    self.args.append((arg.base_type.base_type_node.name, isptr, targs))
                elif isinstance(arg.base_type, CSimpleBaseTypeNode):
                    self.args.append((arg.base_type.name, isinstance(arg.declarator, CPtrDeclaratorNode), None))
                else:
                    raise Exception("nodetype %r not supported yet" % arg.base_type)
        
        else:
            raise Exception("nodetype %r not supported yet" % desc)

    def __str__(self):
        rv = "*" if self.returnsPointer else " "
        rv += "void " if self.rv is None else self.rv+" "
        rv += self.name
        args = [ name + ( "*" if isPtr else "") + (" [" + ", ".join(templates) +  "]" if templates else "")
                   for (name, isPtr, templates) in self.args ]

        return rv + "("+ ", ".join(args) + ")"

        
        

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


if __name__ == "__main__":

    for p in sys.argv[1:]:
        print parse(p)
