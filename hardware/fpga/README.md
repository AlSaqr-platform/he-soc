# FPGA Emulation

We now support emulation on the VCU118. For fpga emulation, you can choose if you want to plug which `axi_slave` you prefer to the `axi_xbar`: either the `hyperbus memory controller` or the `Xilinx DDR4 AXI IP` that uses the onboard DDR4.

To rely on the hyperbus, you need a [special FMC carrier board](https://ieeexplore.ieee.org/document/9607006). Also, when using the DDR we can push the design to 50MHz. When relying on the Hyperbus, our upper limit is 10MHz.

## Bitstream generation

To generate the bitstream do the following

```
bender update

```
then `make simple-padframe=1 scripts-bender-fpga-ddr` to use the 1GHz DDR4 or `make scripts-bender-fpga` to use the hyperbus.

You can also use the `exclude-cluster=1` option, in case you don't want to emulate the cluster as well.

```
cd fpga

source setup.sh
```
 * Select VCU118. The ZCU102 is already too small to fit ariane and the cluster. We will provide support for the ZCU102 as well in the future, with a reduced version of the cluster.
 * Unless you specified the `exclude-llc` when generating the compile script, you are instantiating it!
 * Choose the memory
 * If you choose the hyperram, you can't validate the peripherals. Otherwise you can. Apparently, it's better to instantiate the padframe: it help Vivado with placement, so just say you are also validating the peripherals if you are using the DDR4. 

```
make ips

make clean run
```

## Running code 

As of now, to interface with Alsaqr on FPGA we use [openocd](https://github.com/riscv/riscv-openocd). The debugger we use is [this one](https://www.olimex.com/Products/ARM/JTAG/ARM-USB-OCD-H/).

 * Open the hw manager and load the bitstream
 * Open 3 terminals:

### Terminal 1

```
openocd -f zcu-102-ariane.cfg
```
### Terminal 2

```
screen -L /dev/ttyUSBi 115200
```
### Terminal 3

```
riscv64-unknown-elf-gdb <path-to-compiled-elf>
from gdb terminal
(a) target remote :3333
(b) monitor reset halt
(c) load
(d) c
```
At this point you are supposed to see the uart prints on the screen. 

