from libcpp.vector cimport *
from libcpp.pair   cimport *

cdef extern from "<OpenMS/ANALYSIS/MAPMATCHING/TransformationDescription.h>" namespace "OpenMS":

    cdef cppclass TransformationDescription: # wrap=True;
        TransformationDescription()
        TransformationDescription(TransformationDescription)
        vector[pair[double,double]] getDataPoints()
        double apply(double)
