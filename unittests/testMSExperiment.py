import unittest
import pyOpenMS

class TestPyMSExperiment(unittest.TestCase):

    """
    @tests
    MSExperiment.__init__
    .size
    .getMinMZ
    .sortSpectra
    """ 

    def test_000(self):
        p = pyOpenMS.MSExperiment()
        assert  p.size() == 0
        p.getMinMZ()
        p.sortSpectra(True)
        assert  p.size() == 0


if __name__ == "__main__":
    unittest.main()
