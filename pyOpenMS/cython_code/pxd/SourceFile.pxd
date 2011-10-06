from libcpp.string cimport *
from ChecksumType cimport *

cdef extern from "<OpenMS/METADATA/SourceFile.h>" namespace "OpenMS":

    cdef cppclass SourceFile: #wrap=True
        SourceFile()
        SourceFile(SourceFile)
        string getNameOfFile()
        void setNameOfFile(string)

        string getPathToFile()
        void setPathToFile(string)

        float getFileSize()
        void setFileSize(float)

        string getFileType()
        void setFileType(string)

        string getChecksum()
        void setChecksum(string, ChecksumType)

        ChecksumType getChecksumType()

        string getNativeIDType()
        void setNativeIDType(string)
       
    

