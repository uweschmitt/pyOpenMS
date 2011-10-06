from libcpp.string cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue: #wrap=True
         DataValue()
         DataValue(char *)
         DataValue(int)   
         int operator()     # name="intValue"; pre="assert self._cons_sig == [int,], 'wrong datatype'"
         string operator()  # name="stringValue"; pre="assert self._cons_sig == [str,], 'wrong datatype'"
