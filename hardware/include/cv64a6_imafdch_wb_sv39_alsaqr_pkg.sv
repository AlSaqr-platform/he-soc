// Copyright 2024 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//

package cv64a6_imafdch_wb_sv39_alsaqr_pkg;

  import ariane_soc::*;
  import cva6_config_pkg::*;

  localparam  CVA6AXIIdWidth = 4; // Do not change, CVA6 from planV only supports IdWidth = 4
  localparam  CCUAXIIdWidth = CVA6AXIIdWidth + $clog2(ariane_soc::NumCVA6) + $clog2(ariane_soc::NumCVA6+1) + 1;

  localparam config_pkg::cva6_cfg_t ArianeSocCfg = '{
      NrCommitPorts: unsigned'(CVA6ConfigNrCommitPorts),
      AxiAddrWidth: unsigned'(ariane_axi_soc::AddrWidth),
      AxiDataWidth: unsigned'(ariane_axi_soc::DataWidth),
      AxiIdWidth: unsigned'(CVA6AXIIdWidth),
      AxiUserWidth: unsigned'(ariane_axi_soc::UserWidth),
      NrLoadBufEntries: unsigned'(CVA6ConfigNrLoadBufEntries),
      FpuEn: bit'(CVA6ConfigFpuEn),
      XF16: bit'(CVA6ConfigF16En),
      XF16ALT: bit'(CVA6ConfigF16AltEn),
      XF8: bit'(CVA6ConfigF8En),
      XF8ALT: bit'(CVA6ConfigF8AltEn),
      RVA: bit'(CVA6ConfigAExtEn),
      RVB: bit'(CVA6ConfigBExtEn),
      RVV: bit'(CVA6ConfigVExtEn),
      RVC: bit'(CVA6ConfigCExtEn),
      RVH: bit'(CVA6ConfigHExtEn),
      RVZCB: bit'(CVA6ConfigZcbExtEn),
      XFVec: bit'(CVA6ConfigFVecEn),
      CvxifEn: bit'(CVA6ConfigCvxifEn),
      ZiCondExtEn: bit'(CVA6ConfigZiCondExtEn),
      RVSCLIC: bit'(CVA6ConfigSclicExtEn),
      // Extended
      RVF:
      bit'(
      0
      ),
      RVD: bit'(0),
      FpPresent: bit'(0),
      NSX: bit'(0),
      FLen: unsigned'(0),
      RVFVec: bit'(0),
      XF16Vec: bit'(0),
      XF16ALTVec: bit'(0),
      XF8Vec: bit'(0),
      NrRgprPorts: unsigned'(0),
      NrWbPorts: unsigned'(0),
      EnableAccelerator: bit'(0),
      RVS: bit'(1),
      RVU: bit'(1),
      HaltAddress: 64'h800,
      ExceptionAddress: 64'h808,
      RASDepth: unsigned'(CVA6ConfigRASDepth),
      BTBEntries: unsigned'(CVA6ConfigBTBEntries),
      BHTEntries: unsigned'(CVA6ConfigBHTEntries),
      DmBaseAddress: DebugBase,
      TvalEn: bit'(CVA6ConfigTvalEn),
      NrPMPEntries: unsigned'(CVA6ConfigNrPMPEntries),
      PMPCfgRstVal: {16{64'h0}},
      PMPAddrRstVal: {16{64'h0}},
      PMPEntryReadOnly: 16'd0,
      NOCType: config_pkg::NOC_TYPE_AXI4_ATOP,
      CLICNumInterruptSrc: unsigned'(256),
      // idempotent region
      NrNonIdempotentRules:
      unsigned'(
      1
      ),
      NonIdempotentAddrBase: 1024'({64'b0}),
      NonIdempotentLength: 1024'({HYAXIBase}),
      NrExecuteRegionRules: unsigned'(5),
      //                      DRAM,          Boot ROM,   Debug Module
      ExecuteRegionAddrBase:
      1024'(
      {HYAXIBase, LLCSPMBase, L2SPMBase,   ROMBase,   DebugBase}
      ),
      ExecuteRegionLength: 1024'({HYAXILength, LLCSPMLength, L2SPMLength, ROMLength, DebugLength}),
      // cached region
      NrCachedRegionRules:
      unsigned'(
      1
      ),
      CachedRegionAddrBase: 1024'({HYAXIBase}),
      CachedRegionLength: 1024'({HYAXILength}),
      NrSharedRegionRules:
      unsigned'(
      1
      ),
      SharedRegionAddrBase: 1024'({HYAXIBase}),
      SharedRegionLength: 1024'({HYAXILength}),
      MaxOutstandingCachedStores: unsigned'(0),
      MaxOutstandingUncachedStores: unsigned'(7),
      DebugEn: bit'(1),
      NonIdemPotenceEn: bit'(0),
      AxiBurstWriteEn: bit'(0)
  };

endpackage // cv64a6_imafdch_wb_sv39_alsaqr_pkg

