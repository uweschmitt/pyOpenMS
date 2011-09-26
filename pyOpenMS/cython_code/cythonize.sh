#!/bin/sh
cython -X boundscheck=False -X wraparound=False --cplus _pyOpenMS.pyx 
cp _pyOpenMS.cpp ..
