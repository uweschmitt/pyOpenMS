# the following empty line is important

    def asBunch(Param self):


        class Bunch(dict):
            __getattr__ = dict.__getitem__
            def __setattr__(self, k, v):
                self[k] = v

            def __missing__(self, k):
                self[k] = Bunch()
                return self[k]

            def __str__(self):
                return "\n".join(self._to_str_list())

            def _to_str_list(self):
                rv = []
                # two similar for loops to get output in nice order:
                for k, v in self.items():
                    if not isinstance(v, Bunch):
                        rv.append("%s=%s" % (k,v))
                for k, v in self.items():
                    if isinstance(v, Bunch):
                        for postfix in v._to_str_list():
                            rv.append("%s.%s" % (k, postfix))
                return rv


        cdef list keys = list()

        cdef _ParamIterator param_it = self.inst.get().begin()
        while param_it != self.inst.get().end():
            keys.append(param_it.getName().c_str())
            inc(param_it)

        result = Bunch()

        for k in keys:
            fields = k.split(":")
            d = result
            for f in fields[:-1]:
                if not f in d:
                    d[f]=Bunch()
                d = d[f]
            value = self.getValue(k)

            dt = value.valueType()
            if dt == DataType.STRING_VALUE:
                value = value.toString()
            elif dt == DataType.INT_VALUE:
                value = value.toInt()
            elif dt == DataType.DOUBLE_VALUE:
                value = value.toFloat()
            elif dt == DataType.DOUBLE_LIST:
                value = value.toDoubleList()
            elif dt == DataType.STRING_LIST:
                value = value.toStringList()
            elif dt == DataType.INT_LIST:
                value = value.toIntList()

            d[fields[-1]] = value

        return Bunch(result)

    def updateFrom(self, dd):
        assert isinstance(dd, dict)

        def to_items(dd):
            rv = []
            # two similar for loops to get output in nice order:
            for k, v in dd.items():
                if not isinstance(v, dict):
                    rv.append((k,v))
            for k, v in dd.items():
                if isinstance(v, dict):
                    for postfix, v in to_items(v):
                        rv.append(("%s:%s" % (k, postfix), v))
            return rv

        for key, v in to_items(dd):
            tags = self.getTags(key)
            desc = self.getDescription(key)
            self.setValue(key, DataValue(v), desc, tags)
