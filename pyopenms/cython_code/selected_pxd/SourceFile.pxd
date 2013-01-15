from libcpp.string cimport *
from ChecksumType cimport *

cdef extern from "<OpenMS/METADATA/SourceFile.h>" namespace "OpenMS":

    cdef cppclass SourceFile: #wrap=True
        SourceFile()
        SourceFile(SourceFile)
        string getNameOfFile()
        void setNameOfFile(string) except +

        string getPathToFile()
        void setPathToFile(string) except +

        float getFileSize()
        void setFileSize(float) except +

        string getFileType()
        void setFileType(string) except +

        string getChecksum()
        void setChecksum(string, ChecksumType) except +

        ChecksumType getChecksumType()

        string getNativeIDType()
        void setNativeIDType(string) except +
       
    

