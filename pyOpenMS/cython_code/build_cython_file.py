#encoding: utf-8
from DelegateClassGenerator import Generator, Code
from Types import Type



    


if __name__ == "__main__":

    import sys, glob
    g = Generator()
    g.parse_all(glob.glob("pxd/*.pxd"))

    StringList    = Type(u"StringList")
    string_vector = Type("vector", False, False, False, [ Type("string") ])

    #g.add_result_alias(StringList, string_vector)
    #g.add_input_alias(StringList, string_vector)


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
                
    

    for clz_name in ["Peak1D", "Precursor", "MSExperiment",
                    "InstrumentSettings", "ChromatogramTools", "Polarity",
                    "MzXMLFile", "MzMLFile", "MzDataFile", "StringList",
                    "IntList", "DoubleList", "Param", "String",
                    "SourceFile", "ChecksumType", "DataValue" ]:

       c += g.generate_code_for(clz_name)

    c += g.generate_code_for("MSSpectrum")

    c>>1
    c.addFile("MSSpectrumHelpers.pyx")
    c<<1

    c += g.generate_converters()

    with open("_pyOpenMS.pyx", "w") as out: 
        c.write(out=out)
