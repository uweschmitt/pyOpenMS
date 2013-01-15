from libcpp.string cimport *
#from InstrumentSettings cimport *

cdef extern from "<OpenMS/METADATA/Precursor.h>" namespace "OpenMS":


    cdef cppclass Precursor: #wrap=True
        Precursor()
        Precursor(Precursor)
        double getMZ()
        double getIntensity()
        void setMZ(double ) except +
        void setIntensity(double ) except +
