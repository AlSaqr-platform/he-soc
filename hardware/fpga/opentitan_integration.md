# FPGA EMULATION OF ALSAQR WITH OPENTITAN INTEGRATED

The test is setup to perform secure communication between the Main core that is Ariane and the RoT core, Ibex. The communication happens throught interrupts and a SCMI-compliant mailbox, implemented with a regfile.
In the FPGA synthesis the JTAG ports of both the cores are mapped to the i/o of the FPGA. In particular, the Ariane JTAG port is mapped to the J52 port of the vcu118 board, while the Ibex JTAG port is mapped to the
J2 port, that implements the reduced FMC protocol. The vcu118 board presents a connector for the J2 FMC port, to which it is connected the FMC Test Board presenting 5 ports with 16 pins each. The Ibex JTAG is
mapped to the X2 connector of the FMC Test Board. The figure below describes the connections to the Olimex. The connections of the Ariane JTAG port are the same shown in the "PULP emulation on Xilinx Virtex7 FPGA board" presentation.

The .cfg files to be used in openocd are the same for both the cores with the exception of the Olimex Serial Link. There are two config files, ariane.cfg and ibex.cfg.
Those cfg file have to be changed according to the Olimex ids and the ports for the remote connection to gdb. The command usb-devices shows information about the usb peripherals connected to the PC hosting the board. Connecting one Olimex by time and launching usb-devices
it is easy to figure out which is the serial of each Olimex, that will have to be replaced in the cfg files according to where each Olimex is connected (J52 for Ariane or J2 FMC for Ibex).

## Running the Test

The code for Ariane is in the location <root-of-cva6-repo>/software/hello/hello.riscv while the code for Ibex is located at <root-of-cva6-repo>/sw/mailbox_test/hello_test.elf
To run the test it is needed to open the hw manager (vivado) and load the bitstream. Then open 5 terminals and:

###Terminal 1: openOCD for Ariane
```
openocd -f <path-to-cfg-files>/ariane.cfg
```
###Terminal 2: openOCD for Ibex
```
openocd -f <path-to-cfg-files>/ibex.cfg
```
###Termianl 3: gdb for Ariane
```
riscv64-unknown-elf-gdb <path-to-compiled-elf>/hello.riscv
```
###Terminal 4: gdb for Ibex
``
riscv64-unknown-elf-gdb <path-to-compiled-elf>/hello_test.elf
```
###Terminal 5: screen for the prints
```
screen -L /dev/ttyUSBi 115200
```

At this point, both the openocd processes should be connected to the JTAG ports and should be ready to accept the gdb connection at the ports :1111 for Ibex and :3333 for Ariane. Then:

###Terminal 3: connecting gdb to Ariane
```
target remote :3333
monitor reset halt
load
```
###Temrinal 4: connecting gdb to Ibex
```
target remote :1111
monitor reset halt
load
```

The code is now loaded to the RAM memories and the PC is set to the starting point. I setup the test in such a way that the Ibex core is the first to go in execution. It performs some r/w to the mailbox and
print a message if the readback value correspond to what has been written. Then Ibex goes in "wait for interrupt". At this point Ariane starts the communication test. It performs as well some write and checks
it the readback values correspond to the ones written, rings the doorbell and goes in wait for (completion) interrupt as well. At this point Ibex receives the irq from the mailbox and starts the IRQ Handler which
is in charge to read the mailbox regs and compare the values with the ones Ariane has written. If they match, Ibex raises the completion interrupt writing the correspondent register of the mailbox and goes back to wfi.
Ariane receives the completion interrupt, whose IRQ Handler prints out a message and return. At this point the test is over and it also succeded. If some communication error between the cores or with tha mailbox,
the code never arrives to the final "test succeeded" print.
To launch the test so:


###Terminal 4: connecting gdb to Ibex
```
continue
```
###Temrinal 3: connecting gdb to Ariane
```
continue

```
The terminal 5 with the uart screen should now show the prints of the test. The test can be repeated by resetting the cores (monitor reset halt + laod + continue in both gdb processes)