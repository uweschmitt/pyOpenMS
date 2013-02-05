
from libcpp cimport *
from Types cimport *
from BaseFeature cimport *
from Peak2D cimport *

cdef extern from "<OpenMS/KERNEL/ConsensusFeature.h>" namespace "OpenMS":

    cdef cppclass ConsensusFeature:
        ConsensusFeature() except +
        ConsensusFeature(UInt64, Peak2D, UInt64) except +
        void insert(UInt64, Peak2D, UInt64) except +
        void insert(UInt64, BaseFeature) except +
        void computeConsensus() except +
        void computeMonoisotopicConsensus() except +

    # ctypedef DPosition[1] DPosition1 # TODO
