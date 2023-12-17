ifdef nogui
	sim_flags = batch-mode=1 
endif

current_dir = $(shell pwd)

ifdef CLUSTER_BIN
	cc-elf-y = -DCLUSTER_BIN_PATH=\"$(current_dir)/stimuli/cluster.bin\"  -DCLUSTER_BIN
endif

ifdef USE_HYPER
	cc-elf-y += -DUSE_HYPER
endif

utils_dir = $(SW_HOME)/inc/

directories = . drivers/inc drivers/src string_lib/inc string_lib/src padframe/inc padframe/src udma udma/cpi udma/i2c udma/spim udma/uart udma/sdio ../../../BearSSL/src ../../../BearSSL/inc ../../../BearSSL/build

INC=$(foreach d, $(directories), -I$(utils_dir)$d)


inc_dir := $(SW_HOME)/common/

RISCV_PREFIX ?= riscv$(XLEN)-unknown-elf-
RISCV_GCC ?= $(RISCV_PREFIX)gcc

RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data
# RISCV_OBJDUMP ?= /opt/modules/riscv-gnu-toolchain/2023.07.27_clang/bin/llvm-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data
# RISCV_OBJDUMP ?= /opt/modules/riscv-gnu-toolchain/2023.07.27_clang/bin/riscv64-unknown-elf-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

RISCV_FLAGS     := -mcmodel=medany -static -std=gnu99 -DNUM_CORES=1 -O3 -ffreestanding -ffast-math -fno-common -fno-builtin-printf $(INC) 
# -march=rv32im -mabi=ilp32

MY_S_FILE := /scratch/amusa/he-soc/software/14_vec-daxpy/vec-daxpy.S

# emb-bench
# RISCV_LINK_OPTS := -static -nostdlib -nostartfiles -static-libgcc -lm -lc -lgcc
# riscv-bench
RISCV_LINK_OPTS := -static -nostdlib -nostartfiles -static-libgcc -lm -g -lgcc 
 
clean:
	rm -f $(APP).riscv
	rm -f $(APP).dump
	rm -f *.slm
 
# clang -> riscv64-unknown-elf-clang
# build:
# 	/opt/modules/riscv-gnu-toolchain/2023.02.25/bin/riscv64-unknown-elf-gcc $(RISCV_FLAGS) -T $(inc_dir)test.ld $(cc-elf-y) $(inc_dir)crt.S $(inc_dir)syscalls.c  -L $(inc_dir) $(APP).c -o $(APP).riscv $(RISCV_LINK_OPTS)
#	echo $(APP).riscv | tee -a  $(HW_HOME)/regression.list

# modify for emb-benchmarks and risv-bench [WORK]
build:
	$(RISCV_GCC) $(RISCV_FLAGS) -T $(inc_dir)test.ld $(cc-elf-y) $(inc_dir)crt.S $(inc_dir)syscalls.c  -L $(inc_dir) $(APP).c -o $(APP).riscv $(RISCV_LINK_OPTS)
	echo $(APP).riscv | tee -a  $(HW_HOME)/regression.list

# original [WORK]
#build:
#	$(RISCV_GCC) $(RISCV_FLAGS) -T $(inc_dir)test.ld $(cc-elf-y) $(inc_dir)crt.S  $(inc_dir)syscalls.c  -L $(inc_dir) $(APP).c -o $(APP).riscv $(RISCV_LINK_OPTS)
#	echo $(APP).riscv | tee -a  $(HW_HOME)/regression.list

dis:
	$(RISCV_OBJDUMP) $(APP).riscv > $(APP).dump

dump:
	$(SW_HOME)/elf_to_slm.py --binary=$(APP).riscv --vectors=hyperram0.slm
	cp hyperram*.slm  $(HW_HOME)/
	cp $(APP).riscv  $(HW_HOME)/
	echo $(APP).riscv | tee -a  $(HW_HOME)/regression.list

all: clean build dis dump

rtl: 
	 $(MAKE) -C  $(SW_HOME)/../hardware/ all/

sim:
	$(MAKE) -C  $(SW_HOME)/../hardware/ sim $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv

