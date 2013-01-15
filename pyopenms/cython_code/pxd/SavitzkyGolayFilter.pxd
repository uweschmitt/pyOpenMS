from MSSpectrum cimport *
from MSExperiment cimport *
from ChromatogramPeak cimport *

cdef extern from "<OpenMS/FILTERING/SMOOTHING/SavitzkyGolayFilter.h>" namespace "OpenMS":
    
    cdef cppclass SavitzkyGolayFilter:  # wrap=True
        SavitzkyGolayFilter()
        void filter (MSSpectrum[Peak1D]) except +
        void filterExperiment (MSExperiment[Peak1D, ChromatogramPeak]) except +
