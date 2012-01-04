#encoding: utf-8
from Cython.Compiler.CmdLine import parse_command_line
from Cython.Compiler.Main import create_default_resultobj, CompilationSource
from Cython.Compiler import Pipeline
from Cython.Compiler.Scanning import FileSourceDescriptor
from Cython.Compiler.Nodes import *
from Cython.Compiler.ExprNodes import *

from Types import *

import re
import os

from collections import defaultdict



def parse_annotations(node, lines):
    parts = lines[node.pos[1] - 1].split("#")
    result = dict()
    if len(parts)>1:
        # parse python statements in comments
        dd = dict()
        exec parts[1].strip() in dd
        allowed = [int, float, str, bool, tuple, list]
        result = dict( (k,v) for (k,v) in dd.items() if type(v) in allowed )
    return result
        


class Enum(object):

    def __init__(self, name, items, annotations):
        self.name = name
        self.items = items
        self.annotations = annotations
        self.wrap = annotations.get("wrap", False)
        self.py_name = name
        self.type_ = Type(self.name, is_enum=True)

    @classmethod
    def fromTree(cls, node, lines):
        name = node.name
        items = []
        annotations = parse_annotations(node, lines)

        current_value = 0
        for item in node.items:
            if item.value is not None:
                current_value = item.value.constant_result
            items.append((item.name, current_value))
            current_value += 1

        return cls(name, items, annotations)

    def __str__(self):
        res = "enum %s : " % self.name
        res += ", ".join("%s: %d" % (i, v) for (i, v) in self.items)
        return res


class CPPClass(object):

    # allows only one instantiation tuple in comments.
    # if you want more:
    #    - make factory from __init__
    #    - return individual classes
    #    - further todo: individual Python names for distinct instances
    #      (maybe via comment:  inst PyClassOne=<B,C>

    def __init__(self, name, instances, targs, methods, annotations):
        self.name = name
        self.instances = instances
        self.targs = targs
        self.methods = methods
        self.annotations = annotations

        self.wrap = not annotations.get("ignore", False)
        self.type_ = Type(name, template_args = targs)
        self.cy_repr = cy_repr(self.type_)
        self.py_name = py_name(self.type_)

    @classmethod
    def fromTree(cls, node, lines):

        typedefs = dict() # record here, but later not used
        if hasattr(node, "stats"): # more than just class def
            for stat in node.stats:
                if isinstance(stat, CTypeDefNode):
                    alias = stat.base_type.name
                    basetype = stat.declarator.base.name
                    args = [ Type(decl.name) for decl in stat.declarator.dimension.args ]
                    typedefs[alias] = Type(basetype, template_args=args)
                elif isinstance(stat, CppClassNode):
                    node = stat
                    break
                else:
                    print "ignore node", stat

        name = node.name
        annotations = parse_annotations(node, lines)

        instances = dict()  # maps template args to instantiation types

        targs = None
        if node.templates is not None:
            instargs = annotations.get("inst")
            ttargs = None # noe nested templates supported 
            targs = [Type(t.strip(), template_args = ttargs) for t in instargs]
            instances = dict(zip(node.templates, targs))


        methods = defaultdict(list)

        for att in node.attributes:
            meth = CPPMethod.fromTree(att, lines, instances)
            if meth is not None:
                methods[meth.name].append(meth)

        return cls(name, instances, targs, methods, annotations)
        

    def __str__(self):
        rv = ["class %s: " % cy_repr(self.type_)]
        for meth_list in self.methods.values():
            rv += ["     " + str(method) for method in meth_list]
        return "\n".join(rv)


def extract_type(base_type, decl, instances):
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
                ttype = instances.get(name, Type(name, is_ptr, is_ref))
                targs.append(ttype)
            elif isinstance(arg, NameNode):
                name = arg.name
                targs.append(instances.get(name, Type(name)))
            elif isinstance(arg, IndexNode): # nested template !
                # only handles one nesting level !
                name = arg.base.name
                if hasattr(arg.index, "args"):
                    args = [ Type(a.name) for a in arg.index.args ]
                else:
                    args = [ Type(arg.index.name) ]
                tt = Type(name, template_args=args)
                targs.append(tt)
            else:
                raise Exception("can not handle template arg %r" % arg)

        base_type = base_type.base_type_node

    is_ptr = isinstance(decl, CPtrDeclaratorNode)
    is_ref = isinstance(decl, CReferenceDeclaratorNode)
    is_unsigned = hasattr(base_type, "signed") and not base_type.signed
    return instances.get(base_type.name, Type(base_type.name, is_ptr,
                                              is_ref, is_unsigned, targs))


class CPPMethod(object):

    def __init__(self, result_type,  name, args, annotations):

        self.result_type = result_type
        self.name = name
        self.args = args
        self.annotations = annotations
        self.wrap = not self.annotations.get("ignore", False)

    @classmethod
    def fromTree(cls, node, lines, instances):

        annotations = parse_annotations(node, lines)
        
        if isinstance(node, CppClassNode):
            return None # nested classes only can be delcared in pxd

        decl = node.declarators[0]
        result_type = extract_type(node.base_type, decl, instances)

        if isinstance(decl, CNameDeclaratorNode):
            if re.match("^operator\W*\(\)$", decl.name):
                name = decl.name[:-2]
                args = []
                return cls(result_type, name, args, annotations)
            raise Exception("can not handle %s" % decl.name)

        if isinstance(decl.base, CFuncDeclaratorNode):
            decl = decl.base

        name = decl.base.name
        args = []
        for arg in decl.args:
            argdecl = arg.declarator
            if isinstance(argdecl, CReferenceDeclaratorNode) or \
               isinstance(argdecl, CPtrDeclaratorNode):
                argname = argdecl.base.name
            else:
                argname = argdecl.name
            tt = extract_type(arg.base_type, argdecl, instances)
            args.append((argname,tt))
                              

        return cls(result_type, name, args, annotations)

    def __str__(self):
        rv = cy_repr(self.result_type)
        rv += " " + self.name
        argl = [cy_repr(type_) + " " + str(name) for name, type_ in self.args]
        return rv + "(" + ", ".join(argl) + ")"


def parse(path):

    """ reads pxd file and extracts *SINGLE* class """

    options, sources = parse_command_line(["--cplus", path])

    path = os.path.abspath(path)
    basename = os.path.basename(path)
    name, ext = os.path.splitext(basename)

    source_desc = FileSourceDescriptor(path, basename)
    source = CompilationSource(source_desc, name, os.getcwd())
    result = create_default_resultobj(source, options)

    context = options.create_context()
    pipeline = Pipeline.create_pyx_pipeline(context, options, result)
    tree = pipeline[0](source)  # only parser

    if hasattr(tree.body, "stats"):
        for s in tree.body.stats:
            if isinstance(s, CDefExternNode):
                body = s.body
                break
    else:
        body = tree.body.body

    lines = open(path).readlines()

    if isinstance(body, CEnumDefNode):
            return Enum.fromTree(body, lines)

    return CPPClass.fromTree(body, lines)

if __name__ == "__main__":
    import sys
    print parse(sys.argv[1])
