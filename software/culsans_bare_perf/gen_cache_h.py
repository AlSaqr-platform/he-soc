#!/bin/env python3

import os

cache_ways = 8
cache_entries = 128
cache_line_bytes = 16
cache_size = cache_ways * cache_entries * cache_line_bytes

stride = cache_line_bytes >> 3

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


content = f"""\
#ifndef __CACHE_H__
#define __CACHE_H__

#define CACHE_WAYS {cache_ways}
#define CACHE_ENTRIES {cache_entries}
#define CACHE_LINE_BYTE {cache_line_bytes}
#define CACHE_SIZE_BYTE {cache_size}

// cachelines are {cache_line_bytes << 3}bit long
// cache is {cache_size >> 10}kB: {cache_line_bytes}B cachelines x {cache_entries} entries x {cache_ways} ways
{define_type("cacheline_t", cache_line_bytes << 3)}

#endif
"""

with open("inc/cache.h", "w") as f:
    f.write(content)