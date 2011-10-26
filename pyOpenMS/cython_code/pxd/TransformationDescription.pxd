
cdef extern from "<OpenMS/ANALYSIS/MAPMATCHING/TransformationDescription.h>" namespace "OpenMS":

    cdef cppclass TransformationDescription: # wrap=True;
        TransformationDescription()
        TransformationDescription(TransformationDescription)
