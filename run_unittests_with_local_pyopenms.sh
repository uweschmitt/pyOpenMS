#!/bin/sh
python check_test_coverage.py
export PYTHONPATH=.
nosetests -w unittests $*
