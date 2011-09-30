from libcpp.vector cimport *
from libcpp.string cimport *
from cython.operator cimport dereference as deref
from pxd.ChromatogramPeak cimport ChromatogramPeak as _ChromatogramPeak
from pxd.ChromatogramTools cimport ChromatogramTools as _ChromatogramTools
from pxd.InstrumentSettings cimport InstrumentSettings as _InstrumentSettings
from pxd.IonSource cimport Polarity as _Polarity
from pxd.MSExperiment cimport MSExperiment as _MSExperiment
from pxd.MSSpectrum cimport MSSpectrum as _MSSpectrum
from pxd.MzDataFile cimport MzDataFile as _MzDataFile
from pxd.MzMLFile cimport MzMLFile as _MzMLFile
from pxd.MzXMLFile cimport MzXMLFile as _MzXMLFile
from pxd.Peak1D cimport Peak1D as _Peak1D
from pxd.Polarity cimport Polarity as _Polarity
from pxd.Precursor cimport Precursor as _Precursor
cdef class Peak1D:                     
    cdef _Peak1D * inst                 
    cdef _new_inst(self):          
       self.inst = new _Peak1D()        
    cdef _set_inst(self, _Peak1D * inst): 
        if self.inst != NULL:      
            del self.inst          
        self.inst = inst           
    def __init__(self, _new_inst = True): 
        if _new_inst:              
           self._new_inst()        
    def __dealloc__(self):         
        if self.inst != NULL:      
            del self.inst          
    def getMZ (self):   
        _result = self.inst.getMZ()
        return _result
    def getIntensity (self):   
        _result = self.inst.getIntensity()
        return _result
    def setMZ (self, double a):   
        self.inst.setMZ(a)          
        return self
    def setIntensity (self, double a):   
        self.inst.setIntensity(a)          
        return self
cdef class Precursor:                     
    cdef _Precursor * inst                 
    cdef _new_inst(self):          
       self.inst = new _Precursor()        
    cdef _set_inst(self, _Precursor * inst): 
        if self.inst != NULL:      
            del self.inst          
        self.inst = inst           
    def __init__(self, _new_inst = True): 
        if _new_inst:              
           self._new_inst()        
    def __dealloc__(self):         
        if self.inst != NULL:      
            del self.inst          
    def getMZ (self):   
        _result = self.inst.getMZ()
        return _result
    def getIntensity (self):   
        _result = self.inst.getIntensity()
        return _result
    def setMZ (self, double a):   
        self.inst.setMZ(a)          
        return self
    def setIntensity (self, double a):   
        self.inst.setIntensity(a)          
        return self
cdef class MSSpectrum:                     
    cdef _MSSpectrum[_Peak1D] * inst                 
    cdef _new_inst(self):          
       self.inst = new _MSSpectrum[_Peak1D]()        
    cdef _set_inst(self, _MSSpectrum[_Peak1D] * inst): 
        if self.inst != NULL:      
            del self.inst          
        self.inst = inst           
    def __init__(self, _new_inst = True): 
        if _new_inst:              
           self._new_inst()        
    def __dealloc__(self):         
        if self.inst != NULL:      
            del self.inst          
    def getRT (self):   
        _result = self.inst.getRT()
        return _result
    def setRT (self, double a):   
        self.inst.setRT(a)          
        return self
    def getMSLevel (self):   
        _result = self.inst.getMSLevel()
        return _result
    def setMSLevel (self, int a):   
        self.inst.setMSLevel(a)          
        return self
    def getName (self):   
        _result = self.inst.getName()
        return _result.c_str()
    def setName (self, char * a):   
        cdef string * _a_as_str = new string(a)
        self.inst.setName(deref(_a_as_str))          
        del _a_as_str
        return self
    def size (self):   
        _result = self.inst.size()
        return _result
    def __getitem__(self, int idx):
        cdef _Peak1D _res = deref(self.inst)[idx]
        __res_py = Peak1D(False) 
        __res_py._set_inst(new _Peak1D(_res)) 
        return __res_py                
    def updateRanges (self):   
        self.inst.updateRanges()          
        return self
    def getInstrumentSettings (self):   
        _result = self.inst.getInstrumentSettings()
        __result_py = InstrumentSettings(False) 
        __result_py._set_inst(new _InstrumentSettings(_result)) 
        return __result_py                
    def findNearest (self, double a):   
        _result = self.inst.findNearest(a)
        return _result
    def getPrecursors (self):   
        _result = self.inst.getPrecursors()
        _rv = list()
        for _i in range(_result.size()):
            _res = Precursor(False) 
            _res._set_inst(new _Precursor(_result.at(_i)))
            _rv.append(_res)
        return _rv
    def setPrecursors (self,  a):   
        cdef vector[_Precursor] * _a_as_vec = new vector[_Precursor]()  
        cdef Precursor _v000               
        for _v000 in a:            
            deref(_a_as_vec).push_back(deref(_v000.inst))
        self.inst.setPrecursors(deref(_a_as_vec))          
        del _a_as_vec
        return self
    def getNativeID (self):   
        _result = self.inst.getNativeID()
        return _result.c_str()
    def setNativeID (self, char * a):   
        cdef string * _a_as_str = new string(a)
        self.inst.setNativeID(deref(_a_as_str))          
        del _a_as_str
        return self
cdef class MSExperiment:                     
    cdef _MSExperiment[_Peak1D,_ChromatogramPeak] * inst                 
    cdef _new_inst(self):          
       self.inst = new _MSExperiment[_Peak1D,_ChromatogramPeak]()        
    cdef _set_inst(self, _MSExperiment[_Peak1D,_ChromatogramPeak] * inst): 
        if self.inst != NULL:      
            del self.inst          
        self.inst = inst           
    def __init__(self, _new_inst = True): 
        if _new_inst:              
           self._new_inst()        
    def __dealloc__(self):         
        if self.inst != NULL:      
            del self.inst          
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
    def sortSpectra (self, int a):   
        self.inst.sortSpectra(a)          
        return self
    def size (self):   
        _result = self.inst.size()
        return _result
    def __getitem__(self, int idx):
        cdef _MSSpectrum[_Peak1D] _res = deref(self.inst)[idx]
        __res_py = MSSpectrum(False) 
        __res_py._set_inst(new _MSSpectrum[_Peak1D](_res)) 
        return __res_py                
    def updateRanges (self):   
        self.inst.updateRanges()          
        return self
    def push_back (self, MSSpectrum a):   
        self.inst.push_back(deref(a.inst))          
        return self
cdef class InstrumentSettings:                     
    cdef _InstrumentSettings * inst                 
    cdef _new_inst(self):          
       self.inst = new _InstrumentSettings()        
    cdef _set_inst(self, _InstrumentSettings * inst): 
        if self.inst != NULL:      
            del self.inst          
        self.inst = inst           
    def __init__(self, _new_inst = True): 
        if _new_inst:              
           self._new_inst()        
    def __dealloc__(self):         
        if self.inst != NULL:      
            del self.inst          
    def getPolarity (self):   
        _result = self.inst.getPolarity()
        return <int>_result
    def setPolarity (self, int a):   
        self.inst.setPolarity(<_Polarity>a)          
        return self
cdef class ChromatogramTools:                     
    cdef _ChromatogramTools * inst                 
    cdef _new_inst(self):          
       self.inst = new _ChromatogramTools()        
    cdef _set_inst(self, _ChromatogramTools * inst): 
        if self.inst != NULL:      
            del self.inst          
        self.inst = inst           
    def __init__(self, _new_inst = True): 
        if _new_inst:              
           self._new_inst()        
    def __dealloc__(self):         
        if self.inst != NULL:      
            del self.inst          
    def convertChromatogramsToSpectra (self, MSExperiment epx):   
        self.inst.convertChromatogramsToSpectra(deref(epx.inst))          
        return self
    def convertSpectraToChromatograms (self, MSExperiment epx, int remove_spectra):   
        self.inst.convertSpectraToChromatograms(deref(epx.inst), remove_spectra)          
        return self
cdef class Polarity:         
    POSNULL=0
    POSITIVE=1
    NEGATIVE=2
    SIZE_OF_POLARITY=3
cdef class MzXMLFile:                     
    cdef _MzXMLFile * inst                 
    cdef _new_inst(self):          
       self.inst = new _MzXMLFile()        
    cdef _set_inst(self, _MzXMLFile * inst): 
        if self.inst != NULL:      
            del self.inst          
        self.inst = inst           
    def __init__(self, _new_inst = True): 
        if _new_inst:              
           self._new_inst()        
    def __dealloc__(self):         
        if self.inst != NULL:      
            del self.inst          
    def load (self, char * a, MSExperiment b):   
        cdef string * _a_as_str = new string(a)
        self.inst.load(deref(_a_as_str), deref(b.inst))          
        del _a_as_str
        return self
    def store (self, char * a, MSExperiment b):   
        cdef string * _a_as_str = new string(a)
        self.inst.store(deref(_a_as_str), deref(b.inst))          
        del _a_as_str
        return self
cdef class MzMLFile:                     
    cdef _MzMLFile * inst                 
    cdef _new_inst(self):          
       self.inst = new _MzMLFile()        
    cdef _set_inst(self, _MzMLFile * inst): 
        if self.inst != NULL:      
            del self.inst          
        self.inst = inst           
    def __init__(self, _new_inst = True): 
        if _new_inst:              
           self._new_inst()        
    def __dealloc__(self):         
        if self.inst != NULL:      
            del self.inst          
    def load (self, char * a, MSExperiment b):   
        cdef string * _a_as_str = new string(a)
        self.inst.load(deref(_a_as_str), deref(b.inst))          
        del _a_as_str
        return self
    def store (self, char * a, MSExperiment b):   
        cdef string * _a_as_str = new string(a)
        self.inst.store(deref(_a_as_str), deref(b.inst))          
        del _a_as_str
        return self
cdef class MzDataFile:                     
    cdef _MzDataFile * inst                 
    cdef _new_inst(self):          
       self.inst = new _MzDataFile()        
    cdef _set_inst(self, _MzDataFile * inst): 
        if self.inst != NULL:      
            del self.inst          
        self.inst = inst           
    def __init__(self, _new_inst = True): 
        if _new_inst:              
           self._new_inst()        
    def __dealloc__(self):         
        if self.inst != NULL:      
            del self.inst          
    def load (self, char * a, MSExperiment b):   
        cdef string * _a_as_str = new string(a)
        self.inst.load(deref(_a_as_str), deref(b.inst))          
        del _a_as_str
        return self
    def store (self, char * a, MSExperiment b):   
        cdef string * _a_as_str = new string(a)
        self.inst.store(deref(_a_as_str), deref(b.inst))          
        del _a_as_str
        return self
