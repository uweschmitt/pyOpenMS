#!/bin/sh
rm -rf dist/*
python setup.py bdist $*
if [ $? -eq 0 ]; then
    echo
    python build_zip_for_install.py
fi

