# Al Saqr litmus tests

## Commands

- `make all`: build hardware, generate and run all available tests
- `make build-litmus-tests`: generate the .elf of the available tests
- `make run-litmus-tests`: runs the available tests
- `make compare-litmus-tests`: generate the comparison report
- `make build-hw`: build the RTL design
- `make <testname>`: generate a single test log in hw-results

If a single test has to be generated, make sure to first execute `make build-litmus-tests`.