# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## 2.0.8 - Stable Release Alsaqr 2 branch: alsaqr_2_220725 - 22/07/2025

### Hardware

### Interface/Feature frozen macros:
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

### Work In progress (RTL FROZEN)
- Further testing

### Changed (bug fixes):
- CULSANS: fixed a bug preventing linux to work with custom kernels. pin count changed together with axi ID.
- OPENTITAN: fixed different bugs on TCDM and iDMA datapaths (requiring interface changes, few more signals).
- CULSANS: updated ID remapper, and changes in CULSANS macro pincount.
- TOP: bug fixes on PMU. all good now, minor impact on backend
- REPO: VIP clone again broken due to changes on INFINEON website. You MUST copy vips from an older directory (under he-soc/hardware/tb/vips)

## 2.0.7 - Stable Release Alsaqr 2 branch: alsaqr_2_280525 - 28/05/2025

### Hardware

### Interface/Feature frozen macros:
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

### Work In progress (RTL FROZEN)
- Further testing

### Changed (bug fixes):
- REPO: adding prints to each test printing test name
- REPO: updated regression list scripts.
- REPO: started porting commands from bringup to master branch

## 2.0.6 - Stable Release Alsaqr 2 branch: alsaqr_2_220525 - 22/05/2025

### Hardware

### Interface/Feature frozen macros:
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

### Work In progress (RTL FROZEN)
- Further testing

### Changed (bug fixes):
- REPO: fixed Bender manifest and VIP clone.

## 2.0.5 - Stable Release Alsaqr 2 branch: alsaqr_2_130525 - 13/05/2025

### Hardware

### Interface/Feature frozen macros:
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

### Work In progress (RTL FROZEN)
- Further testing

### Changed (bug fixes):
- REPO: removed gitlab dependencies  (not needed and causing errors due to permissions)

## 2.0.4 - Stable Release Alsaqr 2 branch: alsaqr_2_130525 - 13/05/2025

### Hardware

### Interface/Feature frozen macros:
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

### Work In progress (RTL FROZEN)
- Further testing

### Changed (bug fixes):
- REPO: removed gitlab dependencies  (not needed and causing errors due to permissions)

## 2.0.3 - Stable Release Alsaqr 2 branch: alsaqr_2_050525 - 05/05/2025

### Hardware

### Interface/Feature frozen macros:
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

### Work In progress (RTL FROZEN)
- Further testing

### Changed (bug fixes):
- OpenTitan: added a Data Width converter for the iDMA.
- TOP: Axi LLC has been reverted to the version of alsaqr 1 due to bugs. No impact on macro interfaces o memory count.
- TOP: Fixed the register file of hyperbus pads, which handles the driving strength. Mem map was not 32bit aligned.
- REPO: Fixed scripts to clone VIPs. No need anymore to keep a local copy pointed by symlinks.

## 2.0.2 - Stable Release Alsaqr 2 branch: alsaqr_2_130325 - 13/03/2025

### Hardware

### Interface/Feature frozen macros:
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

### Work In progress (RTL FROZEN)
- Further testing

### Testing:
- Ran subset of regression tests on the chip's netlist: all works.
- Added more tests
- Enhanced regression scripts: now more clear reports and error logging.

### Changed:
- TOP: Updated Bootrom, moved stack pointer from L3 to L2 (avoid deadlocks when L3 unconnected).

## 2.0.1 - Stable Release Alsaqr 2 branch: alsaqr_2_190225 - 19/02/2025

### Hardware

### Interface/Feature frozen macros:
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

### Work In progress (RTL FROZEN)
- Further testing

### Testing:
- Ran subset of regression tests on the chip's netlist: all works.

### Changed:
- TOP: recast connection of a debug module reset signal (was connected the wrong one). This fixes a timing violation on TOP.

## 2.0.0 - Stable Release Alsaqr 2 branch: alsaqr_2_160225 - 16/02/2025

### Hardware

### Interface/Feature frozen macros:
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

### Work In progress (RTL FROZEN)
- Further testing

### Testing:
- Ran subset of regression tests on the chip's netlist: all works.

### Changed:
- CVA6: moved the snooper's dw converter outside to resolve timing violation -> changed pin count (smaller DW for AXI intf of snooper).
- CVA6: bug fix to h-ext -> no relevant changes.
- TOP: fixed bug within PMU AXI interface.
- TOP: bug fixed into PMU's CDCs

## 1.0.0 - alsaqr_2_101124 - 10/11/2024

## Interface frozen macros:
- OpenTitan
- Cluster


### Work In progress Macro
- Culsans
- Hyperbus
- OpenTitan
- Cluster
- TOP

## 0.0.9 - alsaqr_080224 - 08/02/2024

### Hardware

### Changed
# TOP
- Add 2 additional 128-bit Logic Locking registers for new logic locking feature using 2 blocks. Compute the XOR between each couple of register.

### Feature Frozen Macros
- Cluster
- OpenTitan
- Hyperram

### Work In progress Macro
- Culsans

### Software

## 0.0.8 - alsaqr_310124 - 31/01/2024

### Hardware

### Changed
# TOP
- Add 2 128-bit Logic Locking registers

### Feature Frozen Macros
- Cluster
- OpenTitan
- Hyperram

### Work In progress Macro
- Culsans

### Software
- Fix N30 IOSTANDARD LVCMOS12 FPGA pin config

## 0.0.7 - alsaqr_260124 - 26/01/2024

### Hardware

### Changed
# TOP
- Fix PLIC register file bug which prevent to keep memory of previous configurations

### Feature Frozen Macros
- Cluster
- OpenTitan
- Hyperram

### Work In progress Macro
- Culsans

### Software
- Restore Hello + L1 cluster tests into the regression list
- Update cluster runtime to match L2 size
- Remove absolute path in ddr4 run.tcl file for FPGA bitstream generation
- Add check bender to ensure correct version download

## 0.0.6 - alsaqr_180124 - 18/01/2024

### Hardware

### Changed
# CVA6
- Updated CVA6 dependency to bootable linux core

### Feature Frozen Macros
- Cluster
- OpenTitan
- Hyperram

### Work In progress Macro
- Culsans

### Software
- Implementing FPGA flow for linux boot. The boot flow has been tested both using single/dual core configuration + FMC board having 4 Hyperrams (32KB total)
- Update CVA6 runtime to enable and check Hypervisor extension
- Fix Regression flow for correct execution of cluster tests. Hello + L1 test has been temporarily removed from the regression netlist list due to a synchronization issue. The tests will be reintroduced as soon the SW bug is fixed.

## 0.0.5 - alsaqr_181223 - 18/12/2023

### Hardware

### Changed
# CVA6
- Updated CVA6 dependency: fixed a bug related to performance counters and enabled the hypervisor extension (with a 7% of overhead in area)
# Hyperbus
- Fixed a minor bug related to the irq connection. One signal was not connected. Very minor change.
# TOP
- Fixed a bug with the memory wrapper for the ethernet peripheral: two inputs to the memory macro were floating.

### Feature Frozen Macros
- Cluster
- OpenTitan
- Hyperram

### Work In progress Macro
- Culsans

### Software
- Created a new flow to run regression tests with the post synthesis chip netlist, which now include opentitan as well.
- Implementing optimizations flags for netlist simulations (including regressions). An hello world completes in less then 10 minutes now.

## 0.0.4 - alsaqr_271123 - 27/11/2023

### Hardware

### Changed
# CVA6
- Updated CVA6 dependency with new PLANVTECH delivery.
- In new PLANVTECH delivery, cache subsystem has changed. Check wisely the new paths names for the memory instances.
- The gf22 memory macros instantiated are of the same cuts, but there are less in the ICACHE, while for the Dirty Cache, there are now 3x 128x64 macros (not only one), for each core.
# TOP
- Fixed performance bug with LLC
- Fixed bug with Ethernet clock connections.
- Host domain's bootrom update: fixed a bug preventing some of the CVA6 bootmodes

### Feature Frozen Macros
- Cluster
- Open Titan
- Hyperram

### Work In progress Macro
- Culsans

### Software
- Unified the old regressions tests with the new one. There are 22 tests now.

## 0.0.3 - alsaqr_031123 - 03/11/2023

### Hardware

### Added

- Update Top level Synthesis constraints 

### Changed
- L2 memory decreased from 64KB to 32KB
- LLC memory decreased from 256KB to 128KB 

### Feature Frozen Macros
- Cluster
- Open Titan
- Hyperram

### Work In progress Macro
- Culsans

### Software

- Peripherals verification with the new padframe completed
- Update test for hyperram using 4 CS
- Add regression for PULP Cluster
- JTAG boot: through JTAG we boot Core 0, which will run the code in L3. The code in L3 run by core 0 will then boot the second core.
- JTAG boot: through JTAG we boot both the Cores independently
- OpenTitan boot: Opentitan boots the Core 0, which again will boot Core 1
- OpenTitan boot: OpenTitan boots both the cores independently (still under development)
- Bypass the internal clock divider between dco and clock[0]

## 0.0.2 - alsaqr_131023 - 13/10/2023

### Hardware

### Added

- Scripts for post synthesis simulations
- Update Synthesis constraints for Open Titan targeting 400 MHz

### Changed
- Padframe
- FPUs within the PULP Cluster
- Added 4 Chip Select per each PHY within the HyperRAM macro
- Updated Culsans to latest delivery

### Feature Frozen Macros
- Cluster
- Open Titan
- Hyperram

### Work In progress Macro
- Culsans

### Software

NB: The software development of the regression test is work in progress due to the modification of the padframe and it still need to be verified accordingly.

## 0.0.1 - alsaqr_170923 - 17/09/2023

### Hardware

### Added

- Fixed FLL macro.
- New initialization script, automatically downlading the VIPs and running bender update
- Added flow to run RTL simulations using the gf22 macros

### Changed

- LLC size reduced from 512KB to 256KB
- Updated CVA6 repository to the most recent delivered by planv
- Update tc_sram_gf22 wrapper: the most recent CVA6 release contains one different memory cut (128x64), which does not impact on the cache size, so on area occupation of Culsans.
- Updated the OpenTitan synthesis constraints, consider it as a v1.0, still WIP.
- Changed the IRQ channel (from 143 to 10) to which the mailbox is connected to CVA6 plic.
- Update Ethernet IP with async reset and fix multiple driven signal in ddro.sv


### Feature Frozen Macros
- Cluster
- Open Titan

### Work In progress Macro
- Culsans
- Hyperram

### Software

The software development of the regression is work in progress, here you find the regression already in place

### Regression
- spim_flash
- qspim_flash
- uart
- usart
- sdio
- cam
- can
- hyperbus
- i2c



