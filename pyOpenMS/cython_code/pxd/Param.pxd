from libcpp.string cimport *
from libcpp.vector cimport *
from DataValue cimport *
from String cimport *

cdef extern from "<OpenMS/DATASTRUCTURES/Param.h>" namespace "OpenMS":
    
    cdef cppclass Param: #wrap=True
         Param()
         Param(Param)
         void setValue(String key, DataValue val, String desc, StringList tags)
         DataValue getValue(String key)
         #ParamEntry getEntry(string key) # ignore=True
         int exists(String key)

         void addTag(String key, String tag) except +
         void addTags(String key, StringList tags) except +
         int hasTag(String key, String tag)
         StringList getTags(String key)
         void clearTags(String key) except +

         string getDescription(String key)
         void setSectionDescription(String key, String desc)
         string getSectionDescription(String key)

         int size()
         int empty()
         void clear()
         void insert(String prefix, Param param)
         void remove(String key)
         void removeAll(String prefix)
         Param copy(String prefix, int remove_prefix)

         void setValidStrings(String key, vector[String] strings)
         void setMinInt(String key, int min)
         void setMaxInt(String key, int max)
         void setMinFloat(String key, double min)
         void setMaxFloat(String key, double max)

         void store(string filename)
         void load(string filename)

