#!/bin/sh
cd  pyOpenMS/cython_code; 
source generate_code_and_cythonize.sh
if [ $? -eq 0 ]; then
    cd ../..
    python setup.py  install --user 
    # python setup.py build_ext --inplace starts compiler again !
    # so just copy the extension module from the last step:
    cp $(find build -name pyOpenMS.pyd) pyOpenMS/
fi
