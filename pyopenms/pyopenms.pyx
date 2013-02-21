from  libcpp.string  cimport string as libcpp_string
from  libcpp.set     cimport set as libcpp_set
from  libcpp.vector  cimport vector as libcpp_vector
from  libcpp.pair    cimport pair as libcpp_pair
from  smart_ptr cimport shared_ptr
from  libcpp cimport bool
from cython.operator cimport dereference as deref, preincrement as inc, address as address
from libc.stdint cimport *
from libc.stddef cimport *
from UniqueIdInterface cimport setUniqueId as _setUniqueId
cimport numpy as np
from ChromatogramPeak cimport CoordinateType
from Types cimport DoubleReal
from Types cimport Int
from Types cimport Int32
from Types cimport Int64
from ChromatogramPeak cimport IntensityType
from Types cimport Real
from Types cimport SignedSize
from Types cimport Size
from Types cimport Time
from Types cimport UID
from Types cimport UInt
from Types cimport UInt32
from Types cimport UInt64
from stdint cimport int16_t
from stdint cimport int32_t
from stdint cimport int64_t
from stdint cimport int8_t
from stdint cimport int_fast16_t
from stdint cimport int_fast32_t
from stdint cimport int_fast64_t
from stdint cimport int_fast8_t
from stdint cimport int_least16_t
from stdint cimport int_least32_t
from stdint cimport int_least64_t
from stdint cimport int_least8_t
from stdint cimport intmax_t
from stdint cimport intptr_t
from stdint cimport uint16_t
from stdint cimport uint32_t
from stdint cimport uint64_t
from stdint cimport uint8_t
from stdint cimport uint_fast16_t
from stdint cimport uint_fast32_t
from stdint cimport uint_fast64_t
from stdint cimport uint_fast8_t
from stdint cimport uint_least16_t
from stdint cimport uint_least32_t
from stdint cimport uint_least64_t
from stdint cimport uint_least8_t
from stdint cimport uintmax_t
from stdint cimport uintptr_t
from SourceFile cimport ChecksumType as _ChecksumType
from DataValue cimport DataType as _DataType
from ProteinIdentification cimport DigestionEnzyme as _DigestionEnzyme
from ProgressLogger cimport LogType as _LogType
from ProteinIdentification cimport PeakMassType as _PeakMassType
from IonSource_Polarity cimport Polarity as _Polarity
from DataProcessing cimport ProcessingAction as _ProcessingAction
from SpectrumSettings cimport SpectrumType as _SpectrumType
from FileTypes cimport Type as _Type
from VersionInfo cimport create as _create_VersionInfo
from TransformationModelLinear cimport getDefaultParameters as _getDefaultParameters_TransformationModelLinear
from TransformationModelInterpolated cimport getDefaultParameters as _getDefaultParameters_TransformationModelInterpolated
from TransformationModelBSpline cimport getDefaultParameters as _getDefaultParameters_TransformationModelBSpline
from FeatureFinderAlgorithmPicked cimport getProductName as _getProductName_FeatureFinderAlgorithmPicked
from VersionInfo cimport getRevision as _getRevision_VersionInfo
from VersionInfo cimport getTime as _getTime_VersionInfo
from FileHandler cimport getType as _getType_FileHandler
from VersionInfo cimport getVersion as _getVersion_VersionInfo
from DateTime cimport now as _now_DateTime
from UniqueIdInterface cimport setUniqueId as _setUniqueId_UniqueIdInterface
from MapAlignmentAlgorithmPoseClustering cimport transformFeatureMaps as _transformFeatureMaps_MapAlignmentAlgorithmPoseClustering
from MapAlignmentAlgorithmPoseClustering cimport transformPeakMaps as _transformPeakMaps_MapAlignmentAlgorithmPoseClustering
from AASequence cimport AASequence as _AASequence
from AcquisitionInfo cimport AcquisitionInfo as _AcquisitionInfo
from BaseFeature cimport BaseFeature as _BaseFeature
from ChromatogramPeak cimport ChromatogramPeak as _ChromatogramPeak
from ChromatogramTools cimport ChromatogramTools as _ChromatogramTools
from ConsensusFeature cimport ConsensusFeature as _ConsensusFeature
from DataProcessing cimport DataProcessing as _DataProcessing
from DataValue cimport DataValue as _DataValue
from DateTime cimport DateTime as _DateTime
from DefaultParamHandler cimport DefaultParamHandler as _DefaultParamHandler
from DoubleList cimport DoubleList as _DoubleList
from Feature cimport Feature as _Feature
from FeatureFinder cimport FeatureFinder as _FeatureFinder
from FeatureFinderAlgorithmPicked cimport FeatureFinderAlgorithmPicked as _FeatureFinderAlgorithmPicked
from FeatureMap cimport FeatureMap as _FeatureMap
from FeatureXMLFile cimport FeatureXMLFile as _FeatureXMLFile
from FileHandler cimport FileHandler as _FileHandler
from InstrumentSettings cimport InstrumentSettings as _InstrumentSettings
from IntList cimport IntList as _IntList
from MSExperiment cimport MSExperiment as _MSExperiment
from MSSpectrum cimport MSSpectrum as _MSSpectrum
from MapAlignmentAlgorithmPoseClustering cimport MapAlignmentAlgorithmPoseClustering as _MapAlignmentAlgorithmPoseClustering
from MetaInfoInterface cimport MetaInfoInterface as _MetaInfoInterface
from MzDataFile cimport MzDataFile as _MzDataFile
from MzMLFile cimport MzMLFile as _MzMLFile
from MzXMLFile cimport MzXMLFile as _MzXMLFile
from Param cimport Param as _Param
from Param cimport ParamEntry as _ParamEntry
from Param cimport ParamIterator as _ParamIterator
from Peak1D cimport Peak1D as _Peak1D
from Peak2D cimport Peak2D as _Peak2D
from PeakPickerHiRes cimport PeakPickerHiRes as _PeakPickerHiRes
from PeakTypeEstimator cimport PeakTypeEstimator as _PeakTypeEstimator
from PeptideHit cimport PeptideHit as _PeptideHit
from PeptideIdentification cimport PeptideIdentification as _PeptideIdentification
from Precursor cimport Precursor as _Precursor
from Product cimport Product as _Product
from ProgressLogger cimport ProgressLogger as _ProgressLogger
from ProteinHit cimport ProteinHit as _ProteinHit
from ProteinIdentification cimport ProteinIdentification as _ProteinIdentification
from RichPeak1D cimport RichPeak1D as _RichPeak1D
from RichPeak2D cimport RichPeak2D as _RichPeak2D
from Software cimport Software as _Software
from SourceFile cimport SourceFile as _SourceFile
from SpectrumSettings cimport SpectrumSettings as _SpectrumSettings
from String cimport String as _String
from StringList cimport StringList as _StringList
from TransformationDescription cimport TransformationDescription as _TransformationDescription
from TransformationModel cimport TransformationModel as _TransformationModel
from TransformationModel cimport TransformationModelBSpline as _TransformationModelBSpline
from TransformationModel cimport TransformationModelInterpolated as _TransformationModelInterpolated
from TransformationModel cimport TransformationModelLinear as _TransformationModelLinear
from TransformationXMLFile cimport TransformationXMLFile as _TransformationXMLFile
from UniqueIdGenerator cimport UniqueIdGenerator as _UniqueIdGenerator
from UniqueIdInterface cimport UniqueIdInterface as _UniqueIdInterface
from VersionInfo cimport VersionDetails as _VersionDetails
from VersionInfo cimport VersionInfo as _VersionInfo
cdef extern from "autowrap_tools.hpp":
    char * _cast_const_away(char *)
cdef extern from "autowrap_tools.hpp":
    void _iadd(_AASequence *, _AASequence *)
cdef extern from "autowrap_tools.hpp":
    void _iadd(_FeatureMap[_Feature] *, _FeatureMap[_Feature] *)
def __static_VersionDetails_create(bytes in_0 ):
    assert isinstance(in_0, bytes), 'arg in_0 wrong type'

    cdef _VersionDetails * _r = new _VersionDetails(_create_VersionInfo((_String(<char *>in_0))))
    cdef VersionDetails py_result = VersionDetails.__new__(VersionDetails)
    py_result.inst = shared_ptr[_VersionDetails](_r)
    return py_result
def __static_TransformationModelLinear_getDefaultParameters(Param in_0 ):
    assert isinstance(in_0, Param), 'arg in_0 wrong type'

    _getDefaultParameters_TransformationModelLinear(<_Param &>deref(in_0.inst.get()))
def __static_TransformationModelInterpolated_getDefaultParameters(Param in_0 ):
    assert isinstance(in_0, Param), 'arg in_0 wrong type'

    _getDefaultParameters_TransformationModelInterpolated(<_Param &>deref(in_0.inst.get()))
def __static_TransformationModelBSpline_getDefaultParameters(Param in_0 ):
    assert isinstance(in_0, Param), 'arg in_0 wrong type'

    _getDefaultParameters_TransformationModelBSpline(<_Param &>deref(in_0.inst.get()))
def __static_FeatureFinderAlgorithmPicked_getProductName():
    cdef _String _r = _getProductName_FeatureFinderAlgorithmPicked()
    py_result = _cast_const_away(<char*>_r.c_str())
    return py_result
def __static_VersionInfo_getRevision():
    cdef _String _r = _getRevision_VersionInfo()
    py_result = _cast_const_away(<char*>_r.c_str())
    return py_result
def __static_VersionInfo_getTime():
    cdef _String _r = _getTime_VersionInfo()
    py_result = _cast_const_away(<char*>_r.c_str())
    return py_result
def __static_FileHandler_getType(bytes filename ):
    assert isinstance(filename, bytes), 'arg filename wrong type'

    cdef int _r = _getType_FileHandler((_String(<char *>filename)))
    py_result = <int>_r
    return py_result
def __static_VersionInfo_getVersion():
    cdef _String _r = _getVersion_VersionInfo()
    py_result = _cast_const_away(<char*>_r.c_str())
    return py_result
def __static_DateTime_now():
    cdef _DateTime * _r = new _DateTime(_now_DateTime())
    cdef DateTime py_result = DateTime.__new__(DateTime)
    py_result.inst = shared_ptr[_DateTime](_r)
    return py_result
def __static_MapAlignmentAlgorithmPoseClustering_transformFeatureMaps(list in_0 , list in_1 ):
    assert isinstance(in_0, list) and all(isinstance(li, FeatureMap) for li in in_0), 'arg in_0 wrong type'
    assert isinstance(in_1, list) and all(isinstance(li, TransformationDescription) for li in in_1), 'arg in_1 wrong type'
    cdef libcpp_vector[_FeatureMap[_Feature]] * v0 = new libcpp_vector[_FeatureMap[_Feature]]()
    cdef FeatureMap item0
    for item0 in in_0:
       v0.push_back(deref(item0.inst.get()))
    cdef libcpp_vector[_TransformationDescription] * v1 = new libcpp_vector[_TransformationDescription]()
    cdef TransformationDescription item1
    for item1 in in_1:
       v1.push_back(deref(item1.inst.get()))
    _transformFeatureMaps_MapAlignmentAlgorithmPoseClustering(deref(v0), deref(v1))
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
def __static_MapAlignmentAlgorithmPoseClustering_transformPeakMaps(list in_0 , list in_1 ):
    assert isinstance(in_0, list) and all(isinstance(li, MSExperiment) for li in in_0), 'arg in_0 wrong type'
    assert isinstance(in_1, list) and all(isinstance(li, TransformationDescription) for li in in_1), 'arg in_1 wrong type'
    cdef libcpp_vector[_MSExperiment[_Peak1D,_ChromatogramPeak]] * v0 = new libcpp_vector[_MSExperiment[_Peak1D,_ChromatogramPeak]]()
    cdef MSExperiment item0
    for item0 in in_0:
       v0.push_back(deref(item0.inst.get()))
    cdef libcpp_vector[_TransformationDescription] * v1 = new libcpp_vector[_TransformationDescription]()
    cdef TransformationDescription item1
    for item1 in in_1:
       v1.push_back(deref(item1.inst.get()))
    _transformPeakMaps_MapAlignmentAlgorithmPoseClustering(deref(v0), deref(v1))
    del v1
    del v0 
cdef class Polarity:
    POLNULL = 0
    POSITIVE = 1
    NEGATIVE = 2
    SIZE_OF_POLARITY = 3 
cdef class MSExperiment:
    cdef shared_ptr[_MSExperiment[_Peak1D,_ChromatogramPeak]] inst
    def __dealloc__(self):
         self.inst.reset()
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_MSExperiment[_Peak1D,_ChromatogramPeak]](new _MSExperiment[_Peak1D,_ChromatogramPeak]())
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def sortSpectra(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().sortSpectra((<bool>in_0))
    def getMaxRT(self):
        cdef double _r = self.inst.get().getMaxRT()
        py_result = <float>_r
        return py_result
    def getMinMZ(self):
        cdef double _r = self.inst.get().getMinMZ()
        py_result = <float>_r
        return py_result
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getLoadedFilePath(self):
        cdef _String _r = self.inst.get().getLoadedFilePath()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setLoadedFilePath(self, bytes path ):
        assert isinstance(path, bytes), 'arg path wrong type'
    
        self.inst.get().setLoadedFilePath((_String(<char *>path)))
    def updateRanges(self):
        self.inst.get().updateRanges()
    def push_back(self, MSSpectrum spec ):
        assert isinstance(spec, MSSpectrum), 'arg spec wrong type'
    
        self.inst.get().push_back(<_MSSpectrum[_Peak1D]>deref(spec.inst.get()))
    def __getitem__(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _MSSpectrum[_Peak1D] * _r = new _MSSpectrum[_Peak1D](deref(self.inst.get())[(<int>in_0)])
        cdef MSSpectrum py_result = MSSpectrum.__new__(MSSpectrum)
        py_result.inst = shared_ptr[_MSSpectrum[_Peak1D]](_r)
        return py_result
    def getMaxMZ(self):
        cdef double _r = self.inst.get().getMaxMZ()
        py_result = <float>_r
        return py_result
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def getMinRT(self):
        cdef double _r = self.inst.get().getMinRT()
        py_result = <float>_r
        return py_result
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, MSExperiment):
            return False
        cdef MSExperiment other_casted = other
        cdef MSExperiment self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get())
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
    def _init_0(self):
        self.inst = shared_ptr[_ProteinHit](new _ProteinHit())
    def _init_1(self, float score ,  rank , bytes accession , bytes sequence ):
        assert isinstance(score, float), 'arg score wrong type'
        assert isinstance(rank, (int, long)), 'arg rank wrong type'
        assert isinstance(accession, bytes), 'arg accession wrong type'
        assert isinstance(sequence, bytes), 'arg sequence wrong type'
    
    
    
    
        self.inst = shared_ptr[_ProteinHit](new _ProteinHit((<float>score), (<int>rank), (_String(<char *>accession)), (_String(<char *>sequence))))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==4) and (isinstance(args[0], float)) and (isinstance(args[1], (int, long))) and (isinstance(args[2], bytes)) and (isinstance(args[3], bytes)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setSequence(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setSequence((_String(<char *>in_0)))
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getCoverage(self):
        cdef double _r = self.inst.get().getCoverage()
        py_result = <float>_r
        return py_result
    def setAccession(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setAccession((_String(<char *>in_0)))
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getScore(self):
        cdef float _r = self.inst.get().getScore()
        py_result = <float>_r
        return py_result
    def setRank(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().setRank((<int>in_0))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def getRank(self):
        cdef unsigned int _r = self.inst.get().getRank()
        py_result = <int>_r
        return py_result
    def getAccession(self):
        cdef _String _r = self.inst.get().getAccession()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def setCoverage(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setCoverage((<float>in_0))
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setScore(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setScore((<float>in_0))
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, ProteinHit):
            return False
        cdef ProteinHit other_casted = other
        cdef ProteinHit self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class ConsensusFeature:
    cdef shared_ptr[_ConsensusFeature] inst
    def __dealloc__(self):
         self.inst.reset()
    def getCharge(self):
        cdef int _r = self.inst.get().getCharge()
        py_result = <int>_r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_ConsensusFeature](new _ConsensusFeature())
    def _init_1(self,  in_0 , Peak2D in_1 ,  in_2 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, Peak2D), 'arg in_1 wrong type'
        assert isinstance(in_2, (int, long)), 'arg in_2 wrong type'
    
    
    
        self.inst = shared_ptr[_ConsensusFeature](new _ConsensusFeature((<int>in_0), <_Peak2D>deref(in_1.inst.get()), (<int>in_2)))
    def _init_2(self,  in_0 , BaseFeature in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, BaseFeature), 'arg in_1 wrong type'
    
    
        self.inst = shared_ptr[_ConsensusFeature](new _ConsensusFeature((<int>in_0), <_BaseFeature>deref(in_1.inst.get())))
    def _init_3(self,  in_0 , ConsensusFeature in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, ConsensusFeature), 'arg in_1 wrong type'
    
    
        self.inst = shared_ptr[_ConsensusFeature](new _ConsensusFeature((<int>in_0), <_ConsensusFeature>deref(in_1.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==3) and (isinstance(args[0], (int, long))) and (isinstance(args[1], Peak2D)) and (isinstance(args[2], (int, long))):
             self._init_1(*args)
        elif (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], BaseFeature)):
             self._init_2(*args)
        elif (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], ConsensusFeature)):
             self._init_3(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def hasValidUniqueId(self):
        cdef size_t _r = self.inst.get().hasValidUniqueId()
        py_result = <size_t>_r
        return py_result
    def computeDechargeConsensus(self, FeatureMap in_0 ,  in_1 ):
        assert isinstance(in_0, FeatureMap), 'arg in_0 wrong type'
        assert isinstance(in_1, (int, long)), 'arg in_1 wrong type'
    
    
        self.inst.get().computeDechargeConsensus(<_FeatureMap[_Feature]>deref(in_0.inst.get()), (<bool>in_1))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setWidth(self, float q ):
        assert isinstance(q, float), 'arg q wrong type'
    
        self.inst.get().setWidth((<float>q))
    def setCharge(self,  q ):
        assert isinstance(q, (int, long)), 'arg q wrong type'
    
        self.inst.get().setCharge((<int>q))
    def getUniqueId(self):
        cdef size_t _r = self.inst.get().getUniqueId()
        py_result = <size_t>_r
        return py_result
    def computeConsensus(self):
        self.inst.get().computeConsensus()
    def clearUniqueId(self):
        cdef size_t _r = self.inst.get().clearUniqueId()
        py_result = <size_t>_r
        return py_result
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setUniqueId(self,  rhs ):
        assert isinstance(rhs, (int, long)), 'arg rhs wrong type'
    
        self.inst.get().setUniqueId((<int>rhs))
    def hasInvalidUniqueId(self):
        cdef size_t _r = self.inst.get().hasInvalidUniqueId()
        py_result = <size_t>_r
        return py_result
    def _insert_0(self,  in_0 , Peak2D in_1 ,  in_2 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, Peak2D), 'arg in_1 wrong type'
        assert isinstance(in_2, (int, long)), 'arg in_2 wrong type'
    
    
    
        self.inst.get().insert((<int>in_0), <_Peak2D>deref(in_1.inst.get()), (<int>in_2))
    def _insert_1(self,  in_0 , BaseFeature in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, BaseFeature), 'arg in_1 wrong type'
    
    
        self.inst.get().insert((<int>in_0), <_BaseFeature>deref(in_1.inst.get()))
    def _insert_2(self,  in_0 , ConsensusFeature in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, ConsensusFeature), 'arg in_1 wrong type'
    
    
        self.inst.get().insert((<int>in_0), <_ConsensusFeature>deref(in_1.inst.get()))
    def insert(self, *args):
        if (len(args)==3) and (isinstance(args[0], (int, long))) and (isinstance(args[1], Peak2D)) and (isinstance(args[2], (int, long))):
            return self._insert_0(*args)
        elif (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], BaseFeature)):
            return self._insert_1(*args)
        elif (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], ConsensusFeature)):
            return self._insert_2(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getQuality(self):
        cdef float _r = self.inst.get().getQuality()
        py_result = <float>_r
        return py_result
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getWidth(self):
        cdef float _r = self.inst.get().getWidth()
        py_result = <float>_r
        return py_result
    def setQuality(self, float q ):
        assert isinstance(q, float), 'arg q wrong type'
    
        self.inst.get().setQuality((<float>q))
    def ensureUniqueId(self):
        cdef size_t _r = self.inst.get().ensureUniqueId()
        py_result = <size_t>_r
        return py_result
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def computeMonoisotopicConsensus(self):
        self.inst.get().computeMonoisotopicConsensus()
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, ConsensusFeature):
            return False
        cdef ConsensusFeature other_casted = other
        cdef ConsensusFeature self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class ProteinIdentification:
    cdef shared_ptr[_ProteinIdentification] inst
    def __dealloc__(self):
         self.inst.reset()
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def setHits(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, ProteinHit) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_ProteinHit] * v0 = new libcpp_vector[_ProteinHit]()
        cdef ProteinHit item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setHits(deref(v0))
        del v0
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
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
    def _init_0(self):
        self.inst = shared_ptr[_ProteinIdentification](new _ProteinIdentification())
    def _init_1(self, ProteinIdentification in_0 ):
        assert isinstance(in_0, ProteinIdentification), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_ProteinIdentification](new _ProteinIdentification(<_ProteinIdentification>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], ProteinIdentification)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def insertHit(self, ProteinHit in_0 ):
        assert isinstance(in_0, ProteinHit), 'arg in_0 wrong type'
    
        self.inst.get().insertHit(<_ProteinHit>deref(in_0.inst.get()))
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, ProteinIdentification):
            return False
        cdef ProteinIdentification other_casted = other
        cdef ProteinIdentification self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get())
    DigestionEnzyme = __DigestionEnzyme
    PeakMassType = __PeakMassType 
cdef class __PeakMassType:
    MONOISOTOPIC = 0
    AVERAGE = 1
    SIZE_OF_PEAKMASSTYPE = 2 
cdef class TransformationXMLFile:
    cdef shared_ptr[_TransformationXMLFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def load(self, bytes in_0 , TransformationDescription in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, TransformationDescription), 'arg in_1 wrong type'
    
    
        self.inst.get().load((_String(<char *>in_0)), <_TransformationDescription &>deref(in_1.inst.get()))
    def __init__(self):
        self.inst = shared_ptr[_TransformationXMLFile](new _TransformationXMLFile())
    def store(self, bytes in_0 , TransformationDescription in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, TransformationDescription), 'arg in_1 wrong type'
    
    
        self.inst.get().store((_String(<char *>in_0)), <_TransformationDescription>deref(in_1.inst.get())) 
cdef class SourceFile:
    cdef shared_ptr[_SourceFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def setNativeIDType(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 wrong type'
    
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
        assert isinstance(in_0, str), 'arg in_0 wrong type'
    
        self.inst.get().setFileType((<libcpp_string>in_0))
    def getFileSize(self):
        cdef float _r = self.inst.get().getFileSize()
        py_result = <float>_r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_SourceFile](new _SourceFile())
    def _init_1(self, SourceFile in_0 ):
        assert isinstance(in_0, SourceFile), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_SourceFile](new _SourceFile(<_SourceFile>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], SourceFile)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setNameOfFile(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 wrong type'
    
        self.inst.get().setNameOfFile((<libcpp_string>in_0))
    def getPathToFile(self):
        cdef libcpp_string _r = self.inst.get().getPathToFile()
        py_result = <libcpp_string>_r
        return py_result
    def setPathToFile(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 wrong type'
    
        self.inst.get().setPathToFile((<libcpp_string>in_0))
    def getFileType(self):
        cdef libcpp_string _r = self.inst.get().getFileType()
        py_result = <libcpp_string>_r
        return py_result
    def setFileSize(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
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
        assert isinstance(in_0, str), 'arg in_0 wrong type'
        assert in_1 in [0, 1, 2, 3], 'arg in_1 wrong type'
    
    
        self.inst.get().setChecksum((<libcpp_string>in_0), (<_ChecksumType>in_1)) 
cdef class Feature:
    cdef shared_ptr[_Feature] inst
    def __dealloc__(self):
         self.inst.reset()
    def getCharge(self):
        cdef int _r = self.inst.get().getCharge()
        py_result = <int>_r
        return py_result
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
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
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getWidth(self):
        cdef float _r = self.inst.get().getWidth()
        py_result = <float>_r
        return py_result
    def setWidth(self, float q ):
        assert isinstance(q, float), 'arg q wrong type'
    
        self.inst.get().setWidth((<float>q))
    def setCharge(self,  q ):
        assert isinstance(q, (int, long)), 'arg q wrong type'
    
        self.inst.get().setCharge((<int>q))
    def getUniqueId(self):
        cdef size_t _r = self.inst.get().getUniqueId()
        py_result = <size_t>_r
        return py_result
    def setRT(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setRT((<float>in_0))
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def clearUniqueId(self):
        cdef size_t _r = self.inst.get().clearUniqueId()
        py_result = <size_t>_r
        return py_result
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getIntensity(self):
        cdef double _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def setUniqueId(self,  rhs ):
        assert isinstance(rhs, (int, long)), 'arg rhs wrong type'
    
        self.inst.get().setUniqueId((<int>rhs))
    def hasInvalidUniqueId(self):
        cdef size_t _r = self.inst.get().hasInvalidUniqueId()
        py_result = <size_t>_r
        return py_result
    def hasValidUniqueId(self):
        cdef size_t _r = self.inst.get().hasValidUniqueId()
        py_result = <size_t>_r
        return py_result
    def getQuality(self,  index ):
        assert isinstance(index, (int, long)), 'arg index wrong type'
    
        cdef float _r = self.inst.get().getQuality((<size_t>index))
        py_result = <float>_r
        return py_result
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setQuality(self,  index , float q ):
        assert isinstance(index, (int, long)), 'arg index wrong type'
        assert isinstance(q, float), 'arg q wrong type'
    
    
        self.inst.get().setQuality((<size_t>index), (<float>q))
    def ensureUniqueId(self):
        cdef size_t _r = self.inst.get().ensureUniqueId()
        py_result = <size_t>_r
        return py_result
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setIntensity((<float>in_0))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setMZ((<float>in_0))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, Feature):
            return False
        cdef Feature other_casted = other
        cdef Feature self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class Param:
    cdef shared_ptr[_Param] inst
    def __dealloc__(self):
         self.inst.reset()
    def load(self, bytes filename ):
        assert isinstance(filename, bytes), 'arg filename wrong type'
    
        self.inst.get().load((_String(<char *>filename)))
    def exists(self, bytes key ):
        assert isinstance(key, bytes), 'arg key wrong type'
    
        cdef int _r = self.inst.get().exists((_String(<char *>key)))
        py_result = <int>_r
        return py_result
    def getDescription(self, bytes key ):
        assert isinstance(key, bytes), 'arg key wrong type'
    
        cdef libcpp_string _r = self.inst.get().getDescription((_String(<char *>key)))
        py_result = <libcpp_string>_r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_Param](new _Param())
    def _init_1(self, Param in_0 ):
        assert isinstance(in_0, Param), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_Param](new _Param(<_Param>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], Param)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setMaxInt(self, bytes key ,  max ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(max, (int, long)), 'arg max wrong type'
    
    
        self.inst.get().setMaxInt((_String(<char *>key)), (<int>max))
    def setMinInt(self, bytes key ,  min ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(min, (int, long)), 'arg min wrong type'
    
    
        self.inst.get().setMinInt((_String(<char *>key)), (<int>min))
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result
    def setMinFloat(self, bytes key , float min ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(min, float), 'arg min wrong type'
    
    
        self.inst.get().setMinFloat((_String(<char *>key)), (<float>min))
    def setValidStrings(self, bytes key , list strings ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(strings, list) and all(isinstance(i, bytes) for i in strings), 'arg strings wrong type'
    
        cdef libcpp_vector[_String] * v1 = new libcpp_vector[_String]()
        cdef bytes item1
        for item1 in strings:
           v1.push_back(_String(<char *>item1))
        self.inst.get().setValidStrings((_String(<char *>key)), deref(v1))
        del v1
    def getEntry(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _ParamEntry * _r = new _ParamEntry(self.inst.get().getEntry((_String(<char *>in_0))))
        cdef ParamEntry py_result = ParamEntry.__new__(ParamEntry)
        py_result.inst = shared_ptr[_ParamEntry](_r)
        return py_result
    def getSectionDescription(self, bytes key ):
        assert isinstance(key, bytes), 'arg key wrong type'
    
        cdef libcpp_string _r = self.inst.get().getSectionDescription((_String(<char *>key)))
        py_result = <libcpp_string>_r
        return py_result
    def hasTag(self, bytes key , bytes tag ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(tag, bytes), 'arg tag wrong type'
    
    
        cdef int _r = self.inst.get().hasTag((_String(<char *>key)), (_String(<char *>tag)))
        py_result = <int>_r
        return py_result
    def store(self, bytes filename ):
        assert isinstance(filename, bytes), 'arg filename wrong type'
    
        self.inst.get().store((_String(<char *>filename)))
    def _setValue_0(self, bytes key , DataValue val , bytes desc , list tags ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(val, DataValue), 'arg val wrong type'
        assert isinstance(desc, bytes), 'arg desc wrong type'
        assert isinstance(tags, list) and all(isinstance(li, bytes) for li in tags), 'arg tags wrong type'
    
    
    
        cdef libcpp_vector[libcpp_string] _v3 = tags
        cdef _StringList v3 = _StringList(_v3)
        self.inst.get().setValue((_String(<char *>key)), <_DataValue>deref(val.inst.get()), (_String(<char *>desc)), (v3))
    def _setValue_1(self, bytes key , DataValue val , bytes desc ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(val, DataValue), 'arg val wrong type'
        assert isinstance(desc, bytes), 'arg desc wrong type'
    
    
    
        self.inst.get().setValue((_String(<char *>key)), <_DataValue>deref(val.inst.get()), (_String(<char *>desc)))
    def setValue(self, *args):
        if (len(args)==4) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)) and (isinstance(args[2], bytes)) and (isinstance(args[3], list) and all(isinstance(li, bytes) for li in args[3])):
            return self._setValue_0(*args)
        elif (len(args)==3) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)) and (isinstance(args[2], bytes)):
            return self._setValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def addTags(self, bytes key , list tags ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(tags, list) and all(isinstance(li, bytes) for li in tags), 'arg tags wrong type'
    
        cdef libcpp_vector[libcpp_string] _v1 = tags
        cdef _StringList v1 = _StringList(_v1)
        self.inst.get().addTags((_String(<char *>key)), (v1))
    def update(self, Param p_old ,  report_new_params ,  only_update_old ):
        assert isinstance(p_old, Param), 'arg p_old wrong type'
        assert isinstance(report_new_params, (int, long)), 'arg report_new_params wrong type'
        assert isinstance(only_update_old, (int, long)), 'arg only_update_old wrong type'
    
    
    
        self.inst.get().update(<_Param>deref(p_old.inst.get()), (<bool>report_new_params), (<bool>only_update_old))
    def _copy_0(self, bytes prefix ,  in_1 ):
        assert isinstance(prefix, bytes), 'arg prefix wrong type'
        assert isinstance(in_1, (int, long)), 'arg in_1 wrong type'
    
    
        cdef _Param * _r = new _Param(self.inst.get().copy((_String(<char *>prefix)), (<bool>in_1)))
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    def _copy_1(self, bytes prefix ):
        assert isinstance(prefix, bytes), 'arg prefix wrong type'
    
        cdef _Param * _r = new _Param(self.inst.get().copy((_String(<char *>prefix))))
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    def copy(self, *args):
        if (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], (int, long))):
            return self._copy_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._copy_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getTags(self, bytes key ):
        assert isinstance(key, bytes), 'arg key wrong type'
    
        cdef _StringList _r = self.inst.get().getTags((_String(<char *>key)))
        py_result = []
        cdef int i, n
        n = _r.size()
        for i in range(n):
            py_result.append(<libcpp_string>_r.at(i))
        return py_result
    def insert(self, bytes prefix , Param param ):
        assert isinstance(prefix, bytes), 'arg prefix wrong type'
        assert isinstance(param, Param), 'arg param wrong type'
    
    
        self.inst.get().insert((_String(<char *>prefix)), <_Param>deref(param.inst.get()))
    def setMaxFloat(self, bytes key , float max ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(max, float), 'arg max wrong type'
    
    
        self.inst.get().setMaxFloat((_String(<char *>key)), (<float>max))
    def getValue(self, bytes key ):
        assert isinstance(key, bytes), 'arg key wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getValue((_String(<char *>key))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def clearTags(self, bytes key ):
        assert isinstance(key, bytes), 'arg key wrong type'
    
        self.inst.get().clearTags((_String(<char *>key)))
    def setSectionDescription(self, bytes key , bytes desc ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(desc, bytes), 'arg desc wrong type'
    
    
        self.inst.get().setSectionDescription((_String(<char *>key)), (_String(<char *>desc)))
    def addTag(self, bytes key , bytes tag ):
        assert isinstance(key, bytes), 'arg key wrong type'
        assert isinstance(tag, bytes), 'arg tag wrong type'
    
    
        self.inst.get().addTag((_String(<char *>key)), (_String(<char *>tag)))
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, Param):
            return False
        cdef Param other_casted = other
        cdef Param self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
    # the following empty line is important

    def asDict(Param self):


        cdef list keys = list()

        cdef _ParamIterator param_it = self.inst.get().begin()
        while param_it != self.inst.get().end():
            keys.append(param_it.getName().c_str())
            inc(param_it)

        result = dict()

        for k in keys:
            value = self.getValue(k)
            dt = value.valueType()
            if dt == DataType.STRING_VALUE:
                value = value.toString()
            elif dt == DataType.INT_VALUE:
                value = value.toInt()
            elif dt == DataType.DOUBLE_VALUE:
                value = value.toDouble()
            elif dt == DataType.DOUBLE_LIST:
                value = value.toDoubleList()
            elif dt == DataType.STRING_LIST:
                value = value.toStringList()
            elif dt == DataType.INT_LIST:
                value = value.toIntList()
            result[k] = value

        return result

    def updateFrom(self, dd):
        assert isinstance(dd, dict)

        for key, v in dd.items():
            tags = self.getTags(key)
            desc = self.getDescription(key)
            self.setValue(key, DataValue(v), desc, tags) 
cdef class DateTime:
    cdef shared_ptr[_DateTime] inst
    def __dealloc__(self):
         self.inst.reset()
    def getTime(self):
        cdef _String _r = self.inst.get().getTime()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def getDate(self):
        cdef _String _r = self.inst.get().getDate()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_DateTime](new _DateTime())
    now = __static_DateTime_now 
cdef class MzDataFile:
    cdef shared_ptr[_MzDataFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def load(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, MSExperiment), 'arg in_1 wrong type'
    
    
        self.inst.get().load((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def startProgress(self,  begin ,  end , bytes label ):
        assert isinstance(begin, (int, long)), 'arg begin wrong type'
        assert isinstance(end, (int, long)), 'arg end wrong type'
        assert isinstance(label, bytes), 'arg label wrong type'
    
    
    
        self.inst.get().startProgress((<ptrdiff_t>begin), (<ptrdiff_t>end), (_String(<char *>label)))
    def getLogType(self):
        cdef _LogType _r = self.inst.get().getLogType()
        py_result = <int>_r
        return py_result
    def endProgress(self):
        self.inst.get().endProgress()
    def __init__(self):
        self.inst = shared_ptr[_MzDataFile](new _MzDataFile())
    def setProgress(self,  value ):
        assert isinstance(value, (int, long)), 'arg value wrong type'
    
        self.inst.get().setProgress((<ptrdiff_t>value))
    def setLogType(self, int in_0 ):
        assert in_0 in [0, 1, 2], 'arg in_0 wrong type'
    
        self.inst.get().setLogType((<_LogType>in_0))
    def store(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, MSExperiment), 'arg in_1 wrong type'
    
    
        self.inst.get().store((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get())) 
cdef class BaseFeature:
    cdef shared_ptr[_BaseFeature] inst
    def __dealloc__(self):
         self.inst.reset()
    def getCharge(self):
        cdef int _r = self.inst.get().getCharge()
        py_result = <int>_r
        return py_result
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def clearUniqueId(self):
        cdef size_t _r = self.inst.get().clearUniqueId()
        py_result = <size_t>_r
        return py_result
    def getQuality(self):
        cdef float _r = self.inst.get().getQuality()
        py_result = <float>_r
        return py_result
    def getUniqueId(self):
        cdef size_t _r = self.inst.get().getUniqueId()
        py_result = <size_t>_r
        return py_result
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def hasValidUniqueId(self):
        cdef size_t _r = self.inst.get().hasValidUniqueId()
        py_result = <size_t>_r
        return py_result
    def hasInvalidUniqueId(self):
        cdef size_t _r = self.inst.get().hasInvalidUniqueId()
        py_result = <size_t>_r
        return py_result
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getWidth(self):
        cdef float _r = self.inst.get().getWidth()
        py_result = <float>_r
        return py_result
    def setQuality(self, float q ):
        assert isinstance(q, float), 'arg q wrong type'
    
        self.inst.get().setQuality((<float>q))
    def ensureUniqueId(self):
        cdef size_t _r = self.inst.get().ensureUniqueId()
        py_result = <size_t>_r
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_BaseFeature](new _BaseFeature())
    def setUniqueId(self,  rhs ):
        assert isinstance(rhs, (int, long)), 'arg rhs wrong type'
    
        self.inst.get().setUniqueId((<int>rhs))
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def setWidth(self, float q ):
        assert isinstance(q, float), 'arg q wrong type'
    
        self.inst.get().setWidth((<float>q))
    def setCharge(self,  q ):
        assert isinstance(q, (int, long)), 'arg q wrong type'
    
        self.inst.get().setCharge((<int>q)) 
cdef class AASequence:
    cdef shared_ptr[_AASequence] inst
    def __dealloc__(self):
         self.inst.reset()
    def getCTerminalModification(self):
        cdef _String _r = self.inst.get().getCTerminalModification()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def __iadd__(AASequence self, AASequence other not None):
        cdef _AASequence * this = self.inst.get()
        cdef _AASequence * that = other.inst.get()
        _iadd(this, that)
        return self
    def toUnmodifiedString(self):
        cdef _String _r = self.inst.get().toUnmodifiedString()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def setStringSequence(self, bytes modification ):
        assert isinstance(modification, bytes), 'arg modification wrong type'
    
        self.inst.get().setStringSequence((_String(<char *>modification)))
    def __add__(AASequence self, AASequence other not None):
        cdef _AASequence  * this = self.inst.get()
        cdef _AASequence * that = other.inst.get()
        cdef _AASequence added = deref(this) + deref(that)
        cdef AASequence result = AASequence.__new__(AASequence)
        result.inst = shared_ptr[_AASequence](new _AASequence(added))
        return result
    def toString(self):
        cdef _String _r = self.inst.get().toString()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def setNTerminalModification(self, bytes modification ):
        assert isinstance(modification, bytes), 'arg modification wrong type'
    
        self.inst.get().setNTerminalModification((_String(<char *>modification)))
    def _init_0(self):
        self.inst = shared_ptr[_AASequence](new _AASequence())
    def _init_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_AASequence](new _AASequence((<char *>in_0)))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getNTerminalModification(self):
        cdef _String _r = self.inst.get().getNTerminalModification()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def setModification(self,  index , bytes modification ):
        assert isinstance(index, (int, long)), 'arg index wrong type'
        assert isinstance(modification, bytes), 'arg modification wrong type'
    
    
        self.inst.get().setModification((<size_t>index), (_String(<char *>modification)))
    def setCTerminalModification(self, bytes modification ):
        assert isinstance(modification, bytes), 'arg modification wrong type'
    
        self.inst.get().setCTerminalModification((_String(<char *>modification))) 
cdef class ChecksumType:
    UNKNOWN_CHECKSUM = 0
    SHA1 = 1
    MD5 = 2
    SIZE_OF_CHECKSUMTYPE = 3 
cdef class Type:
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
cdef class ParamEntry:
    cdef shared_ptr[_ParamEntry] inst
    def __dealloc__(self):
         self.inst.reset()
    property name:
        def __set__(self, bytes name):
        
            self.inst.get().name = (_String(<char *>name))
        
        def __get__(self):
            cdef _String _r = self.inst.get().name
            py_result = _cast_const_away(<char*>_r.c_str())
            return py_result
    property description:
        def __set__(self, bytes description):
        
            self.inst.get().description = (_String(<char *>description))
        
        def __get__(self):
            cdef _String _r = self.inst.get().description
            py_result = _cast_const_away(<char*>_r.c_str())
            return py_result
    property value:
        def __set__(self, DataValue value):
        
            self.inst.get().value = <_DataValue>deref(value.inst.get())
        
        def __get__(self):
            cdef _DataValue * _r = new _DataValue(self.inst.get().value)
            cdef DataValue py_result = DataValue.__new__(DataValue)
            py_result.inst = shared_ptr[_DataValue](_r)
            return py_result
    property tags:
        def __set__(self, set tags):
            cdef libcpp_set[_String] * v0 = new libcpp_set[_String]()
            cdef bytes item0
            for item0 in tags:
               v0.insert(_String(<char *>item0))
            self.inst.get().tags = deref(v0)
            del v0
        def __get__(self):
            _r = self.inst.get().tags
            py_result = set()
            cdef libcpp_set[_String].iterator it__r = _r.begin()
            while it__r != _r.end():
               py_result.add(<char*>deref(it__r).c_str())
               inc(it__r)
            return py_result
    property valid_strings:
        def __set__(self, list valid_strings):
            cdef libcpp_vector[_String] * v0 = new libcpp_vector[_String]()
            cdef bytes item0
            for item0 in valid_strings:
               v0.push_back(_String(<char *>item0))
            self.inst.get().valid_strings = deref(v0)
            del v0
        def __get__(self):
            _r = self.inst.get().valid_strings
            py_result = []
            cdef libcpp_vector[_String].iterator it__r = _r.begin()
            while it__r != _r.end():
               py_result.append(<char*>deref(it__r).c_str())
               inc(it__r)
            return py_result
    property max_float:
        def __set__(self, float max_float):
        
            self.inst.get().max_float = (<float>max_float)
        
        def __get__(self):
            cdef double _r = self.inst.get().max_float
            py_result = <float>_r
            return py_result
    property min_float:
        def __set__(self, float min_float):
        
            self.inst.get().min_float = (<float>min_float)
        
        def __get__(self):
            cdef double _r = self.inst.get().min_float
            py_result = <float>_r
            return py_result
    property max_int:
        def __set__(self,  max_int):
        
            self.inst.get().max_int = (<int>max_int)
        
        def __get__(self):
            cdef int _r = self.inst.get().max_int
            py_result = <int>_r
            return py_result
    property min_int:
        def __set__(self,  min_int):
        
            self.inst.get().min_int = (<int>min_int)
        
        def __get__(self):
            cdef int _r = self.inst.get().min_int
            py_result = <int>_r
            return py_result
    def isValid(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().isValid((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_ParamEntry](new _ParamEntry())
    def _init_1(self, ParamEntry in_0 ):
        assert isinstance(in_0, ParamEntry), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_ParamEntry](new _ParamEntry(<_ParamEntry>deref(in_0.inst.get())))
    def _init_2(self, bytes n , DataValue v , bytes d , list t ):
        assert isinstance(n, bytes), 'arg n wrong type'
        assert isinstance(v, DataValue), 'arg v wrong type'
        assert isinstance(d, bytes), 'arg d wrong type'
        assert isinstance(t, list) and all(isinstance(li, bytes) for li in t), 'arg t wrong type'
    
    
    
        cdef libcpp_vector[libcpp_string] _v3 = t
        cdef _StringList v3 = _StringList(_v3)
        self.inst = shared_ptr[_ParamEntry](new _ParamEntry((_String(<char *>n)), <_DataValue>deref(v.inst.get()), (_String(<char *>d)), (v3)))
    def _init_3(self, bytes n , DataValue v , bytes d ):
        assert isinstance(n, bytes), 'arg n wrong type'
        assert isinstance(v, DataValue), 'arg v wrong type'
        assert isinstance(d, bytes), 'arg d wrong type'
    
    
    
        self.inst = shared_ptr[_ParamEntry](new _ParamEntry((_String(<char *>n)), <_DataValue>deref(v.inst.get()), (_String(<char *>d))))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], ParamEntry)):
             self._init_1(*args)
        elif (len(args)==4) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)) and (isinstance(args[2], bytes)) and (isinstance(args[3], list) and all(isinstance(li, bytes) for li in args[3])):
             self._init_2(*args)
        elif (len(args)==3) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)) and (isinstance(args[2], bytes)):
             self._init_3(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def __richcmp__(self, other, op):
        if op not in (2,):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, ParamEntry):
            return False
        cdef ParamEntry other_casted = other
        cdef ParamEntry self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get()) 
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
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setRT((<float>in_0))
    def getRT(self):
        cdef double _r = self.inst.get().getRT()
        py_result = <float>_r
        return py_result
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setIntensity((<float>in_0))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setMZ((<float>in_0))
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, Peak2D):
            return False
        cdef Peak2D other_casted = other
        cdef Peak2D self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class Product:
    cdef shared_ptr[_Product] inst
    def __dealloc__(self):
         self.inst.reset()
    def getIsolationWindowUpperOffset(self):
        cdef double _r = self.inst.get().getIsolationWindowUpperOffset()
        py_result = <float>_r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_Product](new _Product())
    def _init_1(self, Product in_0 ):
        assert isinstance(in_0, Product), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_Product](new _Product(<_Product>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], Product)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getIsolationWindowLowerOffset(self):
        cdef double _r = self.inst.get().getIsolationWindowLowerOffset()
        py_result = <float>_r
        return py_result
    def setIsolationWindowUpperOffset(self, float bound ):
        assert isinstance(bound, float), 'arg bound wrong type'
    
        self.inst.get().setIsolationWindowUpperOffset((<float>bound))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setMZ((<float>in_0))
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def setIsolationWindowLowerOffset(self, float bound ):
        assert isinstance(bound, float), 'arg bound wrong type'
    
        self.inst.get().setIsolationWindowLowerOffset((<float>bound))
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, Product):
            return False
        cdef Product other_casted = other
        cdef Product self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class ChromatogramPeak:
    cdef shared_ptr[_ChromatogramPeak] inst
    def __dealloc__(self):
         self.inst.reset()
    def getIntensity(self):
        cdef double _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_ChromatogramPeak](new _ChromatogramPeak())
    def setRT(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setRT((<float>in_0))
    def getRT(self):
        cdef double _r = self.inst.get().getRT()
        py_result = <float>_r
        return py_result
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setIntensity((<float>in_0))
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, ChromatogramPeak):
            return False
        cdef ChromatogramPeak other_casted = other
        cdef ChromatogramPeak self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class AcquisitionInfo:
    cdef shared_ptr[_AcquisitionInfo] inst
    def __dealloc__(self):
         self.inst.reset()
    def getMethodOfCombination(self):
        cdef _String _r = self.inst.get().getMethodOfCombination()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_AcquisitionInfo](new _AcquisitionInfo())
    def _init_1(self, AcquisitionInfo in_0 ):
        assert isinstance(in_0, AcquisitionInfo), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_AcquisitionInfo](new _AcquisitionInfo(<_AcquisitionInfo>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], AcquisitionInfo)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setMethodOfCombination(self, bytes method ):
        assert isinstance(method, bytes), 'arg method wrong type'
    
        self.inst.get().setMethodOfCombination((_String(<char *>method)))
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, AcquisitionInfo):
            return False
        cdef AcquisitionInfo other_casted = other
        cdef AcquisitionInfo self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class LogType:
    CMD = 0
    GUI = 1
    NONE = 2 
cdef class MzMLFile:
    cdef shared_ptr[_MzMLFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def load(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, MSExperiment), 'arg in_1 wrong type'
    
    
        self.inst.get().load((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def startProgress(self,  begin ,  end , bytes label ):
        assert isinstance(begin, (int, long)), 'arg begin wrong type'
        assert isinstance(end, (int, long)), 'arg end wrong type'
        assert isinstance(label, bytes), 'arg label wrong type'
    
    
    
        self.inst.get().startProgress((<ptrdiff_t>begin), (<ptrdiff_t>end), (_String(<char *>label)))
    def getLogType(self):
        cdef _LogType _r = self.inst.get().getLogType()
        py_result = <int>_r
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_MzMLFile](new _MzMLFile())
    def endProgress(self):
        self.inst.get().endProgress()
    def setProgress(self,  value ):
        assert isinstance(value, (int, long)), 'arg value wrong type'
    
        self.inst.get().setProgress((<ptrdiff_t>value))
    def setLogType(self, int in_0 ):
        assert in_0 in [0, 1, 2], 'arg in_0 wrong type'
    
        self.inst.get().setLogType((<_LogType>in_0))
    def store(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, MSExperiment), 'arg in_1 wrong type'
    
    
        self.inst.get().store((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get())) 
cdef class FileHandler:
    cdef shared_ptr[_FileHandler] inst
    def __dealloc__(self):
         self.inst.reset()
    def _init_0(self):
        self.inst = shared_ptr[_FileHandler](new _FileHandler())
    def _init_1(self, FileHandler in_0 ):
        assert isinstance(in_0, FileHandler), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_FileHandler](new _FileHandler(<_FileHandler>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], FileHandler)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def loadExperiment(self, str in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, str), 'arg in_0 wrong type'
        assert isinstance(in_1, MSExperiment), 'arg in_1 wrong type'
    
    
        self.inst.get().loadExperiment((<libcpp_string>in_0), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def storeExperiment(self, str in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, str), 'arg in_0 wrong type'
        assert isinstance(in_1, MSExperiment), 'arg in_1 wrong type'
    
    
        self.inst.get().storeExperiment((<libcpp_string>in_0), <_MSExperiment[_Peak1D,_ChromatogramPeak]>deref(in_1.inst.get()))
    def loadFeatures(self, str in_0 , FeatureMap in_1 ):
        assert isinstance(in_0, str), 'arg in_0 wrong type'
        assert isinstance(in_1, FeatureMap), 'arg in_1 wrong type'
    
    
        self.inst.get().loadFeatures((<libcpp_string>in_0), <_FeatureMap[_Feature] &>deref(in_1.inst.get()))
    getType = __static_FileHandler_getType 
cdef class DataValue:
    cdef shared_ptr[_DataValue] inst
    def __dealloc__(self):
         self.inst.reset()
    def _init_0(self):
        self.inst = shared_ptr[_DataValue](new _DataValue())
    def _init_1(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, str) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[libcpp_string] v0 = in_0
        self.inst = shared_ptr[_DataValue](new _DataValue(v0))
    def _init_2(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, (int, long)) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[int] v0 = in_0
        self.inst = shared_ptr[_DataValue](new _DataValue(v0))
    def _init_3(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, float) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[float] v0 = in_0
        self.inst = shared_ptr[_DataValue](new _DataValue(v0))
    def _init_4(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_DataValue](new _DataValue((<char *>in_0)))
    def _init_5(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_DataValue](new _DataValue((<int>in_0)))
    def _init_6(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_DataValue](new _DataValue((<float>in_0)))
    def _init_7(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, bytes) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[libcpp_string] _v0 = in_0
        cdef _StringList v0 = _StringList(_v0)
        self.inst = shared_ptr[_DataValue](new _DataValue((v0)))
    def _init_8(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, int) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[int] _v0 = in_0
        cdef _IntList v0 = _IntList(_v0)
        self.inst = shared_ptr[_DataValue](new _DataValue((v0)))
    def _init_9(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, float) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[double] _v0 = in_0
        cdef _DoubleList v0 = _DoubleList(_v0)
        self.inst = shared_ptr[_DataValue](new _DataValue((v0)))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, str) for li in args[0])):
             self._init_1(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
             self._init_2(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, float) for li in args[0])):
             self._init_3(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
             self._init_4(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
             self._init_5(*args)
        elif (len(args)==1) and (isinstance(args[0], float)):
             self._init_6(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, bytes) for li in args[0])):
             self._init_7(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, int) for li in args[0])):
             self._init_8(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, float) for li in args[0])):
             self._init_9(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def toInt(self):
        cdef int _r = <int>(deref(self.inst.get()))
        py_res = <int>_r
        return py_res
    def toString(self):
        cdef libcpp_string _r = <libcpp_string>(deref(self.inst.get()))
        py_res = <libcpp_string>_r
        return py_res
    def toDouble(self):
        cdef double _r = <double>(deref(self.inst.get()))
        py_res = <float>_r
        return py_res
    def toStringList(self):
        cdef _StringList _r = <_StringList>(deref(self.inst.get()))
        py_res = []
        cdef int i, n
        n = _r.size()
        for i in range(n):
            py_res.append(<libcpp_string>_r.at(i))
        return py_res
    def toDoubleList(self):
        cdef _DoubleList _r = <_DoubleList>(deref(self.inst.get()))
        py_res = []
        cdef int i, n
        n = _r.size()
        for i in range(n):
            py_res.append(<double>_r.at(i))
        return py_res
    def toIntList(self):
        cdef _IntList _r = <_IntList>(deref(self.inst.get()))
        py_res = []
        cdef int i, n
        n = _r.size()
        for i in range(n):
            py_res.append(<int>_r.at(i))
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
        assert isinstance(epx, MSExperiment), 'arg epx wrong type'
    
        self.inst.get().convertChromatogramsToSpectra(<_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(epx.inst.get()))
    def convertSpectraToChromatograms(self, MSExperiment epx ,  remove_spectra ):
        assert isinstance(epx, MSExperiment), 'arg epx wrong type'
        assert isinstance(remove_spectra, (int, long)), 'arg remove_spectra wrong type'
    
    
        self.inst.get().convertSpectraToChromatograms(<_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(epx.inst.get()), (<int>remove_spectra))
    def __init__(self):
        self.inst = shared_ptr[_ChromatogramTools](new _ChromatogramTools()) 
cdef class FeatureFinderAlgorithmPicked:
    cdef shared_ptr[_FeatureFinderAlgorithmPicked[_Peak1D,_Feature]] inst
    def __dealloc__(self):
         self.inst.reset()
    def setParameters(self, Param param ):
        assert isinstance(param, Param), 'arg param wrong type'
    
        self.inst.get().setParameters(<_Param &>deref(param.inst.get()))
    def setName(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setName((_String(<char *>in_0)))
    def getDefaults(self):
        cdef _Param * _r = new _Param(self.inst.get().getDefaults())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    def getName(self):
        cdef _String _r = self.inst.get().getName()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_FeatureFinderAlgorithmPicked[_Peak1D,_Feature]](new _FeatureFinderAlgorithmPicked[_Peak1D,_Feature]())
    def getParameters(self):
        cdef _Param * _r = new _Param(self.inst.get().getParameters())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    getProductName = __static_FeatureFinderAlgorithmPicked_getProductName 
cdef class __DigestionEnzyme:
    TRYPSIN = 0
    PEPSIN_A = 1
    PROTEASE_K = 2
    CHYMOTRYPSIN = 3
    NO_ENZYME = 4
    UNKNOWN_ENZYME = 5
    SIZE_OF_DIGESTIONENZYME = 6 
cdef class PeakTypeEstimator:
    cdef shared_ptr[_PeakTypeEstimator] inst
    def __dealloc__(self):
         self.inst.reset()
    def __init__(self):
        self.inst = shared_ptr[_PeakTypeEstimator](new _PeakTypeEstimator())
    
    def estimateType(self, MSSpectrum spec):
        return self.inst.get().estimateType(spec.inst.get().begin(), spec.inst.get().end()) 
cdef class RichPeak2D:
    cdef shared_ptr[_RichPeak2D] inst
    def __dealloc__(self):
         self.inst.reset()
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getRT(self):
        cdef double _r = self.inst.get().getRT()
        py_result = <float>_r
        return py_result
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def hasValidUniqueId(self):
        cdef size_t _r = self.inst.get().hasValidUniqueId()
        py_result = <size_t>_r
        return py_result
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def getUniqueId(self):
        cdef size_t _r = self.inst.get().getUniqueId()
        py_result = <size_t>_r
        return py_result
    def setRT(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setRT((<float>in_0))
    def __init__(self):
        self.inst = shared_ptr[_RichPeak2D](new _RichPeak2D())
    def clearUniqueId(self):
        cdef size_t _r = self.inst.get().clearUniqueId()
        py_result = <size_t>_r
        return py_result
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getIntensity(self):
        cdef float _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def setUniqueId(self,  rhs ):
        assert isinstance(rhs, (int, long)), 'arg rhs wrong type'
    
        self.inst.get().setUniqueId((<int>rhs))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def hasInvalidUniqueId(self):
        cdef size_t _r = self.inst.get().hasInvalidUniqueId()
        py_result = <size_t>_r
        return py_result
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def ensureUniqueId(self):
        cdef size_t _r = self.inst.get().ensureUniqueId()
        py_result = <size_t>_r
        return py_result
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setIntensity((<float>in_0))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setMZ((<float>in_0))
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, RichPeak2D):
            return False
        cdef RichPeak2D other_casted = other
        cdef RichPeak2D self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class PeptideIdentification:
    cdef shared_ptr[_PeptideIdentification] inst
    def __dealloc__(self):
         self.inst.reset()
    def sort(self):
        self.inst.get().sort()
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setHigherScoreBetter(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().setHigherScoreBetter((<bool>in_0))
    def getIdentifier(self):
        cdef _String _r = self.inst.get().getIdentifier()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def assignRanks(self):
        self.inst.get().assignRanks()
    def insertHit(self, PeptideHit in_0 ):
        assert isinstance(in_0, PeptideHit), 'arg in_0 wrong type'
    
        self.inst.get().insertHit(<_PeptideHit>deref(in_0.inst.get()))
    def setScoreType(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setScoreType((_String(<char *>in_0)))
    def empty(self):
        cdef bool _r = self.inst.get().empty()
        py_result = <bool>_r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_PeptideIdentification](new _PeptideIdentification())
    def _init_1(self, PeptideIdentification in_0 ):
        assert isinstance(in_0, PeptideIdentification), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_PeptideIdentification](new _PeptideIdentification(<_PeptideIdentification>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], PeptideIdentification)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setHits(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, PeptideHit) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_PeptideHit] * v0 = new libcpp_vector[_PeptideHit]()
        cdef PeptideHit item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setHits(deref(v0))
        del v0
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def isHigherScoreBetter(self):
        cdef bool _r = self.inst.get().isHigherScoreBetter()
        py_result = <bool>_r
        return py_result
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def setIdentifier(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setIdentifier((_String(<char *>in_0)))
    def _getReferencingHits_0(self, bytes in_0 , list in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, list) and all(isinstance(li, PeptideHit) for li in in_1), 'arg in_1 wrong type'
    
        cdef libcpp_vector[_PeptideHit] * v1 = new libcpp_vector[_PeptideHit]()
        cdef PeptideHit item1
        for item1 in in_1:
           v1.push_back(deref(item1.inst.get()))
        self.inst.get().getReferencingHits((_String(<char *>in_0)), deref(v1))
        cdef replace = []
        cdef libcpp_vector[_PeptideHit].iterator it = v1.begin()
        while it != v1.end():
           item1 = PeptideHit.__new__(PeptideHit)
           item1.inst = shared_ptr[_PeptideHit](new _PeptideHit(deref(it)))
           replace.append(item1)
           inc(it)
        in_1[:] = replace
        del v1
    def _getReferencingHits_1(self, list in_0 , list in_1 ):
        assert isinstance(in_0, list) and all(isinstance(i, bytes) for i in in_0), 'arg in_0 wrong type'
        assert isinstance(in_1, list) and all(isinstance(li, PeptideHit) for li in in_1), 'arg in_1 wrong type'
        cdef libcpp_vector[_String] * v0 = new libcpp_vector[_String]()
        cdef bytes item0
        for item0 in in_0:
           v0.push_back(_String(<char *>item0))
        cdef libcpp_vector[_PeptideHit] * v1 = new libcpp_vector[_PeptideHit]()
        cdef PeptideHit item1
        for item1 in in_1:
           v1.push_back(deref(item1.inst.get()))
        self.inst.get().getReferencingHits(deref(v0), deref(v1))
        cdef replace = []
        cdef libcpp_vector[_PeptideHit].iterator it = v1.begin()
        while it != v1.end():
           item1 = PeptideHit.__new__(PeptideHit)
           item1.inst = shared_ptr[_PeptideHit](new _PeptideHit(deref(it)))
           replace.append(item1)
           inc(it)
        in_1[:] = replace
        del v1
        del v0
    def _getReferencingHits_2(self, list in_0 , list in_1 ):
        assert isinstance(in_0, list) and all(isinstance(li, ProteinHit) for li in in_0), 'arg in_0 wrong type'
        assert isinstance(in_1, list) and all(isinstance(li, PeptideHit) for li in in_1), 'arg in_1 wrong type'
        cdef libcpp_vector[_ProteinHit] * v0 = new libcpp_vector[_ProteinHit]()
        cdef ProteinHit item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        cdef libcpp_vector[_PeptideHit] * v1 = new libcpp_vector[_PeptideHit]()
        cdef PeptideHit item1
        for item1 in in_1:
           v1.push_back(deref(item1.inst.get()))
        self.inst.get().getReferencingHits(deref(v0), deref(v1))
        cdef replace = []
        cdef libcpp_vector[_PeptideHit].iterator it = v1.begin()
        while it != v1.end():
           item1 = PeptideHit.__new__(PeptideHit)
           item1.inst = shared_ptr[_PeptideHit](new _PeptideHit(deref(it)))
           replace.append(item1)
           inc(it)
        in_1[:] = replace
        del v1
        del v0
    def getReferencingHits(self, *args):
        if (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], list) and all(isinstance(li, PeptideHit) for li in args[1])):
            return self._getReferencingHits_0(*args)
        elif (len(args)==2) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])) and (isinstance(args[1], list) and all(isinstance(li, PeptideHit) for li in args[1])):
            return self._getReferencingHits_1(*args)
        elif (len(args)==2) and (isinstance(args[0], list) and all(isinstance(li, ProteinHit) for li in args[0])) and (isinstance(args[1], list) and all(isinstance(li, PeptideHit) for li in args[1])):
            return self._getReferencingHits_2(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getHits(self):
        _r = self.inst.get().getHits()
        py_result = []
        cdef libcpp_vector[_PeptideHit].iterator it__r = _r.begin()
        cdef PeptideHit item_py_result
        while it__r != _r.end():
           item_py_result = PeptideHit.__new__(PeptideHit)
           item_py_result.inst = shared_ptr[_PeptideHit](new _PeptideHit(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def _getNonReferencingHits_0(self, bytes in_0 , list in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, list) and all(isinstance(li, PeptideHit) for li in in_1), 'arg in_1 wrong type'
    
        cdef libcpp_vector[_PeptideHit] * v1 = new libcpp_vector[_PeptideHit]()
        cdef PeptideHit item1
        for item1 in in_1:
           v1.push_back(deref(item1.inst.get()))
        self.inst.get().getNonReferencingHits((_String(<char *>in_0)), deref(v1))
        cdef replace = []
        cdef libcpp_vector[_PeptideHit].iterator it = v1.begin()
        while it != v1.end():
           item1 = PeptideHit.__new__(PeptideHit)
           item1.inst = shared_ptr[_PeptideHit](new _PeptideHit(deref(it)))
           replace.append(item1)
           inc(it)
        in_1[:] = replace
        del v1
    def _getNonReferencingHits_1(self, list in_0 , list in_1 ):
        assert isinstance(in_0, list) and all(isinstance(i, bytes) for i in in_0), 'arg in_0 wrong type'
        assert isinstance(in_1, list) and all(isinstance(li, PeptideHit) for li in in_1), 'arg in_1 wrong type'
        cdef libcpp_vector[_String] * v0 = new libcpp_vector[_String]()
        cdef bytes item0
        for item0 in in_0:
           v0.push_back(_String(<char *>item0))
        cdef libcpp_vector[_PeptideHit] * v1 = new libcpp_vector[_PeptideHit]()
        cdef PeptideHit item1
        for item1 in in_1:
           v1.push_back(deref(item1.inst.get()))
        self.inst.get().getNonReferencingHits(deref(v0), deref(v1))
        cdef replace = []
        cdef libcpp_vector[_PeptideHit].iterator it = v1.begin()
        while it != v1.end():
           item1 = PeptideHit.__new__(PeptideHit)
           item1.inst = shared_ptr[_PeptideHit](new _PeptideHit(deref(it)))
           replace.append(item1)
           inc(it)
        in_1[:] = replace
        del v1
        del v0
    def _getNonReferencingHits_2(self, list in_0 , list in_1 ):
        assert isinstance(in_0, list) and all(isinstance(li, ProteinHit) for li in in_0), 'arg in_0 wrong type'
        assert isinstance(in_1, list) and all(isinstance(li, PeptideHit) for li in in_1), 'arg in_1 wrong type'
        cdef libcpp_vector[_ProteinHit] * v0 = new libcpp_vector[_ProteinHit]()
        cdef ProteinHit item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        cdef libcpp_vector[_PeptideHit] * v1 = new libcpp_vector[_PeptideHit]()
        cdef PeptideHit item1
        for item1 in in_1:
           v1.push_back(deref(item1.inst.get()))
        self.inst.get().getNonReferencingHits(deref(v0), deref(v1))
        cdef replace = []
        cdef libcpp_vector[_PeptideHit].iterator it = v1.begin()
        while it != v1.end():
           item1 = PeptideHit.__new__(PeptideHit)
           item1.inst = shared_ptr[_PeptideHit](new _PeptideHit(deref(it)))
           replace.append(item1)
           inc(it)
        in_1[:] = replace
        del v1
        del v0
    def getNonReferencingHits(self, *args):
        if (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], list) and all(isinstance(li, PeptideHit) for li in args[1])):
            return self._getNonReferencingHits_0(*args)
        elif (len(args)==2) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])) and (isinstance(args[1], list) and all(isinstance(li, PeptideHit) for li in args[1])):
            return self._getNonReferencingHits_1(*args)
        elif (len(args)==2) and (isinstance(args[0], list) and all(isinstance(li, ProteinHit) for li in args[0])) and (isinstance(args[1], list) and all(isinstance(li, PeptideHit) for li in args[1])):
            return self._getNonReferencingHits_2(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getSignificanceThreshold(self):
        cdef double _r = self.inst.get().getSignificanceThreshold()
        py_result = <float>_r
        return py_result
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def getScoreType(self):
        cdef _String _r = self.inst.get().getScoreType()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, PeptideIdentification):
            return False
        cdef PeptideIdentification other_casted = other
        cdef PeptideIdentification self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class FeatureXMLFile:
    cdef shared_ptr[_FeatureXMLFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def load(self, bytes in_0 , FeatureMap in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, FeatureMap), 'arg in_1 wrong type'
    
    
        self.inst.get().load((_String(<char *>in_0)), <_FeatureMap[_Feature] &>deref(in_1.inst.get()))
    def __init__(self):
        self.inst = shared_ptr[_FeatureXMLFile](new _FeatureXMLFile())
    def store(self, bytes in_0 , FeatureMap in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, FeatureMap), 'arg in_1 wrong type'
    
    
        self.inst.get().store((_String(<char *>in_0)), <_FeatureMap[_Feature] &>deref(in_1.inst.get())) 
cdef class ProcessingAction:
    DATA_PROCESSING = 0
    CHARGE_DECONVOLUTION = 1
    DEISOTOPING = 2
    SMOOTHING = 3
    CHARGE_CALCULATION = 4
    PRECURSOR_RECALCULATION = 5
    BASELINE_REDUCTION = 6
    PEAK_PICKING = 7
    ALIGNMENT = 8
    CALIBRATION = 9
    NORMALIZATION = 10
    FILTERING = 11
    QUANTITATION = 12
    FEATURE_GROUPING = 13
    IDENTIFICATION_MAPPING = 14
    FORMAT_CONVERSION = 15
    CONVERSION_MZDATA = 16
    CONVERSION_MZML = 17
    CONVERSION_MZXML = 18
    CONVERSION_DTA = 19
    SIZE_OF_PROCESSINGACTION = 20 
cdef class DataProcessing:
    cdef shared_ptr[_DataProcessing] inst
    def __dealloc__(self):
         self.inst.reset()
    def getCompletionTime(self):
        cdef _DateTime * _r = new _DateTime(self.inst.get().getCompletionTime())
        cdef DateTime py_result = DateTime.__new__(DateTime)
        py_result.inst = shared_ptr[_DateTime](_r)
        return py_result
    def getProcessingActions(self):
        _r = self.inst.get().getProcessingActions()
        py_result = set()
        cdef libcpp_set[_ProcessingAction].iterator it__r = _r.begin()
        while it__r != _r.end():
           py_result.add(<int>deref(it__r))
           inc(it__r)
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_DataProcessing](new _DataProcessing())
    def getSoftware(self):
        cdef _Software * _r = new _Software(self.inst.get().getSoftware())
        cdef Software py_result = Software.__new__(Software)
        py_result.inst = shared_ptr[_Software](_r)
        return py_result
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setCompletionTime(self, DateTime t ):
        assert isinstance(t, DateTime), 'arg t wrong type'
    
        self.inst.get().setCompletionTime(<_DateTime>deref(t.inst.get()))
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def setProcessingActions(self, set in_0 ):
        assert isinstance(in_0, set) and all(li in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_set[_ProcessingAction] * v0 = new libcpp_set[_ProcessingAction]()
        cdef int item0
        for item0 in in_0:
           v0.insert(<_ProcessingAction> item0)
        self.inst.get().setProcessingActions(deref(v0))
        del v0
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def setSoftware(self, Software s ):
        assert isinstance(s, Software), 'arg s wrong type'
    
        self.inst.get().setSoftware(<_Software>deref(s.inst.get()))
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, DataProcessing):
            return False
        cdef DataProcessing other_casted = other
        cdef DataProcessing self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class Precursor:
    cdef shared_ptr[_Precursor] inst
    def __dealloc__(self):
         self.inst.reset()
    def _init_0(self):
        self.inst = shared_ptr[_Precursor](new _Precursor())
    def _init_1(self, Precursor in_0 ):
        assert isinstance(in_0, Precursor), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_Precursor](new _Precursor(<_Precursor>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], Precursor)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
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
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setIntensity((<float>in_0)) 
cdef class ProgressLogger:
    cdef shared_ptr[_ProgressLogger] inst
    def __dealloc__(self):
         self.inst.reset()
    def getLogType(self):
        cdef _LogType _r = self.inst.get().getLogType()
        py_result = <int>_r
        return py_result
    def startProgress(self,  begin ,  end , bytes label ):
        assert isinstance(begin, (int, long)), 'arg begin wrong type'
        assert isinstance(end, (int, long)), 'arg end wrong type'
        assert isinstance(label, bytes), 'arg label wrong type'
    
    
    
        self.inst.get().startProgress((<ptrdiff_t>begin), (<ptrdiff_t>end), (_String(<char *>label)))
    def endProgress(self):
        self.inst.get().endProgress()
    def __init__(self):
        self.inst = shared_ptr[_ProgressLogger](new _ProgressLogger())
    def setProgress(self,  value ):
        assert isinstance(value, (int, long)), 'arg value wrong type'
    
        self.inst.get().setProgress((<ptrdiff_t>value))
    def setLogType(self, int in_0 ):
        assert in_0 in [0, 1, 2], 'arg in_0 wrong type'
    
        self.inst.get().setLogType((<_LogType>in_0)) 
cdef class RichPeak1D:
    cdef shared_ptr[_RichPeak1D] inst
    def __dealloc__(self):
         self.inst.reset()
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_RichPeak1D](new _RichPeak1D())
    def getIntensity(self):
        cdef float _r = self.inst.get().getIntensity()
        py_result = <float>_r
        return py_result
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setIntensity(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setIntensity((<float>in_0))
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setMZ((<float>in_0))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, RichPeak1D):
            return False
        cdef RichPeak1D other_casted = other
        cdef RichPeak1D self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class MzXMLFile:
    cdef shared_ptr[_MzXMLFile] inst
    def __dealloc__(self):
         self.inst.reset()
    def load(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, MSExperiment), 'arg in_1 wrong type'
    
    
        self.inst.get().load((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def getLogType(self):
        cdef _LogType _r = self.inst.get().getLogType()
        py_result = <int>_r
        return py_result
    def endProgress(self):
        self.inst.get().endProgress()
    def __init__(self):
        self.inst = shared_ptr[_MzXMLFile](new _MzXMLFile())
    def setProgress(self,  value ):
        assert isinstance(value, (int, long)), 'arg value wrong type'
    
        self.inst.get().setProgress((<ptrdiff_t>value))
    def setLogType(self, int in_0 ):
        assert in_0 in [0, 1, 2], 'arg in_0 wrong type'
    
        self.inst.get().setLogType((<_LogType>in_0))
    def store(self, bytes in_0 , MSExperiment in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, MSExperiment), 'arg in_1 wrong type'
    
    
        self.inst.get().store((_String(<char *>in_0)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(in_1.inst.get()))
    def startProgress(self,  begin ,  end , bytes label ):
        assert isinstance(begin, (int, long)), 'arg begin wrong type'
        assert isinstance(end, (int, long)), 'arg end wrong type'
        assert isinstance(label, bytes), 'arg label wrong type'
    
    
    
        self.inst.get().startProgress((<ptrdiff_t>begin), (<ptrdiff_t>end), (_String(<char *>label))) 
cdef class VersionDetails:
    cdef shared_ptr[_VersionDetails] inst
    def __dealloc__(self):
         self.inst.reset()
    property version_major:
        def __set__(self,  version_major):
        
            self.inst.get().version_major = (<int>version_major)
        
        def __get__(self):
            cdef int _r = self.inst.get().version_major
            py_result = <int>_r
            return py_result
    property version_minor:
        def __set__(self,  version_minor):
        
            self.inst.get().version_minor = (<int>version_minor)
        
        def __get__(self):
            cdef int _r = self.inst.get().version_minor
            py_result = <int>_r
            return py_result
    property version_patch:
        def __set__(self,  version_patch):
        
            self.inst.get().version_patch = (<int>version_patch)
        
        def __get__(self):
            cdef int _r = self.inst.get().version_patch
            py_result = <int>_r
            return py_result
    def __init__(self):
        self.inst = shared_ptr[_VersionDetails](new _VersionDetails())
    def __richcmp__(self, other, op):
        if op not in (2, 0, 4):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, VersionDetails):
            return False
        cdef VersionDetails other_casted = other
        cdef VersionDetails self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==0:
            return deref(self_casted.inst.get()) < deref(other_casted.inst.get())
        if op==4:
            return deref(self_casted.inst.get()) > deref(other_casted.inst.get())
    create = __static_VersionDetails_create 
cdef class __SpectrumType:
    UNKNOWN = 0
    PEAKS = 1
    RAWDATA = 2
    SIZE_OF_SPECTRUMTYPE = 3 
cdef class SpectrumSettings:
    cdef shared_ptr[_SpectrumSettings] inst
    def __dealloc__(self):
         self.inst.reset()
    def __init__(self):
        self.inst = shared_ptr[_SpectrumSettings](new _SpectrumSettings())
    def setSourceFile(self, SourceFile in_0 ):
        assert isinstance(in_0, SourceFile), 'arg in_0 wrong type'
    
        self.inst.get().setSourceFile(<_SourceFile>deref(in_0.inst.get()))
    def getInstrumentSettings(self):
        cdef _InstrumentSettings * _r = new _InstrumentSettings(self.inst.get().getInstrumentSettings())
        cdef InstrumentSettings py_result = InstrumentSettings.__new__(InstrumentSettings)
        py_result.inst = shared_ptr[_InstrumentSettings](_r)
        return py_result
    def setType(self, int in_0 ):
        assert in_0 in [0, 1, 2, 3], 'arg in_0 wrong type'
    
        self.inst.get().setType((<_SpectrumType>in_0))
    def getNativeID(self):
        cdef _String _r = self.inst.get().getNativeID()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def getSourceFile(self):
        cdef _SourceFile * _r = new _SourceFile(self.inst.get().getSourceFile())
        cdef SourceFile py_result = SourceFile.__new__(SourceFile)
        py_result.inst = shared_ptr[_SourceFile](_r)
        return py_result
    def setAcquisitionInfo(self, AcquisitionInfo in_0 ):
        assert isinstance(in_0, AcquisitionInfo), 'arg in_0 wrong type'
    
        self.inst.get().setAcquisitionInfo(<_AcquisitionInfo>deref(in_0.inst.get()))
    def getAcquisitionInfo(self):
        cdef _AcquisitionInfo * _r = new _AcquisitionInfo(self.inst.get().getAcquisitionInfo())
        cdef AcquisitionInfo py_result = AcquisitionInfo.__new__(AcquisitionInfo)
        py_result.inst = shared_ptr[_AcquisitionInfo](_r)
        return py_result
    def getType(self):
        cdef int _r = self.inst.get().getType()
        py_result = <int>_r
        return py_result
    def getDataProcessing(self):
        _r = self.inst.get().getDataProcessing()
        py_result = []
        cdef libcpp_vector[_DataProcessing].iterator it__r = _r.begin()
        cdef DataProcessing item_py_result
        while it__r != _r.end():
           item_py_result = DataProcessing.__new__(DataProcessing)
           item_py_result.inst = shared_ptr[_DataProcessing](new _DataProcessing(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def setPeptideIdentifications(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, PeptideIdentification) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_PeptideIdentification] * v0 = new libcpp_vector[_PeptideIdentification]()
        cdef PeptideIdentification item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setPeptideIdentifications(deref(v0))
        del v0
    def setProducts(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, Product) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_Product] * v0 = new libcpp_vector[_Product]()
        cdef Product item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setProducts(deref(v0))
        del v0
    def setDataProcessing(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, DataProcessing) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_DataProcessing] * v0 = new libcpp_vector[_DataProcessing]()
        cdef DataProcessing item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setDataProcessing(deref(v0))
        del v0
    def getComment(self):
        cdef _String _r = self.inst.get().getComment()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def setInstrumentSettings(self, InstrumentSettings in_0 ):
        assert isinstance(in_0, InstrumentSettings), 'arg in_0 wrong type'
    
        self.inst.get().setInstrumentSettings(<_InstrumentSettings>deref(in_0.inst.get()))
    def unify(self, SpectrumSettings in_0 ):
        assert isinstance(in_0, SpectrumSettings), 'arg in_0 wrong type'
    
        self.inst.get().unify(<_SpectrumSettings>deref(in_0.inst.get()))
    def getPeptideIdentifications(self):
        _r = self.inst.get().getPeptideIdentifications()
        py_result = []
        cdef libcpp_vector[_PeptideIdentification].iterator it__r = _r.begin()
        cdef PeptideIdentification item_py_result
        while it__r != _r.end():
           item_py_result = PeptideIdentification.__new__(PeptideIdentification)
           item_py_result.inst = shared_ptr[_PeptideIdentification](new _PeptideIdentification(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def setComment(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setComment((_String(<char *>in_0)))
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
    def setNativeID(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setNativeID((_String(<char *>in_0)))
    def getProducts(self):
        _r = self.inst.get().getProducts()
        py_result = []
        cdef libcpp_vector[_Product].iterator it__r = _r.begin()
        cdef Product item_py_result
        while it__r != _r.end():
           item_py_result = Product.__new__(Product)
           item_py_result.inst = shared_ptr[_Product](new _Product(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def setPrecursors(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, Precursor) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_Precursor] * v0 = new libcpp_vector[_Precursor]()
        cdef Precursor item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setPrecursors(deref(v0))
        del v0
    SpectrumType = __SpectrumType 
cdef class TransformationModelLinear:
    cdef shared_ptr[_TransformationModelLinear] inst
    def __dealloc__(self):
         self.inst.reset()
    def getParameters(self, Param in_0 ):
        assert isinstance(in_0, Param), 'arg in_0 wrong type'
    
        self.inst.get().getParameters(<_Param &>deref(in_0.inst.get()))
    getDefaultParameters = __static_TransformationModelLinear_getDefaultParameters 
cdef class Software:
    cdef shared_ptr[_Software] inst
    def __dealloc__(self):
         self.inst.reset()
    def setVersion(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setVersion((_String(<char *>in_0)))
    def getName(self):
        cdef _String _r = self.inst.get().getName()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def getVersion(self):
        cdef _String _r = self.inst.get().getVersion()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def setName(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setName((_String(<char *>in_0)))
    def __init__(self):
        self.inst = shared_ptr[_Software](new _Software()) 
cdef class PeptideHit:
    cdef shared_ptr[_PeptideHit] inst
    def __dealloc__(self):
         self.inst.reset()
    def getSequence(self):
        cdef _AASequence * _r = new _AASequence(self.inst.get().getSequence())
        cdef AASequence py_result = AASequence.__new__(AASequence)
        py_result.inst = shared_ptr[_AASequence](_r)
        return py_result
    def getProteinAccessions(self):
        _r = self.inst.get().getProteinAccessions()
        py_result = []
        cdef libcpp_vector[_String].iterator it__r = _r.begin()
        while it__r != _r.end():
           py_result.append(<char*>deref(it__r).c_str())
           inc(it__r)
        return py_result
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getScore(self):
        cdef float _r = self.inst.get().getScore()
        py_result = <float>_r
        return py_result
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setCharge(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().setCharge((<int>in_0))
    def setAAAfter(self, bytes in_0 ):
        assert isinstance(in_0, bytes) and len(in_0) == 1, 'arg in_0 wrong type'
    
        self.inst.get().setAAAfter((<char>((in_0)[0])))
    def setAABefore(self, bytes in_0 ):
        assert isinstance(in_0, bytes) and len(in_0) == 1, 'arg in_0 wrong type'
    
        self.inst.get().setAABefore((<char>((in_0)[0])))
    def getRank(self):
        cdef unsigned int _r = self.inst.get().getRank()
        py_result = <int>_r
        return py_result
    def setScore(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setScore((<float>in_0))
    def getAAAfter(self):
        cdef char  _r = self.inst.get().getAAAfter()
        py_result = chr(<char>(_r))
        return py_result
    def getAABefore(self):
        cdef char  _r = self.inst.get().getAABefore()
        py_result = chr(<char>(_r))
        return py_result
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def setProteinAccessions(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(i, bytes) for i in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_String] * v0 = new libcpp_vector[_String]()
        cdef bytes item0
        for item0 in in_0:
           v0.push_back(_String(<char *>item0))
        self.inst.get().setProteinAccessions(deref(v0))
        del v0
    def _init_0(self):
        self.inst = shared_ptr[_PeptideHit](new _PeptideHit())
    def _init_1(self, float score ,  rank ,  charge , AASequence sequence ):
        assert isinstance(score, float), 'arg score wrong type'
        assert isinstance(rank, (int, long)), 'arg rank wrong type'
        assert isinstance(charge, (int, long)), 'arg charge wrong type'
        assert isinstance(sequence, AASequence), 'arg sequence wrong type'
    
    
    
    
        self.inst = shared_ptr[_PeptideHit](new _PeptideHit((<float>score), (<int>rank), (<int>charge), <_AASequence>deref(sequence.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==4) and (isinstance(args[0], float)) and (isinstance(args[1], (int, long))) and (isinstance(args[2], (int, long))) and (isinstance(args[3], AASequence)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setSequence(self, AASequence in_0 ):
        assert isinstance(in_0, AASequence), 'arg in_0 wrong type'
    
        self.inst.get().setSequence(<_AASequence>deref(in_0.inst.get()))
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setRank(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().setRank((<int>in_0))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def addProteinAccession(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().addProteinAccession((_String(<char *>in_0)))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, PeptideHit):
            return False
        cdef PeptideHit other_casted = other
        cdef PeptideHit self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class MapAlignmentAlgorithmPoseClustering:
    cdef shared_ptr[_MapAlignmentAlgorithmPoseClustering] inst
    def __dealloc__(self):
         self.inst.reset()
    def setParameters(self, Param param ):
        assert isinstance(param, Param), 'arg param wrong type'
    
        self.inst.get().setParameters(<_Param &>deref(param.inst.get()))
    def __init__(self):
        self.inst = shared_ptr[_MapAlignmentAlgorithmPoseClustering](new _MapAlignmentAlgorithmPoseClustering())
    def setReference(self,  in_0 , bytes in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, bytes), 'arg in_1 wrong type'
    
    
        self.inst.get().setReference((<int>in_0), (_String(<char *>in_1)))
    def setName(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setName((_String(<char *>in_0)))
    def getDefaults(self):
        cdef _Param * _r = new _Param(self.inst.get().getDefaults())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    def getName(self):
        cdef _String _r = self.inst.get().getName()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def fitModel(self, bytes model_type , Param p , list in_2 ):
        assert isinstance(model_type, bytes), 'arg model_type wrong type'
        assert isinstance(p, Param), 'arg p wrong type'
        assert isinstance(in_2, list) and all(isinstance(li, TransformationDescription) for li in in_2), 'arg in_2 wrong type'
    
    
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
        assert isinstance(in_0, list) and all(isinstance(li, FeatureMap) for li in in_0), 'arg in_0 wrong type'
        assert isinstance(in_1, list) and all(isinstance(li, TransformationDescription) for li in in_1), 'arg in_1 wrong type'
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
    def alignPeakMaps(self, list in_0 , list in_1 ):
        assert isinstance(in_0, list) and all(isinstance(li, MSExperiment) for li in in_0), 'arg in_0 wrong type'
        assert isinstance(in_1, list) and all(isinstance(li, TransformationDescription) for li in in_1), 'arg in_1 wrong type'
        cdef libcpp_vector[_MSExperiment[_Peak1D,_ChromatogramPeak]] * v0 = new libcpp_vector[_MSExperiment[_Peak1D,_ChromatogramPeak]]()
        cdef MSExperiment item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        cdef libcpp_vector[_TransformationDescription] * v1 = new libcpp_vector[_TransformationDescription]()
        cdef TransformationDescription item1
        for item1 in in_1:
           v1.push_back(deref(item1.inst.get()))
        self.inst.get().alignPeakMaps(deref(v0), deref(v1))
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
    def getParameters(self):
        cdef _Param * _r = new _Param(self.inst.get().getParameters())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    transformFeatureMaps = __static_MapAlignmentAlgorithmPoseClustering_transformFeatureMaps
    transformPeakMaps = __static_MapAlignmentAlgorithmPoseClustering_transformPeakMaps 
cdef class MSSpectrum:
    cdef shared_ptr[_MSSpectrum[_Peak1D]] inst
    def __dealloc__(self):
         self.inst.reset()
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def getRT(self):
        cdef double _r = self.inst.get().getRT()
        py_result = <float>_r
        return py_result
    def setSourceFile(self, SourceFile in_0 ):
        assert isinstance(in_0, SourceFile), 'arg in_0 wrong type'
    
        self.inst.get().setSourceFile(<_SourceFile>deref(in_0.inst.get()))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setComment(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setComment((_String(<char *>in_0)))
    def updateRanges(self):
        self.inst.get().updateRanges()
    def push_back(self, Peak1D in_0 ):
        assert isinstance(in_0, Peak1D), 'arg in_0 wrong type'
    
        self.inst.get().push_back(<_Peak1D>deref(in_0.inst.get()))
    def getMSLevel(self):
        cdef unsigned int _r = self.inst.get().getMSLevel()
        py_result = <int>_r
        return py_result
    def setMSLevel(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().setMSLevel((<int>in_0))
    def findNearest(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        cdef int _r = self.inst.get().findNearest((<float>in_0))
        py_result = <int>_r
        return py_result
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result
    def setRT(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setRT((<float>in_0))
    def getName(self):
        cdef libcpp_string _r = self.inst.get().getName()
        py_result = <libcpp_string>_r
        return py_result
    def getNativeID(self):
        cdef _String _r = self.inst.get().getNativeID()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def getSourceFile(self):
        cdef _SourceFile * _r = new _SourceFile(self.inst.get().getSourceFile())
        cdef SourceFile py_result = SourceFile.__new__(SourceFile)
        py_result.inst = shared_ptr[_SourceFile](_r)
        return py_result
    def setAcquisitionInfo(self, AcquisitionInfo in_0 ):
        assert isinstance(in_0, AcquisitionInfo), 'arg in_0 wrong type'
    
        self.inst.get().setAcquisitionInfo(<_AcquisitionInfo>deref(in_0.inst.get()))
    def getAcquisitionInfo(self):
        cdef _AcquisitionInfo * _r = new _AcquisitionInfo(self.inst.get().getAcquisitionInfo())
        cdef AcquisitionInfo py_result = AcquisitionInfo.__new__(AcquisitionInfo)
        py_result.inst = shared_ptr[_AcquisitionInfo](_r)
        return py_result
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setName(self, str in_0 ):
        assert isinstance(in_0, str), 'arg in_0 wrong type'
    
        self.inst.get().setName((<libcpp_string>in_0))
    def getType(self):
        cdef int _r = self.inst.get().getType()
        py_result = <int>_r
        return py_result
    def getDataProcessing(self):
        _r = self.inst.get().getDataProcessing()
        py_result = []
        cdef libcpp_vector[_DataProcessing].iterator it__r = _r.begin()
        cdef DataProcessing item_py_result
        while it__r != _r.end():
           item_py_result = DataProcessing.__new__(DataProcessing)
           item_py_result.inst = shared_ptr[_DataProcessing](new _DataProcessing(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def setPeptideIdentifications(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, PeptideIdentification) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_PeptideIdentification] * v0 = new libcpp_vector[_PeptideIdentification]()
        cdef PeptideIdentification item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setPeptideIdentifications(deref(v0))
        del v0
    def __getitem__(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _Peak1D * _r = new _Peak1D(deref(self.inst.get())[(<int>in_0)])
        cdef Peak1D py_result = Peak1D.__new__(Peak1D)
        py_result.inst = shared_ptr[_Peak1D](_r)
        return py_result
    def setProducts(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, Product) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_Product] * v0 = new libcpp_vector[_Product]()
        cdef Product item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setProducts(deref(v0))
        del v0
    def setDataProcessing(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, DataProcessing) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_DataProcessing] * v0 = new libcpp_vector[_DataProcessing]()
        cdef DataProcessing item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setDataProcessing(deref(v0))
        del v0
    def getComment(self):
        cdef _String _r = self.inst.get().getComment()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def setInstrumentSettings(self, InstrumentSettings in_0 ):
        assert isinstance(in_0, InstrumentSettings), 'arg in_0 wrong type'
    
        self.inst.get().setInstrumentSettings(<_InstrumentSettings>deref(in_0.inst.get()))
    def _init_0(self):
        self.inst = shared_ptr[_MSSpectrum[_Peak1D]](new _MSSpectrum[_Peak1D]())
    def _init_1(self, MSSpectrum in_0 ):
        assert isinstance(in_0, MSSpectrum), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_MSSpectrum[_Peak1D]](new _MSSpectrum[_Peak1D](<_MSSpectrum[_Peak1D]>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], MSSpectrum)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def unify(self, SpectrumSettings in_0 ):
        assert isinstance(in_0, SpectrumSettings), 'arg in_0 wrong type'
    
        self.inst.get().unify(<_SpectrumSettings>deref(in_0.inst.get()))
    def setType(self, int in_0 ):
        assert in_0 in [0, 1, 2, 3], 'arg in_0 wrong type'
    
        self.inst.get().setType((<_SpectrumType>in_0))
    def getPeptideIdentifications(self):
        _r = self.inst.get().getPeptideIdentifications()
        py_result = []
        cdef libcpp_vector[_PeptideIdentification].iterator it__r = _r.begin()
        cdef PeptideIdentification item_py_result
        while it__r != _r.end():
           item_py_result = PeptideIdentification.__new__(PeptideIdentification)
           item_py_result.inst = shared_ptr[_PeptideIdentification](new _PeptideIdentification(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def setNativeID(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setNativeID((_String(<char *>in_0)))
    def clear(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().clear((<int>in_0))
    def getInstrumentSettings(self):
        cdef _InstrumentSettings * _r = new _InstrumentSettings(self.inst.get().getInstrumentSettings())
        cdef InstrumentSettings py_result = InstrumentSettings.__new__(InstrumentSettings)
        py_result.inst = shared_ptr[_InstrumentSettings](_r)
        return py_result
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
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
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def getProducts(self):
        _r = self.inst.get().getProducts()
        py_result = []
        cdef libcpp_vector[_Product].iterator it__r = _r.begin()
        cdef Product item_py_result
        while it__r != _r.end():
           item_py_result = Product.__new__(Product)
           item_py_result.inst = shared_ptr[_Product](new _Product(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def setPrecursors(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, Precursor) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_Precursor] * v0 = new libcpp_vector[_Precursor]()
        cdef Precursor item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setPrecursors(deref(v0))
        del v0
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, MSSpectrum):
            return False
        cdef MSSpectrum other_casted = other
        cdef MSSpectrum self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get())
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
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setIntensity((<float>in_0))
    def setMZ(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        self.inst.get().setMZ((<float>in_0))
    def getMZ(self):
        cdef double _r = self.inst.get().getMZ()
        py_result = <float>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, Peak1D):
            return False
        cdef Peak1D other_casted = other
        cdef Peak1D self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
cdef class TransformationDescription:
    cdef shared_ptr[_TransformationDescription] inst
    def __dealloc__(self):
         self.inst.reset()
    def apply(self, float in_0 ):
        assert isinstance(in_0, float), 'arg in_0 wrong type'
    
        cdef double _r = self.inst.get().apply((<float>in_0))
        py_result = <float>_r
        return py_result
    def getDataPoints(self):
        _r = self.inst.get().getDataPoints()
        cdef list py_result = _r
        return py_result
    def _init_0(self):
        self.inst = shared_ptr[_TransformationDescription](new _TransformationDescription())
    def _init_1(self, TransformationDescription in_0 ):
        assert isinstance(in_0, TransformationDescription), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_TransformationDescription](new _TransformationDescription(<_TransformationDescription>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], TransformationDescription)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,)) 
cdef class InstrumentSettings:
    cdef shared_ptr[_InstrumentSettings] inst
    def __dealloc__(self):
         self.inst.reset()
    def isMetaEmpty(self):
        cdef bool _r = self.inst.get().isMetaEmpty()
        py_result = <bool>_r
        return py_result
    def _setMetaValue_0(self,  in_0 , DataValue in_1 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((<int>in_0), <_DataValue>deref(in_1.inst.get()))
    def _setMetaValue_1(self, bytes in_0 , DataValue in_1 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
        assert isinstance(in_1, DataValue), 'arg in_1 wrong type'
    
    
        self.inst.get().setMetaValue((_String(<char *>in_0)), <_DataValue>deref(in_1.inst.get()))
    def setMetaValue(self, *args):
        if (len(args)==2) and (isinstance(args[0], (int, long))) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_0(*args)
        elif (len(args)==2) and (isinstance(args[0], bytes)) and (isinstance(args[1], DataValue)):
            return self._setMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def setPolarity(self, int in_0 ):
        assert in_0 in [0, 1, 2, 3], 'arg in_0 wrong type'
    
        self.inst.get().setPolarity((<_Polarity>in_0))
    def _init_0(self):
        self.inst = shared_ptr[_InstrumentSettings](new _InstrumentSettings())
    def _init_1(self, InstrumentSettings in_0 ):
        assert isinstance(in_0, InstrumentSettings), 'arg in_0 wrong type'
    
        self.inst = shared_ptr[_InstrumentSettings](new _InstrumentSettings(<_InstrumentSettings>deref(in_0.inst.get())))
    def __init__(self, *args):
        if not args:
             self._init_0(*args)
        elif (len(args)==1) and (isinstance(args[0], InstrumentSettings)):
             self._init_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _metaValueExists_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((_String(<char *>in_0)))
        py_result = <bool>_r
        return py_result
    def _metaValueExists_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef bool _r = self.inst.get().metaValueExists((<int>in_0))
        py_result = <bool>_r
        return py_result
    def metaValueExists(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._metaValueExists_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._metaValueExists_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getMetaValue_0(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((<int>in_0)))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def _getMetaValue_1(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        cdef _DataValue * _r = new _DataValue(self.inst.get().getMetaValue((_String(<char *>in_0))))
        cdef DataValue py_result = DataValue.__new__(DataValue)
        py_result.inst = shared_ptr[_DataValue](_r)
        return py_result
    def getMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._getMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], bytes)):
            return self._getMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _getKeys_0(self, list keys ):
        assert isinstance(keys, list) and all(isinstance(i, bytes) for i in keys), 'arg keys wrong type'
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
        assert isinstance(keys, list) and all(isinstance(li, (int, long)) for li in keys), 'arg keys wrong type'
        cdef libcpp_vector[unsigned int] v0 = keys
        self.inst.get().getKeys(v0)
        keys[:] = v0
    def getKeys(self, *args):
        if (len(args)==1) and (isinstance(args[0], list) and all(isinstance(i, bytes) for i in args[0])):
            return self._getKeys_0(*args)
        elif (len(args)==1) and (isinstance(args[0], list) and all(isinstance(li, (int, long)) for li in args[0])):
            return self._getKeys_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def _removeMetaValue_0(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((_String(<char *>in_0)))
    def _removeMetaValue_1(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        self.inst.get().removeMetaValue((<int>in_0))
    def removeMetaValue(self, *args):
        if (len(args)==1) and (isinstance(args[0], bytes)):
            return self._removeMetaValue_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._removeMetaValue_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def clearMetaInfo(self):
        self.inst.get().clearMetaInfo()
    def getPolarity(self):
        cdef _Polarity _r = self.inst.get().getPolarity()
        py_result = <int>_r
        return py_result
    def __richcmp__(self, other, op):
        if op not in (2, 3):
           op_str = {0: '<', 1: '<=', 2: '==', 3: '!=', 4: '>', 5: '>='}[op]
           raise Exception("comparions operator %s not implemented" % op_str)
        if not isinstance(other, InstrumentSettings):
            return False
        cdef InstrumentSettings other_casted = other
        cdef InstrumentSettings self_casted = self
        if op==2:
            return deref(self_casted.inst.get()) == deref(other_casted.inst.get())
        if op==3:
            return deref(self_casted.inst.get()) != deref(other_casted.inst.get()) 
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
    def setUnassignedPeptideIdentifications(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, PeptideIdentification) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_PeptideIdentification] * v0 = new libcpp_vector[_PeptideIdentification]()
        cdef PeptideIdentification item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setUnassignedPeptideIdentifications(deref(v0))
        del v0
    def sortByMZ(self):
        self.inst.get().sortByMZ()
    def hasValidUniqueId(self):
        cdef size_t _r = self.inst.get().hasValidUniqueId()
        py_result = <size_t>_r
        return py_result
    def updateRanges(self):
        self.inst.get().updateRanges()
    def __add__(FeatureMap self, FeatureMap other not None):
        cdef _FeatureMap[_Feature]  * this = self.inst.get()
        cdef _FeatureMap[_Feature] * that = other.inst.get()
        cdef _FeatureMap[_Feature] added = deref(this) + deref(that)
        cdef FeatureMap result = FeatureMap.__new__(FeatureMap)
        result.inst = shared_ptr[_FeatureMap[_Feature]](new _FeatureMap[_Feature](added))
        return result
    def setProteinIdentifications(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, ProteinIdentification) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_ProteinIdentification] * v0 = new libcpp_vector[_ProteinIdentification]()
        cdef ProteinIdentification item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setProteinIdentifications(deref(v0))
        del v0
    def _sortByIntensity_0(self):
        self.inst.get().sortByIntensity()
    def _sortByIntensity_1(self,  reverse ):
        assert isinstance(reverse, (int, long)), 'arg reverse wrong type'
    
        self.inst.get().sortByIntensity((<bool>reverse))
    def sortByIntensity(self, *args):
        if not args:
            return self._sortByIntensity_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._sortByIntensity_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def size(self):
        cdef int _r = self.inst.get().size()
        py_result = <int>_r
        return py_result
    def getUniqueId(self):
        cdef size_t _r = self.inst.get().getUniqueId()
        py_result = <size_t>_r
        return py_result
    def sortByPosition(self):
        self.inst.get().sortByPosition()
    def __iadd__(FeatureMap self, FeatureMap other not None):
        cdef _FeatureMap[_Feature] * this = self.inst.get()
        cdef _FeatureMap[_Feature] * that = other.inst.get()
        _iadd(this, that)
        return self
    def sortByOverallQuality(self):
        self.inst.get().sortByOverallQuality()
    def hasInvalidUniqueId(self):
        cdef size_t _r = self.inst.get().hasInvalidUniqueId()
        py_result = <size_t>_r
        return py_result
    def swap(self, FeatureMap in_0 ):
        assert isinstance(in_0, FeatureMap), 'arg in_0 wrong type'
    
        self.inst.get().swap(<_FeatureMap[_Feature] &>deref(in_0.inst.get()))
    def clearUniqueId(self):
        cdef size_t _r = self.inst.get().clearUniqueId()
        py_result = <size_t>_r
        return py_result
    def getUnassignedPeptideIdentifications(self):
        _r = self.inst.get().getUnassignedPeptideIdentifications()
        py_result = []
        cdef libcpp_vector[_PeptideIdentification].iterator it__r = _r.begin()
        cdef PeptideIdentification item_py_result
        while it__r != _r.end():
           item_py_result = PeptideIdentification.__new__(PeptideIdentification)
           item_py_result.inst = shared_ptr[_PeptideIdentification](new _PeptideIdentification(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def getDataProcessing(self):
        _r = self.inst.get().getDataProcessing()
        py_result = []
        cdef libcpp_vector[_DataProcessing].iterator it__r = _r.begin()
        cdef DataProcessing item_py_result
        while it__r != _r.end():
           item_py_result = DataProcessing.__new__(DataProcessing)
           item_py_result.inst = shared_ptr[_DataProcessing](new _DataProcessing(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    def setUniqueId(self,  rhs ):
        assert isinstance(rhs, (int, long)), 'arg rhs wrong type'
    
        self.inst.get().setUniqueId((<int>rhs))
    def __getitem__(self,  in_0 ):
        assert isinstance(in_0, (int, long)), 'arg in_0 wrong type'
    
        cdef _Feature * _r = new _Feature(deref(self.inst.get())[(<int>in_0)])
        cdef Feature py_result = Feature.__new__(Feature)
        py_result.inst = shared_ptr[_Feature](_r)
        return py_result
    def setDataProcessing(self, list in_0 ):
        assert isinstance(in_0, list) and all(isinstance(li, DataProcessing) for li in in_0), 'arg in_0 wrong type'
        cdef libcpp_vector[_DataProcessing] * v0 = new libcpp_vector[_DataProcessing]()
        cdef DataProcessing item0
        for item0 in in_0:
           v0.push_back(deref(item0.inst.get()))
        self.inst.get().setDataProcessing(deref(v0))
        del v0
    def sortByRT(self):
        self.inst.get().sortByRT()
    def _clear_0(self):
        self.inst.get().clear()
    def _clear_1(self,  clear_meta_data ):
        assert isinstance(clear_meta_data, (int, long)), 'arg clear_meta_data wrong type'
    
        self.inst.get().clear((<bool>clear_meta_data))
    def clear(self, *args):
        if not args:
            return self._clear_0(*args)
        elif (len(args)==1) and (isinstance(args[0], (int, long))):
            return self._clear_1(*args)
        else:
               raise Exception('can not handle type of %s' % (args,))
    def ensureUniqueId(self):
        cdef size_t _r = self.inst.get().ensureUniqueId()
        py_result = <size_t>_r
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_FeatureMap[_Feature]](new _FeatureMap[_Feature]())
    def push_back(self, Feature spec ):
        assert isinstance(spec, Feature), 'arg spec wrong type'
    
        self.inst.get().push_back(<_Feature>deref(spec.inst.get()))
    def getProteinIdentifications(self):
        _r = self.inst.get().getProteinIdentifications()
        py_result = []
        cdef libcpp_vector[_ProteinIdentification].iterator it__r = _r.begin()
        cdef ProteinIdentification item_py_result
        while it__r != _r.end():
           item_py_result = ProteinIdentification.__new__(ProteinIdentification)
           item_py_result.inst = shared_ptr[_ProteinIdentification](new _ProteinIdentification(deref(it__r)))
           py_result.append(item_py_result)
           inc(it__r)
        return py_result
    # the following empty line is important

    def setUniqueIds(self):
        self.inst.get().applyMemberFunction(address(_setUniqueId)) 
cdef class TransformationModelInterpolated:
    cdef shared_ptr[_TransformationModelInterpolated] inst
    def __dealloc__(self):
         self.inst.reset()
    def getParameters(self, Param in_0 ):
        assert isinstance(in_0, Param), 'arg in_0 wrong type'
    
        self.inst.get().getParameters(<_Param &>deref(in_0.inst.get()))
    getDefaultParameters = __static_TransformationModelInterpolated_getDefaultParameters 
cdef class PeakPickerHiRes:
    cdef shared_ptr[_PeakPickerHiRes] inst
    def __dealloc__(self):
         self.inst.reset()
    def getLogType(self):
        cdef _LogType _r = self.inst.get().getLogType()
        py_result = <int>_r
        return py_result
    def setParameters(self, Param param ):
        assert isinstance(param, Param), 'arg param wrong type'
    
        self.inst.get().setParameters(<_Param &>deref(param.inst.get()))
    def endProgress(self):
        self.inst.get().endProgress()
    def setName(self, bytes in_0 ):
        assert isinstance(in_0, bytes), 'arg in_0 wrong type'
    
        self.inst.get().setName((_String(<char *>in_0)))
    def getDefaults(self):
        cdef _Param * _r = new _Param(self.inst.get().getDefaults())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    def getName(self):
        cdef _String _r = self.inst.get().getName()
        py_result = _cast_const_away(<char*>_r.c_str())
        return py_result
    def __init__(self):
        self.inst = shared_ptr[_PeakPickerHiRes](new _PeakPickerHiRes())
    def setLogType(self, int in_0 ):
        assert in_0 in [0, 1, 2], 'arg in_0 wrong type'
    
        self.inst.get().setLogType((<_LogType>in_0))
    def pick(self, MSSpectrum input , MSSpectrum output ):
        assert isinstance(input, MSSpectrum), 'arg input wrong type'
        assert isinstance(output, MSSpectrum), 'arg output wrong type'
    
    
        self.inst.get().pick(<_MSSpectrum[_Peak1D] &>deref(input.inst.get()), <_MSSpectrum[_Peak1D] &>deref(output.inst.get()))
    def setProgress(self,  value ):
        assert isinstance(value, (int, long)), 'arg value wrong type'
    
        self.inst.get().setProgress((<ptrdiff_t>value))
    def pickExperiment(self, MSExperiment input , MSExperiment output ):
        assert isinstance(input, MSExperiment), 'arg input wrong type'
        assert isinstance(output, MSExperiment), 'arg output wrong type'
    
    
        self.inst.get().pickExperiment(<_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(input.inst.get()), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(output.inst.get()))
    def getParameters(self):
        cdef _Param * _r = new _Param(self.inst.get().getParameters())
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result
    def startProgress(self,  begin ,  end , bytes label ):
        assert isinstance(begin, (int, long)), 'arg begin wrong type'
        assert isinstance(end, (int, long)), 'arg end wrong type'
        assert isinstance(label, bytes), 'arg label wrong type'
    
    
    
        self.inst.get().startProgress((<ptrdiff_t>begin), (<ptrdiff_t>end), (_String(<char *>label))) 
cdef class FeatureFinder:
    cdef shared_ptr[_FeatureFinder] inst
    def __dealloc__(self):
         self.inst.reset()
    def getLogType(self):
        cdef _LogType _r = self.inst.get().getLogType()
        py_result = <int>_r
        return py_result
    def startProgress(self,  begin ,  end , bytes label ):
        assert isinstance(begin, (int, long)), 'arg begin wrong type'
        assert isinstance(end, (int, long)), 'arg end wrong type'
        assert isinstance(label, bytes), 'arg label wrong type'
    
    
    
        self.inst.get().startProgress((<ptrdiff_t>begin), (<ptrdiff_t>end), (_String(<char *>label)))
    def run(self, bytes algorithm_name , MSExperiment input_map , FeatureMap feats , Param param , FeatureMap seeds ):
        assert isinstance(algorithm_name, bytes), 'arg algorithm_name wrong type'
        assert isinstance(input_map, MSExperiment), 'arg input_map wrong type'
        assert isinstance(feats, FeatureMap), 'arg feats wrong type'
        assert isinstance(param, Param), 'arg param wrong type'
        assert isinstance(seeds, FeatureMap), 'arg seeds wrong type'
    
    
    
    
    
        self.inst.get().run((_String(<char *>algorithm_name)), <_MSExperiment[_Peak1D,_ChromatogramPeak] &>deref(input_map.inst.get()), <_FeatureMap[_Feature] &>deref(feats.inst.get()), <_Param &>deref(param.inst.get()), <_FeatureMap[_Feature] &>deref(seeds.inst.get()))
    def endProgress(self):
        self.inst.get().endProgress()
    def setProgress(self,  value ):
        assert isinstance(value, (int, long)), 'arg value wrong type'
    
        self.inst.get().setProgress((<ptrdiff_t>value))
    def __init__(self):
        self.inst = shared_ptr[_FeatureFinder](new _FeatureFinder())
    def setLogType(self, int in_0 ):
        assert in_0 in [0, 1, 2], 'arg in_0 wrong type'
    
        self.inst.get().setLogType((<_LogType>in_0))
    def getParameters(self, bytes algorithm_name ):
        assert isinstance(algorithm_name, bytes), 'arg algorithm_name wrong type'
    
        cdef _Param * _r = new _Param(self.inst.get().getParameters((_String(<char *>algorithm_name))))
        cdef Param py_result = Param.__new__(Param)
        py_result.inst = shared_ptr[_Param](_r)
        return py_result 
cdef class TransformationModelBSpline:
    cdef shared_ptr[_TransformationModelBSpline] inst
    def __dealloc__(self):
         self.inst.reset()
    def getParameters(self, Param in_0 ):
        assert isinstance(in_0, Param), 'arg in_0 wrong type'
    
        self.inst.get().getParameters(<_Param &>deref(in_0.inst.get()))
    getDefaultParameters = __static_TransformationModelBSpline_getDefaultParameters 
cdef class VersionInfo:
    cdef shared_ptr[_VersionInfo] inst
    def __dealloc__(self):
         self.inst.reset()
    getRevision = __static_VersionInfo_getRevision
    getTime = __static_VersionInfo_getTime
    getVersion = __static_VersionInfo_getVersion 

