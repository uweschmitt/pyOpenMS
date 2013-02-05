from libcpp.vector cimport vector as libcpp_vector
from libcpp.pair   cimport pair as libcpp_pair

cdef extern from "<OpenMS/ANALYSIS/MAPMATCHING/TransformationDescription.h>" namespace "OpenMS":

    cdef cppclass TransformationDescription:
        TransformationDescription() except +
        TransformationDescription(TransformationDescription) except +
        libcpp_vector[libcpp_pair[double,double]] getDataPoints() except +# wrap-ignore
        double apply(double) except +
