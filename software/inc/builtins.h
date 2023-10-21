#ifndef __BUILTINS_H__
#define __BUILTINS_H__

/* Bit set */
#define __BITSET(x, size, off)		((x) | (((1<<(size))-1)<<(off)))
#define __BITSET_R(x, size, off)		((x) | (((1<<(size))-1)<<(off)))
#define __BITSET_R_SAFE(x, size, off)	((x) | (((1<<((size)&0x1F))-1)<<((off)&0x1F)))

/* Bit clr */
#define __BITCLR(x, size, off)		((x) & ~(((1<<(size))-1)<<(off)))
#define __BITCLR_R(x, size, off)		((x) & ~(((1<<(size))-1)<<(off)))
#define __BITCLR_R_SAFE(x, size, off)	((x) & ~(((1<<((size)&0x1F))-1)<<((off)&0x1F)))

/* Bit Extraction */
#define __BITEXTRACT(x, size, off) 		(((((x)>>(off))&((unsigned int)(1<<(size))-1))<<(32-(size)))>>(32-(size)))
#define __BITEXTRACTU(x, size, off)		(((x)>>(off))&((unsigned int)(1<<(size))-1))

#define __BITEXTRACT_R(x, size, off) 	(((((x)>>(off))&((unsigned int)(1<<(size))-1))<<(32-(size)))>>(32-(size)))
#define __BITEXTRACTU_R(x, size, off)	(((x)>>(off))&((unsigned int)(1<<(size))-1))

#define __BITEXTRACT_R_SAFE(x, size, off) 	(((((x)>>((off)&0x1F))&((unsigned int)(1<<((((size)>32)?32:(size))))-1))<<(32-((((size)>32)?32:(size)))))>>(32-((((size)>32)?32:(size)))))
#define __BITEXTRACTU_R_SAFE(x, size, off)	(((x)>>((off)&0x1F))&((unsigned int)(1<<((((size)>32)?32:(size))))-1))

/* Bit insertion */
#define __BITINSERT(dst, src, size, off) 	(((dst) & ~(((1<<(size))-1)<<(off))) | (((src) & ((1<<(size))-1))<<(off)))
#define __BITINSERT_R(dst, src, size, off) 	(((dst) & ~(((1<<(size))-1)<<(off))) | (((src) & ((1<<(size))-1))<<(off)))
#define __BITINSERT_R_SAFE(dst, src, size, off) 	(((dst) & ~(((1<<(((size)>32)?32:(size)))-1)<<((off)&0x1F))) | (((src) & ((1<<(((size)>32)?32:(size)))-1))<<((off)&0x1F)))

#define GAP_BINSERT(dst,src,size,off)  __BITINSERT(dst,src,size,off)
#define GAP_BINSERT_R(dst,src,size,off)  __BITINSERT_R(dst, src, size, off)
#define GAP_BEXTRACTU(src,size,off)    __BITEXTRACTU(src, size, off)
#define GAP_BEXTRACT(src,size,off)     __BITEXTRACT(src, size, off)

#endif
