import unittest

from pyopenms import Param, DataValue

from   nose.tools import *

class TestParam(unittest.TestCase):


    def test_Param(self):

        """
        @tests
         Param.__init__
         .addTag
         .addTags
         .exists
         .getTags
         .hasTag
         .load
         .store
         .getValue
         .setValue
         .getKeys
         String.__init__
         String.c_str
        @end
        """

        p = Param()
        key = "testkey"
        tag = "testtag"
        value = DataValue("testvalue")
        assert_raises(Exception, p.addTag, (key, tag))
        assert_raises(Exception, p.getTags, (key, ))

        p.setValue(key, value, "desc", ["tag2"])
        assert p.getValue(key).toString() == value.toString()
        p.addTag(key, tag)

        sl = p.getTags(key)
        eq_( len(sl), 2)
        eq_( sl[0], "tag2")
        eq_( sl[1], "testtag")

        eq_(p.size(), 1)

        p.store("test.param")
        p.load("test.param")

        sl = p.getTags(key)
        eq_( len(sl), 2)
        eq_( sl[0], "tag2")
        eq_( sl[1], "testtag")

        eq_(p.size(), 1)

        assert p.exists(key)
        assert not p.exists("b")

        p.addTags(key, ["a"])
        sl = p.getTags(key)
        eq_( len(sl), 3)
        tags = set ( (sl[0], sl[1], sl[2]) )
        eq_( tags, set( ("a", "tag2", "testtag")) )

        assert p.hasTag(key, tag)
        assert p.hasTag(key, "tag2")
        assert p.hasTag(key, "a")
        assert not p.hasTag(key, "b")

        #assert p.getKeys() == ["testkey"]

    def testFromIniFile(self):
        """
        @tests:
        Param.__init__
        .load
        .exists
        .getValue
        .getDescription
        .getSectionDescription
        .getKeys
        """

        p = Param()
        p.load("test.ini")
        k = "PeakPicker:1:in"
        assert p.exists(k)
        assert len(p.getTags(k)) == 1
        assert p.getTags(k)[0]== "input file"

        d = p.getValue(k)
        assert d.toString() == ""

        assert "input profile data file" in p.getDescription(k)
        assert "Instance '1' section" in p.getSectionDescription("PeakPicker:1")
        assert p.getSectionDescription("PeakPicker") == ""

