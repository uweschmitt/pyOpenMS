from IonSource cimport *
from Polarity cimport *

cdef extern from "<OpenMS/METADATA/InstrumentSettings.h>" namespace "OpenMS":

    cdef cppclass InstrumentSettings:   #wrapall
        
        InstrumentSettings()
        InstrumentSettings(InstrumentSettings) 
        Polarity getPolarity()      
        void setPolarity(Polarity) 
