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

# we can not import the extension module without setting the variable
# OPENMS_DATA_PATH beforehand. so the import above results in a namespace
# pyOpenMS.pyOpenMS where the first pyOpenMS refers this package, and the
# second pyOpenMS is the extsion module. 
#
# >>> import pyOpenMS.pyOpenMS
# >>> print type(pyOpenMS.pyOpenMS.DataValue())
# <type 'pyOpenMS.DataValue'>
# 
# we circumvate this by the following manipulation of sys.modules.  now we get:
# >>> import pyOpenMS
# >>> print type(pyOpenMS.DataValue())
# <type 'pyOpenMS.DataValue'>

#import sys
import sysinfo
#sys.modules["pyOpenMS"] = pyOpenMS
#sys.modules["pyOpenMS.sysinfo"] = sysinfo
