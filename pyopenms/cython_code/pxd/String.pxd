from libcpp.string cimport *
from libcpp.vector cimport *
from DataValue cimport *
from String cimport *


cdef extern from "<OpenMS/DATASTRUCTURES/String.h>" namespace "OpenMS":
    
    cdef cppclass String: #wrap=True
         String()
         String(String)
         String(char *) except +
         char * c_str()     # result_cast="<char *>"
