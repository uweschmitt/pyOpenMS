from Peak1D cimport *
from ChromatogramPeak cimport *
from TransformationDescription cimport *
from MSExperiment cimport *
from String cimport *
from Param cimport *
from ProgressLogger_LogType cimport *
from Feature cimport *
from FeatureMap cimport *

cdef extern from "<OpenMS/ANALYSIS/MAPMATCHING/MapAlignmentAlgorithmPoseClustering.h>" namespace "OpenMS":

    cdef cppclass MapAlignmentAlgorithmPoseClustering:
        MapAlignmentAlgorithmPoseClustering()
        void alignFeatureMaps(libcpp_vector[FeatureMap[Feature]], libcpp_vector[TransformationDescription] &) except +

        void fitModel(String model_type, Param p, libcpp_vector[TransformationDescription] &) except +

        void setLogType(LogType type) except +

        Param getDefaults()
        Param getParameters()
        void setParameters(Param) except +

