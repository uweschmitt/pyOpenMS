from libcpp.vector cimport vector as libcpp_vector

cdef extern from "<OpenMS/DATASTRUCTURES/IntList.h>" namespace "OpenMS":
    
    cdef cppclass IntList: #wrap=True
        IntList()
        IntList(IntList)
        IntList(libcpp_vector[int])
        int size()
        int at(int) except +
