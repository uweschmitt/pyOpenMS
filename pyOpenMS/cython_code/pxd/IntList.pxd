from libcpp.string cimport *
from libcpp.vector cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/IntList.h>" namespace "OpenMS":
    
    cdef cppclass IntList:
        IntList()
        IntList(vector[long])
        int size()
        int at(int)
