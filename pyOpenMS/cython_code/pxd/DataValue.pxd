from libcpp.string cimport *
from libcpp.vector cimport *
from StringList cimport *
from IntList cimport *
from DoubleList cimport *
from DataValue_DataType cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue: #wrap=True
         DataValue()
         DataValue(DataValue) except +
         DataValue(vector[string]) except + #ignore=True
         DataValue(vector[int])  except +#ignore=True
         DataValue(vector[float])  except +#ignore=True
         DataValue(char *) except +
         DataValue(int)    except +
         DataValue(double)    except +
         DataValue(StringList)     except +
         DataValue(IntList)  except +
         DataValue(DoubleList)  except +

         #conversion ops, different declarations as in c++ !
         # except+ does not work here, so we have a pre steatment
         int operator()(int)      #pre="assert self.valueType() == DataType.INT_VALUE"
         string operator()(DataValue)      #pre="assert self.valueType() == DataType.STRING_VALUE"
         double operator()(DataValue)      #pre="assert self.valueType() == DataType.DOUBLE_VALUE"
         StringList operator()(DataValue)  #pre="assert self.valueType() == DataType.STRING_LIST"
         DoubleList operator()(DataValue)  #pre="assert self.valueType() == DataType.DOUBLE_LIST"
         IntList operator()(DataValue)     #pre="assert self.valueType() == DataType.INT_LIST"

         DataType valueType()
         int isEmpty()


