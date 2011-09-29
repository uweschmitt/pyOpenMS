import unittest
import pyOpenMS

class TestBasisObjects(unittest.TestCase):

    def test_Spectrum(self):
        p = pyOpenMS.MSSpectrum()
        assert  p.size() == 0

        p.setRT(1.0)
        assert abs(p.getRT()-1.0) < 1e-5

        p.setMSLevel(3)
        assert p.getMSLevel() == 3

        ex = None
        try:
            p.setMSLevel(-1)
        except Exception ,e:
            ex = e
        #assert ex is not None

    def test_Peak1D(self):
        p = pyOpenMS.Peak1D()

        p.setMZ(1.0)
        assert abs(p.getMZ()-1.0) < 1e-5

        p.setIntensity(4.0)
        assert abs(p.getIntensity()-4.0) < 1e-5

    def test_Precursor(self):
        p = pyOpenMS.Precursor()

        p.setMZ(1.0)
        assert abs(p.getMZ()-1.0) < 1e-5

        p.setIntensity(4.0)
        assert abs(p.getIntensity()-4.0) < 1e-5

if __name__ == "__main__":
    unittest.main()
