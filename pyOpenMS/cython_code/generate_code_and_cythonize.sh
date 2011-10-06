#!/bin/sh
echo "generate _pyOpenMS.pyx"
python build_cython_file.py

if [ $? -eq 0 ]; then
echo "generate _pyOpenMS.cpp"
cython -X boundscheck=False -X wraparound=False --cplus _pyOpenMS.pyx 
fi

if [ $? -eq 0 ]; then
echo "copy _pyOpenMS.cpp"
mv _pyOpenMS.cpp ..
echo "done"
fi
