from libcpp cimport bool
from Feature cimport *
from UniqueIdInterface cimport *

cdef extern from "<OpenMS/KERNEL/FeatureMap.h>" namespace "OpenMS":

    cdef cppclass FeatureMap[FeatureT](UniqueIdInterface):

        # wrap-inherits:
        #   UniqueIdInterface
        #
        # wrap-instances:
        #   FeatureMap := FeatureMap[Feature]

        FeatureMap() nogil except +
        FeatureMap(FeatureMap) nogil except + # wrap-ignore
        int   size()  nogil except +
        Feature operator[](int)      nogil except +
        void   updateRanges() nogil except +
        void push_back(FeatureT spec) nogil except +

        void sortByIntensity() nogil except +
        void sortByIntensity(bool reverse) nogil except +
        void sortByPosition() nogil except +
        void sortByRT() nogil except +
        void sortByMZ() nogil except +
        void sortByOverallQuality() nogil except +

        void swap(FeatureMap[FeatureT] &) nogil except +
        void clear() nogil except +
        void clear(bool clear_meta_data) nogil except +





