from String cimport *
from Types cimport *

cdef extern from "<OpenMS/CONCEPT/UniqueIdInterface.h>" namespace "OpenMS":

    cdef cppclass UniqueIdInterface:
        # wrap-ignore

        UniqueIdInterface()
        UniqueIdInterface(UniqueIdInterface)

        Size getUniqueId() nogil except +
        Size clearUniqueId() nogil except +
        void swap(UniqueIdInterface) nogil except +  # wrap-ignore
        Size hasValidUniqueId() nogil except +
        Size hasInvalidUniqueId() nogil except +
        Size setUniqueId() nogil except +
        #Size setUniqueId(UInt64 rhs) nogil except +
        #Size setUniqueId(String rhs) nogil except +
        Size ensureUniqueId() nogil except +





