
from libcpp cimport *
from Types cimport *
from BaseFeature cimport *
from Peak2D cimport *

cdef extern from "<OpenMS/KERNEL/ConsensusFeature.h>" namespace "OpenMS":

    cdef cppclass ConsensusFeature:
        ConsensusFeature()
        ConsensusFeature(UInt64, Peak2D, UInt64)
        void insert(UInt64, Peak2D, UInt64)
        void insert(UInt64, BaseFeature)
        void computeConsensus()
        void computeMonoisotopicConsensus()

    # ctypedef DPosition[1] DPosition1 # TODO
