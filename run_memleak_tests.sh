#!/bin/sh
export PYTHONPATH=.
nosetests -s -w memoryleaktests/ $*
