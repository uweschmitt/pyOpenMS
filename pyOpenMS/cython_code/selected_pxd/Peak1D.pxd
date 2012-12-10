
cdef extern from "<OpenMS/KERNEL/Peak1D.h>" namespace "OpenMS":
    
    cdef cppclass Peak1D:   # wrap=True
        Peak1D()
        Peak1D(Peak1D &)
        double getMZ() 
        double getIntensity()
        void setMZ(double)  except +
        void setIntensity(double) except +
