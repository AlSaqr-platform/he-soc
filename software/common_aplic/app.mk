# Overwrite in your test Makefile!
APP 	?= main
XLEN    ?= 64
APP_INC ?=
APP_SRC ?= $(filter-out $(APP).c, $(wildcard *.c))


SIM_DEPS ?= work work-dpi tb
SIM_DIR  ?= sim.d

INC += $(addprefix -I, $(APP_INC))
SRC += $(APP_SRC)

include $(SW_HOME)/common.mk

run:
	mkdir -p $(SIM_DIR)
	cd $(SIM_DIR) && \
	ln -sf -t . $(addprefix $(HW_HOME)/, $(SIM_DEPS)) && \
	cp -sf -t . ../hyperram*.slm ../main.riscv
	$(MAKE) -f $(HW_HOME)/Makefile -C $(SIM_DIR) run elf-bin=$(APP).riscv

clean-sim:
	rm -rf $(SIM_DIR)

.PHONY: run clean-sim