from libcpp.string cimport *
from libcpp.vector cimport *
from StringList cimport *
from IntList cimport *
from DoubleList cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue: #wrap=True
         DataValue()
         DataValue(vector[string]) #ignore=True
         DataValue(vector[int]) #ignore=True
         DataValue(vector[float]) #ignore=True
         DataValue(char *)
         DataValue(int)   
         DataValue(double)   
         DataValue(StringList)    
         DataValue(IntList) #ignore=True
         DataValue(DoubleList) #ignore=True
         int operator()     # name="intValue"; pre="assert self._cons_sig == ['int'], 'type mismatch'"
         string operator()  # name="stringValue"; pre="assert self._cons_sig == ['str'], 'type mismatch'"
         double operator()  # name="floatValue"; pre="assert self._cons_sig == ['float'], 'type mismatch'"
         StringList operator() # name="stringList"
         DoubleList operator() # ignore=True; name="floatList"
         IntList operator() # ignore=True; name="intList"


