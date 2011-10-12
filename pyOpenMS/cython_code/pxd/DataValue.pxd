from libcpp.string cimport *
from libcpp.vector cimport *
from StringList cimport *
from IntList cimport *
from DoubleList cimport *
from DataValue_DataType cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue: #wrap=True
         DataValue()
         DataValue(DataValue)
         DataValue(vector[string]) #ignore=True
         DataValue(vector[int]) #ignore=True
         DataValue(vector[float]) #ignore=True
         DataValue(char *)
         DataValue(int)   
         DataValue(double)   
         DataValue(StringList)    
         DataValue(IntList) 
         DataValue(DoubleList) 

         int operator()        # name="intValue";    pre="assert self.valueType() == DataType.INT_VALUE"
         string operator()     # name="stringValue"; pre="assert self.valueType() == DataType.STRING_VALUE"
         double operator()     # name="doubleValue";  pre="assert self.valueType() in [DataType.DOUBLE_VALUE, DataType.INT_VALUE]"
         StringList operator() # name="stringList";  pre="assert self.valueType() == DataType.STRING_LIST"
         DoubleList operator() # name="doubleList";  pre="assert self.valueType() == DataType.DOUBLE_LIST"
         IntList operator()    # name="intList";     pre="assert self.valueType() == DataType.INT_LIST"

         DataType valueType()
         int isEmpty()


