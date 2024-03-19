# Step-by-step 4-core bitstream generation

```
git clone git@github.com:AlSaqr-platform/he-soc.git
cd he-soc
git checkout alsaqr-4-corev1.0
```

Change the `PATH` and `RISCV` exports in the `setup.sh` script.

```
source setup.sh
cd hardware
make bender update
make simple-padframe=1 exclude-cluster=1 exclude-rot=1 quad-core=1 scripts-bender-fpga-ddr
cd fpga
source setup.sh
```
Correct setup settings are highlighted in bold:

*Which board you want to use:  1-zcu102 2-vcu118:* **2**

*Are you instantiating the LLC? y/n* **y**

*Are you instantiating OpenTitan? y/n* **n**

*Which main memory are you using:  1-DDR 2-HYPER:* **1**

*How many CVA6 cores? 2/4* **4**

*Are you validating the peripherals? y/n* **y**

```
make ips

make clean run
```

Vivado IPs shall be generated only once at the first synthesis (unless modifications to the ROMs or to clk frequency are applied)

## Running code on CVA6 only

We have not yet modifed the bare-metal runtime for quad-core support. To run Linux, refer to our fork of the [CVA6-sdk](https://github.com/AlSaqr-platform/cva6-sdk/tree/alsaqr-quad-corev1.0)

As of now, to interface with Alsaqr on FPGA we use [openocd](https://github.com/riscv/riscv-openocd). The debugger we use is [this one](https://www.olimex.com/Products/ARM/JTAG/ARM-USB-OCD-H/).

The CVA6 JTAG is connected to the PMOD0 port (J52 connector) of the VCU118 (refer to the baord's documentation to find it). The connections between the Olimex and the PMOD0 port are shown in the followin image.

![alt text](./openocd/CVA6_jtag_connection.png)

## Install OpenOCD

```
git clone https://github.com/riscv/riscv-openocd.git
cd riscv-openocd
git checkout 3249d415595ee430164aa0429bcc7452c0f251fa
./bootstrap
./configure --enable-jtag_vpi --enable-jtag_dpi --enable-remote-bitbang --enable-fdti enable-ftdi-oscan1 --prefix=/path/to/install
make
make install
```
