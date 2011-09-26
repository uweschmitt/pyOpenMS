from PXDAnalyzer import Enum, CPPClass, CPPMethod, parse
from pprint import pprint
import os


class Generator(object):

    def __init__(self):
        self.declaredTypes = dict()
        self.classesToWrap = list()

    def run_over_all(self, sourcelist):

        for source in sourcelist:
            p = parse(source)
            if p is not None:
                dirname = os.path.dirname(source)
                basename = os.path.basename(source)
                filename, _ = os.path.splitext(basename)
                pxdpath = ".".join( [f for f in os.path.split(dirname) if f ] +[filename,] )
                p.cimport = "from %s cimport %s as _%s" % (pxdpath, p.name, p.name)
                self.declaredTypes[p.name] = p
                if p.wrap:
                    self.classesToWrap.append(p.name)

    def generateCodeFor(self, className):
        obj = self.declaredTypes[className]
        if isinstance(obj, CPPClass):
            return self.generateCodeForClass(obj)

    def generateCodeForClass(self, obj):
    
        print obj.cimport 

        hdr = """
               cdef class %(name)s:
                    cdef %(name)s_  * inst 
                    def __cinit__(self):
                        self.inst = new %(name)s_()
                      """ % obj.__dict__

        hdrlines = [ l for l in hdr.split("\n") if l.strip() ]
        print hdrlines

        indent = len(hdrlines[0])-len(hdrlines[0].lstrip())
        for line in hdrlines:
            print line[indent:]
        
    

if __name__ == "__main__":
    import sys
    g = Generator()
    g.run_over_all(sys.argv[1:])
    
    g.generateCodeFor("ChromatogramTools")
