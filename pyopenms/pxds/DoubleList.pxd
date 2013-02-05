from libcpp.vector cimport vector as libcpp_vector

cdef extern from "<OpenMS/DATASTRUCTURES/DoubleList.h>" namespace "OpenMS":
    
    cdef cppclass DoubleList:
        DoubleList() except +
        DoubleList(DoubleList) except +
        DoubleList(libcpp_vector[double]) except +
        int size() except +
        double at(int) except +
