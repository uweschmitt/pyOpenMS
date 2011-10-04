from Polarity cimport *

cdef extern from "<OpenMS/METADATA/InstrumentSettings.h>" namespace "OpenMS":

    cdef cppclass InstrumentSettings:   #wrap
        
        InstrumentSettings()
        InstrumentSettings(InstrumentSettings) 
        Polarity getPolarity()      
        void setPolarity(Polarity) 
