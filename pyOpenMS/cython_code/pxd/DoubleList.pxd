from libcpp.string cimport *
from libcpp.vector cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DoubleList.h>" namespace "OpenMS":
    
    cdef cppclass DoubleList:
        DoubleList()
        DoubleList(vector[double])
        int size()
        double at(int)
