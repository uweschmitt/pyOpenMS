
from cython.operator cimport address as addr, dereference as deref

# somehow the order if inclusion is important,
# else we get type clash due when openms includes
# headers

#include "MzMLFile.pyx"
#include "MzXMLFile.pyx"
#include "MzDataFile.pyx"
#include "Param.pyx"
#include "Spectrum.pyx"
#include "PeakMap.pyx"

#include "Feature.pyx"
#include "FeatureMap.pyx"

#include "FeatureFinder.pyx"

#include "helpers.pyx"

#include "InternTests.pyx"
include "all.pyx"
