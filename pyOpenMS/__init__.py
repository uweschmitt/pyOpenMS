# load extension module which loads other python modules from this directory
import os, types

j=os.path.join

if os.path.exists(j("pyOpenMS", "share")):
    # local import
    os.environ["OPENMS_DATA_PATH"] = os.path.abspath(j("pyOpenMS", "share", "OpenMS") )
else:
    here = os.path.dirname(os.path.abspath(__file__))
    os.environ["OPENMS_DATA_PATH"] = j(here, "share", "OpenMS") 

import _pyOpenMS

for name, type_ in _pyOpenMS.__dict__.items():
    # extensions clases type is type:
    if not type(type_) == type:
        continue
    stmt = "%(name)s=type('%(name)s', (_pyOpenMS.%(name)s,), dict())" % locals()
    exec  stmt
