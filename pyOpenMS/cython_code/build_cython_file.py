#encoding: utf-8
from DelegateClassGenerator import Generator, Code
if __name__ == "__main__":

    import sys, glob
    g = Generator()
    g.parse_all(glob.glob("pxd/*.pxd"))


    c = Code()
    c.addCode(g.generate_import_statements(), indent=0)

    c += "cimport numpy as np"
    c += "import numpy as np"

    

    for clz_name in ["Peak1D", "Precursor", "MSExperiment",
                    "InstrumentSettings", "ChromatogramTools", "Polarity",
                    "MzXMLFile", "MzMLFile", "MzDataFile",
                    "SourceFile", "ChecksumType", "DataValue" ]:

       c.addCode(g.generate_code_for(clz_name), indent=0)

    c.addCode(g.generate_code_for("MSSpectrum"), indent=0)

    with open("MSSpectrumHelpers.pyx","r") as fp:
        c.addFile(fp, indent=1)


    with open("_pyOpenMS.pyx", "w") as out: 
        c.write(out=out)
