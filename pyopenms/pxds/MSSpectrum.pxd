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


        MSSpectrum() except +
        MSSpectrum(MSSpectrum) except +
        double getRT() except +
        void   setRT(double) except +
        unsigned int getMSLevel() except +
        void setMSLevel(unsigned int) except +

        libcpp_string getName() except +
        void setName(libcpp_string) except +

        int size() except +
        PeakT operator[](int) except +

        void updateRanges() except +
        void clear(int) except +
        void push_back(PeakT)  except +


        InstrumentSettings getInstrumentSettings() except +
        void setInstrumentSettings(InstrumentSettings) except +

        int findNearest(double) except+
        libcpp_vector[Precursor] getPrecursors() except +
        void setPrecursors(libcpp_vector[Precursor])   except +

        void assign(libcpp_vector[Peak1D].iterator, libcpp_vector[Peak1D].iterator) except + # wrap-ignore
        libcpp_vector[Peak1D].iterator begin() except + # wrap-ignore
        libcpp_vector[Peak1D].iterator end() except + # wrap-ignore

        libcpp_string getNativeID() except +
        void   setNativeID(libcpp_string) except +

        SourceFile getSourceFile() except +
        void setSourceFile(SourceFile) except +



