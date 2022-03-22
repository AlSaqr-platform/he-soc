APP := dma_c2h
XLEN:=64

STIM = 1

include $(SW_HOME)/common/common.mk

rtl: 
	 $(MAKE) -C ../../../hardware/ all

sim:
	$(MAKE) -C ../../../hardware/ sim elf-bin=$(shell pwd)/$(APP).riscv
