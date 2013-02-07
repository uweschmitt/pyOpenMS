from libcpp.vector cimport vector as libcpp_vector

cdef extern from "<OpenMS/DATASTRUCTURES/IntList.h>" namespace "OpenMS":

    cdef cppclass IntList:
        IntList()          nogil except +
        IntList(IntList)          nogil except +
        IntList(libcpp_vector[int])          nogil except +
        int size()          nogil except +
        int at(int) nogil except +
