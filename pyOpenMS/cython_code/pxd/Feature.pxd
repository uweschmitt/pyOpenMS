

cdef extern from "<OpenMS/KERNEL/Feature.h>" namespace "OpenMS":
    
    cdef cppclass Feature:   # wrap=True
        Feature()
        Feature(Feature &)
        void setMZ(double)  except +
        void setRT(double)  except +
        void setIntensity(double) except +
        double getMZ() 
        double getRT() 
        double getIntensity()
        void setUniqueId()
