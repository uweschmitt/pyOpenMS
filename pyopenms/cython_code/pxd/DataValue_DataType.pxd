
# enum support in cython is tricky, as cython has problems with
# nested structrues / classes / ....
cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS::DataValue":

     cdef enum DataType:  # wrap=True; 
         STRING_VALUE, INT_VALUE, DOUBLE_VALUE, STRING_LIST, INT_LIST, \
         DOUBLE_LIST, EMPTY_VALUE
