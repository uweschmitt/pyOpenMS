from libcpp.vector cimport vector as libcpp_vector
from libcpp.string cimport string as libcpp_string
from InstrumentSettings cimport *
from Precursor cimport *
from Peak1D cimport *
from SourceFile cimport *

cdef extern from "<OpenMS/KERNEL/MSSpectrum.h>" namespace "OpenMS":

    cdef cppclass MSSpectrum[PeakT]:  # wrap=True; inst=("Peak1D",)
        # wrap-instances:
        #   MSSpectrum := MSSpectrum[Peak1D]


        MSSpectrum() nogil except +
        MSSpectrum(MSSpectrum) nogil except +
        double getRT() nogil except +
        void   setRT(double) nogil except +
        unsigned int getMSLevel() nogil except +
        void setMSLevel(unsigned int) nogil except +

        libcpp_string getName() nogil except +
        void setName(libcpp_string) nogil except +

        int size() nogil except +
        PeakT operator[](int) nogil except +

        void updateRanges() nogil except +
        void clear(int) nogil except +
        void push_back(PeakT)  nogil except +


        InstrumentSettings getInstrumentSettings() nogil except +
        void setInstrumentSettings(InstrumentSettings) nogil except +

        int findNearest(double) nogil except+
        libcpp_vector[Precursor] getPrecursors() nogil except +
        void setPrecursors(libcpp_vector[Precursor])   nogil except +

        void assign(libcpp_vector[Peak1D].iterator, libcpp_vector[Peak1D].iterator) nogil except + # wrap-ignore
        libcpp_vector[Peak1D].iterator begin() nogil except + # wrap-ignore
        libcpp_vector[Peak1D].iterator end() nogil except + # wrap-ignore

        libcpp_string getNativeID() nogil except +
        void   setNativeID(libcpp_string) nogil except +

        SourceFile getSourceFile() nogil except +
        void setSourceFile(SourceFile) nogil except +



