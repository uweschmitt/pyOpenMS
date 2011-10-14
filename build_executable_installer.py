import glob
import re
import os
import zipfile

def pack(p):
    print "pack", p
    dirname = os.path.dirname(p)
    basename = os.path.basename(p)
    fname, ext = os.path.splitext(basename)
    target_name = "install_"+fname+".py"
    if "win32" in fname:
        target_name += "w" # opens on win without console 
    target_path = os.path.join(dirname, target_name)
    print "generate ", target_path
    zf = zipfile.ZipFile(target_path, "w",
                         compression = zipfile.ZIP_STORED, # no compression
                        )
    
    print "write __main__"
    zf.write("main_for_installer.py", "__main__.py")
    print "write", p
    zf.write(p, basename)
    zf.close()

for p in glob.glob("dist/*.zip"):
    if re.match("dist.pyOpenMS-.*(linux|win32).*.zip", p):
        pack(p)
