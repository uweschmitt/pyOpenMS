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


        MSSpectrum()
        MSSpectrum(MSSpectrum)
        double getRT()
        void   setRT(double) except +
        unsigned int getMSLevel()
        void setMSLevel(unsigned int) except +

        libcpp_string getName()
        void setName(libcpp_string) except +

        int size()
        PeakT operator[](int) except + # wrap-ignore

        void updateRanges()
        void clear(int)
        void push_back(PeakT)  except +


        InstrumentSettings getInstrumentSettings()
        void setInstrumentSettings(InstrumentSettings) except +

        int findNearest(double) except+
        libcpp_vector[Precursor] getPrecursors()
        void setPrecursors(libcpp_vector[Precursor])   except +

        void assign(libcpp_vector[Peak1D].iterator, libcpp_vector[Peak1D].iterator) # wrap-ignore
        libcpp_vector[Peak1D].iterator begin() # wrap-ignore
        libcpp_vector[Peak1D].iterator end() # wrap-ignore

        libcpp_string getNativeID()
        void   setNativeID(libcpp_string) except +

        SourceFile getSourceFile()
        void setSourceFile(SourceFile) except +



