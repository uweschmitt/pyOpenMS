cdef extern from "<OpenMS/METADATA/Ionsource.h>" namespace "OpenMS::IonSource" :   
       enum Polarity:   # wrap
            POLNULL, POSITIVE, NEGATIVE, SIZE_OF_POLARITY
