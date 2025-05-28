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

inc_dirs_l2 = . drivers/inc string_lib/inc

src_dirs_l2 = . drivers/src string_lib/src

SRC+=$(foreach d, $(src_dirs), $(wildcard $(utils_dir)$d/*.c))

INC+=$(foreach d, $(inc_dirs), -I$(utils_dir)$d)

SRC_L2+=$(foreach d, $(src_dirs_l2), $(wildcard $(utils_dir)$d/*.c))

INC_L2+=$(foreach d, $(inc_dirs_l2), -I$(utils_dir)$d)

ifneq ($(strip $(wildcard $(HW_HOME)/ip_list/fll_behav/driver)),)
	FLL_DRIVER=1
	INC += -I$(HW_HOME)/ip_list/fll_behav/driver/inc
	SRC += $(wildcard $(HW_HOME)/ip_list/fll_behav/driver/src/*.c)
endif

inc_dir := $(SW_HOME)/common/
inc_dir_culsans := $(SW_HOME)/common_culsans/

RISCV_PREFIX ?= riscv$(XLEN)-unknown-elf-
RISCV_GCC ?= $(RISCV_PREFIX)gcc

RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump -h --disassemble-all --disassemble-zeroes --section=.vectors --section=.text --section=.text.startup --section=.text.init --section=.data --section=.tohost --section=.sdata --section=.rodata --section=.sbss --section=.bss --section=.tdata --section=.tbss --section=.stack -t -s

RISCV_FLAGS     := -mcmodel=medany -static -std=gnu99 -DNUM_CORES=2 -O3 -ffast-math -fno-common -fno-builtin-printf $(INC)
RISCV_LINK_OPTS := -static -nostdlib -nostartfiles -lm -lgcc

################
## FPGA FLAGS ##
################

# When sw is compiled with fpga=1 uart baudrate is derived from a source clock of 40MHz - This should be used when you are NOT testing peripherals
ifdef fpga
	RISCV_FLAGS += -DFPGA_EMULATION
endif

# When sw is compiled with fpga_ethernet=1 uart baudrate is derived from a source clock of 50MHz - This should be used when you are testing peripherals
ifdef fpga_ethernet
	RISCV_FLAGS += -DFPGA_EMULATION
	RISCV_FLAGS += -DFPGA_ETHERNET
endif


ifdef FLL_DRIVER
	RISCV_FLAGS += -DFLL_DRIVER
endif

clean:
	rm -f $(APP).riscv
	rm -f $(APP).dump
	rm -f *.slm

build:
	$(RISCV_GCC) $(RISCV_FLAGS) -T $(inc_dir)/test.ld $(RISCV_LINK_OPTS) $(cc-elf-y) $(inc_dir)/crt.S $(inc_dir)/syscalls.c -L $(inc_dir) $(APP).c $(SRC) -o $(APP).riscv

build_l2:
	$(RISCV_GCC) $(RISCV_FLAGS) -T $(inc_dir)/test_l2.ld $(RISCV_LINK_OPTS) $(cc-elf-y) $(inc_dir)/crt.S $(inc_dir)/syscalls.c -L $(inc_dir) $(APP).c $(SRC_L2) -o $(APP).riscv

dis:
	$(RISCV_OBJDUMP) $(APP).riscv > $(APP).dump

dump:
	$(SW_HOME)/elf_to_slm.py --binary=$(APP).riscv --vectors=hyperram0.slm
	cp hyperram*.slm  $(HW_HOME)/
	cp $(APP).riscv  $(HW_HOME)/
	echo $(APP).riscv | tee -a  $(HW_HOME)/regression.list

all: clean build dis dump

all_l2: clean build_l2 dis dump

rtl:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean scripts_vip one-phy=0 preload=1 build

rtl_qfn:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean scripts_vip one-phy=1 preload=1 build

rtl_l2:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean scripts_vip one-phy=0 l2-code=1 preload=0 localjtag=1 build

rtl_l2_qfn:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean scripts_vip l2-code=1 localjtag=1 one-phy=1 preload=0 build

sim:
	$(MAKE) -C  $(SW_HOME)/../hardware/ -B sim $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv

macro:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean scripts_vip_macro one-phy=0 preload=1 $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv macro_sim

macro_qfn:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean scripts_vip_macro one-phy=1 preload=1 $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv macro_sim

macro_l2:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean scripts_vip_macro one-phy=0 l2-code=1 preload=0 localjtag=1 $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv macro_sim

macro_l2_qfn:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean scripts_vip_macro l2-code=1 localjtag=1 one-phy=1 preload=0  $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv macro_sim

chip:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean post_synth_all post_synth=1 one-phy=0 preload=1 $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv synth_sim

chip_qfn:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean  post_synth_all post_synth=1 one-phy=1 preload=1 $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv synth_sim

chip_l2:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean  post_synth_all post_synth=1 one-phy=0 l2-code=1 preload=0 localjtag=1  $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv synth_sim

chip_l2_qfn:
	rm -rf $(SW_HOME)/../hardware/compile.tcl
	$(MAKE) -C $(SW_HOME)/../hardware/ -B clean  post_synth_all post_synth=1 l2-code=1 localjtag=1 one-phy=1 preload=0  $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv synth_sim
