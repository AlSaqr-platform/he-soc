# Author: Florian Zaruba, ETH Zurich
# Date: 03/19/2017
# Description: Makefile for linting and testing Ariane.

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
questa_version ?= -10.7b
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
elf-bin        ?= ../software/hello/hello.riscv
ibex_elf_bin   ?= /scratch/mciani/he-soc/hardware/working_dir/opentitan/hw/top_earlgrey/sw/tests/hello_test/hello_test.elf
#cl-bin         ?= ../software/pulp/mm.riscv
cl-bin         ?= none
# root pathelf-bin
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
root-dir := $(dir $(mkfile_path))
# regression
alsaqr-regression-dir      := ./
alsaqr-regression-list     := ./regression.list
alsaqr-regression          := $(shell xargs printf '\n%s' < $(alsaqr-regression-list) | cut -b 1-)

BENDER_FPGA_SCRIPTS_DIR = fpga/alsaqr/tcl/generated
BENDER_SYNTH_DIR = gf22
BENDER_BUILD_DIR:=.


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
compile_flag     += +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -suppress 7063 -suppress 3009 -permissive +define+$(defines)
uvm-flags        += +UVM_NO_RELNOTES +UVM_VERBOSITY=LOW
questa-flags     += -t 1ns -64 -coverage -classdebug $(gui-sim) $(QUESTASIM_FLAGS) -suppress 3009 -suppress 3999
compile_flag_vhd += -64 -nologo -quiet -2008

compile_flag_bender   += +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive 


# Iterate over all include directories and write them with +incdir+ prefixed
# +incdir+ works for Verilator and QuestaSim
list_incdir := $(foreach dir, ${incdir}, +incdir+$(dir))

# if defined, calls the questa targets in batch mode
ifdef batch-mode
	questa-flags += -c
	questa-cmd   := -do "coverage save -onexit ./test.ucdb; run -a; quit -code [coverage attribute -name TESTSTATUS -concise]"
	questa-cmd   += -do " set StdArithNoWarnings 1; set NumericStdNoWarnings 1; run -all;"
else
	questa-cmd   := -do " set StdArithNoWarnings 1; set NumericStdNoWarnings 1; log -r /*; run -all;"
endif 
# we want to preload the memories
ifdef preload
	questa-cmd += +PRELOAD=$(preload)
  compile_flag +=  +PRELOAD=$(preload)
	elf-bin = ../software/hello/hello.riscv
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

ifdef exclude-llc
	questa-cmd += +EXCLUDE_LLC=$(exclude-llc)
  compile_flag +=  +define+EXCLUDE_LLC
  compile_fpga += EXCLUDE_LLC
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

ifdef exclude_otp_rom
	compile_flag += +define+EXCLUDE_OTP_ROM
	questa-cmd += +define+EXCLUDE_OTP_ROM
  compile_fpga += +define+EXCLUDE_OTP_ROM
endif

ifdef preload
	compile_flag += +define+PRELOAD
	questa-cmd += +define+PRELOAD 
endif

bender:
	curl --proto '=https' --tlsv1.2 https://fabianschuiki.github.io/bender/init -sSf | sh

update:
	bender update

libbender:
	@vlib work
	vmap work ./work

scripts-bender-fpga: | Bender.lock
	mkdir -p fpga/alsaqr/tcl/generated
	bender script vivado -t fpga -t xilinx -t tech_cells_generic_include_xilinx_xpm --define="$(compile_fpga)" > $(BENDER_FPGA_SCRIPTS_DIR)/compile.tcl

scripts-bender-fpga-ddr: | Bender.lock
	mkdir -p fpga/alsaqr/tcl/generated
	bender script vivado -t fpga -t ddr -t xilinx -t tech_cells_generic_include_xilinx_xpm --define="$(compile_fpga)" > $(BENDER_FPGA_SCRIPTS_DIR)/compile.tcl

scripts-bender-synopsys: | Bender.lock
	echo 'set ROOT [file normalize [file dirname [info script]]/../../../]' > $(BENDER_SYNTH_DIR)/synopsys/scripts/analyze_alsaqr.tcl
	bender script synopsys -t rtl -t synthesis -t asic -t top_level | grep -v "set ROOT" >> $(BENDER_SYNTH_DIR)/synopsys/scripts/analyze_alsaqr.tcl

scripts:
	bender script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 " --vcom-arg="$(compile_flag_vhd) -work  $(library) -pedanticerrors" \
    -t rtl -t test > compile.tcl

scripts_vip:
	bender script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 " --vcom-arg="$(compile_flag_vhd) -work  $(library) -pedanticerrors" \
    -t rtl -t test -t vip > compile.tcl

post_synth_scripts_vip:
	bender script vsim \
		--vlog-arg="$(compile_flag)  -work  $(library) -suppress 2583 -suppress 13314 " --vcom-arg="$(compile_flag_vhd) -work  $(library) -pedanticerrors" \
    -t rtl -t test -t top_post_synth_sim -t vip > post_synth_compile.tcl

benderrun: libbender $(util) $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	vsim -c -do 'source $(compile_script); quit'
	touch $(library)/.build-srcs

bendertb: benderrun $(dpi)
	touch $(library)/.build-tb

build: bendertb 	$(dpi-library)/ariane_dpi.so
	vopt $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized +acc -check_synthesis


$(library):
	vlib${questa_version} $(library)

# compile DPIs
$(dpi-library)/%.o: tb/dpi/%.cc $(dpi_hdr)
	mkdir -p $(dpi-library)
	$(CXX) -shared -fPIC -std=c++0x -Bsymbolic $(CFLAGS) -c $< -o $@

$(dpi-library)/ariane_dpi.so: $(dpi)
	mkdir -p $(dpi-library)
	# Compile C-code and generate .so file
	$(CXX) -shared -m64 -o $(dpi-library)/ariane_dpi.so $? -L$(RISCV)/lib -L$(SPIKE_ROOT)/lib -Wl,-rpath,$(RISCV)/lib -Wl,-rpath,$(SPIKE_ROOT)/lib -lfesvr

# single test runs on Questa can be started by calling make <testname>, e.g. make towers.riscv
# the test names are defined in ci/riscv-asm-tests.list, and in ci/riscv-benchmarks.list
# if you want to run in batch mode, use make <testname> batch-mode=1
# alternatively you can call make sim elf-bin=<path/to/elf-bin> in order to load an arbitrary binary		
 
generate-trace-vsim:
	make sim preload=$(preload) elf-bin= batch-mode=1
	make generate-trace

run:
	vsim${questa_version} +permissive $(questa-flags) $(questa-cmd) -suppress 3053 -suppress 7033 -suppress 8885 -lib $(library) +notimingchecks +nospecify +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +CVA6_STRING=$(elf-bin) +OT_STRING=$(ibex_elf_bin) +CL_STRING=$(cl-bin) -t 1ps \
	$(uvm-flags) $(QUESTASIM_FLAGS) -sv_lib $(dpi-library)/ariane_dpi  \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log


sim: build run

$(alsaqr-regression): build
	mkdir -p tmp
	../software/elf_to_slm.py --binary=$@ --vectors=hyperram0.slm
	vsim${questa_version} +permissive $(questa-flags) $(questa-cmd) -lib $(library)  -suppress 3053 -suppress 8885 +max-cycles=$(max_cycles) +UVM_TESTNAME=$(test_case) +CVA6_STRING=$@ +CL_STRING=$(cl-bin) -t 1ps \
	$(uvm-flags) $(QUESTASIM_FLAGS) -sv_lib $(dpi-library)/ariane_dpi   \
	${top_level}_optimized $(QUESTASIM_FLAGS) +permissive-off ++$(alsaqr-regression-dir)/$@ ++$(target-options) | tee tmp/alsaqr-regression-$@.log

check-benchmarks:
	echo $(alsaqr-regression)
	./check-regs.sh 

run-regressions:	$(alsaqr-regression)
	$(MAKE) check-benchmarks

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
