NUM_CORES := 2
PLATFORM := alsaqr

WORK   := work
HW_RES := hw-results
SRC    := src

JOBS   ?= 32

ADDITIONAL_FLAGS = dual-boot=1 nogui=1

ifeq ($(wildcard litmus-tests.list),)
    LITMUS_TEST_LIST :=
else
    LITMUS_TEST_LIST := $(shell find $(SRC)/binaries -type f -name "*.elf" -exec basename {} .elf \;)
endif

$(HW_RES):
	mkdir -p $(HW_RES)

build-litmus-tests:
	cd $(SRC)/frontend; ./make.sh
	cd $(SRC)/binaries; ./make-riscv.sh ../tests/ $(PLATFORM) $(NUM_CORES)

litmus-tests.list:
	find $(SRC)/binaries -type f -name "*.elf" -exec basename {} .elf \;  > $@

run-litmus-tests: $(HW_RES)
	$(MAKE) --quiet -j $(JOBS) -C $(WORK) ADDITIONAL_FLAGS=$(ADDITIONAL_FLAGS) \
	$(addprefix ../$(HW_RES)/, $(addsuffix .litmus.log, $(LITMUS_TEST_LIST)))

$(SRC)/litmus.log:
	cd $(SRC); ci/merge-tests.sh

litmus_cmp.log: $(SRC)/litmus.log
	cd $(SRC); ci/compare_model.sh > ../$@

compare-litmus-tests: litmus_cmp.log

build-hw:
	$(MAKE) -C $(HW_HOME) clean scripts_vip build $(ADDITIONAL_FLAGS)

$(LITMUS_TEST_LIST): $(HW_RES)
	$(MAKE) --quiet -C $(WORK) ../$(HW_RES)/$@.litmus.log ADDITIONAL_FLAGS=$(ADDITIONAL_FLAGS)

all: clean build-litmus-tests build-hw run-litmus-tests compare-litmus-tests

clean:
	$(MAKE) -C $(WORK) clean
	rm -f $(HW_RES)/* ./*.log $(SRC)/binaries/*.elf $(SRC)/binaries/*.dump

.PHONY: build-litmus-tests run-litmus-tests compare-litmus-tests build-hw all clean

