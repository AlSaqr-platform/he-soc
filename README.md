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

## NOTE:
Hints to solve compilation issues:
* Copy the `vip` folder in `hardware/tb`
### TODO: Fix these

## Hello World:

```
git clone https://github.com/AlSaqr-platform/cva6.git

git submodule update --init --recursive
```

To compile the code:

```
source setup.sh

cd software/hello

make clean all

cd ../..

```
please change the setup to point to you toolchains and Questasim installations.

### RTL BUILD

To install and configure bender, run:

```
make bender

ulimit -n 2048
```

You also need to download the vip RTL modules ( [HYPERRAM](https://www.cypress.com/documentation/models/verilog/s27kl0641-s27ks0641-verilog), [HYPERFLASH](https://www.cypress.com/verilog/s26ks512s-verilog), [SPI](http://www.cypress.com/file/260016) and [I2C](http://ww1.microchip.com/downloads/en/DeviceDoc/24xx1025_Verilog_Model.zip) ).

```
cd hardware

make update

make scripts_vip

```

Doing so will load the elf binary through the DMI interface, driven by the SimDTM, communicating with FESVR, the host.

To load the code through JTAG interface, you can add the `localjtag=1` option and do `make localjtag=1 scripts_vip`. Be aware that the preload of the code is slower in this case.


### Preload

To reduce simulation time, you can also preload the code in the hyperram. To do so follow the steps here:

```
cd hardware

make update

make preload=1 scripts_vip

```
This will generate the compile.tcl with the right defines. Go to the test you want to run.

### Compile the code

```
cd ../software/hello/

make clean all

```

This will generate the binaries and the hyperram*.slm that will be in the rams at t=0 (in case of preloading). 

### Run the test

 * Option 1: go to the hardware folder and do:

```
make sim elf-bin=../software/hello/hello.riscv
```
or simply `make sim` if you used the preload flag. Be aware that the loaded code will be the last one you compiled.

 * Option 2: go to the test folder (ex `software/hello`)
 
```
make sim
```
### Run test with OpenTitan:

In he-soc/hardware run:
```
make clean sim ibex-elf-bin=<path to test binary>

```
To disable cva6 (and eventually boot it form OpenTitan and run Hello World) use the following flag option:

```
make scripts_vip sec_boot=1

make clean sim ibex-elf-bin=<path to test binary> sec_boot=1

```

### Running code on the cluster

To compile the cluster's code you can go in the `software/pulp` folder:

```
export PATH=/path-to-riscy-toolchain/bin:$PATH

make clean all

```
Then,

```
cd ../cluster

make clean all

make sim elf-bin=../software/cluster/launch_cluster.riscv 

```
### Run regressions

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
