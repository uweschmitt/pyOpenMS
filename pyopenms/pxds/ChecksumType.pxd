
cdef extern from "<OpenMS/METADATA/SourceFile.h>" namespace "OpenMS::SourceFile":
    cdef enum ChecksumType: # wrap=True; 
           UNKNOWN_CHECKSUM, SHA1, MD5, SIZE_OF_CHECKSUMTYPE
