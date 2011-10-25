from Feature cimport *
from FeatureMap cimport *
from libcpp.string cimport *

cdef extern from "<OpenMS/FORMAT/FeatureXMLFile.h>" namespace "OpenMS":

    cdef cppclass FeatureXMLFile:  # wrap=True
        FeatureXMLFile()
        # cython does not support free template args, so Peak1D has
        # to be used as a fixed argument
        void load(string, FeatureMap[Feature]) except+
        void store(string, FeatureMap[Feature]) except+
