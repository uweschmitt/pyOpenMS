import re as __re

def __sig(a):
    t = type(a) 
    m = __re.match("<type '[^.]*\.(\w+)'>", str(t))
    if m is not None:
        return m.groups()[0]
    if t==list: 
        if len(a)==0:
            return 'list[]'
        return 'list[%s]' % __sig(a[0])
    return { str: 'str', 
             int: 'int', 
             float: 'float', 
            }.get(t,t) 
