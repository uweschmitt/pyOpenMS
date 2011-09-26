#include <list>
#include <vector>
#include <iostream>
#include <sstream>
#include <string>
#include <OpenMS/DATASTRUCTURES/Param.h>

using namespace std;
using namespace OpenMS;


list<string> getKeys(Param &p)
{
    // workaround da cython probleme mit inneren klassen hat, falls die auessere klasse
    // keine template klasse ist.
    // -> http://groups.google.com/group/cython-users/msg/74f76f92b5305470
    list<string> rv;
    list<string> path;
    for (Param::ParamIterator param_it = p.begin(); param_it != p.end(); ++param_it)
    {
        vector<Param::ParamIterator::TraceInfo> tr = param_it.getTrace();
        for (vector<Param::ParamIterator::TraceInfo>::iterator trace_it = tr.begin(); trace_it != tr.end(); ++trace_it)
        {
            if (trace_it->opened)
                path.push_back(trace_it->name);
            else
                path.pop_back();
        }

        ostringstream trace;
        for (list<string>::iterator path_it = path.begin(); path_it != path.end(); ++path_it)
            trace << *path_it << ":" ;
        trace << param_it->name;
        rv.push_back(trace.str());
    }
    return rv;
}

// workaround: operator++ macht in cython probleme
list<string>::iterator next(list<string>::iterator it)
{
    return ++it;
}
