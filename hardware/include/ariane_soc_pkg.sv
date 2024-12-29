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

`ifdef TARGET_FPGA
 `ifndef TARGET_DDR
  `define HYPER_FPGA_DDR
 `endif
`endif

package ariane_soc;

  // 2~4 number of cores
  `ifdef QUAD_CORE
   localparam NumCVA6 = 4;
  `else
   localparam NumCVA6 = 2;
  `endif

  // M-Mode Hart, S-Mode Hart
  localparam int unsigned NumTargets = 2*NumCVA6;
  // Uart, SPI, Ethernet, reserved
  localparam int unsigned NumSources = 255;
  localparam int unsigned MaxPriority = 7;

  // AIA
  localparam int unsigned NumSourcesImsic = cva6_config_pkg::CVA6ConfigNrSourcesImsic;
  localparam int unsigned NrVSIntpFiles   = cva6_config_pkg::CVA6ConfigNrVSIntpFiles;
  localparam int unsigned NrVSIntpFilesW  = cva6_config_pkg::CVA6ConfigNrVSIntpFilesW;
  localparam int unsigned NrIntpFiles     = cva6_config_pkg::CVA6ConfigNrIntpFiles; 
  localparam int unsigned NrSourcesW      = cva6_config_pkg::CVA6ConfigNrSourcesW;

  // actually masters, but slaves on the crossbar
  typedef enum int unsigned {
    CVA6        = 0,  // CVA6
    DEBUG_MST   = 1,  // Debug module master port
    CLUSTER_MST = 2,  // Cluster master port
    ROT         = 3,  // RoT
    UDMA_TX     = 4,  // uDMA (tx)
    UDMA_RX     = 5,  // uDMA (rx)
    IOMMU_COMP  = 6,  // IOMMU Completion Interface
    IOMMU_DS    = 7,  // IOMMU Data Structure Interface
    IOPMP_INIT  = 8,  // IOPMP Initiator Port
    ETH         = 9,  // Ethernet's iDMA Port
    PMU         = 10  // PMU's port
  } axi_masters_t;

  localparam NrSlaves = PMU + 1;   // 10

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
  localparam IdWidth   = 4; // Do not change
  localparam IdWidthSlave = IdWidth + $clog2(NrSlaves);

  /// Number of synchronization registers to insert on the async pointers
  localparam CdcSyncStages   = 3;

  // Ensure that SocToClusterIdWidth + $clog2(ClusterNrSlaves) = IdWidth
  localparam SocToClusterIdWidth = 3;

  //DebugModule ID
  localparam logic [31:0] DbgIdCode= 32'h20001001;

  typedef enum int unsigned {
    HYAXI       = 19,
    PMUS_IOPMP  = 18,
    Snooper     = 17,
    AXILiteDom  = 16,
    IOPMP_CFG   = 15,
    MDMA_CFG    = 14,
    IOMMU_CFG   = 13,
    SDMA_CFG    = 12,
    UART        = 11,
    Ethernet    = 10,
    IMSIC       = 9,
    SPI         = 8,
    Timer       = 7,
    APB_SLVS    = 6,
    L2SPM       = 5,
    Cluster_Slv = 4,
    PLIC        = 3,
    CLINT       = 2,
    ROM         = 1,
    Debug_Slv   = 0
  } axi_slaves_t;

  localparam NB_PERIPHERALS = HYAXI + 1;

  `ifdef HYPER_FPGA_DDR
  localparam HyperbusNumPhys          = 2;
  localparam NumChipsPerHyperbus      = 2;
  `else
  localparam HyperbusNumPhys          = 2;
  localparam NumChipsPerHyperbus      = 4;
  `endif
  localparam logic[63:0] HyperRamSize = 64'h4000000; // 64MB


  localparam logic[63:0] DebugLength    = 64'h1000;
  localparam logic[63:0] ROMLength      = 64'h10000;
  localparam logic[63:0] UARTLength     = 64'h1000;
  localparam logic[63:0] SDMALength     = 64'h1000;  
  localparam logic[63:0] IOMMULength    = 64'h1000;
  localparam logic[63:0] MDMALength     = 64'h1000;  
  localparam logic[63:0] IOPMPLength    = 64'h4000;
  localparam logic[63:0] AXILiteLength  = 64'h300000; // Same on cluster side
  localparam logic[63:0] CLINTLength    = 64'hC0000;
  localparam logic[63:0] PLICLength     = 64'h3FF_FFFF;
  localparam logic[63:0] ClusterLength  = 64'h400000;
  localparam logic[63:0] TimerLength    = 64'h1000;
  localparam logic[63:0] SPILength      = 64'h800000;
  localparam logic[63:0] IMSICLength    = 64'h800_0000;
  localparam logic[63:0] EthernetLength = 64'h10000;
  `ifdef HYPER_FPGA_DDR
  localparam logic[63:0] HYAXILength    = 64'h2000000;  //32MB of hyperrams
  `else
  localparam logic[63:0] HYAXILength    = 64'h20000000;  //HyperRamSize*NumChipsPerHyperbus*HyperbusNumPhys;  // 256MB of hyperrams
  `endif
  localparam logic[63:0] LLCSPMLength   = 64'h20000;     // up to 128KB of LLC that can be used as scratchpad
  localparam logic[63:0] L2SPMLength    = 64'h8000;      // 32KB of scratchpad memory
  localparam logic[63:0] APB_SLVSLength = 64'h132000;
  localparam logic[63:0] SnoopLength    = 64'h4000;
  localparam logic[63:0] IOPMP_PMULength = 64'h4000;

  // Instantiate AXI protocol checkers
  localparam bit GenProtocolChecker = 1'b0;

  typedef enum logic [63:0] {
    DebugBase     = 64'h0000_0000,
    ROMBase       = 64'h0001_0000,
    CLINTBase     = 64'h0200_0000,
    PLICBase      = 64'h0C00_0000,
    ClusterBase   = 64'h1000_0000,
    AXILiteBase   = 64'h1040_0000,
    APB_SLVSBase  = 64'h1A10_0000,
    L2SPMBase     = 64'h1C00_0000,
    TimerBase     = 64'h1800_0000,
    SPIBase       = 64'h2000_0000,
    IMSICBase     = 64'h2400_0000,
    EthernetBase  = 64'h3000_0000,
    UARTBase      = 64'h4000_0000,
    SDMABase      = 64'h5000_0000,
    IOMMUBase     = 64'h5001_0000,
    MDMABase      = 64'h5002_0000,
    IOPMPBase     = 64'h5003_0000,
    IOPMP_PMUBase = 64'h5004_0000,
    LLCSPMBase    = 64'h7000_0000,
    SnoopBase     = 64'h7100_0000,
    HYAXIBase     = 64'h8000_0000
  } soc_bus_start_t;
  // Let x = NB_PERIPHERALS: as long as Base(xth slave)+Length(xth slave) is < 1_0000_0000 we can cut the 32 MSBs addresses without any worries.


  localparam NrRegion = 1;
  localparam logic [NrRegion-1:0][NB_PERIPHERALS-1:0] ValidRule = {{NrRegion * NB_PERIPHERALS}{1'b1}};


  // Ethernet
  typedef struct packed {
    logic eth_rxck_i ;
    logic eth_rxctl_i;
    logic eth_rxd0_i ;
    logic eth_rxd1_i ;
    logic eth_rxd2_i ;
    logic eth_rxd3_i ;
    logic eth_md_i;
  } pad_to_eth_t;

  typedef struct packed {
    logic eth_rstn_o;
    logic eth_txck_o;
    logic eth_txctl_o;
    logic eth_txd0_o;
    logic eth_txd1_o;
    logic eth_txd2_o;
    logic eth_txd3_o;
    logic eth_mdc_o;
    logic eth_md_o;
    logic eth_md_oe;
  } eth_to_pad_t;

  typedef struct packed {
    logic clk_soc_o;
    logic clk_cva6_o;
  } fll_to_pad_t;

  // AXI LLC
  // Cache size = 8 x 128 x 8 x 8 = 8kB.
  // Each core partition is 2kB.
  localparam LLC_SET_ASSOC  = 32'd8;
  localparam LLC_NUM_LINES  = 32'd128;
  localparam LLC_NUM_BLOCKS = 32'd8;


endpackage
