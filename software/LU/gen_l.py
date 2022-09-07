#!/usr/bin/env python

import sys
import random


def write_arr(f, name, arr):
    f.write('const int %s[N*N] = {\n' % name)
    for v in arr:
        f.write('%d,\n' % (v))
    f.write('};\n\n')
    return

################################################################################
f = open('data.h', 'w')


SIZE = 64
RANGE = 128

lu   = []

for i in range(0,SIZE):
    for j in range(0,SIZE):
        a = random.randint(0, RANGE-1)

        lu.append(a)

f.write('#define N %d\n' % SIZE)
write_arr(f, 'lu', lu)

