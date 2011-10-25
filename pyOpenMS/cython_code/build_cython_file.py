#encoding: utf-8
from DelegateClassGenerator import Generator, Code
from Types import Type



    


if __name__ == "__main__":

    import sys, glob
    g = Generator()
    g.parse_all(glob.glob("pxd/*.pxd"))


    c = Code()
    c += g.generate_startup()

    c += "cimport numpy as np"
    c += "import numpy as np"

    css = Code()
    css += """
            cdef class str_to_String:
                cdef String * inst 
                def __calloc__(self):
                    inst = NULL
                def __dealloc__(self):
                    if self.inst:
                        del self.inst
                def __init__(self, char * c):
                    inst = String(c)
                def conv(self):
                    return inst
           """

    #g.register_additional_input_converter(Type(u"String"), css)
                
    

    for clz_name in [
                    "PeakPickerHiRes",
                    "Peak1D", 
                     "Precursor", 
                     "MSExperiment",
                    "InstrumentSettings", 
                     "ChromatogramTools", 
                     "Polarity",
                    "MzXMLFile", 
                     "MzMLFile", 
                     "MzDataFile", 
                     "StringList",
                    "IntList", 
                     "DoubleList", 
                     "String",
                    "SourceFile",
                      "ChecksumType", 
                     "DataValue" ,
                    "SavitzkyGolayFilter",
                    "DataType",
                    "FileHandler",
                    "LogType",
                                ]:

       c += g.generate_code_for(clz_name)

    c += g.generate_code_for("MSSpectrum")

    c>>1
    c.addFile("MSSpectrumHelpers.pyx")
    c<<1

    c += g.generate_code_for("Param")
    c>>1
    c.addFile("ParamHelpers.pyx")
    c<<1

    c += g.generate_converters()

    with open("pyOpenMS.pyx", "w") as out: 
        c.write(out=out)
