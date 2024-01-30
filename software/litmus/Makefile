ifndef VERBOSE
.SILENT:
endif

LITMUS_REPO := https://github.com/pulp-platform/CHERI-Litmus.git
SRC_DIR  := src

NUM_CORES := 2
PLATFORM := alsaqr

WORK_DIR  := work
LITMUS_TEST_LIST := litmus-tests.list

RISCV ?= riscv -riscv64-gcc-12.2.0

ADDITIONAL_FLAGS = dual-boot=1 nogui=1

JOBS = 32

$(SRC_DIR):
	git clone $(LITMUS_REPO) $@

build-litmus-tests: $(SRC_DIR)
	cd $</frontend; ./make.sh
	cd $</binaries; ./make-riscv.sh ../tests/ $(PLATFORM) $(NUM_CORES)

$(WORK_DIR):
	mkdir -p $(WORK_DIR)
	ln -sf ../$(SRC_DIR)/binaries $(WORK_DIR)/binaries

$(LITMUS_TEST_LIST): $(SRC_DIR)
	find $(SRC_DIR)/binaries -name "*.elf" \
	-exec bash -c 'basename {} | rev | cut -d. -f2- | rev' \; > $@

build:
	$(MAKE) -C $(HW_HOME) clean scripts_vip build $(ADDITIONAL_FLAGS)

%.litmus_log: %.uart_log
	echo "Processing $*"
	echo "Test $(basename $* .elf) Allowed" > $@
	echo "Histogram" >> $@
	cat $< >> $@
	echo "" >> $@

%.uart_log: %.log
	awk '/^#\s*Mock uart\s*0:/ \
	{ match($$0, /^#\s*Mock uart\s*0:(.*)$$/, arr); \
	gsub(/^[[:space:]]+|[[:space:]]+$$/, "", arr[1]); \
	print arr[1] }' $< > $@

%.log:
	mkdir -p $(dir $@)
	echo "include ../../work.mk" > $(dir $@)/Makefile
	$(MAKE) -C $(dir $@) $(notdir $@) ADDITIONAL_FLAGS=$(ADDITIONAL_FLAGS) |& grep Processing

run-litmus-tests: $(LITMUS_TEST_LIST) $(WORK_DIR)
	$(MAKE) -j $(JOBS) $(shell cat $(LITMUS_TEST_LIST) | xargs -I {} echo "$(WORK_DIR)/{}/{}.litmus_log")

all: build build-litmus-tests run-litmus-tests

.PHONY: build run-litmus-tests build-litmus-tests all
