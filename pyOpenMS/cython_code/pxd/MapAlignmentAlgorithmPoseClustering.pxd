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
    
    #ctypedef MSE MSExperiment[Peak1D, ChromatogramPeak]
    cdef cppclass MapAlignmentAlgorithmPoseClustering: #wrap=True
        MapAlignmentAlgorithmPoseClustering()
        void alignFeatureMaps(vector[FeatureMap[Feature]], vector[TransformationDescription] &) except +
    
        void setReference(int idx, String file) except +
        void getDefaultModel(String model_type, Param p)
        void fitModel(String model_type, Param p, vector[TransformationDescription] &) except +
        
        void setLogType(LogType type) except +

        Param getDefaults()
        Param getParameters()
        void setParameters(Param) except +
        
