
from Types cimport *
from Peak1D cimport *
from MetaInfoInterface cimport *

cdef extern from "<OpenMS/KERNEL/Peak1D.h>" namespace "OpenMS":

    cdef cppclass RichPeak1D(Peak1D, MetaInfoInterface):
        # wrap-inherits:
        #    Peak1D

        RichPeak1D()

        # declare again: cython complains for overloaded methods in base
        # classes
        void getKeys(libcpp_vector[String] & keys)
        void getKeys(libcpp_vector[unsigned int] & keys)
