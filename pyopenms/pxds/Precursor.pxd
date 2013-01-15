from libcpp.string cimport string as libcpp_string
#from InstrumentSettings cimport *

cdef extern from "<OpenMS/METADATA/Precursor.h>" namespace "OpenMS":

    cdef cppclass Precursor:
        Precursor()
        Precursor(Precursor)
        double getMZ()
        double getIntensity()
        void setMZ(double ) except +
        void setIntensity(double ) except +
