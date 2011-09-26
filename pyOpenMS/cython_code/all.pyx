from pxd.Peak1D       cimport *
from pxd.MSExperiment cimport *
from pxd.MSSpectrum   cimport *
from pxd.MzXMLFile    cimport *
from pxd.MzMLFile     cimport *
from pxd.MzDataFile   cimport *
from pxd.ChromatogramTools cimport *
from pxd.InstrumentSettings cimport *

from libcpp.vector cimport *



cdef class PyMSSpectrum:

    cdef MSSpectrum[Peak1D] * inst

    def __cinit__(self):
        self.inst = new MSSpectrum[Peak1D]()

    def __dealloc__(self):
        del self.inst

    cdef replaceInstance(self, MSSpectrum[Peak1D] * inst):
        if self.inst != NULL:
            del self.inst
        self.inst = inst

    def size(self):
        return self.inst.size()

    def getRT(self):
        return self.inst.getRT()

    def setRT(self, double rt):
        self.inst.setRT(rt)

    def setMSLevel(self, unsigned int level):
        self.inst.setMSLevel(level)
        
    def getMSLevel(self):
        return self.inst.getMSLevel()

    def getName(self):
        cdef string name = self.inst.getName()
        return name.c_str()

    def __getitem__(self, int i):
        if i<0: i+= self.size()
        if i<0:
                raise Exception("invalid index")
        cdef Peak1D a = deref(self.inst)[i]
        cdef PyPeak1D  res = PyPeak1D()
        res.replaceInstance(new Peak1D(a))
        return res

    def getInstrumentSettings(self):
        cdef PyInstrumentSettings  res = PyInstrumentSettings()
        res.replaceInstance(new InstrumentSettings(self.inst.getInstrumentSettings()))
        return res

    def getPrecursors(self):
        cdef vector[Precursor] precursors = self.inst.getPrecursors()
        cdef list rv = list()
        cdef Precursor * pc
        for i in range(precursors.size()):
              pc = new Precursor(precursors.at(i))
              pypc = PyPrecursor()
              pypc.replaceInstance(pc)
              rv.append(pypc)
        return rv
            
        
    


cdef class PyMSExperiment:

    cdef MSExperiment[Peak1D, ChromatogramPeak] * inst

    def __cinit__(self):
        self.inst = new MSExperiment[Peak1D, ChromatogramPeak]()

    def __dealloc__(self):
        if self.inst != NULL:
            del self.inst

    def __dealloc__(self):
        del self.inst

    def getMinMZ(self):
        return self.inst.getMinMZ()

    def sortSpectra(self, int b0):
        self.inst.sortSpectra(b0)

    def __getitem__(self, int i):
        if i<0: i+= self.size()
        if i<0:
                raise Exception("invalid index")

        cdef MSSpectrum[Peak1D] a= deref(self.inst)[i]
        cdef PyMSSpectrum  res = PyMSSpectrum()
        res.replaceInstance(new MSSpectrum[Peak1D](a))      
        return res

    def size(self):
        return self.inst.size()



cdef class PyMzXMLFile:

    cdef MzXMLFile * inst

    def __cinit__(self):
        self.inst = new MzXMLFile()

    def load(self, char * path, PyMSExperiment experiment):
        cdef string * s_path = new string(path) 
        self.inst.load(deref(s_path), deref(experiment.inst))
        del s_path

    def store(self, char* path, PyMSExperiment experiment):
        cdef string * s_path = new string(path) 
        self.inst.store(deref(s_path), deref(experiment.inst))
        del s_path
        

cdef class PyMzMLFile:

    cdef MzMLFile * inst

    def __cinit__(self):
        self.inst = new MzMLFile()

    def load(self, char * path, PyMSExperiment experiment):
        cdef string * s_path = new string(path) 
        self.inst.load(deref(s_path), deref(experiment.inst))
        del s_path

    def store(self, char* path, PyMSExperiment experiment):
        cdef string * s_path = new string(path) 
        self.inst.store(deref(s_path), deref(experiment.inst))
        del s_path

cdef class PyMzDataFile:

    cdef MzDataFile * inst

    def __cinit__(self):
        self.inst = new MzDataFile()

    def load(self, char * path, PyMSExperiment experiment):
        cdef string * s_path = new string(path) 
        self.inst.load(deref(s_path), deref(experiment.inst))
        del s_path

    def store(self, char* path, PyMSExperiment experiment):
        cdef string * s_path = new string(path) 
        self.inst.store(deref(s_path), deref(experiment.inst))
        del s_path

cdef class PyChromatogramTools:

    cdef ChromatogramTools * inst

    def __cinit__(self):
        self.inst = new ChromatogramTools()

    def convertChromatogramsToSpectra(self, PyMSExperiment exp):
        self.inst.convertChromatogramsToSpectra(deref(exp.inst))

    def convertSpectraToChromatograms(self, PyMSExperiment exp, int remove):
        self.inst.convertSpectraToChromatograms(deref(exp.inst) , remove)


cdef class PyPolarity:

    cdef int p

    def __cinit__(self, int pp):
        self.p = pp

    def toString(self):
        return { 0 : "POLNULL",
                 1 : "POSITIVE",
                 2 : "NEGATIVE",
                 3 : "SIZE_OF_POLARITY"}[<long>self.p]

    def toInt(self):
        return self.p
        

cdef class PyPrecursor:

    cdef Precursor * inst

    def __cinit__(self):
        self.inst = new Precursor()
        

    def __dealloc__(self):
        del self.inst

    cdef replaceInstance(self, Precursor * inst):
        del self.inst
        self.inst = inst

    def getMZ(self):
        return self.inst.getMZ()

    def getIntensity(self):
        return self.inst.getIntensity()

    def setMZ(self, double mz):
        self.inst.setMZ(mz)

    def setIntensity(self, double I):
        self.inst.setIntensity(I)

cdef class PyPeak1D:

    cdef Peak1D * inst

    def __cinit__(self):
        self.inst = new Peak1D()
        

    def __dealloc__(self):
        del self.inst

    cdef replaceInstance(self, Peak1D * inst):
        del self.inst
        self.inst = inst

    def getMZ(self):
        return self.inst.getMZ()

    def getIntensity(self):
        return self.inst.getIntensity()

    def setMZ(self, double mz):
        self.inst.setMZ(mz)

    def setIntensity(self, double I):
        self.inst.setIntensity(I)

cdef class PyInstrumentSettings:

    cdef InstrumentSettings * inst

    def __cinit__(self):
        self.inst = new InstrumentSettings()

    def __dealloc__(self):
        del self.inst

    cdef replaceInstance(self, InstrumentSettings * inst):
        del self.inst
        self.inst = inst

    def getPolarity(self):
        return PyPolarity(self.inst.getPolarity())

    def setPolarity(self, int p):
        self.inst.setPolarity(<Polarity>p)
        return self.inst.getPolarity()
    
