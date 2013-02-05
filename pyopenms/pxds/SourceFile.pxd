from libcpp.string cimport string as libcpp_string
from ChecksumType cimport *

cdef extern from "<OpenMS/METADATA/SourceFile.h>" namespace "OpenMS":

    cdef cppclass SourceFile:
        SourceFile() except +
        SourceFile(SourceFile) except +
        libcpp_string getNameOfFile() except +
        void setNameOfFile(libcpp_string) except +

        libcpp_string getPathToFile() except +
        void setPathToFile(libcpp_string) except +

        float getFileSize() except +
        void setFileSize(float) except +

        libcpp_string getFileType() except +
        void setFileType(libcpp_string) except +

        libcpp_string getChecksum() except +
        void setChecksum(libcpp_string, ChecksumType) except +

        ChecksumType getChecksumType() except +

        libcpp_string getNativeIDType() except +
        void setNativeIDType(libcpp_string) except +

