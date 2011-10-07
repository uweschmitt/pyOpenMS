#encoding: utf-8


class Type(object):

    CTYPES = ["int", "long", "double", "float", "char", "void"]
    LIBCPPTYPES = ["vector", "string", "list"]

    def __init__(self, basetype, is_ptr=False, is_ref=False,
                       is_unsigned = False,
                       template_args=None, is_enum=False):
        self.basetype = "void" if basetype is None else basetype
        self.is_ptr = is_ptr
        self.is_ref = is_ref
        self.is_unsigned = is_unsigned
        self.is_enum = is_enum
        self.template_args = template_args


def cy_repr(type_):
    """ returns cython type representation """

    if type_.is_enum:
        rv = "enum "
    else:
        rv = ""
    if type_.basetype in Type.CTYPES or type_.basetype in Type.LIBCPPTYPES:
        if type_.is_unsigned:
           rv += "unsigned "
        rv += type_.basetype
    else:
        rv += "_" + type_.basetype
    if type_.template_args is not None:
        rv += "[%s]" % ",".join(cy_repr(t) for t in type_.template_args)

    if type_.is_ptr:
        rv += " * "
    elif type_.is_ref:
        rv += " & "
    return rv


def cpp_repr(type_):
    """ returns C++ type representation """

    if type_.is_enum:
        rv = "enum "
    else:
        rv = ""

    if type_.is_unsigned:
        rv += "unsigned "
    rv += type_.basetype
    if type_.template_args is not None:
        rv += "<%s>" % ",".join(cpp_repr(t) for t in type_.template_args)

    if type_.is_ptr:
        rv += " * "
    elif type_.is_ref:
        rv += " & "
    return rv


def py_repr(type_):
    """ returns Python representation, that is the name the module
        will expose to its users """
    return type_.basetype

def py_type_for_cpp_type(type_):
    key = (type_.basetype, type_.is_ptr, type_.is_ref, type_.is_unsigned)
               #bt     isptr isref  isunsigned
    return {  ("char", True, False, False) : "str",

              ("long", False, False, True) : "int",
              ("long", False, False, False): "int",
              ("long", False, True, True)  : "int",
              ("long", False, True, False) : "int",
              
              # long* not supproted:
              ("long", True, False, True) : None,
              ("long", True, False, False): None,
              ("long", True, True, True)  : None,
              ("long", True, True, False) : None,

              ("int",  False, False, True) : "int",
              ("int",  False, False, False): "int",
              ("int",  False, True, True)  : "int",
              ("int",  False, True, False) : "int",

              # int* not supproted:
              ("int", True, False, True) : None,
              ("int", True, False, False): None,
              ("int", True, True, True)  : None,
              ("int", True, True, False) : None,

              ("float", False, False, False): "float",
              ("float", False, True, False): "float",

              # float* not supproted:
              ("float", True, False, False): None,
              ("float", True, True, False): None,

              ("double", False, False, False): "float",
              ("double", False, True, False): "float",

              # double* not supproted:
              ("double", True, False, False): None,
              ("double", True, True, False): None,
           }.get( key, type_.basetype)


