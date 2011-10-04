import unittest
import pyOpenMS

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
        p = pyOpenMS.MSSpectrum()
        assert  p.size() == 0

        p.setRT(1.0)
        assert abs(p.getRT()-1.0) < 1e-5

        p.setMSLevel(3)
        assert p.getMSLevel() == 3

        ex = None
        try:
            p.setMSLevel(-1)
        except Exception ,e:
            ex = e
        #assert ex is not None

        pc0 = pyOpenMS.Precursor()
        pc0.setMZ(16.0)
        pc0.setIntensity(256.0)

        pc1 = pyOpenMS.Precursor()
        pc1.setMZ(32.0)
        pc1.setIntensity(128.0)
        
        p.setPrecursors([pc0, pc1])

        pcs = p.getPrecursors()
        assert len(pcs) == 2
        assert pcs[0].getMZ() == pc0.getMZ()
        assert pcs[1].getMZ() == pc1.getMZ()
        assert pcs[0].getIntensity() == pc0.getIntensity()
        assert pcs[1].getIntensity() == pc1.getIntensity()

        peak = pyOpenMS.Peak1D()
        peak.setMZ(1.25)
        peak.setIntensity(123.0)

        spec = pyOpenMS.MSSpectrum()
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
        p = pyOpenMS.Peak1D()

        p.setMZ(1.0)
        assert abs(p.getMZ()-1.0) < 1e-5

        p.setIntensity(4.0)
        assert abs(p.getIntensity()-4.0) < 1e-5

    def test_Precursor(self):
        """
        @tests:
        Precursor.__init__
                 .setMZ
                 .getMZ
                 .setIntensity
                 .getIntensity
        """
        p = pyOpenMS.Precursor()

        p.setMZ(1.0)
        assert abs(p.getMZ()-1.0) < 1e-5

        p.setIntensity(4.0)
        assert abs(p.getIntensity()-4.0) < 1e-5

    def test_InstrumentSettings(self):
        """
        @tests:
        InstrumentSettings.__init__
        .getPolarity
        .setPolarity
        Polarity.POLNULL
                .POSITIVE
                .NEGATIVE
                .SIZE_OF_POLARITY
        """
        is_ = pyOpenMS.InstrumentSettings()
        for e in [ pyOpenMS.Polarity.POLNULL,
                   pyOpenMS.Polarity.POSITIVE,
                   pyOpenMS.Polarity.NEGATIVE,
                   pyOpenMS.Polarity.SIZE_OF_POLARITY,]:

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
        sf = pyOpenMS.SourceFile()
        sf.setFileSize(123)
        sf.setFileType("test type")
        sf.setChecksum("0x123", pyOpenMS.ChecksumType.SHA1)
        #sf.setChecksumType(pyOpenMS.ChecksumType.SHA1) # UNKNOWN_CHECKSUM, MD5, SIZE_OF_CHECKSUMTYPE
        sf.setNameOfFile("test.mzXML")
        sf.setPathToFile("./test.mzXML")
        sf.setNativeIDType("scan=")

        assert sf.getFileSize()  == 123
        assert sf.getFileType()  == "test type"
        assert sf.getChecksum()  == "0x123"
        assert sf.getChecksumType() == pyOpenMS.ChecksumType.SHA1
        assert sf.getNameOfFile()  == "test.mzXML"
        assert sf.getPathToFile()  == "./test.mzXML"
        assert sf.getNativeIDType()  == "scan="

        assert pyOpenMS.ChecksumType.SHA1 > -1
        assert pyOpenMS.ChecksumType.MD5 > -1
        assert pyOpenMS.ChecksumType.UNKNOWN_CHECKSUM > -1
        assert pyOpenMS.ChecksumType.SIZE_OF_CHECKSUMTYPE > -1

        spec = pyOpenMS.MSSpectrum()
        spec.setSourceFile(sf)
        sf = spec.getSourceFile()
        assert sf.getFileSize()  == 123
        assert sf.getFileType()  == "test type"
        assert sf.getChecksum()  == "0x123"
        assert sf.getChecksumType() == pyOpenMS.ChecksumType.SHA1
        assert sf.getNameOfFile()  == "test.mzXML"
        assert sf.getPathToFile()  == "./test.mzXML"
        assert sf.getNativeIDType()  == "scan="

     

if __name__ == "__main__":
    unittest.main()
