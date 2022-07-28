APP := main
XLEN:=64

gen_header_c:
	 gcc gen_input.c -o geninput -lm
	./geninput > input.h
	 gcc -std=c99 golden.c -o golden -lm
	./golden > ref.h

include $(shell pwd)/../common.mk
