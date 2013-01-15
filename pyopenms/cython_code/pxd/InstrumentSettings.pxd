from IonSource_Polarity cimport *

cdef extern from "<OpenMS/METADATA/InstrumentSettings.h>" namespace "OpenMS":

    cdef cppclass InstrumentSettings:   #wrap=True
        
        InstrumentSettings()
        InstrumentSettings(InstrumentSettings) 
        Polarity getPolarity()      
        void setPolarity(Polarity)  except +
