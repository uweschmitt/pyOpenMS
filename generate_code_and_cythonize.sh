#!/bin/sh
cd  pyOpenMS/cython_code; 
source generate_code_and_cythonize.sh
if [ $? -eq 0 ]; then
    cd ../..
    python setup.py install --user
fi
