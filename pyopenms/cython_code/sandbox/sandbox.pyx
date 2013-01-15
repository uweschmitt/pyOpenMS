from libcpp.string cimport *
from cython.operator cimport dereference as deref
from DataValue cimport DataValue as _DataValue


cdef class DataValue:

    cdef _DataValue * inst
    cdef list sig

    cdef _set_inst(self, _DataValue *inst):
         self.inst = inst

    def __init__(self, *a, **kw):
        self.sig = map(type, a)
        if len(a) == 0 and kw.get("_no_init"):
            self.inst = new _DataValue() 
        if len(a) == 1:
            if self.sig == [int,]:
                self.inst = new _DataValue(<int>a[0])
            elif self.sig == [str,]:
                self.inst = new _DataValue(<char *>a[0]) 
            else:
                raise Exception("unknown input args %r" % a)


    def getInt(self):
        assert self.sig == [int,]
        return <int>deref(self.inst)

    def getString(self):
        assert self.sig == [str,]
        return (<string>deref(self.inst)).c_str()




cdef _init(int i):
    cdef _DataValue * inst = new _DataValue(i)
    cdef DataValue rv = DataValue(_no_init=True)
    rv._set_inst(inst)
    return rv

def intValue(i):
    return _init(i)


class Test(object):
    class Inner(object):
        A=1
