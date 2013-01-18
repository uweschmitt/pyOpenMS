from libcpp cimport bool
from Feature cimport *

cdef extern from "<OpenMS/KERNEL/FeatureMap.h>" namespace "OpenMS":

    cdef cppclass FeatureMap[FeatureT]:
        # wrap-instances:
        #   FeatureMap := FeatureMap[Feature]

        FeatureMap()
        FeatureMap(FeatureMap)  # wrap-ignore
        int   size()
        Feature operator[](int)      except + # wrap-ignore
        void   updateRanges()
        void push_back(FeatureT spec) except +
        void setUniqueId()
        void sortByIntensity() except +
        void sortByIntensity(bool reverse) except +
        void sortByPosition() except +
        void sortByRT() except +
        void sortByMZ() except +
        void sortByOverallQuality() except +
        void swap(FeatureMap[FeatureT] &) except +
        void clear() except +
        void clear(bool clear_meta_data) except +





