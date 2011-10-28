from libcpp.vector cimport *
from libcpp.string cimport *
from InstrumentSettings cimport *
from Precursor cimport *
from Peak1D cimport *
from SourceFile cimport *

cdef extern from "<OpenMS/KERNEL/MSSpectrum.h>" namespace "OpenMS":

    cdef cppclass MSSpectrum[PeakT]:  # wrap=True; inst=("Peak1D",)
        MSSpectrum()
        MSSpectrum(MSSpectrum)
        double getRT()
        void   setRT(double) except +
        unsigned int getMSLevel()
        void setMSLevel(unsigned int) except +

        string getName()
        void setName(string) except +

        int size()
        PeakT operator[](int) except +

        void updateRanges()
        void clear(int)       
        void push_back(PeakT)  except +

    
        InstrumentSettings getInstrumentSettings()
        void setInstrumentSettings(InstrumentSettings) except +

        int findNearest(double) except+
        vector[Precursor] getPrecursors()       
        void setPrecursors(vector[Precursor])   except +

        void assign(vector[Peak1D].iterator, vector[Peak1D].iterator) # ignore=True
        vector[Peak1D].iterator begin() # ignore=True
        vector[Peak1D].iterator end() # ignore=True

        string getNativeID()
        void   setNativeID(string) except +

        SourceFile getSourceFile()
        void setSourceFile(SourceFile) except +

        

