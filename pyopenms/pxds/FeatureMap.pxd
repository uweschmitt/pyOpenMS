from libcpp cimport bool
from Feature cimport *

cdef extern from "<OpenMS/KERNEL/FeatureMap.h>" namespace "OpenMS":

    cdef cppclass FeatureMap[FeatureT]:
        # wrap-instances:
        #   FeatureMap := FeatureMap[Feature]

        FeatureMap() except +
        FeatureMap(FeatureMap) except + # wrap-ignore
        int   size()  except +
        Feature operator[](int)      except +
        void   updateRanges() except +
        void push_back(FeatureT spec) except +
        void setUniqueId() except +
        void sortByIntensity() except +
        void sortByIntensity(bool reverse) except +
        void sortByPosition() except +
        void sortByRT() except +
        void sortByMZ() except +
        void sortByOverallQuality() except +
        void swap(FeatureMap[FeatureT] &) except +
        void clear() except +
        void clear(bool clear_meta_data) except +





