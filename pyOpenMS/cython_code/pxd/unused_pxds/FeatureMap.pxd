from libcpp.vector cimport vector

cdef extern from "<OpenMS/KERNEL/FeatureMap.h>" namespace "OpenMS":

    cdef cppclass FeatureMap[T]:
        FeatureMap()
        T operator[](int)
        int size()
        void push_back(T)
        void assign(vector[T].iterator, vector[T].iterator)
        void sortByIntensity(bool)
        void updateRanges()
        size_t applyMemberFunction( size_t (*f)() )
        
        
