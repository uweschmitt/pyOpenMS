from libcpp.string cimport string as libcpp_string
from libcpp.vector cimport vector as libcpp_vector
from DataValue cimport *
from String cimport *
from ParamIterator cimport *


cdef extern from "<OpenMS/DATASTRUCTURES/Param.h>" namespace "OpenMS":

    cdef cppclass Param:
         Param() nogil except +
         Param(Param) nogil except +
         void setValue(String key, DataValue val, String desc, StringList tags) nogil except +
         DataValue getValue(String key) nogil except +
         int exists(String key) nogil except +

         void addTag(String key, String tag) nogil except +
         void addTags(String key, StringList tags) nogil except +
         int hasTag(String key, String tag) nogil except +
         StringList getTags(String key) nogil except +
         void clearTags(String key) nogil except +

         libcpp_string getDescription(String key) nogil except +
         void setSectionDescription(String key, String desc) nogil except +
         libcpp_string getSectionDescription(String key) nogil except +

         int size() nogil except +
         void insert(String prefix, Param param) nogil except +

         void setValidStrings(String key, libcpp_vector[String] strings) nogil except +
         void setMinInt(String key, int min) nogil except +
         void setMaxInt(String key, int max) nogil except +
         void setMinFloat(String key, double min) nogil except +
         void setMaxFloat(String key, double max) nogil except +

         void store(String filename) nogil except +
         void load(String filename) nogil except +


         ParamIterator begin() nogil except + # wrap-ignore
         ParamIterator end()   nogil except + # wrap-ignore

