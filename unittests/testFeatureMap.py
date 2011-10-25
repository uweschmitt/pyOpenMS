from pyOpenMS import *

def testFeatureMap():
    """
    @tests:
    FeatureMap.__init__
    .push_back
    .setUniqueId
    .size

    Feature.__init__
    .setMZ
    .getMZ
    .setIntensity
    .getIntensity
    .setRT
    .getRT
    .setUniqueId

    FeatureXMLFile.__init__
    .store
    .load
    """
    fm = FeatureMap()

    f = Feature()
    f.setMZ(1.0)
    f.setIntensity(20.0)
    f.setRT(2.0)
    f.setUniqueId()

    assert f.getMZ() == 1.0
    assert f.getIntensity() == 20.0
    assert f.getRT() == 2.0

    fm.push_back(f)

    f = Feature()
    f.setMZ(2.0)
    f.setIntensity(30.0)
    f.setRT(4.0)
    f.setUniqueId()
    fm.push_back(f)

    fm.setUniqueId()

    ff = FeatureXMLFile()
    ff.store("test.featureXML", fm)

    fmneu = FeatureMap()
    ff.load("test.featureXML", fmneu)
    
    assert fm.size() == fmneu.size()

    f = fmneu[1]
    assert f.getMZ() == 2.0
    assert f.getRT() == 4.0
    assert f.getIntensity() == 30.0
