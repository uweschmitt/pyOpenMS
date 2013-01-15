from libcpp.string cimport string as libcpp_string
from libcpp.vector cimport vector as libcpp_vector
from StringList cimport *
from IntList cimport *
from DoubleList cimport *
from DataValue_DataType cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":
    
    cdef cppclass DataValue: #wrap=True
         DataValue()
         DataValue(DataValue) except +
         DataValue(libcpp_vector[libcpp_string]) except + #ignore=True
         DataValue(libcpp_vector[int])  except +#ignore=True
         DataValue(libcpp_vector[float])  except +#ignore=True
         DataValue(char *) except +
         DataValue(int)    except +
         DataValue(double)    except +
         DataValue(StringList)     except +
         DataValue(IntList)  except +
         DataValue(DoubleList)  except +

         #conversion ops, different declarations as in c++ !
         # except+ does not work here, so we have a pre steatment
         int operator()(int)      #wrap-ignore
         libcpp_string operator()(DataValue)      #wrap-ignore
         double operator()(DataValue)      #wrap-ignore
         StringList operator()(DataValue)  #wrap-ignore
         DoubleList operator()(DataValue)  #wrap-ignore
         IntList operator()(DataValue)     #wrap-ignore

         DataType valueType()
         int isEmpty()


