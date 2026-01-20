#!/usr/bin/env python3

import sys
import random


def write_arr(f, name, arr):
    f.write('const float %s[] = {\n' % name)
    for v in arr:
        f.write('    %f,\n' % v)
    f.write('};\n\n')


def write_res(f, name, arr):
    f.write('const float %s[] = {\n' % name)
    for v in arr:
        f.write('    %f,\n' % v)
    f.write('};\n\n')


# ---------------------------------------------------------------
f = open('mm_fp.h', 'w')

SIZE = 16
RANGE = 16.0

m_a   = []
m_b   = []
m_exp = []

# Generate random FP32 matrices
for i in range(SIZE):
    for j in range(SIZE):
        a = random.uniform(0, RANGE)
        b = random.uniform(0, RANGE)

        m_a.append(a)
        m_b.append(b)

# Compute FP32 matrix multiplication
for i in range(SIZE):
    for j in range(SIZE):
        r = 0.0
        for k in range(SIZE):
            r += m_a[i * SIZE + k] * m_b[k * SIZE + j]
        m_exp.append(r)

# Write arrays
write_arr(f, 'm_a',   m_a)
write_arr(f, 'm_b',   m_b)
write_res(f, 'm_exp', m_exp)

# Constants
f.write('#define SIZE %d\n' % SIZE)

# Global FP32 matrices
f.write('float g_mA[SIZE][SIZE];\n')
f.write('float g_mB[SIZE][SIZE];\n')
f.write('float g_mC[SIZE][SIZE];\n')

f.write('float g_mA1[SIZE][SIZE];\n')
f.write('float g_mB1[SIZE][SIZE];\n')
f.write('float g_mC1[SIZE][SIZE];\n')
