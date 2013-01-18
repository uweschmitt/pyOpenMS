from libc.stdint cimport *
from libc.stddef cimport *
from ctime cimport *

cdef extern from "<OpenMS/CONCEPT/Types.h>" namespace "OpenMS":

    ctypedef int32_t Int32
    ctypedef int64_t Int64
    ctypedef uint32_t UInt32
    ctypedef uint64_t UInt64
    ctypedef time_t   Time
    ctypedef unsigned int UInt
    ctypedef int      Int
    ctypedef float    Real
    ctypedef double   DoubleReal
    ctypedef uint64_t   UID
    ctypedef size_t    Size
    ctypedef ptrdiff_t SignedSize
