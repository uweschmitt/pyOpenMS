from libcpp cimport *
from Types cimport *
from RichPeak2D cimport *

cdef extern from "<OpenMS/KERNEL/BaseFeature.h>" namespace "OpenMS":

    cdef cppclass BaseFeature:

        BaseFeature()
        BaseFeature(BaseFeature &) # wrap-ignore
        Real getQuality() except +
        void setQuality(Real q) except +
        Real getWidth() except +
        void setWidth(Real q) except +
        Int getCharge() except +
        void setCharge(Int q) except +
        bool operator==(BaseFeature) except +

        void getKeys(libcpp_vector[String] & keys) except +
        void getKeys(libcpp_vector[unsigned int] & keys) except +


