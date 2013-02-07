from MSSpectrum cimport *
from DataValue cimport *
from ChromatogramPeak cimport *
from String cimport *

cdef extern from "<OpenMS/KERNEL/MSExperiment.h>" namespace "OpenMS":

    cdef cppclass MSExperiment[PeakT, ChromoPeakT]: # wrap=True; inst=("Peak1D", "ChromatogramPeak")
        # wrap-instances:
        #   MSExperiment := MSExperiment[Peak1D, ChromatogramPeak]

        MSExperiment() nogil except +
        MSExperiment(MSExperiment[PeakT, ChromoPeakT] &)  nogil except + # wrap-ignore

        double getMinMZ() nogil except +
        double getMaxMZ() nogil except +
        double getMinRT() nogil except +
        double getMaxRT() nogil except +
        void sortSpectra(bool) nogil except +
        int   size() nogil except +
        MSSpectrum[PeakT] operator[](int)      nogil except +
        void   updateRanges() nogil except +
        void push_back(MSSpectrum[PeakT] spec) nogil except +
        String getLoadedFilePath() nogil except +
        void setLoadedFilePath(String path) nogil except +
        void  setMetaValue(String key, DataValue value) nogil except +
        DataValue getMetaValue(String key) nogil except +

        libcpp_vector[MSSpectrum[PeakT]].iterator begin() nogil except +        # wrap-iter-begin:__iter__(MSSpectrum)
        libcpp_vector[MSSpectrum[PeakT]].iterator end()    nogil except +       # wrap-iter-end:__iter__(MSSpectrum)
        void  erase(libcpp_vector[MSSpectrum[PeakT]].iterator) nogil except +   # wrap-ignore



