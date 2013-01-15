from libcpp.string cimport *
from libcpp.vector cimport *
from DataValue cimport *
from String cimport *
from ParamIterator cimport *


cdef extern from "<OpenMS/DATASTRUCTURES/Param.h>" namespace "OpenMS":
    
    cdef cppclass Param: #wrap=True
         Param()
         Param(Param)
         void setValue(String key, DataValue val, String desc, StringList tags)
         DataValue getValue(String key) except +
         #ParamEntry getEntry(string key) # ignore=True
         int exists(String key) except +

         void addTag(String key, String tag) except +
         void addTags(String key, StringList tags) except +
         int hasTag(String key, String tag) except +
         StringList getTags(String key) except +
         void clearTags(String key) except +

         string getDescription(String key) except +
         void setSectionDescription(String key, String desc) except +
         string getSectionDescription(String key) except +

         int size()
         void insert(String prefix, Param param) except +

         void setValidStrings(String key, vector[String] strings) except +
         void setMinInt(String key, int min) except +
         void setMaxInt(String key, int max) except +
         void setMinFloat(String key, double min) except +
         void setMaxFloat(String key, double max) except +

         void store(string filename) except +
         void load(string filename) except +


         ParamIterator begin() # ignore=True
         ParamIterator end() # ignore=True
 
