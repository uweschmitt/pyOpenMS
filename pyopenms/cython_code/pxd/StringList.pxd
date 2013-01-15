from libcpp.string cimport *
from libcpp.vector cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/StringList.h>" namespace "OpenMS":
    
    cdef cppclass StringList: #wrap=True
        StringList()
        StringList(StringList)
        StringList(vector[string]) except +
        int size()
        string at(int) except +
