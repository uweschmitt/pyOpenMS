import re

def _sig(a):
    t = type(a) 
    m = re.match("<type '[^.]*\.(\w+)'>", str(t))
    if m is not None:
        return m.groups()[0]
    if t==list: 
        if len(a)==0:
            return 'list[]'
        return 'list[%s]' % _sig(a[0])
    return { str: 'str', 
             int: 'int', 
             float: 'float', 
            }.get(t,t) 
