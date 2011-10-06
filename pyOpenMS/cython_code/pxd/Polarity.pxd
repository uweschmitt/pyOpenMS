
cdef extern from "<OpenMS/METADATA/IonSource.h>" namespace "OpenMS::IonSource":

     cdef enum Polarity:  # wrap=True
            POLNULL, POSITIVE, NEGATIVE, SIZE_OF_POLARITY
