from libcpp.string cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue: #wrap=True
         DataValue()
         DataValue(char *)
         DataValue(int)   
         DataValue(double)   
         int operator()     # name="intValue"; pre="assert self._cons_sig == [int,], 'wrong datatype'"
         string operator()  # name="stringValue"; pre="assert self._cons_sig == [str,], 'wrong datatype'"
         double operator()  # name="floatValue"; pre="assert self._cons_sig == [float,], 'wrong datatype'"
