TESTS ?= $(shell find ./testlist/* -maxdepth 0 -type d -exec basename {} \;)

$(TESTS):
	@echo "Running $@"
	@$(MAKE) -C testlist/$@ all run nogui=1 max-opt=1 >& /dev/null

clean:
	@for item in $(TESTS); do \
	    echo "Cleaning $$item"; \
	   	$(MAKE) -C testlist/$$item clean-sim clean >& /dev/null; \
	done

run: clean
	$(MAKE) $(TESTS)

profile: run
	@./extract_results.py
	@cat results.csv | column -t -s,

all: profile

.PHONY: run clean profile all

