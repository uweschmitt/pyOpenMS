from libcpp cimport *
from Types cimport *
from RichPeak2D cimport *

cdef extern from "<OpenMS/KERNEL/BaseFeature.h>" namespace "OpenMS":

    cdef cppclass BaseFeature:

        BaseFeature()  nogil except +
        BaseFeature(BaseFeature &) # wrap-ignore
        Real getQuality()  nogil except +
        void setQuality(Real q) nogil except +
        Real getWidth() nogil except +
        void setWidth(Real q) nogil except +
        Int getCharge() nogil except +
        void setCharge(Int q) nogil except +
        bool operator==(BaseFeature) nogil except +

        void getKeys(libcpp_vector[String] & keys) nogil except +
        void getKeys(libcpp_vector[unsigned int] & keys) nogil except +


