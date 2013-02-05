from IonSource_Polarity cimport *

cdef extern from "<OpenMS/METADATA/InstrumentSettings.h>" namespace "OpenMS":

    cdef cppclass InstrumentSettings:

        InstrumentSettings()     except +
        InstrumentSettings(InstrumentSettings)     except +
        Polarity getPolarity()     except +
        void setPolarity(Polarity)  except +
