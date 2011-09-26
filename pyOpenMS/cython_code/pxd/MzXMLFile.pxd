
from MSExperiment  cimport *
from ChromatogramPeak cimport *
from Peak1D cimport *
from string cimport *

cdef extern from "<OpenMS/FORMAT/MzXMLFile.h>" namespace "OpenMS":

    cdef cppclass MzXMLFile:  # wrapall
        MzXMLFile()
        # hier muss leider spezialisert werden:
        void load(string, MSExperiment[Peak1D, ChromatogramPeak]) except+
        void store(string, MSExperiment[Peak1D, ChromatogramPeak]) except+
