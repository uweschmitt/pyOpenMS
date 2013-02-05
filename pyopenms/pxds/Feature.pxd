

cdef extern from "<OpenMS/KERNEL/Feature.h>" namespace "OpenMS":

    cdef cppclass Feature:
        Feature() except +
        Feature(Feature &) except +
        void setMZ(double)  except +
        void setRT(double)  except +
        void setIntensity(double) except +
        double getMZ() except +
        double getRT() except +
        double getIntensity() except +
        void setUniqueId() except +
