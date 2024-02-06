#!/bin/env python3

import os

cache_ways = 8
cache_entries = 256
cache_line_bytes = 16
cache_size = cache_ways * cache_entries * cache_line_bytes

if not os.path.isdir("inc"):
    os.makedirs("inc")

def define_type(name, width, signed=False):
    s = f"#define {name} "
    if width > 64:
        s += "__"
    if not signed:
        s += "u"
    s += f"int{width}_t"
    return s


header_preamble = """\
#ifndef __CACHE_H__
#define __CACHE_H__

"""

header_body = f"""\
#define CACHE_WAYS {cache_ways}
#define CACHE_ENTRIES {cache_entries}
#define CACHE_LINE_BYTE {cache_line_bytes}
#define CACHE_SIZE_BYTE {cache_size}

"""

header_prologue = """\
#endif
"""

with open("inc/cache.h", "w") as f:
    f.write(header_preamble + header_body + header_prologue)

header_preamble = f"""\
#ifndef __TEST_UTILS_H__
#define __TEST_UTILS_H__

#include <stdint.h>

// cachelines are {cache_line_bytes << 3}bit long
// cache is {cache_size >> 10}kB: {cache_line_bytes}B cachelines x {cache_entries} entries x {cache_ways} ways
{define_type("cacheline_t", cache_line_bytes << 3)}
{define_type("half_cacheline_t", cache_line_bytes << 2)}

"""

header_body += "void unrolled_write() {\n"
header_body += "\n".join([f"*(data+{idx}) = 0x12345678;" for idx in range(cache_entries * cache_ways)])
header_body += "\n}\n\n"

header_body += "void unrolled_read() {\n"
header_body += "volatile half_cacheline_t* dataptr = (half_cacheline_t*)data;\n"
header_body += "\n".join([f"*(dataptr+2*{idx});" for idx in range(cache_entries * cache_ways)])
header_body += "\n}\n\n"

header_prologue = """\
#endif
"""

with open("inc/test_utils.h", "w") as f:
    f.write(header_preamble + header_body + header_prologue)