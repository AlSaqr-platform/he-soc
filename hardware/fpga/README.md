#FPGA Emulation

We now support emulation on the VCU118. For fpga emulation, you can choose if you want to plug which `axi_slave` you prefer to the `axi_xbar`: either the `hyperbus memory controller` or the `Xilinx DDR4 AXI IP` that uses the onboard DDR4.

## Bitstream generation

To generate the bitstream do the following:

```
bender update

make exclude-cluster=1 scripts-bender-fpga-ddr
```
You can actually remove the `exclude-cluster` option, in case you want to emulate the cluster as well. Please be aware that the bitstream generation will take much more time in that case.
```
cd fpga

source setup.sh
```
Select VCU118. The ZCU102 is already too small to fit ariane and the cluster. We will provide support for the ZCU102 as well in the future, with a reduced cluster.

```
cd alsaqr/tcl/ips/boot_rom/

make clean all

cd ../../../../

cd alsaqr/tcl/ips/clk_mngr/

make clean all

cd ../../../../

cd alsaqr/tcl/ips/ddr/

cd ../../../../

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
(a) target remote 127.0.0.1:3333
(b) monitor reset halt
(c) load
(d) c
```
At this point you are supposed to see the uart prints on the screen. 

