from pyopenms import *
import numpy as np

def testMapAlignment():
    """
    @tests
    MapAlignmentAlgorithmPoseClustering.__init__
    .getDefaultModel
    .alignFeatureMaps
    .fitModel
    .transformFeatureMaps
    .setReference
    .setLogType

    String.__init__
    .c_str
    Param.__init__
    .getKeys
    .getValue
    """


    ma = MapAlignmentAlgorithmPoseClustering()
    p = ma.getDefaults()
    bunch = p.asBunch()
    bunch.pairfinder.ignore_charge="false"
    p.store("temp_test.ini")
    bunch.pairfinder.ignore_charge="true"
    p.updateFrom(bunch)


    p.load("temp_test.ini")
    bunch = p.asBunch()
    assert bunch.pairfinder.ignore_charge == "false"

    bunch.pairfinder.ignore_charge="false"
    p.updateFrom(bunch)

    ma.setLogType(LogType.CMD)

    # check default settings
    # assert p.getValue("symmetric_regression")

    mse = MSExperiment()
    FileHandler().loadExperiment("test.mzML", mse)

    transformations = []
    maps = [mse,mse]
    ma.setReference(2, "")
    ma.alignPeakMaps(maps, transformations)

    assert len(transformations) == 2

    ps = transformations[0].getDataPoints()
    assert type(ps) == list
    ps = transformations[1].getDataPoints()
    assert type(ps) == list
 
    #print ma.getDefaults().getKeys()
    #print len(ps), mse.size()
    #assert len(ps) == mse.size()

    ma.fitModel("linear", p, transformations)

    pvorher0 = mse[0].get_peaks()[:10,:]
    pvorher1 = mse[1].get_peaks()[:10,:]

    return 

    ma.transformPeakMaps(maps,  transformations)

    pnachher0 = maps[0][0].get_peaks()[:10,:]
    pnachher1 = maps[0][1].get_peaks()[:10,:]

    assert np.all(pvorher0==pnachher0)
    assert np.all(pvorher1==pnachher1)




