current_dir = $(shell pwd)

utils_dir = $(SW_HOME)/inc/

directories = . drivers/inc drivers/src string_lib/inc string_lib/src

INC=$(foreach d, $(directories), -I$(utils_dir)$d)

inc_dir := $(SW_HOME)/common_pulp

RISCV_PREFIX ?= riscv$(XLEN)-unknown-elf-
RISCV_GCC ?= $(RISCV_PREFIX)gcc

RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

RISCV_FLAGS     := -mcmodel=medany -static -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf $(INC)
RISCV_LINK_OPTS := -static -nostartfiles -lm -lgcc

clean:
	echo $(current_dir)
	rm -f $(APP).riscv
	rm -f $(APP).dump
	rm -f *.bin

build:
	$(RISCV_GCC) $(RISCV_FLAGS) -T $(inc_dir)/test.ld $(RISCV_LINK_OPTS) $(inc_dir)/crt.S $(inc_dir)/syscalls.c -L $(inc_dir) $(APP).c -o $(APP).riscv


dis:
	$(RISCV_OBJDUMP) $(APP).riscv > $(APP).dump

dump_header:
	riscv32-unknown-elf-objcopy --pad-to 0x0 -O binary $(APP).riscv cluster.bin
	$(inc_dir)/elf_to_header.py --binary=$(current_dir)/$(APP).riscv --vectors=$(current_dir)/../cluster_code.h

all: clean build dis dump_header

