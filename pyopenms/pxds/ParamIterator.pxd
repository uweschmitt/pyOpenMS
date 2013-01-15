from String cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/Param.h>" namespace "OpenMS::Param":

         cppclass ParamIterator:
             # wrap-ignore
             #ParamEntry& operator*()
             ParamIterator operator++()
             ParamIterator operator--()
             String getName()
             int operator==(ParamIterator)
             int operator!=(ParamIterator)
             int operator<(ParamIterator)
             int operator>(ParamIterator)
             int operator<=(ParamIterator)
             int operator>=(ParamIterator)
