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

directories = . drivers/inc drivers/src string_lib/inc string_lib/src padframe/inc padframe/src udma udma/cpi udma/i2c udma/spim udma/uart udma/sdio

INC=$(foreach d, $(directories), -I$(utils_dir)$d)

inc_dir := $(SW_HOME)/common/

CC        := clang
CC_FLAGS  := -mcmodel=medany -static --sysroot=/usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/riscv64-hero-linux-gnu/sysroot
CC_LIBS   := -L /usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/riscv64-hero-linux-gnu/sysroot/usr/lib
CC_INC    := -I /usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/riscv64-hero-linux-gnu/sysroot/usr/include/ -I $(utils_dir) -I $(inc_dir) -I $(INC)
LINK_OPTS := -static -nostdlib -nostartfiles
OBJDUMP   := llvm-objdump --disassemble-all --disassemble-zeroes

ifeq ($(STIM), 1)
clean:
	rm -f $(APP).riscv
	rm -f $(APP).dump
	rm -f *.slm
	rm -f *.map
	$(MAKE) -C ./stimuli clean 
else
clean:
	rm -f $(APP).riscv
	rm -f $(APP).dump
	rm -f *.slm
	rm -f *.map
endif

build:
	$(CC) $(CC_FLAGS) $(CC_LIBS) $(CC_INC) --target=riscv64-hero-linux-gnu -mno-relax $(inc_dir)/crt.S $(inc_dir)/syscalls.c $(APP).c $(LINK_OPTS) -Wl,-T $(inc_dir)/test.ld -Wl,-Map,output.map -o $(APP).riscv

dis:
	$(OBJDUMP) -d $(APP).riscv > $(APP).dump

dump:
	$(SW_HOME)/elf_to_slm.py --binary=$(APP).riscv --vectors=hyperram0.slm
	cp hyperram*.slm  $(HW_HOME)/
	cp $(APP).riscv  $(HW_HOME)/
	echo $(APP).riscv | tee -a  $(HW_HOME)/regression.list

stim:
	$(MAKE) -C ./stimuli clean all

ifeq ($(STIM), 1) 
  all: clean stim build dis dump
  STIM = 0
else
  all: clean build dis dump
endif

rtl: 
	 $(MAKE) -C  $(HW_HOME)/ all

sim:
	$(MAKE) -C  $(HW_HOME)/ sim $(sim_flags) elf-bin=$(shell pwd)/$(APP).riscv
