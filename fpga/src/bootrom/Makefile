# Copyright 2020 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51
#
# Nils Wistoff <nwistoff@iis.ee.ethz.ch>

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR  := $(dir $(MKFILE_PATH))
ROOT        := ${MKFILE_DIR}../../../../..
ARIANE_SDK  ?= ${ROOT}/../ariane-sdk
INCLUDES = -I./ -I./src
SRCS_C = src/main.c src/uart.c
OBJS_C = $(SRCS_C:.c=.o)

.PHONY: all
all: bootrom.coe

%.o: %.c
	riscv64-unknown-elf-gcc -Os -ggdb -march=rv64imafd -mabi=lp64d -Wall -mcmodel=medany -mexplicit-relocs -fno-builtin $(INCLUDES) -c $<  -o $@
	@echo "CC    <= $<"

%.dtb: %.dts
	dtc -I dts $< -O dtb -o $@

bootrom.elf bootrom.dump bootrom.bin: bootrom.S $(OBJS_C) bootrom.ld occamy.dtb
	riscv64-unknown-elf-gcc -mabi=lp64d -march=rv64imafd -static -nostartfiles $(INCLUDES) -Tbootrom.ld $< $(OBJS_C) -o bootrom.elf
	riscv64-unknown-elf-objdump -d bootrom.elf > bootrom.dump
	riscv64-unknown-elf-objcopy --pad-to 0x1001000 -O binary bootrom.elf bootrom.bin


%.coe: %.bin 
	bin2coe -i $< -o $@ -w 64
	cp bootrom.coe ../../../hardware/fpga/alsaqr/tcl/ips/boot_rom/boot_code.coe
	python3 gen_rom_sv.py --binary bootrom.elf --vectors bootrom.sv

clean:
	rm -rf *.bin *.coe *.dump src/*.o *.dtb

#  export PATH=$PATH:~/.local/bin
