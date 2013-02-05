from String cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/Param.h>" namespace "OpenMS::Param":

         cppclass ParamIterator:
             # wrap-ignore
             #ParamEntry& operator*()
             ParamIterator operator++() except +
             ParamIterator operator--() except +
             String getName() except +
             int operator==(ParamIterator) except +
             int operator!=(ParamIterator) except +
             int operator<(ParamIterator) except +
             int operator>(ParamIterator) except +
             int operator<=(ParamIterator) except +
             int operator>=(ParamIterator) except +
