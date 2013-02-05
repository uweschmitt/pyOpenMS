from libcpp cimport *
from Types cimport *
from DPosition cimport *

cdef extern from "<OpenMS/KERNEL/Peak1D.h>" namespace "OpenMS":

    cdef cppclass Peak1D:
        Peak1D()               except +
        Peak1D(Peak1D &)               except +
        Real getIntensity()     except +
        DoubleReal getMZ()     except +
        void setMZ(DoubleReal)  except +
        void setIntensity(Real) except +
        bool operator==(Peak1D) except +
        #DPosition1 getPosition() except +
