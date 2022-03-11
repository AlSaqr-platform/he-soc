APP := stimuli
XLEN:=32

current_dir = $(shell pwd)

utils_dir = $(current_dir)/../../inc/

directories = . drivers/inc drivers/src string_lib/inc string_lib/src

INC=$(foreach d, $(directories), -I$(utils_dir)$d)

inc_dir := $(current_dir)/../../common_pulp

RISCV_PREFIX ?= riscv$(XLEN)-unknown-elf-
RISCV_GCC ?= $(RISCV_PREFIX)gcc

RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

RISCV_FLAGS     := -mcmodel=medany -static -O2 -ffast-math -fno-common -fno-builtin-printf $(INC)
RISCV_LINK_OPTS := -static -nostartfiles -lm

CC        := clang
CC_FLAGS  := -mcmodel=medany -static --sysroot=/usr/scratch/lagrev1/ytortorella/hero_devel/install/riscv32-unknown-elf
CC_LIBS   := -L /usr/scratch/lagrev1/ytortorella/hero_devel/install/riscv32-unknown-elf/lib/rv32imcxpulpv2/ilp32/
CC_INC    := -I /usr/scratch/lagrev1/ytortorella/hero_devel/install/riscv32-unknown-elf/include/ -I $(utils_dir) -I $(inc_dir) -I $(INC)
LINK_OPTS := -static -nostartfiles
OBJDUMP   := llvm-objdump --disassemble-all --disassemble-zeroes

clean:
	rm -f $(APP).riscv
	rm -f $(APP).dump

build:
	$(CC) $(CC_FLAGS) $(CC_INC) $(CC_LIBS) -target riscv32-unknown-elf -mno-relax $(inc_dir)/crt.S $(inc_dir)/syscalls.c $(APP).c $(LINK_OPTS) -Wl,-T$(inc_dir)/test.ld -o $(APP).riscv

dis:
	$(OBJDUMP) $(APP).riscv > $(APP).dump

dump_header:
	$(inc_dir)/elf_to_header.py --binary=$(current_dir)/$(APP).riscv --vectors=$(current_dir)/../cluster_code.h

all: clean build dis dump_header
