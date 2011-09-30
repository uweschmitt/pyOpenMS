import unittest
import numpy as np
import pyOpenMS

class TestExperimentsAndSpecsAndPeaks(unittest.TestCase):

    def test_000(self):
        p = pyOpenMS.MzXMLFile()
        e = pyOpenMS.MSExperiment()
        p.load("test.mzXML", e)
        assert e.size() == 2884

        spec = e[0]
        assert abs(spec.getRT()-0.00291) < 0.0001
        assert spec.getMSLevel() == 1 
        assert spec.size() == 281
        assert spec.getName() == ""

        # get data as raw numpy array
        peaks = spec.get_peaks()
        assert peaks.shape == (281, 2)
        assert peaks.dtype == np.float32

        assert spec.getPrecursors() == []

        polarity = spec.getInstrumentSettings().getPolarity()
        assert polarity ==pyOpenMS.Polarity.POLNULL
        peak = spec[0]

        assert abs(peak.getMZ() - 205.159) < 0.001
        assert abs(peak.getIntensity() - 2491.6) < 0.1


if __name__ == "__main__":
    unittest.main()
