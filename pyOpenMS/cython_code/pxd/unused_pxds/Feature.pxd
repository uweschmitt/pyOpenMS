
cdef extern from "<OpenMS/KERNEL/Feature.h>" namespace "OpenMS":

    cdef cppclass Feature:
        Feature()
        Feature(Feature)
        float getQuality()
        int   getCharge()
        float getWidth()
        double getMZ()
        double getRT()
        void   setMZ(double)
        void   setRT(double)
        
