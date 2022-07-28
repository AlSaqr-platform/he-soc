#!/usr/bin/env python

import sys
import random


def write_arr(f, name, arr):
    f.write('const char %s[] = {\n' % name)
    for v in arr:
        f.write('%d,\n' % (v))
    f.write('};\n\n')
    return

def write_res(f, name, arr):
    f.write('const int %s[] = {\n' % name)
    for v in arr:
        f.write('%d,\n' % (v))
    f.write('};\n\n')
    return

################################################################################
f = open('mm.h', 'w')


SIZE = 128
RANGE = 128

m_a   = []
m_b   = []
m_exp = []

for i in range(0,SIZE):
    for j in range(0,SIZE):
        a = random.randint(0, RANGE-1)
        b = random.randint(0, RANGE-1)

        m_a.append(a)
        m_b.append(b)

for i in range(0,SIZE):
    for j in range(0,SIZE):
        r = 0

        for k in range (0,SIZE):
            r = r + m_a[i * SIZE + k] * m_b[k * SIZE + j]

        m_exp.append(r)


write_arr(f, 'm_a',   m_a)
write_arr(f, 'm_b',   m_b)
write_res(f, 'm_exp', m_exp)

f.write('#define SIZE %d\n' % SIZE)


f.write('char g_mA[SIZE][SIZE];\n')
f.write('char g_mB[SIZE][SIZE];\n')
f.write('int g_mC[SIZE][SIZE];\n')

