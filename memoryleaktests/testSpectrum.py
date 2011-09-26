import win32api, sys
import unittest
import pyOpenMS
 
def show_mem(label):
    t = win32api.GlobalMemoryStatus()
    v, p = t['AvailVirtual'], t['AvailPhys']
    v /= 1024.0 * 1024
    p /= 1024.0 * 1024

    print (label+" ").ljust(30, "."), ": %8.2f MB" % p



class Test0001(unittest.TestCase):

    def test_extractSpectraFromMSExperiment(self):

        print
        show_mem("start")
        p = pyOpenMS.PyMzXMLFile()
        e = pyOpenMS.PyMSExperiment()
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
       

if __name__ == "__main__":
    unittest.main()
