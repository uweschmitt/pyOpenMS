@set PYTHONPATH=
@python check_test_coverage.py
@nosetests -w unittests %*
