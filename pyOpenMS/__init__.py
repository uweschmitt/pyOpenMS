# load extension module which loads other python modules from this directory
import os, types

j=os.path.join

if os.path.exists(j("pyOpenMS", "share")):
    # local import
    os.environ["OPENMS_DATA_PATH"] = os.path.abspath(j("pyOpenMS", "share", "OpenMS") )
else:
    here = os.path.dirname(os.path.abspath(__file__))
    os.environ["OPENMS_DATA_PATH"] = j(here, "share", "OpenMS") 



from pyOpenMS import *
import sysinfo

from version import version as __version__
