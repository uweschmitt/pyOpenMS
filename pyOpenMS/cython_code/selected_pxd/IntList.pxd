from libcpp.string cimport *
from libcpp.vector cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/IntList.h>" namespace "OpenMS":
    
    cdef cppclass IntList: #wrap=True
        IntList()
        IntList(IntList)
        IntList(vector[int])
        int size()
        int at(int) except +
