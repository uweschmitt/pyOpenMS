from pxd.ChromatogramPeak cimport ChromatogramPeak
from pxd.ChromatogramTools cimport ChromatogramTools
from pxd.InstrumentSettings cimport InstrumentSettings
from pxd.IonSource cimport Polarity
from pxd.MSExperiment cimport MSExperiment
from pxd.MSSpectrum cimport MSSpectrum
from pxd.MzDataFile cimport MzDataFile
from pxd.MzMLFile cimport MzMLFile
from pxd.MzXMLFile cimport MzXMLFile
from pxd.Peak1D cimport Peak1D
from pxd.Polarity cimport Polarity
from pxd.Precursor cimport Precursor
from pxd.string cimport string
from pxd.string cimport string
from libcpp.vector cimport *
from cython.operator cimport address as addr, dereference as deref
cdef class Py_Peak1D:
    cdef _Peak1D  * inst 
    def __cinit__(self):
        self.inst = new _Peak1D()
    def __dealloc__(self):
        del self.inst
    cdef replaceInstance(self, _Peak1D * inst):
        if self.inst:
              del self.inst
        self.inst = inst
    def getMZ (self):
        _result = self.inst.getMZ() 
        return _result

    def getIntensity (self):
        _result = self.inst.getIntensity() 
        return _result

    def setMZ (self, _double a):
        self.inst.setMZ(a) 
        return self
    def setIntensity (self, _double a):
        self.inst.setIntensity(a) 
        return self
cdef class Py_Precursor:
    cdef _Precursor  * inst 
    def __cinit__(self):
        self.inst = new _Precursor()
    def __dealloc__(self):
        del self.inst
    cdef replaceInstance(self, _Precursor * inst):
        if self.inst:
              del self.inst
        self.inst = inst
    def getMZ (self):
        _result = self.inst.getMZ() 
        return _result

    def getIntensity (self):
        _result = self.inst.getIntensity() 
        return _result

    def setMZ (self, _double a):
        self.inst.setMZ(a) 
        return self
    def setIntensity (self, _double a):
        self.inst.setIntensity(a) 
        return self
cdef class Py_MSSpectrum:
    cdef _MSSpectrum[_Peak1D]  * inst 
    def __cinit__(self):
        self.inst = new _MSSpectrum[_Peak1D]()
    def __dealloc__(self):
        del self.inst
    cdef replaceInstance(self, _MSSpectrum[_Peak1D] * inst):
        if self.inst:
              del self.inst
        self.inst = inst
    def getRT (self):
        _result = self.inst.getRT() 
        return _result

    def setRT (self, _double a):
        self.inst.setRT(a) 
        return self
    def getMSLevel (self):
        _result = self.inst.getMSLevel() 
        return _result

    def setMSLevel (self, _int a):
        self.inst.setMSLevel(a) 
        return self
    def getName (self):
        _result = self.inst.getName() 
        return _result.c_str()

    def setName (self, char * a):
        cdef string * a_as_str = new string(a)
        self.inst.setName(deref(a_as_str)) 
        del a_as_str
        return self
    def size (self):
        _result = self.inst.size() 
        return _result

    def __getitem__(self, int idx):
        cdef _PeakT res = deref(self.inst)[idx]
        return res

    def updateRanges (self):
        self.inst.updateRanges() 
        return self
    def getInstrumentSettings (self):
        _result = self.inst.getInstrumentSettings() 
        _result_py = InstrumentSettings()
        _result_py.replaceInstance(new _InstrumentSettings(_result))
        return _result_py

    def findNearest (self, _double a):
        _result = self.inst.findNearest(a) 
        return _result

    def getPrecursors (self):
        _result = self.inst.getPrecursors() 
        rv = list()
        for i in range(_result.size()):
            res = Precursor()
            res.replaceInstance(new _Precursor(_result.at(i)))
            rv.append(res)
        return rv

    def setPrecursors (self,  a):
        cdef _vector[_Precursor] * a_as_vec = new _vector[_Precursor]()
        cdef Precursor v000
        for v000 in a:
            deref(a_as_vec).push_back(deref(v000.inst))
        self.inst.setPrecursors(deref(a_as_vec)) 
        del a_as_vec
        return self
    def getNativeID (self):
        _result = self.inst.getNativeID() 
        return _result.c_str()

    def setNativeID (self, char * a):
        cdef string * a_as_str = new string(a)
        self.inst.setNativeID(deref(a_as_str)) 
        del a_as_str
        return self
cdef class Py_MSExperiment:
    cdef _MSExperiment[_Peak1D,_ChromatogramPeak]  * inst 
    def __cinit__(self):
        self.inst = new _MSExperiment[_Peak1D,_ChromatogramPeak]()
    def __dealloc__(self):
        del self.inst
    cdef replaceInstance(self, _MSExperiment[_Peak1D,_ChromatogramPeak] * inst):
        if self.inst:
              del self.inst
        self.inst = inst
    def getMinMZ (self):
        _result = self.inst.getMinMZ() 
        return _result

    def getMaxMZ (self):
        _result = self.inst.getMaxMZ() 
        return _result

    def getMinRT (self):
        _result = self.inst.getMinRT() 
        return _result

    def getMaxRT (self):
        _result = self.inst.getMaxRT() 
        return _result

    def sortSpectra (self, _int a):
        self.inst.sortSpectra(a) 
        return self
    def size (self):
        _result = self.inst.size() 
        return _result

    def __getitem__(self, int idx):
        cdef Py__MSSpectrum[_PeakT] res = deref(self.inst)[idx]
        res_py = MSSpectrum()
        res_py.replaceInstance(new _MSSpectrum[_PeakT](res))
        return res_py

    def updateRanges (self):
        self.inst.updateRanges() 
        return self
    def push_back (self, _MSSpectrum[_PeakT] a):
        self.inst.push_back(a) 
        return self
cdef class Py_InstrumentSettings:
    cdef _InstrumentSettings  * inst 
    def __cinit__(self):
        self.inst = new _InstrumentSettings()
    def __dealloc__(self):
        del self.inst
    cdef replaceInstance(self, _InstrumentSettings * inst):
        if self.inst:
              del self.inst
        self.inst = inst
cdef class Py_MzXMLFile:
    cdef _MzXMLFile  * inst 
    def __cinit__(self):
        self.inst = new _MzXMLFile()
    def __dealloc__(self):
        del self.inst
    cdef replaceInstance(self, _MzXMLFile * inst):
        if self.inst:
              del self.inst
        self.inst = inst
    def load (self, char * a, _MSExperiment[_Peak1D,_ChromatogramPeak] b):
        cdef string * a_as_str = new string(a)
        self.inst.load(deref(a_as_str), b) 
        del a_as_str
        return self
    def store (self, char * a, _MSExperiment[_Peak1D,_ChromatogramPeak] b):
        cdef string * a_as_str = new string(a)
        self.inst.store(deref(a_as_str), b) 
        del a_as_str
        return self
cdef class Py_MzMLFile:
    cdef _MzMLFile  * inst 
    def __cinit__(self):
        self.inst = new _MzMLFile()
    def __dealloc__(self):
        del self.inst
    cdef replaceInstance(self, _MzMLFile * inst):
        if self.inst:
              del self.inst
        self.inst = inst
    def load (self, char * a, _MSExperiment[_Peak1D,_ChromatogramPeak] b):
        cdef string * a_as_str = new string(a)
        self.inst.load(deref(a_as_str), b) 
        del a_as_str
        return self
    def store (self, char * a, _MSExperiment[_Peak1D,_ChromatogramPeak] b):
        cdef string * a_as_str = new string(a)
        self.inst.store(deref(a_as_str), b) 
        del a_as_str
        return self
cdef class Py_MzDataFile:
    cdef _MzDataFile  * inst 
    def __cinit__(self):
        self.inst = new _MzDataFile()
    def __dealloc__(self):
        del self.inst
    cdef replaceInstance(self, _MzDataFile * inst):
        if self.inst:
              del self.inst
        self.inst = inst
    def load (self, char * a, _MSExperiment[_Peak1D,_ChromatogramPeak] b):
        cdef string * a_as_str = new string(a)
        self.inst.load(deref(a_as_str), b) 
        del a_as_str
        return self
    def store (self, char * a, _MSExperiment[_Peak1D,_ChromatogramPeak] b):
        cdef string * a_as_str = new string(a)
        self.inst.store(deref(a_as_str), b) 
        del a_as_str
        return self
cdef class Py_ChromatogramTools:
    cdef _ChromatogramTools  * inst 
    def __cinit__(self):
        self.inst = new _ChromatogramTools()
    def __dealloc__(self):
        del self.inst
    cdef replaceInstance(self, _ChromatogramTools * inst):
        if self.inst:
              del self.inst
        self.inst = inst
    def convertChromatogramsToSpectra (self, _MSExperiment[_Peak1D,_ChromatogramPeak] epx):
        self.inst.convertChromatogramsToSpectra(epx) 
        return self
    def convertSpectraToChromatograms (self, _MSExperiment[_Peak1D,_ChromatogramPeak] epx, _int remove_spectra):
        self.inst.convertSpectraToChromatograms(epx, remove_spectra) 
        return self
