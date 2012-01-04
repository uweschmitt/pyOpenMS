
from Feature cimport *

cdef extern from "<OpenMS/KERNEL/FeatureMap.h>" namespace "OpenMS":

    cdef cppclass FeatureMap[FeatureT]: # wrap=True; inst=("Feature",)
        FeatureMap()
        FeatureMap(FeatureMap)
        int   size()                            
        Feature operator[](int)      except +
        void   updateRanges()                  
        void push_back(FeatureT spec) except +
        void setUniqueId()


       
    

