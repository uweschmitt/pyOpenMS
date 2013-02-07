from MSSpectrum cimport *
from MSExperiment cimport *
from ChromatogramPeak cimport *
from Peak1D cimport *
from Param cimport *
from ProgressLogger_LogType cimport *

cdef extern from "<OpenMS/TRANSFORMATIONS/RAW2PEAK/PeakPickerHiRes.h>" namespace "OpenMS":

    cdef cppclass PeakPickerHiRes:
        PeakPickerHiRes()                  nogil except +
        PeakPickerHiRes(PeakPickerHiRes)   nogil except + #wrap-ignore
        void pick(MSSpectrum[Peak1D] & input, MSSpectrum[Peak1D] & output) nogil except +
        void pickExperiment(MSExperiment[Peak1D, ChromatogramPeak] & input, MSExperiment[Peak1D, ChromatogramPeak] & output) nogil except +
        Param getParameters() nogil except +
        Param getDefaults()   nogil except +
        void setParameters(Param param) nogil except +

        void setLogType(LogType type) nogil except +
