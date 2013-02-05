from libcpp.vector cimport vector as libcpp_vector

cdef extern from "<OpenMS/DATASTRUCTURES/IntList.h>" namespace "OpenMS":

    cdef cppclass IntList:
        IntList()          except +
        IntList(IntList)          except +
        IntList(libcpp_vector[int])          except +
        int size()          except +
        int at(int) except +
