from MSExperiment  cimport *
from libcpp.string cimport string as libcpp_string
from FileTypes cimport *
from Types cimport *

cdef extern from "<OpenMS/FORMAT/FileHandler.h>" namespace "OpenMS":

    cdef cppclass FileHandler:  # wrap=True
        FileHandler()
        FileHandler(FileHandler)
       
        void loadExperiment(libcpp_string, MSExperiment[Peak1D, ChromatogramPeak] &) except+
        void storeExperiment(libcpp_string, MSExperiment[Peak1D, ChromatogramPeak]) except+



cdef extern from "<OpenMS/FORMAT/FileHandler.h>" namespace "OpenMS::FileHandler":

    int  getType(String filename) # wrap-static:FileHandler
