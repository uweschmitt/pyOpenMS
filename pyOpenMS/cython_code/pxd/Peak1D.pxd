
cdef extern from "<OpenMS/KERNEL/Peak1D.h>" namespace "OpenMS":
    
    cdef cppclass Peak1D:   # wrap
        Peak1D()
        Peak1D(Peak1D &)
        double getMZ() 
        double getIntensity()
        void setMZ(double) 
        void setIntensity(double)
