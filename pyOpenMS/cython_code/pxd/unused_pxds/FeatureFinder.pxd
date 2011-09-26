#encoding: utf-8
from string cimport *
from MSExperiment cimport *
from FeatureMap cimport *
from Param cimport *
from Feature cimport *
from Peak1D cimport *
from ChromatogramPeak cimport *

cdef extern from "<OpenMS/TRANSFORMATIONS/FEATUREFINDER/FeatureFinder.h>" namespace "OpenMS":


    cdef cppclass FeatureFinder:
        FeatureFinder()
        void run(string, MSExperiment[Peak1D, ChromatogramPeak], FeatureMap[Feature] out, Param, FeatureMap[Feature] seeds) except+
        Param getParameters(string) except+

        
# Implentierung nicht in DLL, sondern in FeatureFinder_impl.h, muss also included werden damit
# beim linken kein unresolved symbol übrig bleibt.
cdef extern from "<OpenMS/TRANSFORMATIONS/FEATUREFINDER/FeatureFinder_impl.h>" namespace "OpenMS":
     pass
