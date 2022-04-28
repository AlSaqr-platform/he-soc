#!/bin/bash

cd alsaqr/tcl/ips/axi_dma

make clean all

cd ../axi_ethernet

make clean all

cd ../boot_rom

make clean all

cd ../clk_mng

make clean all

cd ../ddr

make clean all

cd ../qspi

make clean all

cd ../../../../
