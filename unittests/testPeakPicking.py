
import unittest
import numpy as np

from pyOpenMS import *

from   nose.tools import *

class TestPickPicker(unittest.TestCase):


    def test_Param(self):

        """
        @tests
         PeakPickerHiRes.__init__
         .getParameters
         .setParameters
        Param.getKeys
        @end 
        """

        pp = PeakPickerHiRes()
        param = pp.getParameters()
        keys = param.getKeys()
        assert len(keys)==2
        assert "signal_to_noise" in keys
        assert "ms1_only" in keys

        param.setValue(String("ms1_only"), DataValue("true"), String(""), StringList())
        pp.setParameters(param)
        
        param = pp.getParameters()
        keys = param.getKeys()
        assert len(keys)==2
        assert "signal_to_noise" in keys
        assert "ms1_only" in keys
        assert param.getValue(String("ms1_only")).toString() == "true"

    def test_picking(self):

        """
        @tests
        PeakPickerHiRes.__init__
        .pick
        .pickExperiment
        .setLogType
        FileHandler.__init__
        FileHandler.loadExperiment
        MSExperiment.__init__
        LogType.CMD
        LogType.GUI
        LogType.NONE
        """
        
        ein = MSExperiment()
        FileHandler().loadExperiment("test.mzML", ein)

        pp = PeakPickerHiRes()
        sout = MSSpectrum()
        sin  = ein[100]
        pp.pick(sin, sout)
        assert sout.size() == 10

        eout = MSExperiment()
        pp.setLogType(LogType.CMD)
        pp.pickExperiment(ein, eout)
        assert eout[100].size() == 10

        assert np.all(eout[100].get_peaks() == sout.get_peaks())

        # test if defined at all:
        LogType.GUI
        LogType.NONE

        


