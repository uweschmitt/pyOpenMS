from MSExperiment  cimport *
from ChromatogramPeak cimport *
from Peak1D cimport *
from String cimport *
from ProgressLogger cimport *

cdef extern from "<OpenMS/FORMAT/MzXMLFile.h>" namespace "OpenMS":

    cdef cppclass MzXMLFile(ProgressLogger):
        # wrap-inherits:
        #   ProgressLogger

        MzXMLFile() nogil except +
        # cython does not support free template args, so Peak1D has
        # to be used as a fixed argument
        void load(String, MSExperiment[Peak1D, ChromatogramPeak] &) nogil except+
        void store(String, MSExperiment[Peak1D, ChromatogramPeak] &) nogil except+
