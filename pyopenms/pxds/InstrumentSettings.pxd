from IonSource_Polarity cimport *

cdef extern from "<OpenMS/METADATA/InstrumentSettings.h>" namespace "OpenMS":

    cdef cppclass InstrumentSettings:

        InstrumentSettings()     nogil except +
        InstrumentSettings(InstrumentSettings)     nogil except +
        Polarity getPolarity()     nogil except +
        void setPolarity(Polarity)  nogil except +
