from libcpp cimport bool
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from Types cimport *

cdef extern from "<OpenMS/METADATA/MetaInfoInterface.h>" namespace "OpenMS":

    cdef cppclass MetaInfoInterface:
        MetaInfoInterface()
        bool operator==(MetaInfoInterface)
        DataValue getMetaValue(unsigned int)
        DataValue getMetaValue(String)
        bool metaValueExists(String)
        bool metaValueExists(unsigned int)
        #void getKeys(libcpp_vector[String] & keys)
        #void getKeys(libcpp_vector[unsigned int] & keys)
        bool isMetaEmpty()
        void clearMetaInfo()

