from String cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/Param.h>" namespace "OpenMS::Param":
 
         cppclass ParamIterator: # wrap=False
              #ParamEntry& operator*()
              ParamIterator operator++()
              ParamIterator operator--()
              String getName()
              bint operator==(ParamIterator)
              bint operator!=(ParamIterator)
              bint operator<(ParamIterator)
              bint operator>(ParamIterator)
              bint operator<=(ParamIterator)
              bint operator>=(ParamIterator)
