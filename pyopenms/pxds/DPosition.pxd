
from libcpp cimport *
from Types cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DPosition.h>" namespace "OpenMS":

    cdef cppclass DPosition[N]:
        # wrap-ignore
        DPosition()

    ctypedef DPosition DPosition1 "DPosition<1>"
