from libcpp.string cimport string as libcpp_string
from libcpp.vector cimport vector as libcpp_vector

cdef extern from "<OpenMS/DATASTRUCTURES/StringList.h>" namespace "OpenMS":

    cdef cppclass StringList:
        StringList() nogil except +
        StringList(StringList) nogil except +
        StringList(libcpp_vector[libcpp_string]) nogil except +
        int size() nogil except +
        libcpp_string at(int) nogil except +
