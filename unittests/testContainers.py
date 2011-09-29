import unittest
import pyOpenMS

class TestExperimentsAndSpecsAndPeaks(unittest.TestCase):

    def test_inst(self):
        p = pyOpenMS.MzXMLFile()
        e = pyOpenMS.MSExperiment()
        p.load("test.mzXML", e)
        assert e.size() == 2884

        spec = e[0]
        assert abs(spec.getRT()-0.00291) < 0.0001
        assert spec.getMSLevel() == 1 
        assert spec.size() == 281
        assert spec.getName() == ""

        assert spec.getPrecursors() == []

        assert spec.getInstrumentSettings().getPolarity()==pyOpenMS.Polarity.POSNULL
        peak = spec[0]

        assert abs(peak.getMZ() - 205.159) < 0.001
        assert abs(peak.getIntensity() - 2491.6) < 0.1


if __name__ == "__main__":
    unittest.main()
