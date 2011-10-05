from libcpp.string cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue: #wrap
         DataValue()
         DataValue(char *)
         DataValue(int)   
         int operator()     # ignore
         string operator()  # ignore
