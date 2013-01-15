from libcpp.string cimport string as libcpp_string
from ChecksumType cimport *

cdef extern from "<OpenMS/METADATA/SourceFile.h>" namespace "OpenMS":

    cdef cppclass SourceFile:
        SourceFile()
        SourceFile(SourceFile)
        libcpp_string getNameOfFile()
        void setNameOfFile(libcpp_string) except +

        libcpp_string getPathToFile()
        void setPathToFile(libcpp_string) except +

        float getFileSize()
        void setFileSize(float) except +

        libcpp_string getFileType()
        void setFileType(libcpp_string) except +

        libcpp_string getChecksum()
        void setChecksum(libcpp_string, ChecksumType) except +

        ChecksumType getChecksumType()

        libcpp_string getNativeIDType()
        void setNativeIDType(libcpp_string) except +

