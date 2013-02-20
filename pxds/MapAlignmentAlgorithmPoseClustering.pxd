from Peak1D cimport *
from ChromatogramPeak cimport *
from TransformationDescription cimport *
from MSExperiment cimport *
from String cimport *
from Param cimport *
from Feature cimport *
from FeatureMap cimport *
from DefaultParamHandler cimport *
from Types cimport *

cdef extern from "<OpenMS/ANALYSIS/MAPMATCHING/MapAlignmentAlgorithmPoseClustering.h>" namespace "OpenMS":

    cdef cppclass MapAlignmentAlgorithmPoseClustering(DefaultParamHandler):
        # wrap-inherits:
        #    DefaultParamHandler

        MapAlignmentAlgorithmPoseClustering() nogil except +
        void alignFeatureMaps(libcpp_vector[FeatureMap[Feature]], libcpp_vector[TransformationDescription] &) nogil except +
        void alignPeakMaps(libcpp_vector[MSExperiment[Peak1D,ChromatogramPeak]], libcpp_vector[TransformationDescription] &) nogil except +

        void fitModel(String model_type, Param p, libcpp_vector[TransformationDescription] &) nogil except +
        void setReference (int, String) nogil except +
       
cdef extern from "<OpenMS/ANALYSIS/MAPMATCHING/MapAlignmentAlgorithmPoseClustering.h>" namespace "OpenMS::MapAlignmentAlgorithmPoseClustering":

    void transformFeatureMaps(libcpp_vector[FeatureMap[Feature]], libcpp_vector[TransformationDescription] &) nogil except + #wrap-attach:MapAlignmentAlgorithmPoseClustering
    void transformPeakMaps(libcpp_vector[MSExperiment[Peak1D,ChromatogramPeak]], libcpp_vector[TransformationDescription]) nogil except + #wrap-attach:MapAlignmentAlgorithmPoseClustering

