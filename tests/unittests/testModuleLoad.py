import unittest

class TestModuleLoad(unittest.TestCase):

    def test_load(self):
        import pyopenms
        print  "loaded", pyopenms
        import os
        assert "pyopenms" in  os.environ.get("OPENMS_DATA_PATH")
        assert  pyopenms.__package__ == "pyopenms"


if __name__ == "__main__":
    unittest.main()
