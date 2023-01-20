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


### RTL BUILD
Modify the setup.sh script, it should point to your RISCV and QUESTASIM paths
A working version for bender is already present in the root dir of the repo, it is needed to export the path to it as follows:

```
cd <path-to-root-dir-he-soc>

source setup.sh 

export PATH=<path-to-root-dir-he-soc>:$PATH

ulimit -n 2048
```

You also need to download the vip RTL modules ( [HYPERRAM](https://www.cypress.com/documentation/models/verilog/s27kl0641-s27ks0641-verilog), [HYPERFLASH](https://www.cypress.com/verilog/s26ks512s-verilog), [SPI](http://www.cypress.com/file/260016) and [I2C](http://ww1.microchip.com/downloads/en/DeviceDoc/24xx1025_Verilog_Model.zip) ).


Into he-soc/hardware/tb , create the directory he-soc/hardware/tb/vip and clone into it the vips RTL modules.

```
cd hardware

make update

bender clone opentitan
```
here conflicts will appear: for "tech cells generics" and "axi" select the hashed version, for "riscv_dbg" select "`>=0.4.1, <0.5.0`"

### SOFTWARE BUILD
```
make -C ../software/mbox_test clean all

make -C working_dir/opentitan/hw/top_earlgrey/sw/tests/mbox_test clean all
```
### RUN THE TEST
```

make exclude-cluster=1 exclude-llc=1 preload=1 scripts_vip 

make clean sim

```

### FPGA Emulation

We now support emulation on Xilinx VCU118. Please have a look to the README in the `hardware/fpga` folder.

