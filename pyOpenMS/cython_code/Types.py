#encoding: utf-8
class Type(object):

    CTYPES=["int", "long", "double", "float", "char", "void"]
    LIBCPPTYPES = ["vector", "string", "list" ]

    def __init__(self, basetype, is_ptr=False, is_ref=False, 
                       template_args=None, is_enum=False):
        self.basetype = "void" if basetype is None else basetype
        self.is_ptr = is_ptr
        self.is_ref = is_ref
        self.is_enum= is_enum
        self.template_args = template_args

def cython_repr(type_):
    """ returns cython type representation """

    if type_.is_enum:
        rv ="enum "
    else:
        rv =""
    if type_.basetype in Type.CTYPES or type_.basetype in Type.LIBCPPTYPES:
       rv += type_.basetype
    else:
        rv += "_"+type_.basetype
    if type_.template_args is not None:
        rv += "[%s]" %  ",".join(cython_repr(t) for t in type_.template_args)

    if type_.is_ptr:
        rv +=" * "
    elif type_.is_ref:
        rv +=" & "
    return rv

def cpp_repr(type_):
    """ returns C++ type representation """

    if type_.is_enum:
        rv ="enum "
    else:
        rv =""
    rv += type_.basetype
    if type_.template_args is not None:
        rv += "<%s>" %  ",".join(cpp_repr(t) for t in type_.template_args)

    if type_.is_ptr:
        rv +=" * "
    elif type_.is_ref:
        rv +=" & "
    return rv

def python_repr(type_):
    """ returns Python representation, that is the name the module
        will expose to its users """
    return type_.basetype

