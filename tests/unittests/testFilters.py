import unittest
from   pyOpenMS import *
from   nose.tools import *

class TestBasisObjects(unittest.TestCase):

    def test_SavitzkyGolayFilter(self):
        """
        @tests:
        SavitzkyGolayFilter.__init__
        .filter
        .filterExperiment
        """

        myfilter = SavitzkyGolayFilter()
        p = MzXMLFile()
        e = MSExperiment()
        p.load("test.mzXML", e)

        # Test the filter fxn
        spectrum = e[0]
        myfilter.filter(spectrum)
        spectrum_before = e[0]
        spectrum_after = spectrum

        assert(spectrum_before.size() == spectrum_after.size() )
        assert_almost_equal(spectrum_before[0].getIntensity(),2491.61669921875, 0)
        assert_almost_equal(spectrum_after[0].getIntensity(), 3746.34423828125, 0)

        # Test the filterExperiment fxn
        myfilter = SavitzkyGolayFilter()
        p = MzXMLFile()
        e = MSExperiment()
        p.load("test.mzXML", e)

        spectrum_before = e[0]
        myfilter.filterExperiment(e)
        spectrum_after = e[0]

        assert(spectrum_before.size() == spectrum_after.size() )
        assert_almost_equal(spectrum_before[0].getIntensity(), 2491.61669921875, 0)
        assert_almost_equal(spectrum_after[0].getIntensity(), 3746.34423828125, 0)

if __name__ == "__main__":
    unittest.main()
