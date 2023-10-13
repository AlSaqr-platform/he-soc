# AlSaqr SoC

This repository contains the hardware files needed to build the AlSaqr-SoC. The architecture of the SoC is briefly described in the block diagram below.

![alt text](./hardware/docs/RTL.jpg)

The repository is organized as follows

```
|── bootrom
|── fpga 
|── hardware
|── software
```

 * The `fpga` folder contains some git submodules.

 * The `hardware` folder is organized as follows:

   - `deps` contains local component integrated in the SoC
   - `host` contains the host-system: it wraps the core and plugs it into the `axi_node` to which the slaves are attached
   - `tb` contains the testbench
   - `fpga` contains the scripts to generate the bitstream

 * `software` contains the bare metals tests you can run on the SoC

## Repo initialization
Please change the setup to point to you toolchains and Questasim installations in he-soc/setup.sh):
** NB: this fetches the current master branch, under costant developement. **

```
git clone git@github.com:AlSaqr-platform/he-soc.git

cd he-soc/

source setup.sh
```
** NB: To target a specific release you should git checkout it as first step after cloning the repo. **
```
git clone git@github.com:AlSaqr-platform/he-soc.git

cd he-soc

git checkout tags/<tag-name> 

source setup.sh
```

To install, configure bender and download the git dependencies + verification IPs, from he-soc/ run:

```
cd hardware/

ulimit -n 2048

make init
```
To compile the hello world, in he-soc/hardware run:

```
make -C ../software/hello_culsans clean all
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
By default, the elf binary will be loaded through the DMI interface, driven by the SimDTM, communicating with FESVR, the host.

To load the code through JTAG interface, you can add the `localjtag=1` option to the previous command, for instance: `make localjtag=1 scripts_vip`.
Be aware that the preload of the code is slower in this case.

### Preload

To reduce simulation time, you can also preload the code in the hyperram. To do so follow the steps here:

```
make clean preload=1 scripts_vip
```
This will generate the compile.tcl with the preload defines.

### Run the test

 * Option 1: in the he-soc/hardware folder run (elf-bin shall be equal to the path to the elf you want to laod):

```
make clean sim elf-bin=../software/hello_culsans/hello_culsans.riscv
```
or simply `make clean sim` if you used the preload flag. Be aware that the loaded code will be the last one you compiled.

 * Option 2: go to the test folder (ex `software/hello`)
 
```
make clean all sim
```
### Run test with OpenTitan:

To run mbox test between cva6 and ibex, in he-soc/hardware run:
```
make -C ../software/mbox_test clean all

make clean sim ibex-elf-bin=./opentitan/sw/tests/alsaqr/mbox_test/mbox_test.elf elf-bin=../software/mbox_test/mbox_test.riscv

```

To run the secure boot, use the following commands:

```
make scripts_vip sec_boot=1

make clean sim BOOTMODE=1 sec_boot=1

```

### Running code on the cluster

Work In Progress: to better validate the cluster functionalities we are improving its software environment

### Run regressions

** Due to the padframe modifications this option is under development **

Before merging any modification into the master it is important to run the regression tests to check we did not break anything. To do so, execute the following commands:

```
cd software

source compile_all.sh

cd ../hardware

make scripts_vip

make clean batch-mode=1 run-regressions
```

The tests that will be executed are the one listed in `software/regression.list`

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

** Due to the padframe modifications this option is under development **

The design synthesis of AlSaqr adopts a hierarchical approach. Individual components, such as CVA6, OpenTitan, HyperRAM, PULP Cluster, and FLL, are synthesized independently. However, at the top tier of the design, these submodules are integrated as hard macros, utilizing LEF geometric files alongside lib/db timing views for precision.

To validate the synthesis of AlSaqr we provide the following simulation targets, allowing flexibility and testability:

 * post_synth_all
   This script generates the compile.tcl using all the netlists of the design
   (TOP - FLL - HYPERRAM - CULSANS - CLUSTER - OPENTITAN)

 * post_synth_top
   This script generates the compile.tcl using only the following netlists: TOP - HYPERRAM - FLL

 * post_synth_fll
   This script generates the compile.tcl using only the following netlists: FLL
 
 * post_synth_opentitan
   This script generates the compile.tcl using only the following netlists: OPENTITAN

 * post_synth_cluster
   This script generates the compile.tcl using only the following netlists: CLUSTER

 * post_synth_hyper
   This script generates the compile.tcl using only the following netlists: HYPERRAM

To perform the post sythesis simulation of one of the previous target run the following command within `he-soc/hardware` 

```
make clean post_synth=1 <target_name> synth_sim
```

