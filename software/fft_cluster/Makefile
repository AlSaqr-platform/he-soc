APP := stimuli
XLEN:=64

gen_twiddles_c:
	 gcc gen_twiddles.c -o gentwiddles -lm
	./gentwiddles > twiddles.h

include $(shell pwd)/../common.mk

