#!/bin/sh
unset PYTHONPATH
nosetests -w unittests --tests=testModuleLoad.py -s
nosetests -w unittests $*
