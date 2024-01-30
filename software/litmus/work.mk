include $(HW_HOME)/Makefile

%.log: ../binaries/%.elf
	ln -sf $(HW_HOME)/work work
	ln -sf $(HW_HOME)/work-dpi work-dpi
	ln -sf $(HW_HOME)/tb tb
	$(SW_HOME)/elf_to_slm.py --binary=$< --vectors=hyperram0.slm
	$(MAKE) run $(ADDITIONAL_FLAGS) elf-bin=$< > $@