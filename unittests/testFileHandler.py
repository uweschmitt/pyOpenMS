import unittest, sys
from  pyOpenMS import *
from   pyOpenMS.sysinfo import free_mem


def show_mem(label):

    p = free_mem()
    p /= 1024.0 * 1024
    print (label+" ").ljust(30, "."), ": %8.2f MB" % p
    sys.stdout.flush()


class TestLoadAndStoreInDifferentFileFormats(unittest.TestCase):


    """
    @tests:
    FileHandler.__init__
    FileHandler.loadExperiment
    FileHandler.storeExperiment
    """

    def test000(self):
        

        print
        print
        show_mem("start")

        exp = MSExperiment()
        fh = FileHandler()

        fh.loadExperiment("test.mzXML", exp)
        self.check(exp)

        fh.storeExperiment("test.mzML", exp)
        fh.loadExperiment("test.mzML", exp)
        self.check(exp)
        
        fh.storeExperiment("test.mzData", exp)
        fh.loadExperiment("test.mzData", exp)
        self.check(exp)

        fh.storeExperiment("test.mzXML", exp)
        fh.loadExperiment("test.mzXML", exp)
        self.check(exp)

        del fh
        del exp
        show_mem("after cleanup")

    def check(self, e):
        assert e.size() == 2884

        spec = e[0]
        assert (spec.getRT()-0.00291) < 0.0001
        assert spec.getMSLevel() == 1 
        assert spec.size() == 281
        assert spec.getName() == ""


if __name__ == "__main__":
    unittest.main()

