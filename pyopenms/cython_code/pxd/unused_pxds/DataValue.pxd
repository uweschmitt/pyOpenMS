from string cimport *
from InstrumentSettings cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS::DataValue":


    cdef enum DataType:
    
        STRING_VALUE,     
        INT_VALUE,        
        DOUBLE_VALUE,     
        STRING_LIST,      
        INT_LIST,         
        DOUBLE_LIST,      
        EMPTY_VALUE       

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":

    cdef cppclass DataValue:
        DataValue()
        DataValue(DataValue)
        DataValue(char *)
        DataValue(double)
        DataValue(long)
        char * toChar()

        DataType valueType()
