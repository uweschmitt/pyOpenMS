
from libcpp cimport bool
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from Types cimport *
from MetaInfoInterface cimport *

cdef extern from "<OpenMS/METADATA/ProteinHit.h>" namespace "OpenMS":

    cdef cppclass ProteinHit:

        ProteinHit()           except +
        ProteinHit(ProteinHit &) except + # wrap-ignore
        bool operator==(ProteinHit)           except +
        bool metaValueExists(String)           except +
        bool metaValueExists(unsigned int)           except +
        void getKeys(libcpp_vector[String] & keys)           except +
        void getKeys(libcpp_vector[unsigned int] & keys)           except +

        Real getScore()           except +
        UInt getRank()           except +
        String getSequence()           except +
        String getAccession()           except +
        DoubleReal getCoverage()           except +

        void setScore(Real)           except +
        void setRank(UInt)           except +
        void setAccession(String)           except +
        void setCoverage(DoubleReal)           except +

