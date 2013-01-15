@echo "generate pyOpenMS.pyx"
@python build_cython_file.py
@echo "generate pyOpenMS.cpp"
@cython -X boundscheck=False -X wraparound=False --cplus pyOpenMS.pyx 
@echo "copy pyOpenMS.cpp"
@move pyOpenMS.cpp ..
@echo "done"
