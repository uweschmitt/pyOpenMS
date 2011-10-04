import unittest
import numpy as np
import pyOpenMS

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

         InstrumentSettings.getPolarity
         @end                 

        """

        p = pyOpenMS.MzXMLFile()
        e = pyOpenMS.MSExperiment()
        p.load("test.mzXML", e)
        assert e.size() == 2884
        e.updateRanges()

        assert abs( e.getMinMZ()-202.001) < 0.01
        assert abs( e.getMaxMZ()-649.99) < 0.01
        assert abs( e.getMinRT()-0.002911) < 0.00001
        assert abs( e.getMaxRT()-44.899) < 0.001

        spec = e[0]
        spec.updateRanges()
        assert abs(spec.getRT()-0.00291) < 0.0001
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
        assert abs(xit-700144.3)<0.1, xit

        spec.set_peaks(peaks)
        assert abs(spec.getRT()-0.00291) < 0.0001
        assert spec.getMSLevel() == 1 
        assert spec.size() == 281
        assert spec.getName() == ""

        assert spec.getPrecursors() == []

        polarity = spec.getInstrumentSettings().getPolarity()
        assert polarity ==pyOpenMS.Polarity.POLNULL

        peak = spec[0]

        assert abs(peak.getMZ() - 205.159) < 0.001
        assert abs(peak.getIntensity() - 2491.6) < 0.1

        e.push_back(spec)
        assert e.size() == 2885

        assert spec.findNearest(spec[10].getMZ()) == 10
        assert spec.findNearest(1.00001* spec[10].getMZ()) == 10
        assert spec.findNearest(0.99999* spec[10].getMZ()) == 10


if __name__ == "__main__":
    unittest.main()
