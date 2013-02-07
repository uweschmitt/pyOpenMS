from Peak1D cimport *
from ChromatogramPeak cimport *
from TransformationDescription cimport *
from MSExperiment cimport *
from String cimport *
from Param cimport *
from ProgressLogger_LogType cimport *
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
        void setLogType(LogType type) nogil except +
        void setReference (Size reference_index, String reference_file) nogil except +
