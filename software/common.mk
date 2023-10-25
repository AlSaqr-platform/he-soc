ifdef nogui
	sim_flags = batch-mode=1
endif

#ifdef simple_pad
#	rtl_flags = simple-padframe=1
#	sim_flags += simple-padframe=1
#endif

current_dir = $(shell pwd)

ifdef CLUSTER_BIN
	cc-elf-y = -DCLUSTER_BIN_PATH=\"$(current_dir)/stimuli/cluster.bin\"  -DCLUSTER_BIN
endif

ifdef USE_HYPER
	cc-elf-y += -DUSE_HYPER
endif

utils_dir = $(SW_HOME)/inc/

inc_dirs = . drivers/inc string_lib/inc padframe/inc fpga_padframe/inc udma udma/cpi udma/i2c udma/spim udma/uart udma/sdio apb_timer gpio

src_dirs = . drivers/src string_lib/src udma/uart padframe/src fpga_padframe/src

SRC=$(foreach d, $(src_dirs), $(wildcard $(utils_dir)$d/*.c))

INC=$(foreach d, $(inc_dirs), -I$(utils_dir)$d)

ifneq ($(strip $(wildcard $(HW_HOME)/ip_list/fll_behav/driver)),)
	FLL_DRIVER=1
	INC += -I$(HW_HOME)/ip_list/fll_behav/driver/inc
	SRC += $(wildcard $(HW_HOME)/ip_list/fll_behav/driver/src/*.c)
endif

inc_dir := $(SW_HOME)/common/
inc_dir_culsans := $(SW_HOME)/common_culsans/

RISCV_PREFIX ?= riscv$(XLEN)-unknown-elf-
RISCV_GCC ?= $(RISCV_PREFIX)gcc

RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump -h --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data --section=.tohost --section=.sdata --section=.rodata --section=.sbss --section=.bss --section=.tdata --section=.tbss --section=.stack -t -s

RISCV_FLAGS     := -mcmodel=medany -static -std=gnu99 -DNUM_CORES=2 -O3 -ffast-math -fno-common -fno-builtin-printf $(INC)
RISCV_LINK_OPTS := -static -nostdlib -nostartfiles -lm -lgcc

ifdef FLL_DRIVER
	RISCV_FLAGS += -DFLL_DRIVER
endif

clean:
	rm -f $(APP).riscv
	rm -f $(APP).dump
	rm -f *.slm

# IMPORTANT: the inc_dir_culsans sw environment (taken from planvtech) contains a bug into the printf where it does not print anything when you pass a parameter to it
build_culsans:
	$(RISCV_GCC) $(RISCV_FLAGS) -T $(inc_dir_culsans)/test.ld $(RISCV_LINK_OPTS) $(cc-elf-y) $(inc_dir_culsans)/crt.S  $(inc_dir_culsans)/syscalls.c $(inc_dir_culsans)/util.c -L $(inc_dir_culsans) $(APP).c -o $(APP).riscv

build_single:
	$(RISCV_GCC) $(RISCV_FLAGS) -T $(inc_dir)/test.ld $(RISCV_LINK_OPTS) $(cc-elf-y) $(inc_dir)/crt.S $(inc_dir)/syscalls.c -L $(inc_dir) $(APP).c $(SRC) -o $(APP).riscv

dis:
	$(RISCV_OBJDUMP) $(APP).riscv > $(APP).dump

dump:
	$(SW_HOME)/elf_to_slm.py --binary=$(APP).riscv --vectors=hyperram0.slm
	cp hyperram*.slm  $(HW_HOME)/
	cp $(APP).riscv  $(HW_HOME)/
	echo $(APP).riscv | tee -a  $(HW_HOME)/regression.list

all: clean build_single dis dump

rtl:
	 $(MAKE) -C $(SW_HOME)/../hardware/ -B all

sim:
	$(MAKE) -C  $(SW_HOME)/../hardware/ -B sim $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv
