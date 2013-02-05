from libcpp cimport bool
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from Types cimport *
from MetaInfoInterface cimport *
from ProteinHit cimport *

cdef extern from "<OpenMS/METADATA/ProteinIdentification.h>" namespace "OpenMS":

    cdef cppclass ProteinIdentification:

        ProteinIdentification() except +
        bool operator==(ProteinIdentification) except +
        DataValue getMetaValue(unsigned int) except +
        DataValue getMetaValue(String) except +
        bool metaValueExists(String) except +
        bool metaValueExists(unsigned int) except +
        void getKeys(libcpp_vector[String] & keys) except +
        void getKeys(libcpp_vector[unsigned int] & keys) except +
        bool isMetaEmpty() except +
        void clearMetaInfo() except +

        libcpp_vector[ProteinHit] getHits() except +
        void insertHit(ProteinHit) except +
        void setHits(libcpp_vector[ProteinHit]) except +

