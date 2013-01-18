from MSSpectrum cimport *
from DataValue cimport *
from ChromatogramPeak cimport *
from String cimport *

cdef extern from "<OpenMS/KERNEL/MSExperiment.h>" namespace "OpenMS":

    cdef cppclass MSExperiment[PeakT, ChromoPeakT]: # wrap=True; inst=("Peak1D", "ChromatogramPeak")
        # wrap-instances:
        #   MSExperiment := MSExperiment[Peak1D, ChromatogramPeak]

        MSExperiment()
        MSExperiment(MSExperiment[PeakT, ChromoPeakT] &) # wrap-ignore

        double getMinMZ()
        double getMaxMZ()
        double getMinRT()
        double getMaxRT()
        void sortSpectra(bool)
        int   size()
        MSSpectrum[PeakT] operator[](int)      except +
        void   updateRanges()
        void push_back(MSSpectrum[PeakT] spec) except +
        String getLoadedFilePath()
        void setLoadedFilePath(String path) except +
        void  setMetaValue(String key, DataValue value) except +
        DataValue getMetaValue(String key) except +

        libcpp_vector[MSSpectrum[PeakT]].iterator begin()        # wrap-ignore
        libcpp_vector[MSSpectrum[PeakT]].iterator end()          # wrap-ignore
        void  erase(libcpp_vector[MSSpectrum[PeakT]].iterator)   # wrap-ignore



