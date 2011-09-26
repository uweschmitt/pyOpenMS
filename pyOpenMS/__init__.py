# load extension module which loads other python modules from this directory
import os

if os.path.exists("share"):
    # local import
    os.environ["OPENMS_DATA_PATH"] = os.path.abspath(os.path.join("share", "openMS") )
else:
    here = os.path.dirname(os.path.abspath(__file__))
    os.environ["OPENMS_DATA_PATH"] = os.path.join(here, "share", "openMS") 

from _pyOpenMS import *  
