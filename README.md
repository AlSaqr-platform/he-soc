# AlSaqr SoC

This repository contains the hardware files needed to build the AlSaqr-SoC. The architecture of the SoC is briefly described in the block diagram below.

![alt text](./hardware/docs/AlSaqr.jpg)

The repository is organized as follows

```
|-- bootrom
|-- fpga 
|-- hardware
|-- software
```

 * The `fpga` folder contains some git submodules.

 * The `hardware` folder is organized as follows:

   - `deps` contains local component integrated in the SoC
   - `host` contains the host-system: it wraps the core and plugs it into the `axi_node` to which the slaves are attached
   - `tb` contains the testbench
   - `fpga` contains the scripts to generate the bitstream
   - `docs` contains the datasheet of AlSaqr SoC and the related padframe specification 

 * `software` contains the bare metals tests you can run on the SoC

## RISC-V Toolchain

AlSaqr requires the RISC-V toolchain which is available here: https://github.com/riscv-collab/riscv-gnu-toolchain

For the PULP CLuster make sure the PULP RV32 toolchain is in your PATH. Please refer to PULP RISCV GCC toolchain to use a pre-built release: https://github.com/pulp-platform/pulp-riscv-gcc

## Repo initialization
Please change the setup file to point to your toolchains and Questasim installations in he-soc/setup.sh:

** NB: this fetches the current master branch, under costant developement. **

```
git clone git@github.com:AlSaqr-platform/he-soc.git
cd he-soc/
source setup.sh
source software/pulp-runtime/configs/pulp_cluster.sh
```
** NB: To target a specific release you should git checkout it as first step after cloning the repo. **
```
git clone git@github.com:AlSaqr-platform/he-soc.git
cd he-soc
git checkout tags/<tag-name> 
source setup.sh
source software/pulp-runtime/configs/pulp_cluster.sh
```

To install, configure bender and download the git dependencies + verification IPs, from he-soc/ run:

```
cd hardware/
make init
```
make init step may fail on slower networks as connection breaks before getting all repositories.
Repeat 'make init' step until all repositories downloaded and bender lock generated.

To compile the hello world, in he-soc/hardware run:

```
make -C ../software/hello_culsans clean all
```
To compile the hello world for FPGA board, in he-soc/hardware run:

```
make -C ../software/hello_culsans fpga=1 clean all
```
This will generate the binaries and the hyperram*.slm that will be in the rams at t=0 (in case of preloading). 
 
### Generate TCL for simulation

Then, generate the tcl for simulation and synthesis. In he-soc/hardware run one of two following options accordingly to your target:

* RTL simulation:
```
make scripts_vip
```

* RTL simulation using gf22 macros (this requires the gf22 repository to be cloned and initialized into he-soc/hardware folder, as well as fll's one):
```
make scripts_vip_macro
```
By default, the elf binary will be preloaded into L3.

To load the code through JTAG interface, you can add the `localjtag=1` option to the previous command, for instance: `make localjtag=1 scripts_vip`.
Be aware that the preload of the code is slower in this case.


### Run the test

 * Option 1: in the he-soc/hardware folder run (the test to be run shall be compiled first, as the command runs automatically the simulation with the last tests that has been compiled):

```
make -C ../software/"test you want to run" clean all
make clean sim
```
If you want to speed up the simulation (of about 2x), you can use the "max-opt" flag, which will deactivate the logs of all the waveforms. This is not suitable for debugging, but just to get the result of a test as fast as passible.
To avoid the Questa GUI to be opened, you can use the "nogui=1" flag, which applies the same opts as max-opt and do not open the gui.
```
make scripts_vip max-opt=1
make clean sim max-opt=1
```
or
```
make scripts_vip nogui=1
make clean sim nogui=1
```

The code that will be laoded is the last that has been compiled. Thus, to run a test with preload in L3, you shall compile the test you want to run (as shown above) and then run the simulation without providing the path to the binary.

In case of localjtag preload, you need to provide the path to the binary you want to execute. `make clean sim elf-bin=../software/hello_culsans/hello_culsans.riscv` if you used the localjtag preload flag.

 * Option 2: go to the test folder (ex `software/hello_culsans`)
 
```
make clean all sim
```
### Run test with OpenTitan:

To run mbox test between cva6 and ibex, in he-soc/hardware run:
```
make -C ../software/mbox_test clean all
make clean sim ibex-elf-bin=./opentitan/sw/tests/alsaqr/mbox_test/mbox_test.elf 
```

To run the full secure boot, use the following commands (for instance, opentitan boots CVA6 which runs an hello world):

```
make scripts_vip sec_boot=1
make -C ../software/hello_culsans/ clean all
make clean sim BOOTMODE=1 sec_boot=1

```

### Running code on the cluster

To run code on the cluster we must first source its runtime:
```
cd software
source pulp-runtime/configs/pulp_cluster.sh
```
Each test designed for the cluster is structured as follows:
```
- your-test-folder
  |
  |
  -- stimuli
```
The parent folder contains the code executed by the host (CVA6) and the `stimuli` folder contains the cluster code.

You can compile all the needed files with the following commands:
```
cd your-test-folder
make -C stimuli clean all dump_header
make clean all CLUSTER_BIN=1
```
The tests that will run is the last that's been compiled. Thus, compile a test among the ones in software/cluster_regression.list then run the following commands:
```
cd ../../hardware
make scripts_vip
make clean sim
```
### Run regressions

Before merging any modification into the master it is important to run the regression tests to check we did not break anything. To do so, execute the following commands:

To run the regressions including the CVA6 various dual boot mode, FLL bypass and secure boot/mbox test and periphs, run:
```
cd hardware/
make run_regression
```
The tests executed here can be found in `hardware/regressions/regression.csv`, they are 23 and all of them pass.


### FPGA Emulation

We now support emulation on Xilinx VCU118. Please have a look to the README in the `hardware/fpga` folder.


### Synthesize he-soc into your target technology

This requires the gf22 repository to be cloned and initialized into he-soc/hardware folder.
In he-soc/hardware run:

```
make clean scripts-bender-synopsys
```
The command will generate the analyze_alsaqr.tcl within your technology folder

### Post Synthesis Simulations

NB: Due to the padframe modifications this option is under development

The design synthesis of AlSaqr adopts a hierarchical approach. Individual components, such as CVA6, OpenTitan, HyperRAM, PULP Cluster, and FLL, are synthesized independently. However, at the top tier of the design, these submodules are integrated as hard macros, utilizing LEF geometric files alongside lib/db timing views for precision.

To validate the synthesis of AlSaqr we provide the following simulation targets, allowing flexibility and testability:

 * gf22_fll_behav
  
  RTL + FLL BEHAVIOURAL (YOU NEED ACCESS TO THE PRIVATE FLL REPO FOR THIS)

 * post_synth_all

  ONLY NETLSISTS: TOP - FLL - CVA6 -OPENTITAN - CLUSTER - HYPER

 * post_synth_top

  RTL: OPENTITAN - CLUSTER - CVA6  / NETLIST: TOP - FLL - HYPER

 * post_synth_cva6_hyper

  RTL: TOP - CLUSTER - OPENTITAN - FLL BEHAV (YOU NEED ACCESS TO THE FLL REPO FOR THIS)  / NETLIST: CVA6 - HYPER

 * post_synth_cva6_hyper_fll

  RTL: TOP - CLUSTER - OPENTITAN / NETLIST: CVA6 - HYPER - FLL

 * post_synth_fll

  RTL + FLL NETLIST

 * post_synth_top_fll_behav

  RTL + FLL NETLIST

 * post_synth_cva6

  RTL: (USES FLL DUMMY) + CVA6 NETLIST

 * post_synth_opentitan

  RTL (USES FLL DUMMY) + OPENTITAN NETLIST

 * post_synth_cluster

  RTL (USES FLL DUMMY) + CLUSTER NETLIST

 * post_synth_hyper

  RTL (USES FLL DUMMY) + HYPER NETLIST

 
To perform the post sythesis simulation of one of the previous target run the following command within `he-soc/hardware` (NB: the acc flag ensures that the simulation is fast, about 10 mins for an hello world):

```
make clean post_synth=1 <target_name> synth_sim acc=+acc=p+ariane_tb.
```
There is a framwork to run the regressions with the netlist of the chip as well. The netlist regression list is defined in hardware/regressions/regressions_netlist.csv while the transcript of each simulation will be stored in hardware/regressions/regressions_netlist_reports/ . To run the regression using the netlist do the following:

```
cd hardware/
make run_regression_netlist
```
