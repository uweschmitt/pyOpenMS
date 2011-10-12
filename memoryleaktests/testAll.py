import sys
import unittest
import time
import contextlib
import pyOpenMS
from   pyOpenMS.sysinfo import free_mem
import numpy as np


def show_mem(label):

    p = free_mem()
    p /= 1024.0 * 1024
    print (label+" ").ljust(50, "."), ": %8.2f MB" % p
    sys.stdout.flush()
 

@contextlib.contextmanager
def MemTester(name):
        mem_at_start = free_mem()
        print
        show_mem("start test '%s' with" % name)
        yield
        missing = mem_at_start - free_mem() 
        show_mem("end with")
        print
        assert missing < 0.1* mem_at_start, "possible mem leak"


class TestAll(unittest.TestCase):

    def setUp(self):
        self.mem_at_start = free_mem()
        
        print 
        show_mem("AT THE BEGINNING ")
        print 

    def tearDown(self):
        
        time.sleep(3)
        print 
        show_mem("AT THE END ")
        print 
        missing = self.mem_at_start - free_mem() 
        assert missing < 0.1* self.mem_at_start, "possible mem leak"

    def testAll(self):

        with MemTester("specs from experiment"):
            self.run_extractSpetraFromMSExperiment()

        with MemTester("string_conversions1"):
            self.run_string_conversions1()

        with MemTester("string_conversions2"):
            self.run_string_conversions2()

        with MemTester("string_lists"):
            self.run_string_lists()

        with MemTester("list_conversions"):
            self.run_list_conversions()

        with MemTester("set_spec_peaks"):
            self.set_spec_peaks()

        with MemTester("set_spec_peaks2"):
            self.set_spec_peaks2()


        with MemTester("test io"):
            self.run_fileformats_io()


    def run_string_conversions1(self):

        basestr = 200000*" "
        li = []
        for i in range(1000):
            if (i+1)%100 == 0:
                show_mem("%4d runs" % i)
            dv = pyOpenMS.DataValue(basestr)
            dv = pyOpenMS.DataValue(basestr)
            li.append(dv)
        del li

    def run_string_conversions2(self):

        basestr = 200000*" "
        li = []
        for i in range(1000):
            if (i+1)%100 == 0:
                show_mem("%4d runs" % i)
            sf = pyOpenMS.SourceFile()
            sf.setNameOfFile(basestr)
            sf.setNameOfFile(basestr)
            li.append(sf)
        del li

    def run_string_lists(self):

        basestr = 100000*" "
        li = []
        for i in range(1000):
            if (i+1)%100 == 0:
                show_mem("%4d runs" % i)
            sl = pyOpenMS.StringList([basestr, basestr, basestr])
            sl = pyOpenMS.StringList([basestr, basestr, basestr])
            li.append(sl)
        del li

    def run_list_conversions(self):

        pc = pyOpenMS.Precursor()
        allpcs = 500*[pc]
        li = []
        for i in range(500):
            if (i+1)%100 == 0:
                show_mem("%4d runs" % i)
            spec = pyOpenMS.MSSpectrum()
            spec.setPrecursors(allpcs)
            spec.setPrecursors(allpcs)
            li.append(spec)
        del li

    def set_spec_peaks(self):

        data = np.zeros((10000,2), dtype=np.float32)
        li = []
        for i in range(1000):
            if (i+1)%100 == 0:
                show_mem("%4d specs processed" % i)
            spec = pyOpenMS.MSSpectrum()
            spec.set_peaks(data)
            spec.set_peaks(data)
            spec.set_peaks(data)
            li.append(spec)

        for spec in li:
            del spec
        del data

    def set_spec_peaks2(self):

        data = np.zeros((10000,2), dtype=np.float32)
        li = []
        for i in range(1000):
            if (i+1)%100 == 0:
                show_mem("%4d specs processed" % i)
            spec = pyOpenMS.MSSpectrum()
            spec.set_peaks(data)
            spec.set_peaks(data)
            spec.set_peaks(data)
            spec.set_peaks(spec.get_peaks())
            li.append(spec)

        for spec in li:
            del spec
        del data

    def run_extractSpetraFromMSExperiment(self):
            p = pyOpenMS.MzXMLFile()
            e = pyOpenMS.MSExperiment()
            p.load("../unittests/test.mzXML", e)
            show_mem("data loaded")

            li = []
            print "please be patient :",
            for k in range(5):
                sys.stdout.flush()
                li.append([ e[i] for i in range(e.size()) ])
                li.append([ e[i] for i in range(e.size()) ])
                print (20*k+20), "%",

            print
            show_mem("spectra list generated")
            del li
            show_mem("spectra list deleted")
            del p
            del e

    def run_fileformats_io(self):
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
       

if __name__ == "__main__":
    unittest.main()
