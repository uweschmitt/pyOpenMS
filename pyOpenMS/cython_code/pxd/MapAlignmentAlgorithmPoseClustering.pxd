from Peak1D cimport *
from ChromatogramPeak cimport *
from TransformationDescription cimport *
from MSExperiment cimport *
from String cimport *
from Param cimport *
from ProgressLogger_LogType cimport *

cdef extern from "<OpenMS/ANALYSIS/MAPMATCHING/MapAlignmentAlgorithmPoseClustering.h>" namespace "OpenMS":
    
    #ctypedef MSE MSExperiment[Peak1D, ChromatogramPeak]
    cdef cppclass MapAlignmentAlgorithmPoseClustering: #wrap=True
        MapAlignmentAlgorithmPoseClustering()
        void alignPeakMaps(vector[MSExperiment[Peak1D, ChromatogramPeak]], vector[TransformationDescription] &)
    
        void setReference(int idx, String file)
        void getDefaultModel(String model_type, Param p)
        void fitModel(String model_type, Param p, vector[TransformationDescription])
        void transformPeakMaps(vector[MSExperiment[Peak1D, ChromatogramPeak]] &, vector[TransformationDescription]) 
        
        void setLogType(LogType type)

        Param getDefaults()
        Param getParameters()
        void setParameters(Param)
        
