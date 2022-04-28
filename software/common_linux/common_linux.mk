ifdef nogui
	sim_flags = batch-mode=1 
endif

current_dir = $(shell pwd)

utils_dir = $(SW_HOME)/inc/

directories = . drivers/inc drivers/src string_lib/inc string_lib/src padframe/inc padframe/src udma udma/cpi udma/i2c udma/spim udma/uart 

INC=$(foreach d, $(directories), -I$(utils_dir)$d)

inc_dir := $(SW_HOME)/common/

CC        := clang
CC_FLAGS  := -mcmodel=medany -static --sysroot=/usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/riscv64-hero-linux-gnu/sysroot
CC_LIBS   := -L /usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/riscv64-hero-linux-gnu/sysroot/usr/lib
CC_INC    := -I /usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/riscv64-hero-linux-gnu/sysroot/usr/include/
LINK_OPTS := -static -nostdlib -nostartfiles
OBJDUMP   := llvm-objdump --disassemble-all --disassemble-zeroes

ifeq ($(STIM), 1)
clean:
	rm -f $(APP).elf
	rm -f $(APP).dump
	rm -f *.slm
	rm -rf *.map
	$(MAKE) -C ./stimuli clean 
else
clean:
	rm -f $(APP).elf
	rm -f $(APP).dump
	rm -f *.slm
	rm -rf *.map
endif

build:
	$(CC) $(CC_FLAGS) $(CC_LIBS) $(CC_INC) --target=riscv64-hero-linux-gnu -mno-relax $(APP).c -Wl,-Map,output.map -o $(APP).elf

dis:
	$(OBJDUMP) -d $(APP).elf > $(APP).dump

dump:
	$(SW_HOME)/elf_to_slm.py --binary=$(APP).elf --vectors=hyperram0.slm
	cp hyperram*.slm  $(HW_HOME)/

stim:
	$(MAKE) -C ./stimuli clean all

ifeq ($(STIM), 1) 
  all: clean stim build dis # dump
  STIM = 0
else
  all: clean build dis # dump
endif

rtl: 
	 $(MAKE) -C  $(HW_HOME)/ all

sim:
	$(MAKE) -C  $(HW_HOME)/ sim $(sim_flags) elf-bin=$(shell pwd)/$(APP).elf
