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
		$(VIVADO_VERSION) vivado -mode gui -source run.tcl
