from MSSpectrum cimport *
from DataValue cimport *
from ChromatogramPeak cimport *
from String cimport *

cdef extern from "<OpenMS/KERNEL/MSExperiment.h>" namespace "OpenMS":

    cdef cppclass MSExperiment[PeakT, ChromoPeakT]: # wrap=True; inst=("Peak1D", "ChromatogramPeak")
        # wrap-instances:
        #   MSExperiment := MSExperiment[Peak1D, ChromatogramPeak]

        MSExperiment() except +
        MSExperiment(MSExperiment[PeakT, ChromoPeakT] &)  except + # wrap-ignore

        double getMinMZ() except +
        double getMaxMZ() except +
        double getMinRT() except +
        double getMaxRT() except +
        void sortSpectra(bool) except +
        int   size() except +
        MSSpectrum[PeakT] operator[](int)      except +
        void   updateRanges() except +
        void push_back(MSSpectrum[PeakT] spec) except +
        String getLoadedFilePath() except +
        void setLoadedFilePath(String path) except +
        void  setMetaValue(String key, DataValue value) except +
        DataValue getMetaValue(String key) except +

        libcpp_vector[MSSpectrum[PeakT]].iterator begin() except +        # wrap-iter-begin:__iter__(MSSpectrum)
        libcpp_vector[MSSpectrum[PeakT]].iterator end()    except +       # wrap-iter-end:__iter__(MSSpectrum)
        void  erase(libcpp_vector[MSSpectrum[PeakT]].iterator) except +   # wrap-ignore



