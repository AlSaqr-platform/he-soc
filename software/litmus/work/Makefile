WORK   := .
HW_RES := ../hw-results
SRC    := ../src
TMP    := tmp

LITMUS_TEST_LIST = $(shell find $(SRC)/binaries -type f -name "*.elf" -exec basename {} .elf \;)

SYMLINKS = work work-dpi tb Makefile

ADDITIONAL_FLAGS ?= dual-boot=1 nogui=1

$(HW_RES)/%.litmus.log: $(HW_RES)/%.uart.log
	echo "$<"
	echo "Test $* Allowed" > $@
	echo "Histogram" >> $@
	cat $< >> $@
	echo "" >> $@

$(HW_RES)/%.uart.log: $(WORK)/%.sim.log
	awk '/^#\s*Mock uart\s*0:/ \
	{ match($$0, /^#\s*Mock uart\s*0:(.*)$$/, arr); \
	gsub(/^[[:space:]]+|[[:space:]]+$$/, "", arr[1]); \
	print arr[1] }' $< > $@

$(WORK)/%.sim.log:
	echo "Processing $*..."
	mkdir -p $(TMP)/$*
	for el in $(SYMLINKS); do \
        ln -sf $(HW_HOME)/$$el $(TMP)/$*/$$el; \
    done;
	cd $(TMP)/$* && $(SW_HOME)/elf_to_slm.py --binary=../../$(SRC)/binaries/$*.elf --vectors=hyperram0.slm > /dev/null
	$(MAKE) -C $(TMP)/$* run $(ADDITIONAL_FLAGS) elf-bin=../../$(SRC)/binaries/$*.elf 1> $@ 2> /dev/null

clean:
	rm -f ./*.log
	rm -rf tmp

.PHONY: clean