import sys
import unittest
import pyOpenMS
from   pyOpenMS.sysinfo import free_mem


def show_mem(label):

    p = free_mem()
    p /= 1024.0 * 1024
    print (label+" ").ljust(30, "."), ": %8.2f MB" % p
    sys.stdout.flush()
 

class MemTester(object):

    def __enter__(self):
        self.mem_at_start = free_mem()

    def __exit__(self, *a, **kw):
        missing = free_mem() - self.mem_at_start
        assert missing < 0.1* self.mem_at_start, "possible mem leak"

class TestAll(unittest.TestCase):

    def test_extractSpectraFromMSExperiment(self):

        with MemTester():
            self.run_extractSpetraFromMSExperiment()


    def test_IO(self):

        with MemTester():
            self.run_fileformats_io()

    def run_extractSpetraFromMSExperiment(self):
            print
            print
            show_mem("start")
            p = pyOpenMS.MzXMLFile()
            e = pyOpenMS.MSExperiment()
            p.load("../unittests/test.mzXML", e)
            show_mem("data loaded")

            li = []
            print "please be patient :",
            for k in range(10):
                sys.stdout.flush()
                li.append([ e[i] for i in range(e.size()) ])
                print (10*k+10), "%",

            print
            show_mem("spectra list generated")
            del li
            show_mem("spectra list deleted")
            del p
            del e
            show_mem("remaining objets cleaned up")
            print

    def run_fileformats_io(self):
        print
        print
        show_mem("start")
        
        p = pyOpenMS.MzXMLFile()
        e = pyOpenMS.MSExperiment()

        p.load("../unittests/test.mzXML", e)
        show_mem("after load mzXML")

        ct = pyOpenMS.ChromatogramTools()
        ct.convertChromatogramsToSpectra(e)
        p.store("test.mzXML", e)
        show_mem("after store mzXML")

        p.load("test.mzXML", e)
        show_mem("after load mzXML")

        p = pyOpenMS.MzMLFile()
        ct.convertSpectraToChromatograms(e, True)
        p.store("test.mzML", e)
        show_mem("after store mzML")
        p.load("test.mzML", e)
        show_mem("after load mzML")

        p = pyOpenMS.MzDataFile()
        ct.convertChromatogramsToSpectra(e)
        p.store("test.mzData", e)
        show_mem("after store mzData")
        p.load("test.mzData", e)
        show_mem("after load mzData")

        del e
        del p
        del ct
        show_mem("after cleanup")
       

if __name__ == "__main__":
    unittest.main()
