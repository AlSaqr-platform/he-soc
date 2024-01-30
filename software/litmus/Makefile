LITMUS_REPO := https://github.com/pulp-platform/CHERI-Litmus.git
SRC_DIR  := src

NUM_CORES := 2
PLATFORM := alsaqr

WORK_DIR  := work
LITMUS_TEST_LIST := litmus-tests.list

XLEN := 64

RISCV ?= riscv -riscv64-gcc-12.2.0

OBJDUMP ?= $(RISCV) objdump
OBJDUMP_ARGS := --headers --disassemble-all --disassemble-zeroes

ADDITIONAL_FLAGS = dual-boot=1 nogui=1

$(SRC_DIR):
	git clone $(LITMUS_REPO) $@

build-litmus-tests: $(SRC_DIR)
	cd $</frontend; ./make.sh
	cd $</binaries; ./make-riscv.sh ../tests/ $(PLATFORM) $(NUM_CORES)

.PHONY: build-litmus-tests

$(WORK_DIR):
	mkdir -p $(WORK_DIR)
	ln -sf ../$(SRC_DIR)/binaries $(WORK_DIR)/binaries

$(LITMUS_TEST_LIST): $(SRC_DIR)
	find $(SRC_DIR)/binaries -name "*.elf" \
	-exec bash -c 'basename {} | rev | cut -d. -f2- | rev' \; > $@

build:
	$(MAKE) -C $(HW_HOME) clean scripts_vip build $(ADDITIONAL_FLAGS)

%.dump: %.elf
	$(OBJDUMP) $(OBJDUMP_ARGS) $< > $@

%.log:
	mkdir -p $(dir $@)
	echo "include ../../work.mk" > $(dir $@)/Makefile
	$(MAKE) -C $(dir $@) $(notdir $@)

run-litmus-tests: $(LITMUS_TEST_LIST) $(WORK_DIR) build
	$(MAKE) -j 20 $(shell cat $(LITMUS_TEST_LIST) | xargs -I {} echo "$(WORK_DIR)/{}/{}.log") ADDITIONAL_FLAGS=$(ADDITIONAL_FLAGS)

.PHONY: build run-litmus-tests

%.uart.log: %.log
	awk '/^#\s*Mock uart\s*0:/ \
	{ match($$0, /^#\s*Mock uart\s*0:(.*)$$/, arr); \
	gsub(/^[[:space:]]+|[[:space:]]+$$/, "", arr[1]); \
	print arr[1] }' $< > $@

$(WORK_DIR)/%.litmus.log: $(WORK_DIR)/%.uart.log
	echo "Test $(basename $* .elf) Allowed" > $@
	echo "Histogram" >> $@
	cat $< >> $@
	echo "" >> $@
