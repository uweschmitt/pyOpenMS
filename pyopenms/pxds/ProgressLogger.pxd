from String cimport *
from Types cimport *
from ProgressLogger_LogType cimport *

cdef extern from "<OpenMS/CONCEPT/ProgressLogger.h>" namespace "OpenMS":

    cdef cppclass ProgressLogger:
        ProgressLogger()
        void setLogType(LogType)
        LogType getLogType()
        void startProgress(SignedSize begin, SignedSize end, String label)
        void setProgress(SignedSize value)
        void endProgress()



