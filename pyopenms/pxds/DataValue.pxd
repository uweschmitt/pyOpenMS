from libcpp.string cimport string as libcpp_string
from libcpp.vector cimport vector as libcpp_vector
from StringList cimport *
from IntList cimport *
from DoubleList cimport *
from DataValue_DataType cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/DataValue.h>" namespace "OpenMS":

    cdef cppclass DataValue:
         DataValue()
         DataValue(DataValue) except + # wrap-ignore
         DataValue(libcpp_vector[libcpp_string]) except +
         DataValue(libcpp_vector[int])  except +
         DataValue(libcpp_vector[float])  except +
         DataValue(char *) except +
         DataValue(int)    except +
         DataValue(double)    except +
         DataValue(StringList)     except +
         DataValue(IntList)  except +
         DataValue(DoubleList)  except +

         #conversion ops, different declarations as in c++ !
         int operator()(int)    except +  #wrap-cast:toInt
         libcpp_string operator()(DataValue)  except +  #wrap-cast:toString
         double operator()(DataValue)  except +         #wrap-cast:toFloat
         StringList operator()(DataValue) except +      #wrap-cast:toStringList
         DoubleList operator()(DataValue) except +      #wrap-cast:toDoubleList
         IntList operator()(DataValue)  except +        #wrap-cast:toIntList

         DataType valueType() except +
         int isEmpty() except +


