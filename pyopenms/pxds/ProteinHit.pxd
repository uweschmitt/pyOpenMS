
from libcpp cimport bool
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from Types cimport *
from MetaInfoInterface cimport *

cdef extern from "<OpenMS/METADATA/ProteinHit.h>" namespace "OpenMS":

    cdef cppclass ProteinHit:

        ProteinHit()
        ProteinHit(ProteinHit &) # wrap-ignore
        bool operator==(ProteinHit)
        bool metaValueExists(String)
        bool metaValueExists(unsigned int)
        void getKeys(libcpp_vector[String] & keys)
        void getKeys(libcpp_vector[unsigned int] & keys)

        Real getScore()
        UInt getRank()
        String getSequence()
        String getAccession()
        DoubleReal getCoverage()

        void setScore(Real)
        void setRank(UInt)
        void setAccession(String)
        void setCoverage(DoubleReal)

