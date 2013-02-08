import pdb
#input-encoding: latin-1

import distribute_setup
distribute_setup.use_setuptools()

# use autowrap to generate cython file for wrapping openms:

import autowrap

print autowrap.__file__
import glob

pxd_files = glob.glob("pyopenms/pxds/*.pxd")
#pxd_files = ["pyopenms/pxds/TransformationDescription.pxd"]

import special_autowrap_conversionproviders
special_autowrap_conversionproviders.register_all()

spectra_extra_code = autowrap.Code.Code().add(
                             open("pyopenms/spectrum_addons.pyx", "r").read()
        )
param_extra_code = autowrap.Code.Code().add(
                             open("pyopenms/param_addons.pyx", "r").read()
        )

extra_methods = dict(MSSpectrum = [spectra_extra_code],
                     Param = [param_extra_code])

autowrap_include_dirs = autowrap.parse_and_generate_code(pxd_files, ".",
                                                "pyopenms/pyopenms.pyx",
                                                False,
                                                extra_methods)

# call cython to generate cpp source file for extension.
#
# (we do not use Extension from cython here, which would take pyopenms.pyx
# and create pyopenms.cpp and compile automatically, as we do not use the
# old distutils here (see lines 3, 4 of this file) and we had some trouble
# to combine cythons Extension() with distribute)

from Cython.Compiler.Main import compile, CompilationOptions
options = CompilationOptions(include_path=autowrap_include_dirs, cplus=True)
compile("pyopenms/pyopenms.pyx", options=options)

from setuptools import setup, Extension

import os, shutil
import sys
import time

# create version information

ctime = os.stat("pyopenms").st_mtime
ts = time.gmtime(ctime)
timestamp = "%02d-%02d-%4d" % (ts.tm_mday, ts.tm_mon, ts.tm_year)

from version import version
full_version= "%s_%s" % (version, timestamp)

print >> open("pyopenms/version.py", "w"), "version=%r\n" % version

# import config

from env import *

# parse config

if OPEN_MS_CONTRIB_BUILD_DIRS.endswith(";"):
    OPEN_MS_CONTRIB_BUILD_DIRS = OPEN_MS_CONTRIB_BUILD_DIRS[:-1]

for OPEN_MS_CONTRIB_BUILD_DIR in  OPEN_MS_CONTRIB_BUILD_DIRS.split(";"):
    if os.path.exists(OPEN_MS_CONTRIB_BUILD_DIR):
        break


j=os.path.join

# package data expected to be installed. on linux the debian package
# contains share/ data and must be intalled to get access to the openms shared
# library.
#
# windows ?

iswin = sys.platform == "win32"

if iswin:
    shutil.copy(OPEN_MS_LIB, "pyopenms")

    shutil.copy(MSVCRDLL, "pyopenms")
    shutil.copy(j(OPEN_MS_CONTRIB_BUILD_DIR, "lib", "xerces-c_3_0.dll"),\
                    "pyopenms")

    libraries=["OpenMSd", "xerces-c_3D", "QtCored4", "gsl_d",
                        "cblas_d",
              ]
    libraries=["OpenMS", "xerces-c_3", "QtCore4", "gsl",
                        "cblas",
              ]

elif sys.platform == "linux2":

    # shutil.copy(OPEN_MS_LIB, "pyOpenMS")

    libraries=["OpenMS", "xerces-c", "QtCore", "gsl",
                        "gslcblas",
              ]

else:
    print
    print "platform ", sys.platform, "not supported yet"
    print
    exit()

library_dirs=[ OPEN_MS_BUILD_DIR,
               j(OPEN_MS_BUILD_DIR,"lib"),
               j(OPEN_MS_CONTRIB_BUILD_DIR,"lib"),
               QT_LIBRARY_DIR,
              ]


import numpy

include_dirs=[
    QT_HEADERS_DIR,
    QT_QTCORE_INCLUDE_DIR,
    j(OPEN_MS_CONTRIB_BUILD_DIR, "include"),
    j(OPEN_MS_CONTRIB_BUILD_DIR, "src", "boost_1_42_0", "include", "boost-1_42"),
    j(OPEN_MS_BUILD_DIR ,  "include"),
    j(OPEN_MS_SRC ,  "include"),
    j(numpy.core.__path__[0],"include"),
             ]


ext = Extension(
        "pyopenms",
        sources = ["pyopenms/pyopenms.cpp"],
        language="c++",
        library_dirs = library_dirs,
        libraries = libraries,
        include_dirs = include_dirs + autowrap_include_dirs,

        # /EHs is important. It sets _CPPUNWIND which causes boost to
        # set BOOST_NO_EXCEPTION in <boost/config/compiler/visualc.hpp>
        # such that  boost::throw_excption() is declared but not implemented.
        # The linker does not like that very much ...
        extra_compile_args = iswin and [ "/EHs"] or ["-g"]

    )


# share_data paths have to be relative to pyOpenMS not to ".",
# see the parameters when calling setup() below.
# so we have to strip a leading "pyOpenMS" in root:
share_data = []
"""
for root, _, files in os.walk(local_share_dir):
    if ".svn" in root: continue #
    if ".git" in root: continue #
    fields = root.split(os.path.sep)
    #print fields
    if fields[0]=="pyOpenMS":
        fields = fields[1:]
    # omit examples, make package too large and are not needed
    if len(fields) > 2 and fields[2] == "examples":
        continue
    root = os.path.sep.join(fields)
    for f in files:
        share_data.append(j(root, f))

"""

if iswin:
    share_data += [MSVCRDLL, "xerces-c_3_0.dll"]
else:
    share_data += ["pyopenms/libOpenMS.so" ]


share_data.append("License.txt")

setup(

    name = "pyopenms",
    packages = ["pyopenms"],
    ext_package = "pyopenms",

    version = full_version,

    url="http://github.com/uweschmitt/pyopenms",

    author="Uwe Schmitt",
    author_email="uschmitt@mineway.de",

    ext_modules = [ext ],

    # setup_requires=["autowrap", "cython"],

    package_data= { "pyopenms": share_data },
)
