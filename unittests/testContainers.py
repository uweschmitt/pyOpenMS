import unittest
import numpy as np
from  pyOpenMS import *

from nose.tools import *

class TestExperimentsAndSpecsAndPeaks(unittest.TestCase):

    def test_000(self):
        """ 
        @tests:

         MzXMLFile.__init__
                  .load

         MSExperiment.__init__
         .updateRanges
         .getMinRT
         .getMinMZ
         .getMaxRT
         .getMaxMZ
         .push_back

         MSSpectrum.size
         .getRT
         .getMSLevel
         .getName
         .setName
         .getNativeID
         .setNativeID
         .size
         .get_peaks
         .intensityInRange
         .set_peaks
         .getPrecursors
         .getInstrumentSettings
         .updateRanges
         .findNearest
         .getSourceFile

         InstrumentSettings.getPolarity

         SourceFile.getFileSize
         .getFileType
         .getChecksum
         .getChecksumType
         .getNameOfFile
         .getPathToFile
         .getNativeIDType
         @end                 

        """

        p = MzXMLFile()
        e = MSExperiment()
        p.load("test.mzXML", e)
        assert e.size() == 2884, e.size()
        e.updateRanges()


        assert_almost_equal( e.getMinMZ(), 202.001,  3)
        assert_almost_equal( e.getMaxMZ(), 649.996,  2)
        assert_almost_equal( e.getMinRT(), 0.002911, 5)
        assert_almost_equal( e.getMaxRT(), 44.899,   2)

        spec = e[0]
        spec.updateRanges()
        assert_almost_equal(spec.getRT(), 0.00291, 5)
        assert spec.getMSLevel() == 1 
        assert spec.size() == 281

        assert spec.getName() == ""
        spec.setName("test")
        assert spec.getName() == "test"
        spec.setName("")

        assert spec.getNativeID() == "scan=1", spec.getNativeID()
        spec.setNativeID("test")
        assert spec.getNativeID() == "test"
        spec.setNativeID("scan=1")

        # get data as raw numpy array
        peaks = spec.get_peaks()
        assert peaks.shape == (281, 2)
        assert peaks.dtype == np.float32

        xit = spec.intensityInRange(100,1000)
        assert_almost_equal(xit, 700144.3, 1)

        spec.set_peaks(peaks)
        assert_almost_equal(spec.getRT(), 0.00291, 5)
        assert spec.getMSLevel() == 1 
        assert spec.size() == 281
        assert spec.getName() == ""

        assert spec.getPrecursors() == []

        polarity = spec.getInstrumentSettings().getPolarity()
        assert polarity ==Polarity.POLNULL

        peak = spec[0]

        assert_almost_equal(peak.getMZ(), 205.159, 2)
        assert_almost_equal(peak.getIntensity(), 2491.6, 1)

        e.push_back(spec)
        assert e.size() == 2885

        assert spec.findNearest(spec[10].getMZ()) == 10
        assert spec.findNearest(1.00001* spec[10].getMZ()) == 10
        assert spec.findNearest(0.99999* spec[10].getMZ()) == 10

        sf = spec.getSourceFile()
        assert sf.getFileSize()  == 0
        assert sf.getFileType()  == ""
        assert sf.getChecksum()  == ""
        assert sf.getChecksumType() == 0
        assert sf.getNameOfFile()  == ""
        assert sf.getPathToFile()  == ""
        assert sf.getNativeIDType()  == ""


if __name__ == "__main__":
    unittest.main()
