
from Types cimport *
from Peak2D cimport *
from MetaInfoInterface cimport *

cdef extern from "<OpenMS/KERNEL/Peak2D.h>" namespace "OpenMS":

    cdef cppclass RichPeak2D(Peak2D, MetaInfoInterface):
        # wrap-inherits:
        #    Peak2D

        RichPeak2D() except +

        # declare again: cython complains for overloaded methods in base
        # classes
        void getKeys(libcpp_vector[String] & keys) except +
        void getKeys(libcpp_vector[unsigned int] & keys) except +
