import unittest
import pyOpenMS

class TestExperimentsAndSpecsAndPeaks(unittest.TestCase):

    def test_inst(self):
        p = pyOpenMS.PyMzXMLFile()
        e = pyOpenMS.PyMSExperiment()
        p.load("test.mzXML", e)
        assert e.size() == 2884

        spec = e[0]
        assert abs(spec.getRT()-0.00291) < 0.0001
        assert spec.getMSLevel() == 1 
        assert spec.size() == 281
        assert spec.getName() == ""

        assert spec.getPrecursors() == []

        assert spec.getInstrumentSettings().getPolarity().toString() == "POLNULL"
        assert spec.getInstrumentSettings().getPolarity().toInt() == 0

        peak = spec[0]

        assert abs(peak.getMZ() - 205.159) < 0.001
        assert abs(peak.getIntensity() - 2491.6) < 0.1

        # test negative indexing

        spec = e[-1]
        spec0 = e[e.size()-1]

        # equality check is ok, as both have to come from the same
        # internal data
        assert spec.getRT() == spec0.getRT()

        peak = spec[-1]
        peak0 = spec[spec.size()-1]

        # equality check is ok, as both have to come from the same
        # internal data
        assert peak.getMZ() == peak0.getMZ()
        assert peak.getIntensity() == peak0.getIntensity()

if __name__ == "__main__":
    unittest.main()
