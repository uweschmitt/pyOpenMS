from libcpp.string cimport string as libcpp_string
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from ParamIterator cimport *


cdef extern from "<OpenMS/DATASTRUCTURES/Param.h>" namespace "OpenMS":

    cdef cppclass Param:
         Param() except +
         Param(Param) except +
         void setValue(String key, DataValue val, String desc, StringList tags) except +
         DataValue getValue(String key) except +
         int exists(String key) except +

         void addTag(String key, String tag) except +
         void addTags(String key, StringList tags) except +
         int hasTag(String key, String tag) except +
         StringList getTags(String key) except +
         void clearTags(String key) except +

         libcpp_string getDescription(String key) except +
         void setSectionDescription(String key, String desc) except +
         libcpp_string getSectionDescription(String key) except +

         int size() except +
         void insert(String prefix, Param param) except +

         void setValidStrings(String key, libcpp_vector[String] strings) except +
         void setMinInt(String key, int min) except +
         void setMaxInt(String key, int max) except +
         void setMinFloat(String key, double min) except +
         void setMaxFloat(String key, double max) except +

         void store(libcpp_string filename) except +
         void load(libcpp_string filename) except +


         ParamIterator begin() except + # wrap-ignore
         ParamIterator end()   except + # wrap-ignore

