import unittest

from pyOpenMS import Param, String, StringList, DataValue

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
         .size
         .getValue
         .setValue
         .getKeys
         String.__init__
         String.c_str
        @end 
        """
        
        p = Param()
        key = String("testkey")
        eq_(key.c_str(), "testkey")
        tag = String("testtag")
        value = DataValue("testvalue")
        assert_raises(Exception, p.addTag, (key, tag))
        assert_raises(Exception, p.getTags, (key, ))

        p.setValue(key, value, String("desc"), StringList(["tag2"]))
        assert p.getValue(key).toString() == value.toString()
        p.addTag(key, tag)

        sl = p.getTags(key)
        eq_( sl.size(), 2)
        eq_( sl.at(0), "tag2")
        eq_( sl.at(1), "testtag")

        eq_(p.size(), 1)

        p.store("test.param")
        p.load("test.param")

        sl = p.getTags(key)
        eq_( sl.size(), 2)
        eq_( sl.at(0), "tag2")
        eq_( sl.at(1), "testtag")

        eq_(p.size(), 1)

        assert p.exists(key)
        assert not p.exists(String("b"))
        
        p.addTags(key, StringList(["a"]))
        sl = p.getTags(key)
        eq_( sl.size(), 3)
        tags = set ( (sl.at(0), sl.at(1), sl.at(2)) )
        eq_( tags, set( ("a", "tag2", "testtag")) )

        assert p.hasTag(key, tag)
        assert p.hasTag(key, String("tag2"))
        assert p.hasTag(key, String("a"))
        assert not p.hasTag(key, String("b"))

        assert p.getKeys() == ["testkey"]
       
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
        k = String("PeakPicker:1:in")
        assert p.exists(k)
        assert p.getTags(k).size() == 1
        assert p.getTags(k).at(0) == "input file"

        d = p.getValue(k)
        assert d.toString() == ""

        assert "input profile data file" in p.getDescription(k)
        assert "Instance '1' section" in p.getSectionDescription(String("PeakPicker:1"))
        assert p.getSectionDescription(String("PeakPicker")) == ""

        assert len(p.getKeys())==50, len(p.getKeys())
