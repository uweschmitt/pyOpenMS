from  libcpp.string  cimport string as libcpp_string
from  libcpp.vector  cimport vector as libcpp_vector
from  libcpp.pair    cimport pair as libcpp_pair
from  libcpp cimport bool
from  libc.stdint  cimport *
from  libc.stddef  cimport *
from smart_ptr cimport shared_ptr
cimport numpy as np
import numpy as np
from cython.operator cimport dereference as deref, preincrement as inc, address as address
from BaseFeature cimport BaseFeature as _BaseFeature
from ChecksumType cimport ChecksumType as _ChecksumType
from ChromatogramPeak cimport ChromatogramPeak as _ChromatogramPeak
from ChromatogramTools cimport ChromatogramTools as _ChromatogramTools
from ConsensusFeature cimport ConsensusFeature as _ConsensusFeature
from DataValue_DataType cimport DataType as _DataType
from DataValue cimport DataValue as _DataValue
from DoubleList cimport DoubleList as _DoubleList
from Feature cimport Feature as _Feature
from FeatureMap cimport FeatureMap as _FeatureMap
from FeatureXMLFile cimport FeatureXMLFile as _FeatureXMLFile
from FileHandler cimport FileHandler as _FileHandler
from FileTypes cimport FileTypes as _FileTypes
from InstrumentSettings cimport InstrumentSettings as _InstrumentSettings
from IntList cimport IntList as _IntList
from ProgressLogger_LogType cimport LogType as _LogType
from MSExperiment cimport MSExperiment as _MSExperiment
from MSSpectrum cimport MSSpectrum as _MSSpectrum
from MapAlignmentAlgorithmPoseClustering cimport MapAlignmentAlgorithmPoseClustering as _MapAlignmentAlgorithmPoseClustering
from MetaInfoInterface cimport MetaInfoInterface as _MetaInfoInterface
from MzDataFile cimport MzDataFile as _MzDataFile
from MzMLFile cimport MzMLFile as _MzMLFile
from MzXMLFile cimport MzXMLFile as _MzXMLFile
from Param cimport Param as _Param
from ParamIterator cimport ParamIterator as _ParamIterator
from Peak1D cimport Peak1D as _Peak1D
from Peak2D cimport Peak2D as _Peak2D
from PeakPickerHiRes cimport PeakPickerHiRes as _PeakPickerHiRes
from IonSource_Polarity cimport Polarity as _Polarity
from Precursor cimport Precursor as _Precursor
from ProgressLogger cimport ProgressLogger as _ProgressLogger
from ProteinHit cimport ProteinHit as _ProteinHit
from ProteinIdentification cimport ProteinIdentification as _ProteinIdentification
from RichPeak1D cimport RichPeak1D as _RichPeak1D
from RichPeak2D cimport RichPeak2D as _RichPeak2D
from SourceFile cimport SourceFile as _SourceFile
from String cimport String as _String
from StringList cimport StringList as _StringList
from TransformationDescription cimport TransformationDescription as _TransformationDescription
from UniqueIdGenerator cimport UniqueIdGenerator as _UniqueIdGenerator
from UniqueIdInterface cimport UniqueIdInterface as _UniqueIdInterface
from FileHandler cimport getType as _getType
cdef extern from "autowrap_tools.hpp":
    char * _cast_const_away(char *)
def __static_FileHandler_getType(bytes filename ):
    assert isinstance(filename, bytes), 'arg filename invalid'

    cdef int _r = _getType((_String(<char *>filename)))
    py_result = <int>_r
    return py_result 
cdef class Polarity:
    POLNULL = 0
    POSITIVE = 1
    NEGATIVE = 2
    SIZE_OF_POLARITY = 3 
cdef class MSExperiment:
    cdef shared_ptr[_MSExperiment[_Peak1D,_ChromatogramPeak]] inst
    def __dealloc__(self):
         self.inst.reset()
    def __init__(self):
        self.inst = shared_ptr[_MSExperiment[_Peak1D,_ChromatogramPeak]](new _MSExperiment[_Peak1D,_ChromatogramPeak]())
    def setMetaValue(self, bytes key , DataValue value ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(value, DataValue), 'arg value invalid'
    
    
        self.inst.get().setMetaValue((_String(<char *>key)), <_DataValue>deref(value.inst.get()))
    def sortSpectra(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        self.inst.get().sortSpectra((<bool>in_0))
    def getMaxRT(self):
        cdef double _r = self.inst.get().getMaxRT()
        py_result = <float>_r
        return py_result
    def getMinMZ(self):
        cdef double _r = self.inst.get().getMinMZ()
        py_result = <float>_r
        return py_result
    def getLoadedFilePath(self):
        cdef _String _r = self.inst.get().getLoadedFilePath()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def getMetaValue(self, bytes key ):
        assert isinstance(key, bytes), 'arg key invalid'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>key))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def setLoadedFilePath(self, bytes path ):
        assert isinstance(path, bytes), 'arg path invalid'
    
        self.inst.get().setLoadedFilePath((_String(<char *>path)))
    def updateRanges(self):
        self.inst.get().updateRanges()
    def push_back(self, MSSpectrum spec ):
        assert isinstance(spec, MSSpectrum), 'arg spec invalid'
    
        self.inst.get().push_back(<_MSSpectrum[_Peak1D]>deref(spec.inst.get()))
    def __getitem__(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef _MSSpectrum[_Peak1D] * _r = new _MSSpectrum[_Peak1D](deref(self.inst.get())[(<int>in_0)])
        cdef MSSpectrum py_result = MSSpectrum.__new__(MSSpectrum)
        py_result.inst = shared_ptr[_MSSpectrum[_Peak1D]](_r)
        return py_result
    def getMaxMZ(self):
        cdef double _r = self.inst.get().getMaxMZ()
        py_result = <float>_r
        return py_result
    def getMinRT(self):
        cdef double _r = self.inst.get().getMinRT()
        py_result = <float>_r
        return py_result
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result
    def __iter__(self):
        it = self.inst.get().begin()
        cdef MSSpectrum out
        while it != self.inst.get().end():
            out = MSSpectrum.__new__(MSSpectrum)
            out.inst = shared_ptr[_MSSpectrum[_Peak1D]](new _MSSpectrum[_Peak1D](deref(it)))
            yield out
            inc(it) 
cdef class ProteinHit:
    cdef shared_ptr[_ProteinHit] inst
    def __dealloc__(self):
         self.inst.reset()
    def getSequence(self):
        cdef _String _r = self.inst.get().getSequence()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_ProteinHit](new _ProteinHit())
    def getCoverage(self):
        cdef double _r = self.inst.get().getCoverage()
        py_result = <float>_r
        return py_result
    def setAccession(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
    
        self.inst.get().setAccession((_String(<char *>in_0)))
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], int)):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def getScore(self):
        cdef float _r = self.inst.get().getScore()
        py_result = <float>_r
        return py_result
    def setRank(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        self.inst.get().setRank((<int>in_0))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys invalid'
        cdef libcpp_vector[_String] * v0 = new libcpp_vector[_String]()
        cdef bytes item0
        for item0 in keys:
           v0.push_back(_String(<char *>item0))
        self.inst.get().getKeys(deref(v0))
        cdef replace = []
        cdef libcpp_vector[_String].iterator it = v0.begin()
        while it != v0.end():
           replace.append(<char*>deref(it).c_str())
           inc(it)
        keys[:] = replace
        del v0
    def _getKeys_1(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(li, int) for li in keys), 'arg keys invalid'
        cdef libcpp_vector[unsigned int] * v0 = new libcpp_vector[unsigned int]()
        cdef unsigned int item0
        for item0 in keys:
           v0.push_back(item0)
        self.inst.get().getKeys(deref(v0))
        del v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, int) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def getRank(self):
        cdef unsigned int _r = self.inst.get().getRank()
        py_result = <int>_r
        return py_result
    def getAccession(self):
        cdef _String _r = self.inst.get().getAccession()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def setCoverage(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setCoverage((<float>in_0))
    def setScore(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setScore((<float>in_0))
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, ProteinHit):
            return False
        cdef ProteinHit other_casted = other
        cdef ProteinHit self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get()) 
cdef class ConsensusFeature:
    cdef shared_ptr[_ConsensusFeature] inst
    def __dealloc__(self):
         self.inst.reset()
    def computeConsensus(self):
        self.inst.get().computeConsensus()
    def _insert_0(self, int in_0 , Peak2D in_1 , int in_2 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
        assert isinstance(in_1, Peak2D), 'arg in_1 invalid'
        assert isinstance(in_2, int), 'arg in_2 invalid'
    
    
    
        self.inst.get().insert((<uint64_t>in_0), <_Peak2D>deref(in_1.inst.get()), (<uint64_t>in_2))
    def _insert_1(self, int in_0 , BaseFeature in_1 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
        assert isinstance(in_1, BaseFeature), 'arg in_1 invalid'
    
    
        self.inst.get().insert((<uint64_t>in_0), <_BaseFeature>deref(in_1.inst.get()))
    def insert(self, *args):
        if (len(args)==3) and (isinstance(args[0], int)) and (isinstance(args[1], Peak2D)) and (isinstance(args[2], int)):
            return self._insert_0(*args)
        elif (len(args)==2) and (isinstance(args[0], int)) and (isinstance(args[1], BaseFeature)):
            return self._insert_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def computeMonoisotopicConsensus(self):
        self.inst.get().computeMonoisotopicConsensus()
    def _init_0(self):
        self.inst = shared_ptr[_ConsensusFeature](new _ConsensusFeature())
    def _init_1(self, int in_0 , Peak2D in_1 , int in_2 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
        assert isinstance(in_1, Peak2D), 'arg in_1 invalid'
        assert isinstance(in_2, int), 'arg in_2 invalid'
    
    
    
        self.inst = shared_ptr[_ConsensusFeature](new _ConsensusFeature((<uint64_t>in_0), <_Peak2D>deref(in_1.inst.get()), (<uint64_t>in_2)))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==3) and (isinstance(args[0], int)) and (isinstance(args[1], Peak2D)) and (isinstance(args[2], int)):
             self._init_1(*args)
        else:
               raise Exception('can not handle %s' % (args,)) 
cdef class ProteinIdentification:
    cdef shared_ptr[_ProteinIdentification] inst
    def __dealloc__(self):
         self.inst.reset()
    def setHits(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, ProteinHit) for li in in_0), 'arg in_0 invalid'
        cdef libcpp_vector[_ProteinHit] * v0 = new libcpp_vector[_ProteinHit]()
        cdef ProteinHit item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setHits(deref(v0))
        del v0
    def getHits(self):
        _r = self.inst.get().getHits()
        py_result = []
        cdef libcpp_vector[_ProteinHit].iterator it__r = _r.begin()
        cdef ProteinHit item_py_result
        while it__r != _r.end():
           item_py_result = ProteinHit.__new__(ProteinHit)
           item_py_result.inst = shared_ptr[_ProteinHit](new _ProteinHit(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_ProteinIdentification](new _ProteinIdentification())
    def insertHit(self, ProteinHit in_0 ):
        assert isinstance(in_0, ProteinHit), 'arg in_0 invalid'
    
        self.inst.get().insertHit(<_ProteinHit>deref(in_0.inst.get()))
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], int)):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def _getMetaValue_0(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], int)):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys invalid'
        cdef libcpp_vector[_String] * v0 = new libcpp_vector[_String]()
        cdef bytes item0
        for item0 in keys:
           v0.push_back(_String(<char *>item0))
        self.inst.get().getKeys(deref(v0))
        cdef replace = []
        cdef libcpp_vector[_String].iterator it = v0.begin()
        while it != v0.end():
           replace.append(<char*>deref(it).c_str())
           inc(it)
        keys[:] = replace
        del v0
    def _getKeys_1(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(li, int) for li in keys), 'arg keys invalid'
        cdef libcpp_vector[unsigned int] * v0 = new libcpp_vector[unsigned int]()
        cdef unsigned int item0
        for item0 in keys:
           v0.push_back(item0)
        self.inst.get().getKeys(deref(v0))
        del v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, int) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, ProteinIdentification):
            return False
        cdef ProteinIdentification other_casted = other
        cdef ProteinIdentification self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get()) 
cdef class SourceFile:
    cdef shared_ptr[_SourceFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def setNativeIDType(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 invalid'
    
        self.inst.get().setNativeIDType((<libcpp_string>in_0))
    def getChecksum(self):
        cdef libcpp_string _r = self.inst.get().getChecksum()
        py_result = <libcpp_string>_r
        return py_result
    def getNativeIDType(self):
        cdef libcpp_string _r = self.inst.get().getNativeIDType()
        py_result = <libcpp_string>_r
        return py_result
    def setFileType(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 invalid'
    
        self.inst.get().setFileType((<libcpp_string>in_0))
    def getFileSize(self):
        cdef float _r = self.inst.get().getFileSize()
        py_result = <float>_r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_SourceFile](new _SourceFile())
    def _init_1(self, SourceFile in_0 ):
        assert isinstance(in_0, SourceFile), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_SourceFile](new _SourceFile(<_SourceFile>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], SourceFile)):
             self._init_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def setNameOfFile(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 invalid'
    
        self.inst.get().setNameOfFile((<libcpp_string>in_0))
    def getPathToFile(self):
        cdef libcpp_string _r = self.inst.get().getPathToFile()
        py_result = <libcpp_string>_r
        return py_result
    def setPathToFile(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 invalid'
    
        self.inst.get().setPathToFile((<libcpp_string>in_0))
    def getFileType(self):
        cdef libcpp_string _r = self.inst.get().getFileType()
        py_result = <libcpp_string>_r
        return py_result
    def setFileSize(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setFileSize((<float>in_0))
    def getNameOfFile(self):
        cdef libcpp_string _r = self.inst.get().getNameOfFile()
        py_result = <libcpp_string>_r
        return py_result
    def getChecksumType(self):
        cdef _ChecksumType _r = self.inst.get().getChecksumType()
        py_result = <int>_r
        return py_result
    def setChecksum(self, str in_0 , int in_1 ):
        assert isinstance(in_0, str), 'arg in_0 invalid'
        assert in_1 in [0, 1, 2, 3], 'arg in_1 invalid'
    
    
        self.inst.get().setChecksum((<libcpp_string>in_0), (<_ChecksumType>in_1)) 
cdef class Feature:
    cdef shared_ptr[_Feature] inst
    def __dealloc__(self):
         self.inst.reset()
    def getIntensity(self):
        cdef double _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def setRT(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setRT((<float>in_0))
    def getRT(self):
        cdef double _r = self.inst.get().getRT()
        py_result = <float>_r
        return py_result
    def __copy__(self):
       cdef Feature rv = Feature.__new__(Feature)
       rv.inst = shared_ptr[_Feature](new _Feature(deref(self.inst.get())))
       return rv
    def __init__(self):
        self.inst = shared_ptr[_Feature](new _Feature())
    def setUniqueId(self):
        self.inst.get().setUniqueId()
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setIntensity((<float>in_0))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setMZ((<float>in_0))
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result 
cdef class Param:
    cdef shared_ptr[_Param] inst
    def __dealloc__(self):
         self.inst.reset()
    def getTags(self, bytes key ):
        assert isinstance(key, bytes), 'arg key invalid'
    
        cdef _StringList * _r = new _StringList(self.inst.get().getTags((_String(<char *>key))))
        cdef StringList py_result = StringList.__new__(StringList)
        py_result.inst = shared_ptr[_StringList](_r)
        return py_result
    def insert(self, bytes prefix , Param param ):
        assert isinstance(prefix, bytes), 'arg prefix invalid'
        assert isinstance(param, Param), 'arg param invalid'
    
    
        self.inst.get().insert((_String(<char *>prefix)), <_Param>deref(param.inst.get()))
    def setValue(self, bytes key , DataValue val , bytes desc , StringList tags ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(val, DataValue), 'arg val invalid'
        assert isinstance(desc, bytes), 'arg desc invalid'
        assert isinstance(tags, StringList), 'arg tags invalid'
    
    
    
    
        self.inst.get().setValue((_String(<char *>key)), <_DataValue>deref(val.inst.get()), (_String(<char *>desc)), <_StringList>deref(tags.inst.get()))
    def load(self, str filename ):
        assert isinstance(filename, str), 'arg filename invalid'
    
        self.inst.get().load((<libcpp_string>filename))
    def addTags(self, bytes key , StringList tags ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(tags, StringList), 'arg tags invalid'
    
    
        self.inst.get().addTags((_String(<char *>key)), <_StringList>deref(tags.inst.get()))
    def exists(self, bytes key ):
        assert isinstance(key, bytes), 'arg key invalid'
    
        cdef int _r = self.inst.get().exists((_String(<char *>key)))
        py_result = <int>_r
        return py_result
    def setValidStrings(self, bytes key , list strings ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(strings, list) and all(isinstance(i, bytes) for i in strings), 'arg strings invalid'
    
        cdef libcpp_vector[_String] * v1 = new libcpp_vector[_String]()
        cdef bytes item1
        for item1 in strings:
           v1.push_back(_String(<char *>item1))
        self.inst.get().setValidStrings((_String(<char *>key)), deref(v1))
        del v1
    def setMaxInt(self, bytes key , int max ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(max, int), 'arg max invalid'
    
    
        self.inst.get().setMaxInt((_String(<char *>key)), (<int>max))
    def setMaxFloat(self, bytes key , float max ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(max, float), 'arg max invalid'
    
    
        self.inst.get().setMaxFloat((_String(<char *>key)), (<float>max))
    def getDescription(self, bytes key ):
        assert isinstance(key, bytes), 'arg key invalid'
    
        cdef libcpp_string _r = self.inst.get().getDescription((_String(<char *>key)))
        py_result = <libcpp_string>_r
        return py_result
    def setMinFloat(self, bytes key , float min ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(min, float), 'arg min invalid'
    
    
        self.inst.get().setMinFloat((_String(<char *>key)), (<float>min))
    def _init_0(self):
        self.inst = shared_ptr[_Param](new _Param())
    def _init_1(self, Param in_0 ):
        assert isinstance(in_0, Param), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_Param](new _Param(<_Param>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], Param)):
             self._init_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def getValue(self, bytes key ):
        assert isinstance(key, bytes), 'arg key invalid'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getValue((_String(<char *>key))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getSectionDescription(self, bytes key ):
        assert isinstance(key, bytes), 'arg key invalid'
    
        cdef libcpp_string _r = self.inst.get().getSectionDescription((_String(<char *>key)))
        py_result = <libcpp_string>_r
        return py_result
    def clearTags(self, bytes key ):
        assert isinstance(key, bytes), 'arg key invalid'
    
        self.inst.get().clearTags((_String(<char *>key)))
    def setMinInt(self, bytes key , int min ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(min, int), 'arg min invalid'
    
    
        self.inst.get().setMinInt((_String(<char *>key)), (<int>min))
    def store(self, str filename ):
        assert isinstance(filename, str), 'arg filename invalid'
    
        self.inst.get().store((<libcpp_string>filename))
    def setSectionDescription(self, bytes key , bytes desc ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(desc, bytes), 'arg desc invalid'
    
    
        self.inst.get().setSectionDescription((_String(<char *>key)), (_String(<char *>desc)))
    def addTag(self, bytes key , bytes tag ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(tag, bytes), 'arg tag invalid'
    
    
        self.inst.get().addTag((_String(<char *>key)), (_String(<char *>tag)))
    def hasTag(self, bytes key , bytes tag ):
        assert isinstance(key, bytes), 'arg key invalid'
        assert isinstance(tag, bytes), 'arg tag invalid'
    
    
        cdef int _r = self.inst.get().hasTag((_String(<char *>key)), (_String(<char *>tag)))
        py_result = <int>_r
        return py_result
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result
    # the following empty line is important

    def getKeys(Param self):

        cdef list rv = list()

        cdef _ParamIterator param_it = self.inst.get().begin()
        while param_it != self.inst.get().end():
            rv.append(param_it.getName().c_str())
            inc(param_it)

        return rv 
cdef class MzDataFile:
    cdef shared_ptr[_MzDataFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def load(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
        assert isinstance(in_1, MSExperiment), 'arg in_1 invalid'
    
    
        self.inst.get().load((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def __init__(self):
        self.inst = shared_ptr[_MzDataFile](new _MzDataFile())
    def store(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
        assert isinstance(in_1, MSExperiment), 'arg in_1 invalid'
    
    
        self.inst.get().store((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get())) 
cdef class BaseFeature:
    cdef shared_ptr[_BaseFeature] inst
    def __dealloc__(self):
         self.inst.reset()
    def getCharge(self):
        cdef int _r = self.inst.get().getCharge()
        py_result = <int>_r
        return py_result
    def getQuality(self):
        cdef float _r = self.inst.get().getQuality()
        py_result = <float>_r
        return py_result
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys invalid'
        cdef libcpp_vector[_String] * v0 = new libcpp_vector[_String]()
        cdef bytes item0
        for item0 in keys:
           v0.push_back(_String(<char *>item0))
        self.inst.get().getKeys(deref(v0))
        cdef replace = []
        cdef libcpp_vector[_String].iterator it = v0.begin()
        while it != v0.end():
           replace.append(<char*>deref(it).c_str())
           inc(it)
        keys[:] = replace
        del v0
    def _getKeys_1(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(li, int) for li in keys), 'arg keys invalid'
        cdef libcpp_vector[unsigned int] * v0 = new libcpp_vector[unsigned int]()
        cdef unsigned int item0
        for item0 in keys:
           v0.push_back(item0)
        self.inst.get().getKeys(deref(v0))
        del v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, int) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def getWidth(self):
        cdef float _r = self.inst.get().getWidth()
        py_result = <float>_r
        return py_result
    def setQuality(self, float q ):
        assert isinstance(q, float), 'arg q invalid'
    
        self.inst.get().setQuality((<float>q))
    def __init__(self):
        self.inst = shared_ptr[_BaseFeature](new _BaseFeature())
    def setWidth(self, float q ):
        assert isinstance(q, float), 'arg q invalid'
    
        self.inst.get().setWidth((<float>q))
    def setCharge(self, int q ):
        assert isinstance(q, int), 'arg q invalid'
    
        self.inst.get().setCharge((<int>q))
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, BaseFeature):
            return False
        cdef BaseFeature other_casted = other
        cdef BaseFeature self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get()) 
cdef class StringList:
    cdef shared_ptr[_StringList] inst
    def __dealloc__(self):
         self.inst.reset()
    def at(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef libcpp_string _r = self.inst.get().at((<int>in_0))
        py_result = <libcpp_string>_r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_StringList](new _StringList())
    def _init_1(self, StringList in_0 ):
        assert isinstance(in_0, StringList), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_StringList](new _StringList(<_StringList>deref(in_0.inst.get())))
    def _init_2(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, str) for li in in_0), 'arg in_0 invalid'
        cdef libcpp_vector[libcpp_string] * v0 = new libcpp_vector[libcpp_string]()
        cdef libcpp_string item0
        for item0 in in_0:
           v0.push_back(item0)
        self.inst = shared_ptr[_StringList](new _StringList(deref(v0)))
        del v0
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], StringList)):
             self._init_1(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, str) for li in args[0])):
             self._init_2(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result 
cdef class Peak2D:
    cdef shared_ptr[_Peak2D] inst
    def __dealloc__(self):
         self.inst.reset()
    def __copy__(self):
       cdef Peak2D rv = Peak2D.__new__(Peak2D)
       rv.inst = shared_ptr[_Peak2D](new _Peak2D(deref(self.inst.get())))
       return rv
    def __init__(self):
        self.inst = shared_ptr[_Peak2D](new _Peak2D())
    def getIntensity(self):
        cdef float _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def setRT(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setRT((<float>in_0))
    def getRT(self):
        cdef double _r = self.inst.get().getRT()
        py_result = <float>_r
        return py_result
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setIntensity((<float>in_0))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setMZ((<float>in_0))
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, Peak2D):
            return False
        cdef Peak2D other_casted = other
        cdef Peak2D self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get()) 
cdef class ChecksumType:
    UNKNOWN_CHECKSUM = 0
    SHA1 = 1
    MD5 = 2
    SIZE_OF_CHECKSUMTYPE = 3 
cdef class LogType:
    CMD = 0
    GUI = 1
    NONE = 2 
cdef class MzMLFile:
    cdef shared_ptr[_MzMLFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def __init__(self):
        self.inst = shared_ptr[_MzMLFile](new _MzMLFile())
    def load(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
        assert isinstance(in_1, MSExperiment), 'arg in_1 invalid'
    
    
        self.inst.get().load((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def store(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
        assert isinstance(in_1, MSExperiment), 'arg in_1 invalid'
    
    
        self.inst.get().store((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get())) 
cdef class FileHandler:
    cdef shared_ptr[_FileHandler] inst
    def __dealloc__(self):
         self.inst.reset()
    def _init_0(self):
        self.inst = shared_ptr[_FileHandler](new _FileHandler())
    def _init_1(self, FileHandler in_0 ):
        assert isinstance(in_0, FileHandler), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_FileHandler](new _FileHandler(<_FileHandler>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], FileHandler)):
             self._init_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def loadExperiment(self, str in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, str), 'arg in_0 invalid'
        assert isinstance(in_1, MSExperiment), 'arg in_1 invalid'
    
    
        self.inst.get().loadExperiment((<libcpp_string>in_0), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def storeExperiment(self, str in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, str), 'arg in_0 invalid'
        assert isinstance(in_1, MSExperiment), 'arg in_1 invalid'
    
    
        self.inst.get().storeExperiment((<libcpp_string>in_0), <_MSExperiment[_Peak1D,_ChromatogramPeak]>deref(in_1.inst.get()))
    getType = __static_FileHandler_getType 
cdef class DataValue:
    cdef shared_ptr[_DataValue] inst
    def __dealloc__(self):
         self.inst.reset()
    def _init_0(self):
        self.inst = shared_ptr[_DataValue](new _DataValue())
    def _init_1(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, str) for li in in_0), 'arg in_0 invalid'
        cdef libcpp_vector[libcpp_string] * v0 = new libcpp_vector[libcpp_string]()
        cdef libcpp_string item0
        for item0 in in_0:
           v0.push_back(item0)
        self.inst = shared_ptr[_DataValue](new _DataValue(deref(v0)))
        del v0
    def _init_2(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, int) for li in in_0), 'arg in_0 invalid'
        cdef libcpp_vector[int] * v0 = new libcpp_vector[int]()
        cdef int item0
        for item0 in in_0:
           v0.push_back(item0)
        self.inst = shared_ptr[_DataValue](new _DataValue(deref(v0)))
        del v0
    def _init_3(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, float) for li in in_0), 'arg in_0 invalid'
        cdef libcpp_vector[float] * v0 = new libcpp_vector[float]()
        cdef float item0
        for item0 in in_0:
           v0.push_back(item0)
        self.inst = shared_ptr[_DataValue](new _DataValue(deref(v0)))
        del v0
    def _init_4(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_DataValue](new _DataValue((<char *>in_0)))
    def _init_5(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_DataValue](new _DataValue((<int>in_0)))
    def _init_6(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_DataValue](new _DataValue((<float>in_0)))
    def _init_7(self, StringList in_0 ):
        assert isinstance(in_0, StringList), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_DataValue](new _DataValue(<_StringList>deref(in_0.inst.get())))
    def _init_8(self, IntList in_0 ):
        assert isinstance(in_0, IntList), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_DataValue](new _DataValue(<_IntList>deref(in_0.inst.get())))
    def _init_9(self, DoubleList in_0 ):
        assert isinstance(in_0, DoubleList), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_DataValue](new _DataValue(<_DoubleList>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, str) for li in args[0])):
             self._init_1(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, int) for li in args[0])):
             self._init_2(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, float) for li in args[0])):
             self._init_3(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
             self._init_4(*args)
        elif (len(args)==1) and (isinstance(args[0], int)):
             self._init_5(*args)
        elif (len(args)==1) and (isinstance(args[0], float)):
             self._init_6(*args)
        elif (len(args)==1) and (isinstance(args[0], StringList)):
             self._init_7(*args)
        elif (len(args)==1) and (isinstance(args[0], IntList)):
             self._init_8(*args)
        elif (len(args)==1) and (isinstance(args[0], DoubleList)):
             self._init_9(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def toInt(self):
        cdef int _r = <int>(deref(self.inst.get()))
        py_res = <int>_r
        return py_res
    def toString(self):
        cdef libcpp_string _r = <libcpp_string>(deref(self.inst.get()))
        py_res = <libcpp_string>_r
        return py_res
    def toFloat(self):
        cdef double _r = <double>(deref(self.inst.get()))
        py_res = <float>_r
        return py_res
    def toStringList(self):
        cdef _StringList * _r = new _StringList(<_StringList>(deref(self.inst.get())))
        cdef StringList py_res = StringList.__new__(StringList)
        py_res.inst = shared_ptr[_StringList](_r)
        return py_res
    def toDoubleList(self):
        cdef _DoubleList * _r = new _DoubleList(<_DoubleList>(deref(self.inst.get())))
        cdef DoubleList py_res = DoubleList.__new__(DoubleList)
        py_res.inst = shared_ptr[_DoubleList](_r)
        return py_res
    def toIntList(self):
        cdef _IntList * _r = new _IntList(<_IntList>(deref(self.inst.get())))
        cdef IntList py_res = IntList.__new__(IntList)
        py_res.inst = shared_ptr[_IntList](_r)
        return py_res
    def isEmpty(self):
        cdef int _r = self.inst.get().isEmpty()
        py_result = <int>_r
        return py_result
    def valueType(self):
        cdef _DataType _r = self.inst.get().valueType()
        py_result = <int>_r
        return py_result 
cdef class ChromatogramTools:
    cdef shared_ptr[_ChromatogramTools] inst
    def __dealloc__(self):
         self.inst.reset()
    def convertChromatogramsToSpectra(self, MSExperiment epx ):
        assert isinstance(epx, MSExperiment), 'arg epx invalid'
    
        self.inst.get().convertChromatogramsToSpectra(<_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(epx.inst.get()))
    def convertSpectraToChromatograms(self, MSExperiment epx , int remove_spectra ):
        assert isinstance(epx, MSExperiment), 'arg epx invalid'
        assert isinstance(remove_spectra, int), 'arg remove_spectra invalid'
    
    
        self.inst.get().convertSpectraToChromatograms(<_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(epx.inst.get()), (<int>remove_spectra))
    def __init__(self):
        self.inst = shared_ptr[_ChromatogramTools](new _ChromatogramTools()) 
cdef class MetaInfoInterface:
    cdef shared_ptr[_MetaInfoInterface] inst
    def __dealloc__(self):
         self.inst.reset()
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], int)):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def _getMetaValue_0(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], int)):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def __init__(self):
        self.inst = shared_ptr[_MetaInfoInterface](new _MetaInfoInterface())
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, MetaInfoInterface):
            return False
        cdef MetaInfoInterface other_casted = other
        cdef MetaInfoInterface self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get()) 
cdef class RichPeak2D:
    cdef shared_ptr[_RichPeak2D] inst
    def __dealloc__(self):
         self.inst.reset()
    def getIntensity(self):
        cdef float _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def setRT(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setRT((<float>in_0))
    def getRT(self):
        cdef double _r = self.inst.get().getRT()
        py_result = <float>_r
        return py_result
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys invalid'
        cdef libcpp_vector[_String] * v0 = new libcpp_vector[_String]()
        cdef bytes item0
        for item0 in keys:
           v0.push_back(_String(<char *>item0))
        self.inst.get().getKeys(deref(v0))
        cdef replace = []
        cdef libcpp_vector[_String].iterator it = v0.begin()
        while it != v0.end():
           replace.append(<char*>deref(it).c_str())
           inc(it)
        keys[:] = replace
        del v0
    def _getKeys_1(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(li, int) for li in keys), 'arg keys invalid'
        cdef libcpp_vector[unsigned int] * v0 = new libcpp_vector[unsigned int]()
        cdef unsigned int item0
        for item0 in keys:
           v0.push_back(item0)
        self.inst.get().getKeys(deref(v0))
        del v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, int) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setIntensity((<float>in_0))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setMZ((<float>in_0))
    def __init__(self):
        self.inst = shared_ptr[_RichPeak2D](new _RichPeak2D())
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, RichPeak2D):
            return False
        cdef RichPeak2D other_casted = other
        cdef RichPeak2D self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get()) 
cdef class FileTypes:
    UNKNOWN = 0
    DTA = 1
    DTA2D = 2
    MZDATA = 3
    MZXML = 4
    FEATUREXML = 5
    IDXML = 6
    CONSENSUSXML = 7
    MGF = 8
    INI = 9
    TOPPAS = 10
    TRANSFORMATIONXML = 11
    MZML = 12
    MS2 = 13
    PEPXML = 14
    PROTXML = 15
    MZIDENTML = 16
    GELML = 17
    TRAML = 18
    MSP = 19
    OMSSAXML = 20
    MASCOTXML = 21
    PNG = 22
    XMASS = 23
    TSV = 24
    PEPLIST = 25
    HARDKLOER = 26
    KROENIK = 27
    FASTA = 28
    EDTA = 29
    SIZE_OF_TYPE = 30 
cdef class FeatureXMLFile:
    cdef shared_ptr[_FeatureXMLFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def load(self, bytes in_0 , FeatureMap in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
        assert isinstance(in_1, FeatureMap), 'arg in_1 invalid'
    
    
        self.inst.get().load((_String(<char *>in_0)), <_FeatureMap[_Feature] &>deref(in_1.inst.get()))
    def __init__(self):
        self.inst = shared_ptr[_FeatureXMLFile](new _FeatureXMLFile())
    def store(self, bytes in_0 , FeatureMap in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
        assert isinstance(in_1, FeatureMap), 'arg in_1 invalid'
    
    
        self.inst.get().store((_String(<char *>in_0)), <_FeatureMap[_Feature] &>deref(in_1.inst.get())) 
cdef class Precursor:
    cdef shared_ptr[_Precursor] inst
    def __dealloc__(self):
         self.inst.reset()
    def _init_0(self):
        self.inst = shared_ptr[_Precursor](new _Precursor())
    def _init_1(self, Precursor in_0 ):
        assert isinstance(in_0, Precursor), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_Precursor](new _Precursor(<_Precursor>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], Precursor)):
             self._init_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setMZ((<float>in_0))
    def getIntensity(self):
        cdef double _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setIntensity((<float>in_0)) 
cdef class ProgressLogger:
    cdef shared_ptr[_ProgressLogger] inst
    def __dealloc__(self):
         self.inst.reset()
    def getLogType(self):
        cdef _LogType _r = self.inst.get().getLogType()
        py_result = <int>_r
        return py_result
    def startProgress(self, int begin , int end , bytes label ):
        assert isinstance(begin, int), 'arg begin invalid'
        assert isinstance(end, int), 'arg end invalid'
        assert isinstance(label, bytes), 'arg label invalid'
    
    
    
        self.inst.get().startProgress((<ptrdiff_t>begin), (<ptrdiff_t>end), (_String(<char *>label)))
    def endProgress(self):
        self.inst.get().endProgress()
    def __init__(self):
        self.inst = shared_ptr[_ProgressLogger](new _ProgressLogger())
    def setProgress(self, int value ):
        assert isinstance(value, int), 'arg value invalid'
    
        self.inst.get().setProgress((<ptrdiff_t>value))
    def setLogType(self, int in_0 ):
        assert in_0 in [0, 1, 2], 'arg in_0 invalid'
    
        self.inst.get().setLogType((<_LogType>in_0)) 
cdef class RichPeak1D:
    cdef shared_ptr[_RichPeak1D] inst
    def __dealloc__(self):
         self.inst.reset()
    def __init__(self):
        self.inst = shared_ptr[_RichPeak1D](new _RichPeak1D())
    def getIntensity(self):
        cdef float _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys invalid'
        cdef libcpp_vector[_String] * v0 = new libcpp_vector[_String]()
        cdef bytes item0
        for item0 in keys:
           v0.push_back(_String(<char *>item0))
        self.inst.get().getKeys(deref(v0))
        cdef replace = []
        cdef libcpp_vector[_String].iterator it = v0.begin()
        while it != v0.end():
           replace.append(<char*>deref(it).c_str())
           inc(it)
        keys[:] = replace
        del v0
    def _getKeys_1(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(li, int) for li in keys), 'arg keys invalid'
        cdef libcpp_vector[unsigned int] * v0 = new libcpp_vector[unsigned int]()
        cdef unsigned int item0
        for item0 in keys:
           v0.push_back(item0)
        self.inst.get().getKeys(deref(v0))
        del v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, int) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setIntensity((<float>in_0))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setMZ((<float>in_0))
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, RichPeak1D):
            return False
        cdef RichPeak1D other_casted = other
        cdef RichPeak1D self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get()) 
cdef class MzXMLFile:
    cdef shared_ptr[_MzXMLFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def load(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
        assert isinstance(in_1, MSExperiment), 'arg in_1 invalid'
    
    
        self.inst.get().load((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def store(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 invalid'
        assert isinstance(in_1, MSExperiment), 'arg in_1 invalid'
    
    
        self.inst.get().store((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def __init__(self):
        self.inst = shared_ptr[_MzXMLFile](new _MzXMLFile()) 
cdef class MapAlignmentAlgorithmPoseClustering:
    cdef shared_ptr[_MapAlignmentAlgorithmPoseClustering] inst
    def __dealloc__(self):
         self.inst.reset()
    def setParameters(self, Param in_0 ):
        assert isinstance(in_0, Param), 'arg in_0 invalid'
    
        self.inst.get().setParameters(<_Param>deref(in_0.inst.get()))
    def __init__(self):
        self.inst = shared_ptr[_MapAlignmentAlgorithmPoseClustering](new _MapAlignmentAlgorithmPoseClustering())
    def getDefaults(self):
        cdef _Param * _r = new _Param(self.inst.get().getDefaults())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    def fitModel(self, bytes model_type , Param p , list in_2 ):
        assert isinstance(model_type, bytes), 'arg model_type invalid'
        assert isinstance(p, Param), 'arg p invalid'
        assert isinstance(in_2, list) and all(isinstance(li, TransformationDescription) for li in in_2), 'arg in_2 invalid'
    
    
        cdef libcpp_vector[_TransformationDescription] * v2 = new libcpp_vector[_TransformationDescription]()
        cdef TransformationDescription item2
        for item2 in in_2:
           v2.push_back(deref(item2.inst.get()))
        self.inst.get().fitModel((_String(<char *>model_type)), <_Param>deref(p.inst.get()), deref(v2))
        cdef replace = []
        cdef libcpp_vector[_TransformationDescription].iterator it = v2.begin()
        while it != v2.end():
           item2 = TransformationDescription.__new__(TransformationDescription)
           item2.inst = shared_ptr[_TransformationDescription](new _TransformationDescription(deref(it)))
           replace.append(item2)
           inc(it)
        in_2[:] = replace
        del v2
    def alignFeatureMaps(self, list in_0 , list in_1 ):
        assert isinstance(in_0, list) and all(isinstance(li, FeatureMap) for li in in_0), 'arg in_0 invalid'
        assert isinstance(in_1, list) and all(isinstance(li, TransformationDescription) for li in in_1), 'arg in_1 invalid'
        cdef libcpp_vector[_FeatureMap[_Feature]] * v0 = new libcpp_vector[_FeatureMap[_Feature]]()
        cdef FeatureMap item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        cdef libcpp_vector[_TransformationDescription] * v1 = new libcpp_vector[_TransformationDescription]()
        cdef TransformationDescription item1
        for item1 in in_1:
           v1.push_back(deref(item1.inst.get()))
        self.inst.get().alignFeatureMaps(deref(v0), deref(v1))
        cdef replace = []
        cdef libcpp_vector[_TransformationDescription].iterator it = v1.begin()
        while it != v1.end():
           item1 = TransformationDescription.__new__(TransformationDescription)
           item1.inst = shared_ptr[_TransformationDescription](new _TransformationDescription(deref(it)))
           replace.append(item1)
           inc(it)
        in_1[:] = replace
        del v1
        del v0
    def setLogType(self, int type ):
        assert type in [0, 1, 2], 'arg type invalid'
    
        self.inst.get().setLogType((<_LogType>type))
    def getParameters(self):
        cdef _Param * _r = new _Param(self.inst.get().getParameters())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result 
cdef class MSSpectrum:
    cdef shared_ptr[_MSSpectrum[_Peak1D]] inst
    def __dealloc__(self):
         self.inst.reset()
    def setInstrumentSettings(self, InstrumentSettings in_0 ):
        assert isinstance(in_0, InstrumentSettings), 'arg in_0 invalid'
    
        self.inst.get().setInstrumentSettings(<_InstrumentSettings>deref(in_0.inst.get()))
    def _init_0(self):
        self.inst = shared_ptr[_MSSpectrum[_Peak1D]](new _MSSpectrum[_Peak1D]())
    def _init_1(self, MSSpectrum in_0 ):
        assert isinstance(in_0, MSSpectrum), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_MSSpectrum[_Peak1D]](new _MSSpectrum[_Peak1D](<_MSSpectrum[_Peak1D]>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], MSSpectrum)):
             self._init_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def getSourceFile(self):
        cdef _SourceFile * _r = new _SourceFile(self.inst.get().getSourceFile())
        cdef SourceFile py_result = SourceFile.__new__(SourceFile)
        py_result.inst = shared_ptr[_SourceFile](_r)
        return py_result
    def setName(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 invalid'
    
        self.inst.get().setName((<libcpp_string>in_0))
    def setRT(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setRT((<float>in_0))
    def setNativeID(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 invalid'
    
        self.inst.get().setNativeID((<libcpp_string>in_0))
    def getName(self):
        cdef libcpp_string _r = self.inst.get().getName()
        py_result = <libcpp_string>_r
        return py_result
    def getRT(self):
        cdef double _r = self.inst.get().getRT()
        py_result = <float>_r
        return py_result
    def setSourceFile(self, SourceFile in_0 ):
        assert isinstance(in_0, SourceFile), 'arg in_0 invalid'
    
        self.inst.get().setSourceFile(<_SourceFile>deref(in_0.inst.get()))
    def getInstrumentSettings(self):
        cdef _InstrumentSettings * _r = new _InstrumentSettings(self.inst.get().getInstrumentSettings())
        cdef InstrumentSettings py_result = InstrumentSettings.__new__(InstrumentSettings)
        py_result.inst = shared_ptr[_InstrumentSettings](_r)
        return py_result
    def setPrecursors(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, Precursor) for li in in_0), 'arg in_0 invalid'
        cdef libcpp_vector[_Precursor] * v0 = new libcpp_vector[_Precursor]()
        cdef Precursor item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setPrecursors(deref(v0))
        del v0
    def updateRanges(self):
        self.inst.get().updateRanges()
    def push_back(self, Peak1D in_0 ):
        assert isinstance(in_0, Peak1D), 'arg in_0 invalid'
    
        self.inst.get().push_back(<_Peak1D>deref(in_0.inst.get()))
    def getNativeID(self):
        cdef libcpp_string _r = self.inst.get().getNativeID()
        py_result = <libcpp_string>_r
        return py_result
    def __getitem__(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef _Peak1D * _r = new _Peak1D(deref(self.inst.get())[(<int>in_0)])
        cdef Peak1D py_result = Peak1D.__new__(Peak1D)
        py_result.inst = shared_ptr[_Peak1D](_r)
        return py_result
    def getMSLevel(self):
        cdef unsigned int _r = self.inst.get().getMSLevel()
        py_result = <int>_r
        return py_result
    def getPrecursors(self):
        _r = self.inst.get().getPrecursors()
        py_result = []
        cdef libcpp_vector[_Precursor].iterator it__r = _r.begin()
        cdef Precursor item_py_result
        while it__r != _r.end():
           item_py_result = Precursor.__new__(Precursor)
           item_py_result.inst = shared_ptr[_Precursor](new _Precursor(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def setMSLevel(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        self.inst.get().setMSLevel((<int>in_0))
    def clear(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        self.inst.get().clear((<int>in_0))
    def findNearest(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        cdef int _r = self.inst.get().findNearest((<float>in_0))
        py_result = <int>_r
        return py_result
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result
    # the following empty line is important

    def get_peaks(self):

        cdef _MSSpectrum[_Peak1D] * spec_ = self.inst.get()

        cdef unsigned int n = spec_.size()
        cdef np.ndarray[np.float32_t, ndim=2] peaks
        peaks = np.zeros( [n,2], dtype=np.float32)
        cdef _Peak1D p

        cdef libcpp_vector[_Peak1D].iterator it = spec_.begin()
        cdef int i = 0
        while it != spec_.end():
            peaks[i,0] = deref(it).getMZ()
            peaks[i,1] = deref(it).getIntensity()
            inc(it)
            i += 1

        return peaks

    def set_peaks(self, np.ndarray[np.float32_t, ndim=2] peaks):

        cdef _MSSpectrum[_Peak1D] * spec_ = self.inst.get()

        #cdef int delete_meta = 0
        spec_.clear(0) # delete_meta) # emtpy vector , keep meta data
        cdef _Peak1D p = _Peak1D()
        cdef double mz
        cdef float I
        cdef int N
        N = peaks.shape[0]


        for i in range(N):
            mz = peaks[i,0]
            I  = peaks[i,1]
            p.setMZ(mz)
            p.setIntensity(<float>I)
            spec_.push_back(p)

        spec_.updateRanges()

    def intensityInRange(self, float mzmin, float mzmax):

        cdef int n
        cdef double I

        cdef _MSSpectrum[_Peak1D] * spec_ = self.inst.get()
        cdef int N = spec_.size()

        I = 0
        for i in range(N):
                if deref(spec_)[i].getMZ() >= mzmin:
                    break

        cdef _Peak1D * p
        for j in range(i, N):
                p = address(deref(spec_)[i])
                if p.getMZ() > mzmax:
                    break
                I += p.getIntensity()

        return I

import numpy as np 
cdef class Peak1D:
    cdef shared_ptr[_Peak1D] inst
    def __dealloc__(self):
         self.inst.reset()
    def getIntensity(self):
        cdef float _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def __copy__(self):
       cdef Peak1D rv = Peak1D.__new__(Peak1D)
       rv.inst = shared_ptr[_Peak1D](new _Peak1D(deref(self.inst.get())))
       return rv
    def __init__(self):
        self.inst = shared_ptr[_Peak1D](new _Peak1D())
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setIntensity((<float>in_0))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        self.inst.get().setMZ((<float>in_0))
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, Peak1D):
            return False
        cdef Peak1D other_casted = other
        cdef Peak1D self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get()) 
cdef class TransformationDescription:
    cdef shared_ptr[_TransformationDescription] inst
    def __dealloc__(self):
         self.inst.reset()
    def apply(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 invalid'
    
        cdef double _r = self.inst.get().apply((<float>in_0))
        py_result = <float>_r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_TransformationDescription](new _TransformationDescription())
    def _init_1(self, TransformationDescription in_0 ):
        assert isinstance(in_0, TransformationDescription), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_TransformationDescription](new _TransformationDescription(<_TransformationDescription>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], TransformationDescription)):
             self._init_1(*args)
        else:
               raise Exception('can not handle %s' % (args,)) 
cdef class InstrumentSettings:
    cdef shared_ptr[_InstrumentSettings] inst
    def __dealloc__(self):
         self.inst.reset()
    def setPolarity(self, int in_0 ):
        assert in_0 in [0, 1, 2, 3], 'arg in_0 invalid'
    
        self.inst.get().setPolarity((<_Polarity>in_0))
    def _init_0(self):
        self.inst = shared_ptr[_InstrumentSettings](new _InstrumentSettings())
    def _init_1(self, InstrumentSettings in_0 ):
        assert isinstance(in_0, InstrumentSettings), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_InstrumentSettings](new _InstrumentSettings(<_InstrumentSettings>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], InstrumentSettings)):
             self._init_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def getPolarity(self):
        cdef _Polarity _r = self.inst.get().getPolarity()
        py_result = <int>_r
        return py_result 
cdef class DataType:
    STRING_VALUE = 0
    INT_VALUE = 1
    DOUBLE_VALUE = 2
    STRING_LIST = 3
    INT_LIST = 4
    DOUBLE_LIST = 5
    EMPTY_VALUE = 6 
cdef class FeatureMap:
    cdef shared_ptr[_FeatureMap[_Feature]] inst
    def __dealloc__(self):
         self.inst.reset()
    def swap(self, FeatureMap in_0 ):
        assert isinstance(in_0, FeatureMap), 'arg in_0 invalid'
    
        self.inst.get().swap(<_FeatureMap[_Feature] &>deref(in_0.inst.get()))
    def sortByPosition(self):
        self.inst.get().sortByPosition()
    def _clear_0(self):
        self.inst.get().clear()
    def _clear_1(self, int clear_meta_data ):
        assert isinstance(clear_meta_data, int), 'arg clear_meta_data invalid'
    
        self.inst.get().clear((<bool>clear_meta_data))
    def clear(self, *args):
        if not args:
            return self._clear_0(*args)
        elif (len(args)==1) and (isinstance(args[0], int)):
            return self._clear_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def _sortByIntensity_0(self):
        self.inst.get().sortByIntensity()
    def _sortByIntensity_1(self, int reverse ):
        assert isinstance(reverse, int), 'arg reverse invalid'
    
        self.inst.get().sortByIntensity((<bool>reverse))
    def sortByIntensity(self, *args):
        if not args:
            return self._sortByIntensity_0(*args)
        elif (len(args)==1) and (isinstance(args[0], int)):
            return self._sortByIntensity_1(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def sortByOverallQuality(self):
        self.inst.get().sortByOverallQuality()
    def sortByMZ(self):
        self.inst.get().sortByMZ()
    def updateRanges(self):
        self.inst.get().updateRanges()
    def __init__(self):
        self.inst = shared_ptr[_FeatureMap[_Feature]](new _FeatureMap[_Feature]())
    def push_back(self, Feature spec ):
        assert isinstance(spec, Feature), 'arg spec invalid'
    
        self.inst.get().push_back(<_Feature>deref(spec.inst.get()))
    def setUniqueId(self):
        self.inst.get().setUniqueId()
    def __getitem__(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef _Feature * _r = new _Feature(deref(self.inst.get())[(<int>in_0)])
        cdef Feature py_result = Feature.__new__(Feature)
        py_result.inst = shared_ptr[_Feature](_r)
        return py_result
    def sortByRT(self):
        self.inst.get().sortByRT()
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result 
cdef class PeakPickerHiRes:
    cdef shared_ptr[_PeakPickerHiRes] inst
    def __dealloc__(self):
         self.inst.reset()
    def setParameters(self, Param param ):
        assert isinstance(param, Param), 'arg param invalid'
    
        self.inst.get().setParameters(<_Param>deref(param.inst.get()))
    def getDefaults(self):
        cdef _Param * _r = new _Param(self.inst.get().getDefaults())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_PeakPickerHiRes](new _PeakPickerHiRes())
    def setLogType(self, int type ):
        assert type in [0, 1, 2], 'arg type invalid'
    
        self.inst.get().setLogType((<_LogType>type))
    def pick(self, MSSpectrum input , MSSpectrum output ):
        assert isinstance(input, MSSpectrum), 'arg input invalid'
        assert isinstance(output, MSSpectrum), 'arg output invalid'
    
    
        self.inst.get().pick(<_MSSpectrum[_Peak1D] &>deref(input.inst.get()), <_MSSpectrum[_Peak1D] &>deref(output.inst.get()))
    def pickExperiment(self, MSExperiment input , MSExperiment output ):
        assert isinstance(input, MSExperiment), 'arg input invalid'
        assert isinstance(output, MSExperiment), 'arg output invalid'
    
    
        self.inst.get().pickExperiment(<_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(input.inst.get()), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(output.inst.get()))
    def getParameters(self):
        cdef _Param * _r = new _Param(self.inst.get().getParameters())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result 
cdef class IntList:
    cdef shared_ptr[_IntList] inst
    def __dealloc__(self):
         self.inst.reset()
    def _init_0(self):
        self.inst = shared_ptr[_IntList](new _IntList())
    def _init_1(self, IntList in_0 ):
        assert isinstance(in_0, IntList), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_IntList](new _IntList(<_IntList>deref(in_0.inst.get())))
    def _init_2(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, int) for li in in_0), 'arg in_0 invalid'
        cdef libcpp_vector[int] * v0 = new libcpp_vector[int]()
        cdef int item0
        for item0 in in_0:
           v0.push_back(item0)
        self.inst = shared_ptr[_IntList](new _IntList(deref(v0)))
        del v0
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], IntList)):
             self._init_1(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, int) for li in args[0])):
             self._init_2(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def at(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef int _r = self.inst.get().at((<int>in_0))
        py_result = <int>_r
        return py_result
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result 
cdef class DoubleList:
    cdef shared_ptr[_DoubleList] inst
    def __dealloc__(self):
         self.inst.reset()
    def _init_0(self):
        self.inst = shared_ptr[_DoubleList](new _DoubleList())
    def _init_1(self, DoubleList in_0 ):
        assert isinstance(in_0, DoubleList), 'arg in_0 invalid'
    
        self.inst = shared_ptr[_DoubleList](new _DoubleList(<_DoubleList>deref(in_0.inst.get())))
    def _init_2(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, float) for li in in_0), 'arg in_0 invalid'
        cdef libcpp_vector[double] * v0 = new libcpp_vector[double]()
        cdef double item0
        for item0 in in_0:
           v0.push_back(item0)
        self.inst = shared_ptr[_DoubleList](new _DoubleList(deref(v0)))
        del v0
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], DoubleList)):
             self._init_1(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, float) for li in args[0])):
             self._init_2(*args)
        else:
               raise Exception('can not handle %s' % (args,))
    def at(self, int in_0 ):
        assert isinstance(in_0, int), 'arg in_0 invalid'
    
        cdef double _r = self.inst.get().at((<int>in_0))
        py_result = <float>_r
        return py_result
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result 

