#!/bin/sh
valgrind -v --suppressions=valgrind-python.supp nosetests -w tests
