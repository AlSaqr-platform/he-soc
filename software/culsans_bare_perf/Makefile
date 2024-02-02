TESTS := $(shell find ./testlist/* -maxdepth 0 -type d -exec basename {} \;)
RES_DIR := results

JOBS ?= 32

$(TESTS):
	@echo "Running $@"
	@$(MAKE) -j 1 -C testlist/$@ -d all run >& /dev/null

run-all-tests:
	$(MAKE) -j $(JOBS) $(TESTS)

clean:
	@for item in $(TESTS); do \
	    echo "Cleaning $$item"; \
	   	$(MAKE) -C testlist/$$item clean-sim clean >& /dev/null; \
	done

.PHONY: run-all-tests clean

