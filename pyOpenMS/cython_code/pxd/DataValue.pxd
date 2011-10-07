from libcpp.string cimport *
from StringList cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue: #wrap=True
         DataValue()
         DataValue(char *)
         DataValue(int)   
         DataValue(double)   
         #DataValue(StringList)   
         int operator()     # name="intValue"; pre="assert self._cons_sig == [int,]"
         string operator()  # name="stringValue"; pre="assert self._cons_sig == [str,]"
         #StringList operator() # name="stringList"
         double operator()  # name="floatValue"; pre="assert self._cons_sig == [float]"


