import unittest
import pyOpenMS

class TestBasisObjects(unittest.TestCase):

    def test_Spectrum(self):

        """
        @tests:
        MSSpectrum.__init__
        .size
        .getRT
        .setRT
        .getMSLevel
        .setMSLevel
        .getPrecursors
        .setPrecursors

        Precursor.getMZ
        .setMZ
        .setIntensity
        .setIntensity
                          
        @end 
        """
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

        pc0 = pyOpenMS.Precursor()
        pc0.setMZ(16.0)
        pc0.setIntensity(256.0)

        pc1 = pyOpenMS.Precursor()
        pc1.setMZ(32.0)
        pc1.setIntensity(128.0)
        
        p.setPrecursors([pc0, pc1])

        pcs = p.getPrecursors()
        assert len(pcs) == 2
        assert pcs[0].getMZ() == pc0.getMZ()
        assert pcs[1].getMZ() == pc1.getMZ()
        assert pcs[0].getIntensity() == pc0.getIntensity()
        assert pcs[1].getIntensity() == pc1.getIntensity()



    def test_Peak1D(self):
        """
        @tests:
        Peak1D.__init__
              .setMZ
              .getMZ
              .setIntensity
              .getIntensity
        """
        p = pyOpenMS.Peak1D()

        p.setMZ(1.0)
        assert abs(p.getMZ()-1.0) < 1e-5

        p.setIntensity(4.0)
        assert abs(p.getIntensity()-4.0) < 1e-5

    def test_Precursor(self):
        """
        @tests:
        Precursor.__init__
                 .setMZ
                 .getMZ
                 .setIntensity
                 .getIntensity
        """
        p = pyOpenMS.Precursor()

        p.setMZ(1.0)
        assert abs(p.getMZ()-1.0) < 1e-5

        p.setIntensity(4.0)
        assert abs(p.getIntensity()-4.0) < 1e-5

    def test_InstrumentSettings(self):
        """
        @tests:
        InstrumentSettings.__init__
        .getPolarity
        .setPolarity
        Polarity.POLNULL
                .POSITIVE
                .NEGATIVE
                .SIZE_OF_POLARITY
        """
        is_ = pyOpenMS.InstrumentSettings()
        for e in [ pyOpenMS.Polarity.POLNULL,
                   pyOpenMS.Polarity.POSITIVE,
                   pyOpenMS.Polarity.NEGATIVE,
                   pyOpenMS.Polarity.SIZE_OF_POLARITY,]:

            is_.setPolarity(e)
            assert is_.getPolarity() == e


if __name__ == "__main__":
    unittest.main()
