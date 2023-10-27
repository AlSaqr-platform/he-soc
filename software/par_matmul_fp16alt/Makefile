APP := par_matmul_fp16alt
XLEN:=64

include $(shell pwd)/../common.mk

rtl: 
	 $(MAKE) -C ../../hardware/ all

sim:
	$(MAKE) -C ../../hardware/ sim elf-bin=$(shell pwd)/$(APP).riscv
