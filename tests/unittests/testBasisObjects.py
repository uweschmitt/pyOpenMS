import unittest
from pyOpenMS import *
from   nose.tools import *

class TestBasisObjects(unittest.TestCase):


    def test_Spectrum(self):

        """
        @tests:
        MSSpectrum.__init__
        .size
        .getRT
        .setRT
        .getMSLevel
        .setMSLevel
        .getPrecursors
        .setPrecursors
        .clear
        .push_back

        Precursor.getMZ
        .setMZ
        .setIntensity
        .setIntensity

        Peak1D.__init__
        .setMZ
        .getMZ
        .setIntensity
        .getIntensity
                          
        @end 
        """
        spec = MSSpectrum()
        assert  spec.size() == 0

        spec.setRT(1.0)
        assert_almost_equal(spec.getRT(),1.0)

        spec.setMSLevel(3)
        assert spec.getMSLevel() == 3

        ex = None
        try:
            spec.setMSLevel(-1)
        except Exception ,e:
            ex = e
        assert ex is not None

        pc0 = Precursor()
        pc0.setMZ(16.0)
        pc0.setIntensity(256.0)

        pc1 = Precursor()
        pc1.setMZ(32.0)
        pc1.setIntensity(128.0)
        
        spec.setPrecursors([pc0, pc1])

        pcs = spec.getPrecursors()
        eq_(len(pcs), 2)
        assert pcs[0].getMZ() == pc0.getMZ()
        assert pcs[1].getMZ() == pc1.getMZ()
        assert pcs[0].getIntensity() == pc0.getIntensity()
        assert pcs[1].getIntensity() == pc1.getIntensity()

        peak = Peak1D()
        peak.setMZ(1.25)
        peak.setIntensity(123.0)

        spec = MSSpectrum()
        spec.push_back(peak)
        assert spec.size() == 1
        assert spec[0].getMZ() == 1.25
        assert spec[0].getIntensity() == 123.0

        spec.clear(False)
        assert spec.size() == 0
        



    def test_Peak1D(self):
        """
        @tests:
        Peak1D.__init__
              .setMZ
              .getMZ
              .setIntensity
              .getIntensity
        """
        peak = Peak1D()

        peak.setMZ(1.0)
        assert_almost_equal(peak.getMZ(),1.0)

        peak.setIntensity(4.0)
        assert_almost_equal(peak.getIntensity(), 4.0)

    def test_Precursor(self):
        """
        @tests:
        Precursor.__init__
                 .setMZ
                 .getMZ
                 .setIntensity
                 .getIntensity
        """
        pc = Precursor()

        pc.setMZ(1.0)
        assert_almost_equal(pc.getMZ(),1.0)

        pc.setIntensity(4.0)
        assert_almost_equal(pc.getIntensity(), 4.0)

    def test_InstrumentSettings(self):
        """
        @tests:
        InstrumentSettings.__init__
        .getPolarity
        .setPolarity
        Polarity.POLNULL
        Polarity.POSITIVE
        Polarity.NEGATIVE
        Polarity.SIZE_OF_POLARITY
        """
        is_ = InstrumentSettings()
        for e in [ Polarity.POLNULL,
                   Polarity.POSITIVE,
                   Polarity.NEGATIVE,
                   Polarity.SIZE_OF_POLARITY,]:

            is_.setPolarity(e)
            assert is_.getPolarity() == e

    def test_SourceFile(self):
        """
        @tests:
         SourceFile.__init__
         SourceFile.getFileSize
         .getFileType
         .getChecksum
         .getChecksumType
         .getNameOfFile
         .getPathToFile
         .getNativeIDType
         .setFileSize
         .setFileType
         .setChecksum
         .setNameOfFile
         .setPathToFile
         .setNativeIDType

        ChecksumType.SHA1
        .MD5
        .UNKNOWN_CHECKSUM
        .SIZE_OF_CHECKSUMTYPE

        MSSpectrum.__init__
        .setSourceFile
        .getSourceFile

        @end
        """
        sf = SourceFile()
        sf.setFileSize(123)
        sf.setFileType("test type")
        sf.setChecksum("0x123", ChecksumType.SHA1)
        sf.setNameOfFile("test.mzXML")
        sf.setPathToFile("./test.mzXML")
        sf.setNativeIDType("scan=")

        assert sf.getFileSize()  == 123
        assert sf.getFileType()  == "test type"
        assert sf.getChecksum()  == "0x123"
        assert sf.getChecksumType() == ChecksumType.SHA1
        assert sf.getNameOfFile()  == "test.mzXML"
        assert sf.getPathToFile()  == "./test.mzXML"
        assert sf.getNativeIDType()  == "scan="

        assert ChecksumType.SHA1 > -1
        assert ChecksumType.MD5 > -1
        assert ChecksumType.UNKNOWN_CHECKSUM > -1
        assert ChecksumType.SIZE_OF_CHECKSUMTYPE > -1

        spec = MSSpectrum()
        spec.setSourceFile(sf)
        sf = spec.getSourceFile()
        assert sf.getFileSize()  == 123
        assert sf.getFileType()  == "test type"
        assert sf.getChecksum()  == "0x123"
        assert sf.getChecksumType() == ChecksumType.SHA1
        assert sf.getNameOfFile()  == "test.mzXML"
        assert sf.getPathToFile()  == "./test.mzXML"
        assert sf.getNativeIDType()  == "scan="

    def test_DataValue(self):
        """
        @tests:
        DataValue.__init__
        .isEmpty
        .toInt
        .toString
        .toDouble
        .toStringList
        .toDoubleList
        .toIntList 
        .valueType
         DataType.DOUBLE_LIST
         DataType.DOUBLE_VALUE
         DataType.EMPTY_VALUE
         DataType.INT_LIST
         DataType.INT_VALUE
         DataType.STRING_LIST
         DataType.STRING_VALUE
        @end
        """

        assert DataValue().isEmpty()
        
        dint = DataValue(3)
        assert dint.toInt() == 3
        dstr = DataValue("uwe") 
        assert dstr.toString() == "uwe"
        dflt = DataValue(0.125)
        assert dflt.toDouble()  == 0.125
        sl = StringList(["a","b"])
        dslst= DataValue(sl)
        
        lsb = dslst.toStringList()
        assert lsb.size() == 2
        assert lsb.at(0) == "a"
        assert lsb.at(1) == "b"

        assert_raises(AssertionError, dint.toString)
        assert_raises(AssertionError, dstr.toInt)
        assert_raises(AssertionError, dflt.toInt)
        assert_raises(AssertionError, dslst.toInt)
        assert_raises(AssertionError, dslst.toDouble)
        assert_raises(AssertionError, dslst.toString)
        assert_raises(AssertionError, dslst.toIntList)
        assert_raises(AssertionError, dslst.toDoubleList)

        assert DataValue(IntList([1,2,3])).toIntList().size() == 3
        assert DataValue(DoubleList([1.0,2.0,3.0])).toDoubleList().size() == 3

        eq_( DataValue(1).valueType(), DataType.INT_VALUE)
        eq_( DataValue(1.0).valueType(), DataType.DOUBLE_VALUE)
        eq_( DataValue(IntList([1])).valueType(), DataType.INT_LIST)
        eq_( DataValue(DoubleList([1.0])).valueType(), DataType.DOUBLE_LIST)

        eq_( DataValue("1").valueType(), DataType.STRING_VALUE)
        eq_( DataValue(StringList(["1"])).valueType(), DataType.STRING_LIST)

    def testListObject(self):
        """
        @tests:
         DoubleList.__init__
         DoubleList.at
         DoubleList.size
         IntList.__init__
         IntList.at
         IntList.size
         StringList.__init__
         StringList.at
         StringList.size

        """

        d = DoubleList([1.0, 2.0])
        assert d.size() == 2
        assert [ d.at(i) for i in range(d.size()) ] == [1.0, 2.0]
        
        d = IntList([1, 2])
        assert d.size() == 2
        assert [ d.at(i) for i in range(d.size()) ] == [1, 2]
    
        d = StringList(["1", "2"])
        assert d.size() == 2
        assert [ d.at(i) for i in range(d.size()) ] == ["1", "2"]



if __name__ == "__main__":
    unittest.main()
