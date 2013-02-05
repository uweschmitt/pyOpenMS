from libcpp cimport bool
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from Types cimport *

cdef extern from "<OpenMS/METADATA/MetaInfoInterface.h>" namespace "OpenMS":

    cdef cppclass MetaInfoInterface:
        MetaInfoInterface() except +
        bool operator==(MetaInfoInterface) except +
        DataValue getMetaValue(unsigned int) except +
        DataValue getMetaValue(String) except +
        bool metaValueExists(String) except +
        bool metaValueExists(unsigned int) except +
        #void getKeys(libcpp_vector[String] & keys)
        #void getKeys(libcpp_vector[unsigned int] & keys)
        bool isMetaEmpty() except +
        void clearMetaInfo() except +

