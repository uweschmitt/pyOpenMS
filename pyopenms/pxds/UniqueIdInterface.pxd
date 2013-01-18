from String cimport *
from Types cimport *

cdef extern from "<OpenMS/CONCEPT/UniqueIdInterface.h>" namespace "OpenMS":

    cdef cppclass UniqueIdInterface:
        # wrap-ignore
        Size getUniqueId()
        Size clearUniqueId()
        void swap(UniqueIdInterface)
        Size hasValidUniqueId()
        Size hasInvalidUniqueId()
        Size setUniqueId()
        Size setUniqueId(UInt64 rhs)
        Size setUniqueId(String rhs)
        Size ensureUniqueId()





