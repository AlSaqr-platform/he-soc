// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "apb_macros.sv"

module periph_bus_wrap 
  import apb_soc_pkg::*;
  import udma_subsystem_pkg::*;
#(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32
) (
    input logic    clk_i,
    input logic    rst_ni,

    APB.Slave  apb_slave,
    APB.Master udma_master,
    APB.Master gpio_master,
    APB.Master fll_master,
    APB.Master hyaxicfg_master,
    APB.Master advtimer_master,
    APB.Master padframe_master,
    APB.Master socctrl_master,
    APB.Master serial_link_master,
    APB.Master apb_can0_master,
    APB.Master apb_can1_master,
    APB.Master apb_uart_master
);

    APB
    #(
        .ADDR_WIDTH( APB_ADDR_WIDTH ),
        .DATA_WIDTH( APB_DATA_WIDTH )
    )
    s_masters[apb_soc_pkg::NUM_APB_SLAVES-1:0]();

    logic [apb_soc_pkg::NUM_APB_SLAVES-1:0][APB_ADDR_WIDTH-1:0] s_start_addr;
    logic [apb_soc_pkg::NUM_APB_SLAVES-1:0][APB_ADDR_WIDTH-1:0] s_end_addr;

   
    `APB_ASSIGN_MASTER(s_masters[0], fll_master);
    assign s_start_addr[0] = apb_soc_pkg::FLLBase;
    assign s_end_addr[0]   = apb_soc_pkg::FLLBase + apb_soc_pkg::FLLLength - 1;

    `APB_ASSIGN_MASTER(s_masters[1], hyaxicfg_master);
    assign s_start_addr[1] = apb_soc_pkg::HYAXICFGBase;
    assign s_end_addr[1]   = apb_soc_pkg::HYAXICFGBase + apb_soc_pkg::HYAXICFGLength - 1 ;

    `APB_ASSIGN_MASTER(s_masters[2], advtimer_master);
    assign s_start_addr[2] = apb_soc_pkg::ADVTIMERBase;
    assign s_end_addr[2]   = apb_soc_pkg::ADVTIMERBase + apb_soc_pkg::ADVTIMERLength - 1 ;

    `APB_ASSIGN_MASTER(s_masters[3], padframe_master);
    assign s_start_addr[3] = apb_soc_pkg::PADFRAMEBase;
    assign s_end_addr[3]   = apb_soc_pkg::PADFRAMEBase + apb_soc_pkg::PADFRAMELength - 1 ;  

    `APB_ASSIGN_MASTER(s_masters[4], gpio_master);
    assign s_start_addr[4] = apb_soc_pkg::GPIOSBase;
    assign s_end_addr[4]   = apb_soc_pkg::GPIOSBase + apb_soc_pkg::GPIOSLength - 1;

    `APB_ASSIGN_MASTER(s_masters[5], socctrl_master);
    assign s_start_addr[5] = apb_soc_pkg::SOCCTRLBase;
    assign s_end_addr[5]   = apb_soc_pkg::SOCCTRLBase + apb_soc_pkg::SOCCTRLLength - 1 ;   

    `APB_ASSIGN_MASTER(s_masters[6], serial_link_master);
    assign s_start_addr[6] = apb_soc_pkg::SerLinkBase;
    assign s_end_addr[6]   = apb_soc_pkg::SerLinkBase + apb_soc_pkg::SerLinkLength - 1;

    `APB_ASSIGN_MASTER(s_masters[7], apb_can0_master);
    assign s_start_addr[7] = apb_soc_pkg::Can0Base;
    assign s_end_addr[7]   = apb_soc_pkg::Can0Base + apb_soc_pkg::CanLength - 1;

    `APB_ASSIGN_MASTER(s_masters[8], apb_can1_master);
    assign s_start_addr[8] = apb_soc_pkg::Can1Base;
    assign s_end_addr[8]   = apb_soc_pkg::Can1Base + apb_soc_pkg::CanLength - 1;
    
    `APB_ASSIGN_MASTER(s_masters[9], udma_master);
    assign s_start_addr[9] = apb_soc_pkg::UDMABase;
    assign s_end_addr[9]   = apb_soc_pkg::UDMABase + apb_soc_pkg::UDMALength - 1;

   `APB_ASSIGN_MASTER(s_masters[10], apb_uart_master);
    assign s_start_addr[10] = apb_soc_pkg::APBUARTBase;
    assign s_end_addr[10]   = apb_soc_pkg::APBUARTBase + apb_soc_pkg::APBUARTLength - 1;

   
   apb_node_wrap #(
        .NB_MASTER      ( apb_soc_pkg::NUM_APB_SLAVES ),
        .APB_ADDR_WIDTH ( 32                          ),
        .APB_DATA_WIDTH ( 32                          )
    ) apb_node_wrap_i (
        .clk_i        ( clk_i        ),
        .rst_ni       ( rst_ni       ),

        .apb_slave    ( apb_slave    ),
        .apb_masters  ( s_masters    ),

        .start_addr_i ( s_start_addr ),
        .end_addr_i   ( s_end_addr   )
    );



endmodule
