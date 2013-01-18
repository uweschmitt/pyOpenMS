from libcpp cimport bool
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from Types cimport *
from MetaInfoInterface cimport *
from ProteinHit cimport *

cdef extern from "<OpenMS/METADATA/ProteinIdentification.h>" namespace "OpenMS":

    cdef cppclass ProteinIdentification:

        ProteinIdentification()
        bool operator==(ProteinIdentification)
        DataValue getMetaValue(unsigned int)
        DataValue getMetaValue(String)
        bool metaValueExists(String)
        bool metaValueExists(unsigned int)
        #void getKeys(libcpp_vector[String] & keys)
        #void getKeys(libcpp_vector[unsigned int] & keys)
        bool isMetaEmpty()
        void clearMetaInfo()

        libcpp_vector[ProteinHit] getHits()
        void insertHit(ProteinHit)
        void setHits(libcpp_vector[ProteinHit])

