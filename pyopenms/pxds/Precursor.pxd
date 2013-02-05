from libcpp.string cimport string as libcpp_string
#from InstrumentSettings cimport *

cdef extern from "<OpenMS/METADATA/Precursor.h>" namespace "OpenMS":

    cdef cppclass Precursor:
        Precursor()           except +
        Precursor(Precursor)           except +
        double getMZ()           except +
        double getIntensity()           except +
        void setMZ(double ) except +
        void setIntensity(double ) except +
