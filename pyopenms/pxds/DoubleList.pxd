from libcpp.vector cimport vector as libcpp_vector

cdef extern from "<OpenMS/DATASTRUCTURES/DoubleList.h>" namespace "OpenMS":
    
    cdef cppclass DoubleList: #wrap=True
        DoubleList()
        DoubleList(DoubleList)
        DoubleList(libcpp_vector[double])
        int size()
        double at(int) except +
