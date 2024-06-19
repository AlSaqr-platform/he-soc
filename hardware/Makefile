# Author: Florian Zaruba, ETH Zurich
# Date: 03/19/2017
# Description: Makefile for linting and testing Ariane.
# Bender
BENDER:=./bender
# questa library
library        ?= work
# verilator lib
ver-library    ?= work-ver
# library for DPI
dpi-library    ?= work-dpi
# Top level module to compile
top_level      ?= ariane_tb
# Maximum amount of cycles for a successful simulation run
max_cycles     ?= 10000000
# Test case to run
test_case      ?= core_test
# QuestaSim Version
questa_version ?=
# verilator version
verilator      ?= verilator
# traget option
target-options ?=
# additional definess
defines        ?= WT_DCACHE
# test name for torture runs (binary name)
test-location  ?= output/test
# set to either nothing or -log
torture-logs   :=
# custom elf bin to run with sim or sim-verilator
CORE_ID        ?= 0
elf-bin        ?= $(SW_HOME)/hello_culsans/hello_culsans.riscv
# opentitan variables
ibex-elf-bin   ?= none
BOOTMODE       ?= 0
OT_FLASH       ?= ./opentitan/sw/tests/alsaqr/flash_alsaqr_boot/bazel-out/flash_alsaqr_boot_signed8.vmem
#cl-bin         ?= ../software/pulp/mm.riscv
cl-bin         ?= none
# root pathelf-bin
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
root-dir := $(dir $(mkfile_path))
# acc options
# guide: define acc=<+"instance name".> , the dot includes all the child instances.
# Example: <make clean sim acc=+u_RoT.>,  this will plot all the OpenTitan and subinstances signals (all the OT design)
acc            ?= +acc
noacc          ?=

# regression
alsaqr-regression-dir        := ./
alsaqr-regression-list       := $(SW_HOME)/regression.list
alsaqr-regression            := $(shell xargs printf '\n%s' < $(alsaqr-regression-list) | cut -b 1-)

alsaqr-regression-post-synth := $(shell xargs printf '\n%s' < $(alsaqr-regression-list) | cut -b 1-)

BENDER_FPGA_SCRIPTS_DIR = fpga/alsaqr/tcl/generated
BENDER_SYNTH_DIR = gf22
BENDER_BUILD_DIR:=.
CULSANS_ROOT := ip_list/culsans

CVA6_PKG := cv64a6_imafdch_sv39_wb

#  fix pedantic questa 2024 veer error
ifdef QUESTA
	pedanticerrors ?= -pedanticerrors
else
	QUESTA ?=
	pedanticerrors ?=
endif

ifndef RISCV
$(error RISCV not set - please point your RISCV variable to your RISCV installation)
endif

ifndef QUESTASIM_HOME
$(error QUESTASIM not set - please point to your QUESTA installation)
endif

ifndef post_synth
    compile_script := compile.tcl
else
    compile_script := post_synth_compile.tcl
endif

# spike tandem verification
ifdef spike-tandem
    compile_flag += -define SPIKE_TANDEM
    ifndef preload
        $(error Tandem verification requires preloading)
    endif
endif


ifdef spike-tandem
    util += tb/common/spike.sv
endif

util := $(addprefix $(root-dir), $(util))
# Test packages
test_pkg := $(wildcard tb/test/*/*sequence_pkg.sv*) \
			$(wildcard tb/test/*/*_pkg.sv*)

# DPI
dpi := $(patsubst tb/dpi/%.cc, ${dpi-library}/%.o, $(wildcard tb/dpi/*.cc))

# filter spike stuff if tandem is not activated
ifndef spike-tandem
    dpi := $(filter-out ${dpi-library}/spike.o ${dpi-library}/sim_spike.o, $(dpi))
endif

# filter dromajo stuff if dromajo is not activated
ifndef DROMAJO
    dpi := $(filter-out ${dpi-library}/dromajo_cosim_dpi.o, $(dpi))
endif

dpi_hdr := $(wildcard tb/dpi/*.h)
dpi_hdr := $(addprefix $(root-dir), $(dpi_hdr))
CFLAGS := -I$(QUESTASIM_HOME)/include         \
          -I$(RISCV)/include                  \
          -I$(SPIKE_ROOT)/include             \
          $(if $(DROMAJO), -I../tb/dromajo/src,) \
          -std=c++11 -I../tb/dpi -O3

ifdef spike-tandem
    CFLAGS += -Itb/riscv-isa-sim/install/include/spike
endif

# Compile and sim flags
compile_flag     += +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -suppress 3999 -suppress 3009 -suppress 8386 -suppress 8360 -permissive +define+$(defines)
uvm-flags        += +UVM_NO_RELNOTES +UVM_VERBOSITY=LOW
questa-flags     += -t 1ns -64 -coverage -classdebug -suppress 3999 -suppress 3009 -suppress 8360 -suppress 8386 $(gui-sim) $(QUESTASIM_FLAGS)
compile_flag_vhd += -64 -nologo -quiet -2008

questa-cmd       ?= -do " set StdArithNoWarnings 1; set NumericStdNoWarnings 1; log -r /*; run -all;"

compile_flag_bender   += +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -suppress 8386  -permissive


# Iterate over all include directories and write them with +incdir+ prefixed
# +incdir+ works for Verilator and QuestaSim
list_incdir := $(foreach dir, ${incdir}, +incdir+$(dir))

ifdef nogui
  acc   := +acc=p+ariane_tb.
	noacc := +noacc=p+dut.
  questa-flags += -c
	compile_flag += -O5
	questa-cmd   := -do " set StdArithNoWarnings 1; set NumericStdNoWarnings 1; run -all;"
endif

ifdef max-opt
  acc   :=
	noacc := +noacc=+ariane_tb.
	questa-cmd   := -do " set StdArithNoWarnings 1; set NumericStdNoWarnings 1; run -all;"
	compile_flag += -O5
endif

# if defined, calls the questa targets in batch mode
ifdef batch-mode
	questa-flags += -c
  acc   := +acc=p+ariane_tb.
	noacc := +noacc=p+dut.
	questa-cmd   := -do "coverage save -onexit ./test.ucdb; run -a; quit -code [coverage attribute -name TESTSTATUS -concise]"
	questa-cmd   += -do " set StdArithNoWarnings 1; set NumericStdNoWarnings 1; run -all;"
endif

ifdef preload
	questa-cmd += +PRELOAD=$(preload)
  compile_flag +=  +PRELOAD=$(preload)
	elf-bin = none
endif

ifdef l3-fake
	questa-cmd += +L3_TCSRAM=$(l3-fake)
  compile_flag +=  +define+L3_TCSRAM
  compile_fpga += L3_TCSRAM
endif

ifdef exclude-cluster
	questa-cmd += +EXCLUDE_CLUSTER=$(exclude-cluster)
  compile_flag +=  +define+EXCLUDE_CLUSTER
  compile_fpga += EXCLUDE_CLUSTER
endif

ifdef exclude-rot
	questa-cmd += +EXCLUDE_ROT=$(exclude-rot)
  compile_flag +=  +define+EXCLUDE_ROT
  compile_fpga += EXCLUDE_ROT
endif

ifdef exclude-llc
	questa-cmd += +EXCLUDE_LLC=$(exclude-llc)
  compile_flag +=  +define+EXCLUDE_LLC
  compile_fpga += EXCLUDE_LLC
endif

ifdef simple-padframe
	questa-cmd   += +SIMPLE_PADFRAME=$(simple-padframe) +ETH2FMC_NO_PADFRAME=$(simple-padframe)
	compile_flag += +define+SIMPLE_PADFRAME +define+ETH2FMC_NO_PADFRAME
	compile_fpga += SIMPLE_PADFRAME
	compile_fpga += ETH2FMC_NO_PADFRAME
endif

ifdef spike-tandem
    questa-cmd += -gblso tb/riscv-isa-sim/install/lib/libriscv.so
endif

# remote bitbang is enabled
ifdef rbb
	compile_flag += +define+JTAG_RBB  +jtag_rbb_enable=1
	questa-cmd += +define+JTAG_RBB  +jtag_rbb_enable=1
endif

ifdef localjtag
	compile_flag += +define+USE_LOCAL_JTAG
	questa-cmd += +define+USE_LOCAL_JTAG
endif

ifdef sec_boot
	compile_flag += +define+SEC_BOOT
	questa-cmd += +define+SEC_BOOT
endif

ifdef sim_jtag
	compile_flag += +define+SIM_JTAG
	questa-cmd += +define+SIM_JTAG
endif

ifdef clk-bypass
	compile_flag += +define+TEST_CLOCK_BYPASS
	questa-cmd += +define+TEST_CLOCK_BYPASS
endif

ifdef dual-boot
	compile_flag += +define+DUAL_BOOT
	questa-cmd += +define+DUAL_BOOT
endif

bender:
	wget "https://github.com/pulp-platform/bender/releases/download/v0.22.0/bender-0.22.0-x86_64-linux-gnu-centos7.8.2003.tar.gz"
	tar -xvzf bender-0.22.0-x86_64-linux-gnu-centos7.8.2003.tar.gz
	rm bender-0.22.0-x86_64-linux-gnu-centos7.8.2003.tar.gz
	./bender --version | grep -q "bender 0.22.0"

update:
	$(BENDER) update

libbender:
	$(QUESTA) vlib work
	$(QUESTA) vmap work ./work

scripts-bender-fpga: | Bender.lock
	mkdir -p fpga/alsaqr/tcl/generated
	$(BENDER) script vivado -t $(CVA6_PKG) -t fpga -t xilinx -t tech_cells_generic_include_xilinx_xpm --define="$(compile_fpga) EXCLUDE_PADFRAME" > $(BENDER_FPGA_SCRIPTS_DIR)/compile.tcl

scripts-bender-fpga-ddr: | Bender.lock
	mkdir -p fpga/alsaqr/tcl/generated
	$(BENDER) script vivado -t $(CVA6_PKG) -t fpga -t ddr -t xilinx -t tech_cells_generic_include_xilinx_xpm --define="$(compile_fpga)" > $(BENDER_FPGA_SCRIPTS_DIR)/compile.tcl

scripts-bender-synopsys: | Bender.lock
	echo 'set ROOT [file normalize [file dirname [info script]]/../../../]' > $(BENDER_SYNTH_DIR)/synopsys/scripts/analyze_alsaqr.tcl
	$(BENDER) script synopsys -t rtl -t synthesis -t $(CVA6_PKG) -t asic -t top_level | grep -v "set ROOT" >> $(BENDER_SYNTH_DIR)/synopsys/scripts/analyze_alsaqr.tcl

scripts:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 " --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t rtl -t test -t tb  -t $(CVA6_PKG) > $(compile_script)

scripts_vip_macro:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb -t vip -t $(CVA6_PKG) > $(compile_script)

scripts_vip:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 " --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t rtl -t test -t tb -t vip -t $(CVA6_PKG) > $(compile_script)

# The following scripts must be used only for post synthesis simulations and provides different configuration to simulate the design

# RTL + FLL BEHAVIOURAL (YOU NEED ACCESS TO THE PRIVATE FLL REPO FOR THIS)
gf22_fll_behav:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t rtl -t gf22_fll_behav -t test -t tb -t vip -t $(CVA6_PKG) > $(compile_script)

# ONLY NETLSISTS: TOP - FLL - CVA6 -OPENTITAN - CLUSTER - HYPER
post_synth_all:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb_synth -t vip -t post_synth_all -t $(CVA6_PKG) > $(compile_script)

# RTL: OPENTITAN - CLUSTER - CVA6  / NETLIST: TOP - FLL - HYPER
post_synth_top:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb_synth -t vip -t post_synth_top -t $(CVA6_PKG) > $(compile_script)

# RTL: TOP - CLUSTER - OPENTITAN - FLL BEHAV (YOU NEED ACCESS TO THE FLL REPO FOR THIS)  / NETLIST: CVA6 - HYPER
post_synth_cva6_hyper:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag) -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb_synth -t vip -t post_synth_cva6_hyper -t $(CVA6_PKG) > $(compile_script)

# RTL: TOP (USES FLL DUMMY) + CVA6 NETLIST
post_synth_cva6:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag) -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
	-t asic -t asic -t rtl -t test -t tb_synth -t vip -t post_synth_cva6 -t $(CVA6_PKG) > $(compile_script)

# RTL: TOP - CLUSTER - OPENTITAN / NETLIST: CVA6 - HYPER - FLL
post_synth_cva6_hyper_fll:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb_synth -t vip -t post_synth_cva6_hyper_fll -t $(CVA6_PKG) > $(compile_script)

# RTL + FLL NETLIST
post_synth_fll:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb_synth -t vip -t post_synth_fll -t $(CVA6_PKG) > $(compile_script)

# RTL + FLL NETLIST
post_synth_top_fll_behav:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb_synth -t vip -t post_synth_top_fll_behav -t $(CVA6_PKG) > $(compile_script)

# RTL (USES FLL DUMMY) + OPENTITAN NETLIST
post_synth_opentitan:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb -t vip -t post_synth_opentitan -t $(CVA6_PKG) > $(compile_script)

# RTL (USES FLL DUMMY) + CLUSTER NETLIST
post_synth_cluster:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb -t vip -t post_synth_cluster -t $(CVA6_PKG) > $(compile_script)

# RTL (USES FLL DUMMY) + HYPER NETLIST
post_synth_hyper:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t asic -t rtl -t test -t tb -t vip -t post_synth_hyper -t $(CVA6_PKG) > $(compile_script)

# NOT TESTED YET
post_pr_scripts_vip:
	$(BENDER) script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 -suppress 8386 +nospecify +notimingchecks" --vcom-arg="$(compile_flag_vhd) -work  $(library) $(pedanticerrors)" \
    -t rtl -t test -t tb_synth -t $(CVA6_PKG) -t top_post_pr_sim -t vip > post_pr_compile.tcl

## -sdfnoerror -sdfnowarn -sdfmin ./gf22/innovus/cva6/out

benderrun: libbender $(util) $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	$(QUESTA) vsim -c -do 'source $(compile_script); quit'
	touch $(library)/.build-srcs

benderrun_macro: libbender $(util) $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	$(QUESTA) vsim -c -do 'source gf22/modelsim/libraries.sh; source $(compile_script); quit'
	touch $(library)/.build-srcs

benderrun_synth: libbender $(util) $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	$(QUESTA) vsim -c -do 'source gf22/modelsim/libraries.sh; source $(compile_script); quit'
	touch $(library)/.build-srcs

bendertb: benderrun $(dpi)
	touch $(library)/.build-tb

bendertb_macro: benderrun_macro $(dpi)
	touch $(library)/.build-tb

bendertb_synth: benderrun_synth $(dpi)
	touch $(library)/.build-tb

build: bendertb 	$(dpi-library)/ariane_dpi.so
	$(QUESTA) vopt $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized $(noacc) $(acc) -check_synthesis

build_dbg: bendertb 	$(dpi-library)/ariane_dpi.so
	$(QUESTA) vopt $(compile_flag) -debugdb -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized $(noacc) $(acc) -check_synthesis

build_macro: bendertb_macro 	$(dpi-library)/ariane_dpi.so
	$(QUESTA) vopt $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized $(noacc) $(acc) -check_synthesis

build_synth: bendertb_synth 	$(dpi-library)/ariane_dpi.so
	$(QUESTA) vopt $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized $(noacc) $(acc) -check_synthesis

$(library):
	vlib${questa_version} $(library)

# compile DPIs
$(dpi-library)/%.o: tb/dpi/%.cc $(dpi_hdr)
	mkdir -p $(dpi-library)
	$(CXX) -shared -fPIC -std=c++0x -Bsymbolic $(CFLAGS) -c $< -o $@

$(dpi-library)/ariane_dpi.so: $(dpi)
	mkdir -p $(dpi-library)
	# Compile C-code and generate .so file
	$(CXX) -shared -m64 -o $(dpi-library)/ariane_dpi.so $? -L$(RISCV)/lib -L$(SPIKE_ROOT)/lib -Wl,-rpath,$(RISCV)/lib -Wl,-rpath,$(SPIKE_ROOT)/lib

# single test runs on Questa can be started by calling make <testname>, e.g. make towers.riscv
# the test names are defined in ci/riscv-asm-tests.list, and in ci/riscv-benchmarks.list
# if you want to run in batch mode, use make <testname> batch-mode=1
# alternatively you can call make sim elf-bin=<path/to/elf-bin> in order to load an arbitrary binary

generate-trace-vsim:
	make sim preload=$(preload) elf-bin= batch-mode=1
	make generate-trace

run:
	$(QUESTA) vsim +permissive $(questa-flags) $(questa-cmd) -suppress 3053 -suppress 8885 -suppress 3999 -suppress 8386 -suppress 8360 -lib $(library) +OT_FLASH=$(OT_FLASH) +CORE_ID=$(CORE_ID) +BOOTMODE=$(BOOTMODE) +OT_SRAM=$(ibex-elf-bin)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +CVA6_STRING=$(elf-bin) +CL_STRING=$(cl-bin) +notimingchecks +nospecify  -t 1ps \
	$(uvm-flags) $(QUESTASIM_FLAGS) -sv_lib $(dpi-library)/ariane_dpi  \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

run_dbg:
	$(QUESTA) vsim +permissive $(questa-flags) $(questa-cmd) -debugDB -suppress 3053 -suppress 8885 -suppress 3999 -suppress 8386 -suppress 8360 -lib $(library) +OT_FLASH=$(OT_FLASH) +CORE_ID=$(CORE_ID) +BOOTMODE=$(BOOTMODE) +OT_SRAM=$(ibex-elf-bin)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +CVA6_STRING=$(elf-bin) +CL_STRING=$(cl-bin) +notimingchecks +nospecify  -t 1ps \
	$(uvm-flags) $(QUESTASIM_FLAGS) -sv_lib $(dpi-library)/ariane_dpi  \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

#	vsim${questa_version} +permissive $(questa-flags) $(questa-cmd) -suppress 3053 -suppress 8885 -lib $(library) +notimingchecks +nospecify +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +CVA6_STRING=$(elf-bin) +CL_STRING=$(cl-bin) -t 1ps \
#	-sdfnoerror -sdfnowarn  -sdfmin /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap=./gf22/innovus/cva6/out/cva6_synth_wrap.sdf.gz +sdf_verbose \

sim: build run

sim_dbg: build_dbg run_dbg

macro_sim: build_macro run

synth_sim: build_synth run

$(alsaqr-regression): build_macro
	mkdir -p tmp
	$(MAKE) -C $(SW_HOME)/$@ clean all
	$(QUESTA) vsim +permissive $(questa-flags) $(questa-cmd) -suppress 3053 -suppress 8885 -suppress 3999 -suppress 8386 -suppress 8360 -lib $(library) +OT_FLASH=$(OT_FLASH) +CORE_ID=$(CORE_ID) +BOOTMODE=$(BOOTMODE) +OT_SRAM=$(ibex-elf-bin)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +CVA6_STRING=$@ +CL_STRING=$(cl-bin) +notimingchecks +nospecify  -t 1ps \
	$(uvm-flags) $(QUESTASIM_FLAGS) -sv_lib $(dpi-library)/ariane_dpi   \
	${top_level}_optimized +permissive-off ++$(alsaqr-regression-dir)/$@ ++$(target-options) | tee tmp/alsaqr-regression-$@.log

check-benchmarks:
	echo $(alsaqr-regression)
	./check-regs.sh

run-regressions:	$(alsaqr-regression)
	$(MAKE) scripts_vip_macro
	$(MAKE) check-benchmarks

run_regression:
	rm -rf regressions/regression_reports
	mkdir regressions/regression_reports
	python3 regression.py
	regressions/check_regs.sh

run_regression_netlist:
	rm -rf regressions/regression_netlist_reports
	mkdir regressions/regression_netlist_reports
	python3 regression_netlist.py
	regressions/check_netlist_regs.sh

$(alsaqr-regression-post-synth): build_synth
	mkdir -p tmp
	$(MAKE) -C $(SW_HOME)/$@ clean all
	$(QUESTA) vsim +permissive $(questa-flags) $(questa-cmd) -suppress 3053 -suppress 8885 -suppress 3999 -suppress 8386 -suppress 8360 -lib $(library) +OT_FLASH=$(OT_FLASH) +CORE_ID=$(CORE_ID) +BOOTMODE=$(BOOTMODE) +OT_SRAM=$(ibex-elf-bin)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +CVA6_STRING=$@ +CL_STRING=$(cl-bin) +notimingchecks +nospecify  -t 1ps \
	$(uvm-flags) $(QUESTASIM_FLAGS) -sv_lib $(dpi-library)/ariane_dpi   \
	${top_level}_optimized +permissive-off ++$(alsaqr-regression-dir)/$@ ++$(target-options) | tee tmp/alsaqr-regression-$@.log

# NB: This regression for post synthesis requires preload=1 or localjtag=1 otherwise it will not work!!!!
run-regressions-post-synth:	$(alsaqr-regression-post-synth)
	$(MAKE) check-benchmarks-synth

check-benchmarks-synth:
	echo $(alsaqr-regression-post-synth)
	./check-regs.sh

tb/vips/spi_flash:
	rm -rf $@
	mkdir $@
	rm -rf model_tmp && mkdir model_tmp
	cd model_tmp; wget https://www.infineon.com/dgdl/Infineon-S25fs256s-SimulationModels-v02_00-EN.zip?fileId=8ac78c8c7d0d8da4017d0f6251a24e7b
	cd model_tmp; mv 'Infineon-S25fs256s-SimulationModels-v02_00-EN.zip?fileId=8ac78c8c7d0d8da4017d0f6251a24e7b' model.zip
	cd model_tmp; unzip model.zip
	cd model_tmp; mv 'S25fs256s' exe_folder
	cd model_tmp/exe_folder; unzip S25fs256s.exe
	cp model_tmp/exe_folder/S25fs256s/model/s25fs256s.v model_tmp/exe_folder/S25fs256s/model/s25fs256s_verilog.sdf $@
	rm -rf model_tmp

tb/vips/hyperram_model:
	rm -rf $@
	mkdir $@
	rm -rf model_tmp && mkdir model_tmp
	cd model_tmp; wget https://www.infineon.com/dgdl/Infineon-S27KL0641_S27KS0641_VERILOG-SimulationModels-v05_00-EN.zip?fileId=8ac78c8c7d0d8da4017d0f6349a14f68
	cd model_tmp; mv 'Infineon-S27KL0641_S27KS0641_VERILOG-SimulationModels-v05_00-EN.zip?fileId=8ac78c8c7d0d8da4017d0f6349a14f68' model.zip
	cd model_tmp; unzip model.zip
	cd model_tmp; mv 'S27KL0641 S27KS0641' exe_folder
	cd model_tmp/exe_folder; unzip S27ks0641.exe
	cp model_tmp/exe_folder/S27ks0641/model/s27ks0641.v model_tmp/exe_folder/S27ks0641/model/s27ks0641_verilog.sdf $@
	rm -rf model_tmp

tb/vips/i2c_eeprom:
	rm -rf $@
	mkdir $@
	rm -rf model_tmp && mkdir model_tmp
	cd model_tmp; wget https://ww1.microchip.com/downloads/en/DeviceDoc/24xx1025_Verilog_Model.zip
	cd model_tmp; unzip 24xx1025_Verilog_Model.zip
	cp model_tmp/24AA1025.v model_tmp/24FC1025.v model_tmp/24LC1025.v $@
	rm -rf model_tmp

vips: tb/vips/spi_flash tb/vips/hyperram_model tb/vips/i2c_eeprom

init: bender vips update

.PHONY: culsans-sw-init
culsans-sw-init:
	make -C ip_list/culsans/tests/integration/ libs/libintegr.a
	make -C ip_list/culsans/tests/performance/ libs/libintegr.a
	make -C ip_list/culsans/tests/integration/testlist/access_nocache_noshare main.riscv
	make -C ip_list/culsans/tests/integration/testlist/read_cache_share main.riscv
	make -C ip_list/culsans/tests/integration/testlist/read_cache_share_overlap main.riscv
	make -C ip_list/culsans/tests/integration/testlist/read_modify_cache main.riscv
	make -C ip_list/culsans/tests/integration/testlist/read_modify_cache_share main.riscv
	make -C ip_list/culsans/tests/integration/testlist/read_modify_cache_share_intense main.riscv
	make -C ip_list/culsans/tests/integration/testlist/read_nocache_noshare main.riscv
	make -C ip_list/culsans/tests/integration/testlist/read_nocache_noshare_overlap main.riscv
	make -C ip_list/culsans/tests/integration/testlist/writeback_cleanunique_flush main.riscv
	make -C ip_list/culsans/tests/integration/testlist/writeback_evict main.riscv
	make -C ip_list/culsans/tests/integration/testlist/writeback_readshared_flush main.riscv
	make -C ip_list/culsans/tests/integration/testlist/writeback_readunique_flush main.riscv
	make -C ip_list/culsans/tests/integration/testlist/writeback_readunique_modify main.riscv
	make -C ip_list/culsans/tests/integration/testlist/write_cache_noshare main.riscv
	make -C ip_list/culsans/tests/integration/testlist/write_cache_share main.riscv
	make -C ip_list/culsans/tests/integration/testlist/write_cache_share_overlap main.riscv
	make -C ip_list/culsans/tests/performance/testlist/read_noshared_remote main.riscv
	make -C ip_list/culsans/tests/performance/testlist/read_noshared_remote_busy main.riscv
	make -C ip_list/culsans/tests/performance/testlist/read_noshared_remote_busy_snoop main.riscv
	make -C ip_list/culsans/tests/performance/testlist/read_shared main.riscv
	make -C ip_list/culsans/tests/performance/testlist/read_shared_busy main.riscv
	make -C ip_list/culsans/tests/performance/testlist/read_shared_busy_snoop main.riscv
	make -C ip_list/culsans/tests/performance/testlist/read_shared_remote main.riscv
	make -C ip_list/culsans/tests/performance/testlist/read_shared_remote_busy main.riscv
	make -C ip_list/culsans/tests/performance/testlist/read_shared_remote_busy_snoop main.riscv

clean:
	rm -rf $(riscv-torture-dir)/output/test*
	rm -rf $(library)/ $(dpi-library)/ $(ver-library)/
	rm -f tmp/*.ucdb tmp/*.log *.wlf *vstf wlft* *.ucdb
	rm -f *log
	rm -f transcript
	rm -f uart

clean_regs:
	rm -f *.riscv
	rm -f regression.list


all: clean build
