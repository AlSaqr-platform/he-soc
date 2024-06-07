constrs_path := alsaqr/tcl
constr_list := $(constrs_path)/constraints.xdc
constr_list += $(constrs_path)/constraints_peripherals.xdc

ifeq ($(MAIN_MEM), HYPER)
constr_list += $(constrs_path)/constraints_hyper.xdc
endif
ifeq ($(USE_OT), 1)
constr_list += $(constrs_path)/constraints_opentitan.xdc
endif
ifeq ($(SIMPLE_PAD), 1)
constr_list += $(constrs_path)/constraints_fpga_padframe.xdc
endif

clean:
		rm -rf vivado*
		rm -rf .Xil
		rm -rf alsaqr/alsaqr*
		rm -rf ./*.mif

ips:
		$(MAKE) -C alsaqr/tcl/ips/boot_rom clean all
		$(MAKE) -C alsaqr/tcl/ips/clk_mngr clean all
		$(MAKE) -C alsaqr/tcl/ips/ddr      clean all
		$(MAKE) -C alsaqr/tcl/ips/qspi     clean all
		$(MAKE) -C alsaqr/tcl/ips/otp_ot   clean all
		$(MAKE) -C alsaqr/tcl/ips/rom_ot   clean all

constr:
		rm -f ./timing_constr.xdc
		cat $(constr_list) > ./timing_constr.xdc

run: constr
		vivado -mode batch -source run.tcl

