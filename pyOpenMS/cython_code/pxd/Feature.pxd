

cdef extern from "<OpenMS/KERNEL/Feature.h>" namespace "OpenMS":
    
    cdef cppclass Feature:   # wrap=True
        Feature()
        Feature(Feature &)
        void setMZ(double) 
        void setRT(double) 
        void setIntensity(double)
        double getMZ() 
        double getRT() 
        double getIntensity()
        void setUniqueId()
