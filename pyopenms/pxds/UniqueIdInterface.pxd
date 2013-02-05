from String cimport *
from Types cimport *

cdef extern from "<OpenMS/CONCEPT/UniqueIdInterface.h>" namespace "OpenMS":

    cdef cppclass UniqueIdInterface:
        # wrap-ignore
        Size getUniqueId() except +
        Size clearUniqueId() except +
        void swap(UniqueIdInterface) except +
        Size hasValidUniqueId() except +
        Size hasInvalidUniqueId() except +
        Size setUniqueId() except +
        Size setUniqueId(UInt64 rhs) except +
        Size setUniqueId(String rhs) except +
        Size ensureUniqueId() except +





