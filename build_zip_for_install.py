import glob
import re
import os
import zipfile
import sys

def pack(p):
    print "pack", p
    dirname = os.path.dirname(p)
    basename = os.path.basename(p)
    fname, ext = os.path.splitext(basename)
    py_version = "".join(map(str, sys.version_info[:2]))
    target_name = "install_"+fname+"_for_py_"+py_version+".zip"
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
    return target_path

print "\nBUILD INSTALLER"
print "===============\n"

for p in glob.glob("dist/pyOpenMS-*.zip"):
    fname = os.path.basename(p)
    generated = pack(p)

    basename = os.path.basename(generated)
    dirname  = os.path.dirname(generated)

    target = fname # os.path.join(dirname, fname)

    print
    print "FULL INSTALLER: ", target
    zf = zipfile.ZipFile(target, "w", compression = zipfile.ZIP_STORED)

    zipdir, _ = os.path.splitext(fname)

    zf.write(generated, zipdir+"/"+basename)
    zf.writestr(zipdir+"/install.bat", "python.exe %s" % basename)
    zf.writestr(zipdir+"/README.txt", """

    how to proceed:

            1) unzip the zip file

            2) start install.bat

            3) now you should get a dialog asking for the installation target,
               in most common cases it is enough to click "global install to.."
               or "local install to.."

    """)

    zf.close()

    os.remove(p)


