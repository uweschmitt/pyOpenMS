#from cython.operators import preincrement
#from libcpp.vector cimport *
#from libcpp.list cimport *
#from pxd.DataValue cimport *
#from pxd.DataValue_DataType cimport *
#from pxd.Param cimport *


def getKeys(Param self):
    cdef list rv = list()

    cdef _ParamIterator param_it = self.inst.begin()
    while param_it != self.inst.end():
        rv.append(param_it.getName().c_str())
        preincrement(param_it)

    return rv

