import re
import os
import types

def parse_file(path_list, regex_list):
    if not isinstance(path_list, (types.ListType, types.TupleType)):
        path_list = [path_list]

    if not isinstance(regex_list, (types.ListType, types.TupleType)):
        regex_list = [regex_list]

    lines = []
    for path in path_list:
        try:
            file = open(path, 'r')
            lines.extend(file.readlines())
            file.close()
        except IOError, e:
            logger.exception(e)

    ret = {}
    for line in lines:
        for regex in regex_list:
            match = regex.match(line)
            if match:
                for k, v in match.groupdict().iteritems():
                    ov = ret.get(k, v)
                    if k in ret:
                        ov.append(v)
                    else:
                        ov = [ov]
                    ret[k] = ov

    return ret
