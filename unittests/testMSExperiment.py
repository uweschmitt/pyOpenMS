import unittest
import pyOpenMS

class TestPyMSExperiment(unittest.TestCase):

    def test_inst(self):
        p = pyOpenMS.MSExperiment()
        assert  p.size() == 0
        p.getMinMZ()
        p.sortSpectra(True)
        assert  p.size() == 0


if __name__ == "__main__":
    unittest.main()
