#encoding: utf-8
from   string import Template

class Code(object):

    """ class to collect code lines,
        code can be nested.

        example usage:

            h = Code()

            h += "def hello($varname):"
            h>>1
            h += "print $varname"
            h<<1
            h.resolve(varname="arg")

        for more use cases see DelegateClassGenerator.py

    """

    def __init__(self, *a):
        self.lines = list(a)
        self.level = 0

    def __lshift__(self, indent):
        self.level -= indent
        assert self.level >= 0

    def __rshift__(self, indent):
        self.level += indent

    def __iter__(self):
        return iter(self.lines)

    def __iadd__(self, what):

        if type(what) == Code:
            # code has no outer identation:
            assert what.level == 0 
            for line in what:
                self += line
            return self

        if type(what) == list or type(what)==tuple:
            for line in what:
                self += line
            return self

        indent = self.level * 4 * " "
        lines = what.split("\n")
        # multi lines:
        #   first nonempty line is aligend to the left
        #   relative identation of following line is preserved
        if len(lines)>1:
            i0 = 0
            for l in lines:
                ls = l.lstrip()
                if ls: # first nonempty line dictates indent
                    i0 = len(l)-len(ls)
                    break
            lines = [ l[i0:] for l in lines ]
        self.lines.extend(( indent + l for l in lines))
        return self

    def addFile(self, path, indent=0):
        c = Code()
        with open(path, "r") as fp:
            for l in fp:
                c += l.rstrip()
        self += c
        return self

    def resolve(_self, **parameters):
        # in some situtations **parameters contains a key "self", which
        # lets this method crash unless we use something else as "self" for
        # the first arg
        resolved = []
        for line in _self.lines:
                resolved.append(Template(line).substitute(parameters))
        _self.lines = resolved
        return _self

    def write(self, out, indent=0):
        for l in self.lines:
              print >> out, l
        return self

    def __str__(self):
        return "\n".join(self.lines)

