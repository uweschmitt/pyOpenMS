from string cimport *
from InstrumentSettings cimport *

cdef extern from "<OpenMS/METADATA/Precursor.h>" namespace "OpenMS":


    cdef cppclass Precursor: #wrapall
        Precursor()
        Precursor(Precursor)
        double getMZ()
        double getIntensity()
        void setMZ(double )
        void setIntensity(double )
