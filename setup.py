#input-encoding: utf-8

from distutils.core import setup, Extension
import glob, os, shutil


# ADAPT THESE LINES ! ##################################

OPEN_MS_SRC = "e:/OpenMS-1.8/"

OPEN_MS_BUILD_DIR="e:/OpenMS-1.8_BUILD"
OPEN_MS_CONTRIB_BUILD_DIR=r"e:\OpenMS-1.8\contrib_build"
QT_HOME_DEVEL = r"C:\QtSDK\Desktop\Qt\4.7.3\msvc2008"

###################################### ADAPT END #######


# package data must not be external, so copy here
if not os.path.exists("share"):
    shutil.copytree(j(OPEN_MS_SRC, "share"), "share")

j=os.path.join
libraries=["OpenMS", "xerces-c_3", "QtCore4", "gsl",
                    "cblas",
          ]

library_dirs=[OPEN_MS_BUILD_DIR, 
              j(OPEN_MS_CONTRIB_BUILD_DIR,"lib"),
              j(QT_HOME_DEVEL,"lib") ]

import numpy.core
include_dirs=[
              j(QT_HOME_DEVEL, "include"),
              j(QT_HOME_DEVEL, "include", "QtCore"),
              j(OPEN_MS_CONTRIB_BUILD_DIR, "include"),
              j(OPEN_MS_SRC ,  "include"),
              j(numpy.core.__path__[0],"include"), 
             ]


ext = Extension(
        "_pyOpenMS",
        sources = ["pyOpenMS/_pyOpenMS.cpp"], 
        language="c++",
        library_dirs = library_dirs,
        libraries = libraries,
        include_dirs = include_dirs,
 
        # /EHs is important. It sets _CPPUNWIND which causes boost to
        # set BOOST_NO_EXCEPTION in <boost/config/compiler/visualc.hpp>
        # such that  boost::throw_excption() is declared but not implemented.
        # The linker does not like that very much ...
        extra_compile_args = [ "/EHs"]  
     
    )



share_data = []

for root, _, files in os.walk(j(".", "share")):
    for f in files:
        share_data.append(j(root, f))


setup(

  name = "pyOpenMS",
  packages = ["pyOpenMS"],
  #package_dir = { "pyOpenMS" : "." },
  ext_package = "pyOpenMS",

  version="0.1",
  url="http://github.com/uweschmitt/msExpert",
  author="uwe schmitt",
  author_email="uschmitt@mineway.de",

  ext_modules = [ext ],

  package_data={ "pyOpenMS": 
                      [ "OpenMS.dll", "msvcr90.dll", "xerces-c_3_0.dll"] 
                      + share_data }
               ,
)
