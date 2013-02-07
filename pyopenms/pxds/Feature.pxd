

cdef extern from "<OpenMS/KERNEL/Feature.h>" namespace "OpenMS":

    cdef cppclass Feature:
        Feature() nogil except +
        Feature(Feature &) nogil except +
        void setMZ(double)  nogil except +
        void setRT(double)  nogil except +
        void setIntensity(double) nogil except +
        double getMZ() nogil except +
        double getRT() nogil except +
        double getIntensity() nogil except +
        void setUniqueId() nogil except +
