#!/bin/sh
python setup.py bdist 
if [ $? -eq 0 ]; then
    echo
    python build_executable_installer.py
fi

