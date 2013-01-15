from libcpp.string cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue:
         DataValue()
         DataValue(char *)
         DataValue(int)   
         int operator() 
         string operator() 
