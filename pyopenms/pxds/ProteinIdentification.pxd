from libcpp cimport bool
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from Types cimport *
from MetaInfoInterface cimport *
from ProteinHit cimport *

cdef extern from "<OpenMS/METADATA/ProteinIdentification.h>" namespace "OpenMS":

    cdef cppclass ProteinIdentification:

        ProteinIdentification() nogil except +
        bool operator==(ProteinIdentification) nogil except +
        DataValue getMetaValue(unsigned int) nogil except +
        DataValue getMetaValue(String) nogil except +
        bool metaValueExists(String) nogil except +
        bool metaValueExists(unsigned int) nogil except +
        void getKeys(libcpp_vector[String] & keys) nogil except +
        void getKeys(libcpp_vector[unsigned int] & keys) nogil except +
        bool isMetaEmpty() nogil except +
        void clearMetaInfo() nogil except +

        libcpp_vector[ProteinHit] getHits() nogil except +
        void insertHit(ProteinHit) nogil except +
        void setHits(libcpp_vector[ProteinHit]) nogil except +

