#from libcpp.string cimport *
#from libcpp.vector cimport *
#from DataValue cimport *
#from String cimport *
from libc.string cimport const_char


cdef extern from "<OpenMS/DATASTRUCTURES/String.h>" namespace "OpenMS":

    cdef cppclass String:
        # we have converters for this, do not wrap the class itself !
        # wrap-ignore
         String() except +
         String(String) except +
         String(char *) except +
         const_char * c_str() except +
