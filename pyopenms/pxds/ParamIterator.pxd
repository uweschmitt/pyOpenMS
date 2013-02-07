from String cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/Param.h>" namespace "OpenMS::Param":

         cppclass ParamIterator:
             # wrap-ignore
             #ParamEntry& operator*()
             ParamIterator operator++() nogil except +
             ParamIterator operator--() nogil except +
             String getName() nogil except +
             int operator==(ParamIterator) nogil except +
             int operator!=(ParamIterator) nogil except +
             int operator<(ParamIterator) nogil except +
             int operator>(ParamIterator) nogil except +
             int operator<=(ParamIterator) nogil except +
             int operator>=(ParamIterator) nogil except +
