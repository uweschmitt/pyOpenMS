cdef extern from "<OpenMS/CONCEPT/ProgressLogger.h>" namespace "OpenMS::ProgressLogger":

    cdef enum LogType: # wrap=True
        CMD, GUI, NONE
        
