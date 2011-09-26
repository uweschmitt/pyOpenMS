
cdef extern from "<OpenMS/METADATA/Ionsource.h>" namespace "OpenMS":

     cdef enum Polarity:  # wrap
            POLNULL, POSITIVE, NEGATIVE, SIZE_OF_POLARITY
