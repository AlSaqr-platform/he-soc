APP := hello_pulp_l3
XLEN:=64

include $(shell pwd)/../common.mk

rtl: 
	 $(MAKE) -C ../../hardware/ all

sim:
	$(MAKE) -C ../../hardware/ sim elf-bin=$(shell pwd)/$(APP).riscv
