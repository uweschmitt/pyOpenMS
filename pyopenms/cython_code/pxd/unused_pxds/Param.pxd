from libcpp.list cimport *
from string cimport *
from InstrumentSettings cimport *
from DataValue cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/Param.h>" namespace "OpenMS":


    cdef cppclass Param:

        Param()
        Param(Param)
        void setValue(string, DataValue)
        DataValue getValue(string) except+
        void store(string) except+
        void load(string) except+


cdef extern from "HelperFunctions.h":
    list[string] getKeys(Param)
    list[string].iterator next(list[string].iterator)

