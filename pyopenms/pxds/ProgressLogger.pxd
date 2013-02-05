from String cimport *
from Types cimport *
from ProgressLogger_LogType cimport *

cdef extern from "<OpenMS/CONCEPT/ProgressLogger.h>" namespace "OpenMS":

    cdef cppclass ProgressLogger:
        ProgressLogger()           except +
        void setLogType(LogType)           except +
        LogType getLogType()           except +
        void startProgress(SignedSize begin, SignedSize end, String label)           except +
        void setProgress(SignedSize value)           except +
        void endProgress()           except +



