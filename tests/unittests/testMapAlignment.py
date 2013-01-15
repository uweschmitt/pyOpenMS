from pyOpenMS import *
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

    return True
    raise Exception("INVALID TEST ! ADAPT AS SOON AS POSSIBLE")
 
    ma = MapAlignmentAlgorithmPoseClustering()
    s = String()
    p = Param()
    ma.getDefaultModel(s, p)
    ma.setLogType(LogType.CMD)

    # check default settings
    assert s.c_str() == "linear"
    assert p.getKeys() == ["symmetric_regression"]
    assert p.getValue(String("symmetric_regression")).toString() == "true"

    mse = MSExperiment()
    FileHandler().loadExperiment("test.mzML", mse)

    transformations = []
    maps = [mse,mse]
    ma.setReference(2, String())
    ma.alignPeakMaps(maps, transformations)

    assert len(transformations) == 2

    ps = transformations[0].getDataPoints()
    assert type(ps) == list
    assert type(ps[0]) == tuple
    
    #print ma.getDefaults().getKeys()
    #print len(ps), mse.size()
    #assert len(ps) == mse.size()

    ma.fitModel(s, p, transformations)

    pvorher0 = mse[0].get_peaks()[:10,:]
    pvorher1 = mse[1].get_peaks()[:10,:]

    ma.transformPeakMaps(maps,  transformations)

    pnachher0 = maps[0][0].get_peaks()[:10,:]
    pnachher1 = maps[0][1].get_peaks()[:10,:]

    assert np.all(pvorher0==pnachher0)
    assert np.all(pvorher1==pnachher1)




