TESTS := $(shell find ./testlist/* -maxdepth 0 -type d -exec basename {} \;)

JOBS ?= 32

$(TESTS):
	@echo "Running $@"
	@$(MAKE) -C testlist/$@ all run >& /dev/null

run-all-tests:
	$(MAKE) -j $(JOBS) $(TESTS) nogui=1 max-opt=1

clean:
	@for item in $(TESTS); do \
	    echo "Cleaning $$item"; \
	   	$(MAKE) -C testlist/$$item clean-sim clean >& /dev/null; \
	done

profile:
	grep -oP 'Error: \[JTAG\] FAILED: return code \K\d*' testlist/*/sim.d/transcript | sed 's@testlist/\([^/]*\)/.*:\([^:]*\)@\1 \2@' > results.log

all: clean run-all-tests profile

.PHONY: run-all-tests clean profile all

