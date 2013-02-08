import unittest

class TestModuleLoad(unittest.TestCase):

    def test_load(self):
        import pyopenms
        print  "loaded", pyopenms
        assert  pyopenms.__package__ == "pyopenms"


if __name__ == "__main__":
    unittest.main()
