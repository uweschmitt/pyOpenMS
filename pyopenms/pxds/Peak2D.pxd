from libcpp cimport *
from Types cimport *

cdef extern from "<OpenMS/KERNEL/Peak2D.h>" namespace "OpenMS":

    cdef cppclass Peak2D:
        Peak2D()
        Peak2D(Peak2D &)
        Real getIntensity()     except +
        DoubleReal getMZ()     except +
        DoubleReal getRT()     except +
        void setMZ(DoubleReal)  except +
        void setRT(DoubleReal)  except +
        void setIntensity(Real) except +
        bool operator==(Peak2D) except +

#TODO: getPosition
