from MSSpectrum cimport *
from Peak1D cimport *
from ChromatogramPeak cimport *

cdef extern from "<OpenMS/KERNEL/MSExperiment.h>" namespace "OpenMS":

    cdef cppclass MSExperiment[PeakT, ChromoPeakT]: # wrap=True; inst=("Peak1D", "ChromatogramPeak")
        MSExperiment()
        double getMinMZ()                         
        double getMaxMZ()                           
        double getMinRT()                          
        double getMaxRT()                         
        void sortSpectra(bool)                   
        int   size()                            
        MSSpectrum[PeakT] operator[](int)     
        void   updateRanges()                  
        vector[MSSpectrum[PeakT]].iterator begin()        # ignore=True
        vector[MSSpectrum[PeakT]].iterator end()          # ignore=True
        void  erase(vector[MSSpectrum[PeakT]].iterator)   # ignore=True
        void push_back(MSSpectrum[PeakT])
       
    

