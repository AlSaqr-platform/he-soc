
min = -2 ** (12-1)
max = 2 ** (12-1) - 1
step = 16 # Read only half cacheline

content = """\
#include <stdint.h>
#include "cache.h"

"""

content += """\
void reads(volatile cacheline_t *base_addr) {

\tasm volatile (
"""
content += ';"\n'.join([f'\t\t"ld t0, {offset}(%0)' for offset in range(min, max, step)])
content += '"'

content += """
\t\t:
\t\t: "r" (base_addr)
\t\t: "t0"
\t);
}

"""

content += """\
void writes(volatile cacheline_t *base_addr) {

\tasm volatile (
"""
content += '\t\t"li t0, 0x1234ABCD;"\n'
content += ';"\n'.join([f'\t\t"sd t0, {offset}(%0)' for offset in range(min, max, step)])
content += '"'

content += """
\t\t:
\t\t: "r" (base_addr)
\t\t: "t0"
\t);
}
"""

with open("src/unrolled.c", "w") as f:
    print(content, file=f)