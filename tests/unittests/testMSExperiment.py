import pdb
import unittest
import pyopenms

class TestPyMSExperiment(unittest.TestCase):

    """
    @tests
    MSExperiment.__init__
    .size
    .getMinMZ
    .sortSpectra
    """ 

    def test_000(self):
        p = pyopenms.MSExperiment()
        assert  p.size() == 0
        p.getMinMZ()
        p.sortSpectra(True)
        assert  p.size() == 0


        p.setLoadedFilePath("/tmp/x")
        assert isinstance(p.getLoadedFilePath(), str)
        assert p.getLoadedFilePath != ""

if __name__ == "__main__":
    unittest.main()
