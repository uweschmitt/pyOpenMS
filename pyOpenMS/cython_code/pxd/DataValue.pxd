from libcpp.string cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue: #wrap=True
         DataValue()
         DataValue(char *)
         DataValue(int)   
         int operator()     # ignore=True;name="intValue"; pre="assert self._con_sig == [int,]"
         string operator()  # ignore=True;name="stringValue"; pre="assert self._con_sig == [int,]"
