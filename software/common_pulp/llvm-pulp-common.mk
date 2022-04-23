current_dir = $(shell pwd)

utils_dir = $(SW_HOME)/inc/

directories = . drivers/inc drivers/src string_lib/inc string_lib/src

INC=$(foreach d, $(directories), -I$(utils_dir)$d)

inc_dir := $(SW_HOME)/common_pulp

RISCV_PREFIX ?= riscv$(XLEN)-unknown-elf-
RISCV_GCC ?= $(RISCV_PREFIX)gcc

RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

RISCV_FLAGS     := -mcmodel=medany -static -O2 -ffast-math -fno-common -fno-builtin-printf $(INC)
RISCV_LINK_OPTS := -static -nostartfiles -lm

CC        := clang
CC_FLAGS  := -mcmodel=medany -static --sysroot=/usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/riscv32-hero-unknown-elf
CC_LIBS   := -L /usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/riscv32-hero-unknown-elf/lib/rv32imcxpulpv2/ilp32/
CC_INC    := -I /usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/riscv32-hero-unknown-elf/include/ -I $(utils_dir) -I . -I $(INC)
LINK_OPTS := -static -nostartfiles -Wl,--gc-sections
OBJDUMP   := llvm-objdump --disassemble-all --disassemble-zeroes

clean:
	rm -f $(APP).riscv
	rm -f $(APP).dump
	rm -f $(APP).ll
	rm -f ./-*
	rm -f ../cluster_code.h

build:
	$(CC) $(CC_FLAGS) $(CC_INC) $(CC_LIBS) -O3 -target riscv32-unknown-elf -mno-relax $(inc_dir)/crt.S $(inc_dir)/syscalls.c $(APP).c $(LINK_OPTS) -Wl,-T$(inc_dir)/test.ld -o $(APP).riscv

build-sdk:
	# clang -c -emit-llvm -S -MT $(APP).ll -MMD -MP -MF -DNO_MAIN -DNO_DOUBLE -I../include  -fopenmp=libomp -O3 -static -fhero-device-default-as=device -target riscv32-hero-unknown-elf -I/scratch/ytortorella/hero-sdk/pulp/sdk/pkg/sdk/dev/install/include -I/scratch/ytortorella/hero-sdk/openmp-examples/common -include hero_64.h va_list.c
	clang -c -emit-llvm -S -MT $(APP).ll -MMD -MP -MF -DNO_MAIN -DNO_DOUBLE -I/scratch/ytortorella/hero_devel/openmp-examples/tests-pulp/ -O3 -static -target riscv32-hero-unknown-elf -I/scratch/ytortorella/hero_devel/pulp/sdk/pkg/sdk/dev/install/include -I/scratch/ytortorella/hero_devel/openmp-examples/common -include /scratch/ytortorella/hero_devel/openmp-examples/common/hero_64.h $(APP).c

build-sdk-elf:
	clang -v -DNO_MAIN -DNO_DOUBLE -I/scratch/ytortorella/hero_devel/pulp/sdk/pkg/sdk/dev/install/include -O3 -static -target riscv32-hero-unknown-elf -I/scratch/ytortorella/hero_devel/pulp/sdk/pkg/sdk/dev/install/include $(APP).ll  -static -o $(APP).riscv

dis:
	$(OBJDUMP) $(APP).riscv > $(APP).dump

dump_header:
	$(inc_dir)/elf_to_header.py --binary=$(current_dir)/$(APP).riscv --vectors=$(current_dir)/../cluster_code.h

all: clean build dis dump_header
