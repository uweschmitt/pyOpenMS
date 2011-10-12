import unittest

from pyOpenMS import Param, String, StringList, DataValue

from   nose.tools import *

class TestParam(unittest.TestCase):


    def test_Param(self):

        """
        @tests
         Param.__init__
         Param.addTag
         Param.addTags
         Param.clear
         Param.clearTags
         Param.copy
         Param.empty
         Param.exists
         Param.getDescription
         Param.getSectionDescription
         Param.getTags
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
        
        
