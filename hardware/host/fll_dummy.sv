// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`ifndef TEST_CLOCK_BYPASS
  `timescale 1ns/1ns
 `endif

module fll_dummy #(
  parameter int unsigned NB_FLL = 4,
  parameter int unsigned CFG_ADDR_WIDTH = 4,
  parameter int unsigned CFG_DATA_WIDTH = 32,
  parameter int unsigned NB_SCAN_CHAIN = 1
) (
  // Clock & reset
    output  logic [NB_FLL-1:0]          OUTCLK, // FLL clock outputs
    input   logic                       REFCLK, // Reference clock input
    input   logic                       RSTB,   // Asynchronous reset (active low)

  // Configuration I/F
    input   logic                       CFGREQ, // CFG I/F access request (active high)
    output  logic                       CFGACK, // CFG I/F access granted (active high)
    input   logic [CFG_ADDR_WIDTH-1:0]  CFGAD,  // CFG I/F address bus
    input   logic [CFG_DATA_WIDTH-1:0]  CFGD,   // CFG I/F input data bus (write)
    output  logic [CFG_DATA_WIDTH-1:0]  CFGQ,   // CFG I/F output data bus (read)
    input   logic                       CFGWEB, // CFG I/F write enable (active low)

  // Power management
    input   logic                       PWD,    // Asynchronous power down (active high)
    input   logic                       RET,    // Asynchronous retention/isolation control (active high)

  // Test I/F
    input   logic                       TM,     // Test mode (active high)
    input   logic                       TE,     // Scan enable (active high)
    input   logic [NB_SCAN_CHAIN-1:0]   TD,     // Scan data input for chain 1:4
    output  logic [NB_SCAN_CHAIN-1:0]   TQ,     // Scan data output for chain 1:4
    input   logic                       JTD,    // Scan data in 5
    output  logic                       JTQ     // Scan data out 5
);

 `ifdef TARGET_ASIC
  `ifdef TARGET_TOP_POST_SYNTH_SIM
   `define GENERATE_CLOCK
  `endif
 `else
   `define GENERATE_CLOCK
 `endif

   `ifdef GENERATE_CLOCK
   logic clk_100;
   logic clk_250;
   // logic clk_800;
   // logic clk_333;
   parameter time ClkPeriod_100 = 10ns;       // 100 MHz Frequency
   parameter time ClkPeriod_250 = 4ns;        // 250 MHz Frquency
   // parameter time ClkPeriod_800 = 1.25ns;     // 800 MHz Frquency
   // parameter time ClkPeriod_333 = 3.03ns;     // 333 MHz Frquency


   assign CFGACK = 1'b1;
   assign CFGQ   = 32'hdeadbeef;

   assign TQ = 1'b0;
   assign JTQ = 1'b0;

   `ifndef TEST_CLOCK_BYPASS
     // Generate 100 MHz clock
     initial begin
        clk_100 = 1'b0;
     end
     always begin
       // Emit rising clock edge.
       clk_100 = 1'b1;
       // Wait for at most half the clock period before emitting falling clock edge.  Due to integer
       // division, this is not always exactly half the clock period but as close as we can get.
       #(ClkPeriod_100/2);
       // Emit falling clock edge.
       clk_100 = 1'b0;
       // Wait for remainder of clock period before continuing with next cycle.
       #(ClkPeriod_100/2);
     end // always

     // Generate 250 MHz clock
     initial begin
        clk_250 = 1'b0;
     end
     always begin
       // Emit rising clock edge.
       clk_250 = 1'b1;
       // Wait for at most half the clock period before emitting falling clock edge.  Due to integer
       // division, this is not always exactly half the clock period but as close as we can get.
       #(ClkPeriod_250/2);
       // Emit falling clock edge.
       clk_250 = 1'b0;
       // Wait for remainder of clock period before continuing with next cycle.
       #(ClkPeriod_250/2);
     end // always


      ///////////////////////////////////////////////////////////////////////////////////////////////////////
    //  // Generate 333 MHz clock
    //  initial begin
    //     clk_333 = 1'b0;
    //  end
    //  always begin
    //    // Emit rising clock edge.
    //    clk_333 = 1'b1;
    //    // Wait for at most half the clock period before emitting falling clock edge.  Due to integer
    //    // division, this is not always exactly half the clock period but as close as we can get.
    //    #(ClkPeriod_333/2);
    //    // Emit falling clock edge.
    //    clk_333 = 1'b0;
    //    // Wait for remainder of clock period before continuing with next cycle.
    //    #(ClkPeriod_333/2);
    //  end // always

    //  // Generate 800 MHz clock
    //  initial begin
    //     clk_800 = 1'b0;
    //  end
    //  always begin
    //    // Emit rising clock edge.
    //    clk_800 = 1'b1;
    //    // Wait for at most half the clock period before emitting falling clock edge.  Due to integer
    //    // division, this is not always exactly half the clock period but as close as we can get.
    //    #(ClkPeriod_800/2);
    //    // Emit falling clock edge.
    //    clk_800 = 1'b0;
    //    // Wait for remainder of clock period before continuing with next cycle.
    //    #(ClkPeriod_800/2);
    //  end // always

     // Assigning clocks to OUTCLK
     // OUTCLK [0] for CVA6 250 MHz
     for (genvar i=0;i<NB_FLL;i++) begin
        if (i == 0) begin
          assign OUTCLK[i] = clk_250 & RSTB;
        end else begin
          assign OUTCLK[i] = clk_100 & RSTB;
        end
     end
    //  for (genvar i=0;i<NB_FLL;i++) begin
    //     assign OUTCLK[i] = clk & RSTB;
    //  end
   `endif

  `endif //  `ifdef GENERATE_CLOCK

endmodule: fll_dummy



