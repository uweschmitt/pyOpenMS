import unittest

from pyOpenMS import Param, String, StringList, DataValue

from   nose.tools import *

class TestParam(unittest.TestCase):


    def test_Param(self):

        """
        @tests
         Param.__init__
         Param.clear
         Param.clearTags
         Param.copy
         Param.empty
         Param.exists
         Param.getDescription
         Param.getSectionDescription
         Param.getValue
         Param.hasTag
         Param.insert
         Param.load
         Param.remove
         Param.removeAll
         Param.setMaxFloat
         Param.setMaxInt
         Param.setMinFloat
         Param.setMinInt
         Param.setSectionDescription
         Param.setValidStrings
         Param.setValue
         Param.size
         Param.store
         String.__init__
         String.c_str
        @end 
        """
        
        p = Param()
        key = String("testkey")
        tag = String("testtag")
        value = DataValue("testvalue")
        assert_raises(Exception, p.addTag, (key, tag))
        assert_raises(Exception, p.getTags, (key, ))

        p.setValue(key, value, String("desc"), StringList(["tag2"]))
        p.addTag(key, tag)
        sl = p.getTags(key)
        assert sl.size() == 2
        assert sl.at(0)=="tag2"
        assert sl.at(1) == "testtag"
        
        p.addTags(key, StringList(["a"]))
        sl = p.getTags(key)
        assert sl.size() == 3
        assert sl.at(0)=="tag2"
        assert sl.at(1) == "testtag"
        assert sl.at(2) == "a"

        assert p.hasTag(tag)
        assert p.hasTag(String("tag2"))
        assert p.hasTag(String("a"))
        assert not p.hasTag(String("b"))
        
