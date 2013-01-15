import unittest

class TestModuleLoad(unittest.TestCase):

    def test_load(self):
        import pyOpenMS
        print  "loaded", pyOpenMS
        import os
        assert "pyOpenMS" in  os.environ.get("OPENMS_DATA_PATH")
        assert  pyOpenMS.__package__ == "pyOpenMS"


if __name__ == "__main__":
    unittest.main()
