#!/bin/env python3

import os
import math

cache_ways = 8
cache_entries = 128
cache_line_bytes = 16
cache_size = cache_ways * cache_entries * cache_line_bytes

if not os.path.isdir("inc"):
    os.makedirs("inc")

if not os.path.isdir("src"):
    os.makedirs("src")

def define_type(name, width, signed=False):
    s = f"#define {name} "
    if width > 64:
        s += "__"
    if not signed:
        s += "u"
    s += f"int{width}_t"
    return s


content = f"""\
#ifndef __CACHE_H__
#define __CACHE_H__

#define CACHE_WAYS {cache_ways}
#define CACHE_ENTRIES {cache_entries}
#define CACHE_LINE_BYTE {cache_line_bytes}
#define CACHE_SIZE_BYTE {cache_size}
#define NUM_WORDS {int(math.log2(cache_size) - 3)}

// cachelines are {cache_line_bytes << 3}bit long
// cache is {cache_size >> 10}kB: {cache_line_bytes}B cachelines x {cache_entries} entries x {cache_ways} ways
{define_type("cacheline_t", cache_line_bytes << 3)}

#endif
"""

with open("inc/cache.h", "w") as f:
    f.write(content)

content = f"""\
#include <stdint.h>
#include "cache.h"

extern volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES];

"""

content += "void unrolled_write() {\n"
content += "\n".join([f"*(data+{idx}) = 0x12345678;" for idx in range(cache_entries * cache_ways)])
content += "\n}\n\n"

content += "void unrolled_read() {\n"
content += "volatile uint64_t* dataptr = (uint64_t*)data;\n"
content += "\n".join([f"*(dataptr+2*{idx});" for idx in range(cache_entries * cache_ways)])
content += "\n}\n\n"

with open("src/unrolled.c", "w") as f:
    f.write(content)