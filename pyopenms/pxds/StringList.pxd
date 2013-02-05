from libcpp.string cimport string as libcpp_string
from libcpp.vector cimport vector as libcpp_vector

cdef extern from "<OpenMS/DATASTRUCTURES/StringList.h>" namespace "OpenMS":

    cdef cppclass StringList:
        StringList() except +
        StringList(StringList) except +
        StringList(libcpp_vector[libcpp_string]) except +
        int size() except +
        libcpp_string at(int) except +
