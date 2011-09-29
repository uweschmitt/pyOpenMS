import platform

if not hasattr(platform, "win32_ver"):
    print
    print "THIS IS NO WINDOWS OS, SO DO NOT EXPECT THIS STUFF TO RUN"
    print

compilers={ "1000" : "Visual C++ 4.x",
            "1100" : "Visual C++ 5",
            "1200" : "Visual C++ 6",
            "1300" : "Visual C++ .NET 2003",
            "1400" : "Visual C++ 2005",
            "1500" : "Visual C++ 2008"
          }
    

compiler = platform.python_compiler()
if not compiler.startswith("MSC v."):
    print
    print "DO NOT UNDERSTAND %r" % compiler
    print


ver = compiler[6:10]
bits= compiler[11:17]

print
print "for building pyOpenMS you need:"
print "  - OPEN-MS sources"
print "  - OpenMS.dll"
print "  - built OPEN-MS contrib package"
print "  - QtSDK 4.7.x"
print "  -", compilers.get(ver, "MSC v."+ver), bits
print
    
print
print "please install the needed packages and modify setup.py"
print
