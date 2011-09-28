
from MSExperiment  cimport *
from ChromatogramPeak cimport *
from Peak1D cimport *
from libcpp.string cimport *

cdef extern from "<OpenMS/FORMAT/MzDataFile.h>" namespace "OpenMS":

    cdef cppclass MzDataFile:  # wrapall
        MzDataFile()
        # hier muss leider spezialisert werden:
        void load(string, MSExperiment[Peak1D, ChromatogramPeak]) except+
        void store(string, MSExperiment[Peak1D, ChromatogramPeak]) except+
