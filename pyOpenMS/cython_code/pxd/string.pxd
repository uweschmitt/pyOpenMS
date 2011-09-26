
cdef extern from "<string>" namespace "std":
    cdef cppclass string: 
        string()
        string(char *)
        char * c_str()
