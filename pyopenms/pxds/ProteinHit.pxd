
from libcpp cimport bool
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from Types cimport *
from MetaInfoInterface cimport *

cdef extern from "<OpenMS/METADATA/ProteinHit.h>" namespace "OpenMS":

    cdef cppclass ProteinHit(MetaInfoInterface):
        # wrap-inherits:
        #   MetaInfoInterface

        ProteinHit()           nogil except +
        ProteinHit(ProteinHit &) nogil except + # wrap-ignore


        bool operator==(ProteinHit)           nogil except +
        bool operator!=(ProteinHit)           nogil except +


        Real getScore()           nogil except +
        UInt getRank()           nogil except +
        String getSequence()           nogil except +
        String getAccession()           nogil except +
        DoubleReal getCoverage()           nogil except +

        void setScore(Real)           nogil except +
        void setRank(UInt)           nogil except +
        void setAccession(String)           nogil except +
        void setCoverage(DoubleReal)           nogil except +

        # cython has a problem with inheritance of overloaded methods,
        # so we do not declare them here, but separately in each derived
        # class which we want to be wrapped:
        void getKeys(libcpp_vector[String] & keys)
        void getKeys(libcpp_vector[unsigned int] & keys)
        DataValue getMetaValue(unsigned int) nogil except +
        DataValue getMetaValue(String) nogil except +
        bool metaValueExists(String) nogil except +
        bool metaValueExists(unsigned int) nogil except +
        void removeMetaValue(String) nogil except +
        void removeMetaValue(unsigned int) nogil except +
