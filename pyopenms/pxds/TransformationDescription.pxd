from libcpp.vector cimport vector as libcpp_vector
from libcpp.pair   cimport pair as libcpp_pair

cdef extern from "<OpenMS/ANALYSIS/MAPMATCHING/TransformationDescription.h>" namespace "OpenMS":

    cdef cppclass TransformationDescription:
        TransformationDescription()
        TransformationDescription(TransformationDescription)
        libcpp_vector[libcpp_pair[double,double]] getDataPoints()
        double apply(double)
