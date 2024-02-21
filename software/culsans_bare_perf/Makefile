TEST_FOLDER = testlist
TESTS ?= $(shell find ./$(TEST_FOLDER)/* -maxdepth 0 -type d -exec basename {} \;)

$(TESTS):
	@echo "Running $@"
	@$(MAKE) -C $(TEST_FOLDER)/$@ all run nogui=1 max-opt=1 >& /dev/null

clean:
	@for item in $(TESTS); do \
	    echo "Cleaning $$item"; \
	   	$(MAKE) -C $(TEST_FOLDER)/$$item clean-sim clean >& /dev/null; \
	done

src/unrolled.c:
	./gen_unrolled_c.py

inc/cache.h:
	./gen_cache_h.py

run: clean inc/cache.h src/unrolled.c
	$(MAKE) $(TESTS)

profile: run
	@./extract_results.py
	@cat results.csv | column -t -s,

all: profile

.PHONY: run clean profile all

