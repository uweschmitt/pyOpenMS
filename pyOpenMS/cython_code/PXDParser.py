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


def has(node, lines, what):
    """ look for 'what' in comment according to 'node'.
        'lines' are the line of the file """
    parts = lines[node.pos[1] - 1].split("#")
    return  len(parts) > 1 and what in parts[1]


class Enum(object):

    def __init__(self, node, lines):
        self.name = node.name
        self.items = []
        self.line_number = node.pos[1]
        self.file_name = node.pos[0].filename
        self.wrap = has(node, lines, "wrap")

        current_value = 0
        for item in node.items:
            if item.value is not None:
                current_value = item.value.constant_result
            self.items.append((item.name, current_value))
            current_value += 1

        self.py_repr = self.name
        self.type_ = Type(self.name, is_enum=True)

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

    def __init__(self, node, lines):
        self.name = node.name
        self.line_number = node.pos[1]
        self.file_name = node.pos[0].filename
        self.wrap = has(node, lines, "wrap")

        self.instances = dict()  # maps template args to instantiation types

        targs = None
        if node.templates is not None:
            # parse comment
            m = re.search("inst\W*=\W*<(.*)>", lines[self.line_number - 1])
            if self.wrap and not m:
                raise Exception("need inst=<A,..> arg for template class")
            instargs = m.group(1).split(",")
            # template nesting not supported:
            ttargs = None
            targs = [Type(t.strip(), template_args = ttargs) for t in instargs]
            self.instances = dict(zip(node.templates, targs))

        self.type_ = Type(self.name, template_args = targs)
        self.cpp_repr = cpp_repr(self.type_)
        self.cy_repr = cy_repr(self.type_)
        self.py_repr = py_repr(self.type_)

        self.methods = defaultdict(list)

        for att in node.attributes:
            if not has(att, lines, "ignore"):
                meth = CPPMethod(att, lines, self.instances)
                self.methods[meth.name].append(meth)
        

    def __str__(self):
        rv = ["class %s: " % cpp_repr(self.type_)]
        for meth_list in self.methods.values():
            rv += ["     " + str(method) for method in meth_list]
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
                ttype = instances.get(name, Type(name, is_ptr, is_ref))
                targs.append(ttype)
            elif isinstance(arg, NameNode):
                name = arg.name
                targs.append(instances.get(name, Type(name)))
            else:
                raise Exception("%s,%d: can not handle template arg %r"\
                                % (self.file_name, self.line_number, arg))

        base_type = base_type.base_type_node

    is_ptr = isinstance(decl, CPtrDeclaratorNode)
    is_ref = isinstance(decl, CReferenceDeclaratorNode)
    is_unsigned = not base_type.signed
    return instances.get(base_type.name, Type(base_type.name, is_ptr,
                                              is_ref, is_unsigned, targs))


class CPPMethod(object):

    def __init__(self, node, lines, instances):

        self.line_number = node.pos[1]
        self.file_name = node.pos[0].filename

        decl = node.declarators[0]
        self.result_type = parse_type(node.base_type, decl, instances)

        if isinstance(decl, CNameDeclaratorNode):
            if re.match("^operator\W*\(\)$", decl.name):
                self.name = decl.name[:-2]
                self.args = []
                return
            raise Exception("can not handle %s" % decl.name)

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
        argl = [cpp_repr(type_) + " " + str(name) for name, type_ in self.args]
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
            return Enum(body, lines)

    return CPPClass(body, lines)

if __name__ == "__main__":
    import sys
    print parse(sys.argv[1])
