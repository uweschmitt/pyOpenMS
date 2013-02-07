from libcpp.vector cimport vector as libcpp_vector

cdef extern from "<OpenMS/DATASTRUCTURES/DoubleList.h>" namespace "OpenMS":
    
    cdef cppclass DoubleList:
        DoubleList() nogil except +
        DoubleList(DoubleList) nogil except +
        DoubleList(libcpp_vector[double]) nogil except +
        int size() nogil except +
        double at(int) nogil except +
