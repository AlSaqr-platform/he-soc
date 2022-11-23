// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba, ETH Zurich
// Description: Contains SoC information as constants
package ariane_soc;
  // M-Mode Hart, S-Mode Hart
  localparam int unsigned NumTargets = 2;
  // Uart, SPI, Ethernet, reserved
  localparam int unsigned NumSources = 255;
  localparam int unsigned MaxPriority = 7;

  localparam NrSlaves = 4; // actually masters, but slaves on the crossbar: Debug module, CVA6, Cluster

   
  typedef struct packed {
      logic [31:0] idx;
      logic [63:0] start_addr;
      logic [63:0] end_addr;
   } addr_map_rule_t;

  // 4 is recommended by AXI standard, so lets stick to it, do not change
  // The ID width of the master ports is wider than that of the slave ports.
  // The additional ID bits are used by the internal multiplexers to route responses. 
  // The ID width of the master ports must be AxiIdWidthSlvPorts + $clog_2(NoSlvPorts).
  // The same parameters in cva6/include/ariane_axi need to match with the values below!
  localparam IdWidth   = 5; // Do not change
  localparam IdWidthSlave = IdWidth + $clog2(NrSlaves); 

  // Ensure that SocToClusterIdWidth + $clog2(ClusterNrSlaves) = IdWidth 
  localparam SocToClusterIdWidth = 3;   
   
  typedef enum int unsigned {
    HYAXI       = 13,
    SERIAL_LINK = 12,
    AXILiteDom  = 11, 
    UART        = 10,
    Ethernet    = 9,
    SPI         = 8,
    Timer       = 7,
    APB_SLVS    = 6,
    L2SPM       = 5,
    Cluster     = 4,
    PLIC        = 3,
    CLINT       = 2,
    ROM         = 1,
    Debug       = 0
  } axi_slaves_t;
   
  localparam NB_PERIPHERALS = HYAXI + 1;

  `ifdef FPGA_EMUL 
  localparam HyperbusNumPhys          = 1;
  localparam NumChipsPerHyperbus      = 2;
  `else
  localparam HyperbusNumPhys          = 2;
  localparam NumChipsPerHyperbus      = 2;
  `endif
  localparam logic[63:0] HyperRamSize = 64'h4000000; // 64MB
   

  localparam logic[63:0] DebugLength    = 64'h1000;
  localparam logic[63:0] ROMLength      = 64'h10000;
  localparam logic[63:0] UARTLength     = 64'h1000;
  localparam logic[63:0] AXILiteLength  = 64'h100000; // Same on cluster side
  localparam logic[63:0] SerLinkLength  = 64'h1000; // to check
  localparam logic[63:0] CLINTLength    = 64'hC0000;
  localparam logic[63:0] PLICLength     = 64'h3FF_FFFF;
  localparam logic[63:0] ClusterLength  = 64'h400000;
  localparam logic[63:0] TimerLength    = 64'h1000;
  localparam logic[63:0] SPILength      = 64'h800000;
  localparam logic[63:0] EthernetLength = 64'h10000;
  localparam logic[63:0] HYAXILength    = 64'h20000000;  //HyperRamSize*NumChipsPerHyperbus*HyperbusNumPhys;  // 256MB of hyperrams
  localparam logic[63:0] L2SPMLength    = 64'h80000;     // 512KB of scratchpad memory 
  localparam logic[63:0] APB_SLVSLength = 64'h123000;
   
  // Instantiate AXI protocol checkers
  localparam bit GenProtocolChecker = 1'b0;

  typedef enum logic [63:0] {
    DebugBase    = 64'h0000_0000,
    ROMBase      = 64'h0001_0000,
    CLINTBase    = 64'h0200_0000,
    PLICBase     = 64'h0C00_0000,
    ClusterBase  = 64'h1000_0000,
    AXILiteBase  = 64'h1040_0000,                             
    APB_SLVSBase = 64'h1A10_0000,
    L2SPMBase    = 64'h1C00_0000,
    TimerBase    = 64'h1800_0000,
    SPIBase      = 64'h2000_0000,
    EthernetBase = 64'h3000_0000,
    UARTBase     = 64'h4000_0000,
    SerLink_Base = 64'h6000_0000,
    HYAXIBase    = 64'h8000_0000
  } soc_bus_start_t; 
  // Let x = NB_PERIPHERALS: as long as Base(xth slave)+Length(xth slave) is < 1_0000_0000 we can cut the 32 MSBs addresses without any worries. 

  
  localparam NrRegion = 1;
  localparam logic [NrRegion-1:0][NB_PERIPHERALS-1:0] ValidRule = {{NrRegion * NB_PERIPHERALS}{1'b1}};

  localparam ariane_pkg::ariane_cfg_t ArianeSocCfg = '{
    RASDepth: 2,
    BTBEntries: 32,
    BHTEntries: 128,
    // idempotent region
    NrNonIdempotentRules:  1,
    NonIdempotentAddrBase: {64'b0},
    NonIdempotentLength:   {HYAXIBase},
    NrExecuteRegionRules:  4,
    ExecuteRegionAddrBase: {HYAXIBase, L2SPMBase,   ROMBase,   DebugBase},
    ExecuteRegionLength:   {HYAXILength, L2SPMLength, ROMLength, DebugLength},
    // cached region
    NrCachedRegionRules:    1,
    CachedRegionAddrBase:  {HYAXIBase},
    CachedRegionLength:    {HYAXILength},
    //  cache config
    Axi64BitCompliant:      1'b1,
    SwapEndianess:          1'b0,
    // debug
    DmBaseAddress:          DebugBase,
    NrPMPEntries:           8
  };

  typedef struct packed {
    logic         ddr0_i;
    logic         ddr1_i;
    logic         ddr2_i;
    logic         ddr3_i;
    logic         ddr_clk_i;
  } pad_to_ser_link;

  typedef struct packed {
    logic         ddr0_o;
    logic         ddr1_o;
    logic         ddr2_o;
    logic         ddr3_o;
  } ser_link_to_pad;

endpackage
