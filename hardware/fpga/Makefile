clean:
		rm -rf vivado*
		rm -rf .Xil
		rm -rf alsaqr/alsaqr*

ips:
		$(MAKE) -C alsaqr/tcl/ips/boot_rom clean all
		$(MAKE) -C alsaqr/tcl/ips/clk_mngr clean all
		$(MAKE) -C alsaqr/tcl/ips/ddr      clean all
		$(MAKE) -C alsaqr/tcl/ips/qspi     clean all

run:
		vitis-2020.2 vivado -mode gui -source run.tcl

