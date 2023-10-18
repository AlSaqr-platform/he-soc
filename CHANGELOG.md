# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

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



