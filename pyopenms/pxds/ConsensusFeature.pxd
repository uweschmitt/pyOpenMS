
from libcpp cimport *
from Types cimport *
from BaseFeature cimport *
from Peak2D cimport *

cdef extern from "<OpenMS/KERNEL/ConsensusFeature.h>" namespace "OpenMS":

    cdef cppclass ConsensusFeature:
        ConsensusFeature() nogil except +
        ConsensusFeature(UInt64, Peak2D, UInt64) nogil except +
        void insert(UInt64, Peak2D, UInt64) nogil except +
        void insert(UInt64, BaseFeature) nogil except +
        void computeConsensus() nogil except +
        void computeMonoisotopicConsensus() nogil except +

    # ctypedef DPosition[1] DPosition1 # TODO
