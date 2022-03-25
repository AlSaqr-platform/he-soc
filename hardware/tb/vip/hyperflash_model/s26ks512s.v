///////////////////////////////////////////////////////////////////////////////
//  File name : s26ks512s.v
///////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2014 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version:  | author:        |   date:    | changes made:
//    V1.0     R.Prokopovic     13 Apr 30     Initial release
//
//    V1.1     R. Prokopovic    13 May 15   Improved read operation for
//                                          different ASOs, fixed sector
//                                          Protection, fixed ASPR register
//                                          programming, FSM state transitions,
//                                         fixed Buffer programming of SSR ASO
//    V1.2     R. Prokopovic    13 May 23  Device times, scaled values, updated
//                                         Program operation time for single
//                                         word and page program is updated,
//                                         now it is the same time tdevice_SWPB
//    V1.3     R. Prokopovic    13 Jun 4   Burst Write feature added
//                                         CRC read states updated
//                                         Protection condition of DYB fixed,
//                                         ASPR_reg[0] only for PPB
//                                         Programming of ASPR_reg[2:1] with
//                                        2'b11 is not allowed
//    V1.4     R. Prokopovic    13 Jun 10 Program Error state fixed   
//                                        Program and Erase protection fixed 
//                                        Read of Suspended Line fixed 
//                                        Burst Length read fixed 
//                                        Program of ASP register fixed 
//
//    V1.5    R.Prokopovic     13 Jul 01    Password program update, forbid
//                                          password program when ASPR[2] is 0
//                                          Set program fail bit and sector
//                                          lock bit when wrong password is
//                                          is provided
//    V1.6    R.Prokopovic      13 Sep 02  Warning message for burst write fix
//                                       SSR buffer program region address fix
//                                       Corrupt lines uses WBLine instead of
//                                       WLine variable
//                                       Flags added for program and erase due
//                                       to errors when 2 triggers occur in one
//                                       program or erase state
//    V1.7    S.Petrovic        14 Feb 14 Update to datasheet S80KS Rev0.63.pdf
//    V1.8    S.Petrovic        14 Feb 20 Corrected burst read implementation
//    V1.9    S.Petrovic        14 Feb 21 Corrected chip and sector erase
//                                        implementation
//    V1.10   S.Petrovic        14 Mar 20 CRC calculation corrected;
//                                        Write to lowest 16 bytes of SSR enabled;
//                                        Sector protect status corrected
//    V1.11   S.Petrovic        14 Mar 21 CRC calculation corrected
//    V1.12   S.Petrovic        14 Mar 25 Corrected bug in LRPG1 state
//    V1.13   S.Petrovic        14 Apr 11 Read burst corrected
//    V1.14   I.Viljacik        14 May 27 Update to datasheet S26KS_032S_02GT
//    V1.15   S.Petrovic        14 May 29 Corrected sensitivity list of
//                                        Functional block.
//    V1.16   S.Petrovic        14 Jun 03 Update to datasheet Rev0.79
//    V1.17   S.Petrovic        14 Jun 05 Corrected CFI array
//    V1.18   S.Stevanovic      15 Jul 21   Update to HBP_DRS_2_150508.pdf with
//                                          supplement documents
//                                          Fixed DPD exit condition, setting
//                                          default values after exiting DPD.
//                                          Hybrid Burst Enable fixed.
//                                          64B Wrapped Burst fixed.
//    V1.19   S.Stevanovic      15 Jul 31   tACC time checking fixed
//    V1.20   M.Stojanovic      15 Oct 14   POR & RESET# issue (bug #491) fixed
//    V1.21   M.Stojanovic      15 Nov 09  Changed name from "BUFFER" to "BUFFERs26ks512s"
//                                         (bug #492 fixed)
//    V1.22   S.Stevanovic      16 Jan 27   #493 and #495 fixed. In ESUL2,
//                                          ESPSULS2, and PSUL2 states for 88h
//                                          command check (SA) 555h instead of
//                                          (SA) 55h
//    V1.23   M.Stojanovic      16 Mar 14  #504 fixed - secure region
//    V1.24   M.Stojanovic      16 Oct 10  RWDS doesn't depends on the CLK edge (#515 fixed)
//    V1.25   M.Stojanovic      17 Feb 18  Fixing for loops for WBData and WBAddr in ESPG,
//                                         ESPSR, PG, PSR, LRPG. Loops should count from
//                                         (wr_cnt - 1).
//
///////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        Spansion
//  Technology:     Flash Memory
//  Part:           S26KS512S
//
//  Description:   RPC - Reduced Pin Count Flash Memory,
//                 512Mb (64MByte) CMOS 1.8 Volt Core and I/O,
//                 MirrorBit NOR flash Technology, x8 data bus
//
//
//////////////////////////////////////////////////////////////////////////////
//  Comments :
//      For correct simulation, simulator resolution should be set to 1 ps
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ps/1 ps

module s26ks512s
    (
    DQ7      ,
    DQ6      ,
    DQ5      ,
    DQ4      ,
    DQ3      ,
    DQ2      ,
    DQ1      ,
    DQ0      ,

    CSNeg    ,
    CK       ,
    CKNeg    ,

    RESETNeg ,
    RWDS     ,

    INTNeg   ,
    RSTONeg
    );

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////
    inout  DQ7;
    inout  DQ6;
    inout  DQ5;
    inout  DQ4;
    inout  DQ3;
    inout  DQ2;
    inout  DQ1;
    inout  DQ0;

    input  CSNeg;
    input  CK;
    input  CKNeg;

    input  RESETNeg;
    inout  RWDS;

    output INTNeg;
    output RSTONeg;

    // If speedsimulation is needed uncomment following line

//     `define SPEEDSIM;

    // interconnect path delay signals
    wire CSNeg_ipd;
    wire CK_ipd;
    wire CKNeg_ipd;
    wire RESETNeg_ipd;
    wire WPNeg_ipd;
    wire DQ7_ipd;
    wire DQ6_ipd;
    wire DQ5_ipd;
    wire DQ4_ipd;
    wire DQ3_ipd;
    wire DQ2_ipd;
    wire DQ1_ipd;
    wire DQ0_ipd;

    wire [7:0] Din;
    assign Din = { DQ7_ipd,
                   DQ6_ipd,
                   DQ5_ipd,
                   DQ4_ipd,
                   DQ3_ipd,
                   DQ2_ipd,
                   DQ1_ipd,
                   DQ0_ipd};

    wire [7:0] Dout;
    assign Dout = { DQ7,
                    DQ6,
                    DQ5,
                    DQ4,
                    DQ3,
                    DQ2,
                    DQ1,
                    DQ0 };

// Port WPNeg is no longer visible to the customer. However the real part still
// supports the WPNeg feature where when WPNeg is active Erase and Programming
// are not possible. The WPNeg functionality is kept, thus using the signal
    wire   WPNeg         = 1'b1;
    wire   WPNeg_in;
    wire   RESETNeg_in;
    //Internal pull-up for WPNeg
    assign WPNeg_in = (WPNeg_ipd === 1'bz) ? 1'b1 : WPNeg_ipd;
    assign RESETNeg_in = (RESETNeg_ipd === 1'bz) ? 1'b1 : RESETNeg_ipd;

    //  internal delays
    reg IACC_in          = 0;// Initial access delay
    reg IACC_out         = 1;
    reg RST_in           = 0; // Hardware Reset Timeout
    reg RST_out          = 1;

    reg sSTART_T1    ; // Program/Erase suspend start timeout
    reg START_T1_in  ;

    reg UNLOCKDONE_in  = 0; // Password Unlock start timeout
    reg UNLOCKDONE_out = 1;

    reg MTS_in  = 0; // Temperature Measurement
    reg MTS_out = 1;

    reg DPD_in  = 0; // Deep Power Down
    reg DPD_out = 1;

    wire   DPDExt_in;       // DPD Exit event
    reg    DPDExt_out  = 0; // DPD Exit event confirmed
    reg    DPDExt      = 0; // DPD Exit event detected

    // event control registers
    reg rising_edge_PoweredUp     = 0;
    reg rising_edge_CSNeg         = 0;
    reg falling_edge_CSNeg        = 0;
    reg rising_edge_CKDiff        = 0;
    reg falling_edge_CKDiff       = 0;
    reg falling_edge_write        = 0;
    reg falling_edge_RESETNeg     = 0;
    reg rising_edge_RESETNeg      = 0;
    reg falling_edge_RST          = 0;
    reg rising_edge_reseted       = 0;

    reg rising_edge_ESTART        = 0;
    reg rising_edge_EDONE         = 0;
    reg rising_edge_PSTART        = 0;
    reg rising_edge_PDONE         = 0;
    reg rising_edge_BCSTART       = 0;
    reg rising_edge_BCDONE        = 0;
    reg rising_edge_NVCR_LOAD_ACT  = 0;
    reg rising_edge_PG_POR_START  = 0;
    reg rising_edge_EESSTART      = 0;
    reg rising_edge_EESDONE       = 0;
    reg rising_edge_PSUSP         = 0;
    reg rising_edge_PRES          = 0;
    reg rising_edge_ESUSP         = 0;
    reg rising_edge_ERES          = 0;
    reg rising_edge_CRCSTART      = 0;
    reg rising_edge_CRCDONE       = 0;
    reg falling_edge_EERR         = 0;
    reg falling_edge_PERR         = 0;
    reg rising_edge_CRCSUSP       = 0;
    reg rising_edge_CRCRES        = 0;
    reg falling_edge_PDONE        = 0;
    reg falling_edge_EDONE        = 0;

    reg rising_edge_sSTART_T1     = 0;
    reg rising_edge_UNLOCKDONE_out = 0;
    reg rising_edge_status_7       = 0;
    reg rising_edge_IACC_out       = 1;
    reg rising_edge_MTS_out        = 0;
    reg rising_edge_DPD_out        = 0;

    reg [7:0] Dout_zd = 8'bzzzzzzzz;

    wire  DQ7_zd   ;
    wire  DQ6_zd   ;
    wire  DQ5_zd   ;
    wire  DQ4_zd   ;
    wire  DQ3_zd   ;
    wire  DQ2_zd   ;
    wire  DQ1_zd   ;
    wire  DQ0_zd   ;

    assign {DQ7_zd,
            DQ6_zd,
            DQ5_zd,
            DQ4_zd,
            DQ3_zd,
            DQ2_zd,
            DQ1_zd,
            DQ0_zd  } = Dout_zd;

    reg RWDS_zd       = 1'bz;

    reg RWDS_temp;

    reg INTNeg_zd  = 1'bz;
    reg RSTONeg_zd = 1'bz;

    // Pull-up recomended for INTNeg and RSTONeg
    wire INTNeg_pull_up;
    assign INTNeg_pull_up = (INTNeg_zd === 1'bx) ? 1 : INTNeg_zd;
    wire RSTONeg_pull_up;
    assign RSTONeg_pull_up = (RSTONeg_zd == 1'b1) ? 1'bz : RSTONeg_zd;

    reg CKDiff = 1'bz ;

    parameter UserPreload     = 1;
    parameter mem_file_name   = "none";//"s26ks512s.mem";
    parameter secsi_file_name = "none";//"s26ks512s_secsi.mem";

    parameter TimingModel = "DefaultTimingModel";

    parameter PartID   = "S26KS512S";
    parameter MaxData  = 16'hFFFF;
    parameter MemSize  = 25'h1FFFFFF;
    parameter SecNum   = 255;
    parameter SecSize  = 18'h1FFFF; // 256KB/128KWord
    parameter PageNum  = 16384;     // Pages(16B) Within Sector
    parameter PageSize = 15;         // 16B/8Words
    parameter PrmSecSize = 11'h7FF; // Parameter Sector Size 4KB
    // Parameter HiAddrBit is the highest bit in CA bits for address
    // Page Addr is [HiAddrBit:16]
    // For 128Mbit HiAddrBit is 35, 256Mbit is 36, 512Mbit is 37
    // 01Gbit is 38, 02Gbit is 39, 04Gbit is 40
    parameter HiAddrBit = 37;
    parameter AddrRANGE = 25'h1FFFFFF;
    // Secure Silicon Region size
    parameter SecSi_size = 511;

    //Write-Buffer-Lines(512B) Within Sector
    parameter WrBuffLength   = 255;      //512B/256Word

    // Number of Lines (512B) in one Sector
    parameter LineNum = 511;

    // Start Address of Low Address mapping parameter 224KB sector (SA00)
    parameter Lo_prm224KB_sa = 15'h4000;
    // End Address of High Address mapping parameter 224KB sector (SA255)
    parameter Hi_prm224KB_sa = 17'h1BFFF;

    // Parameter Sector erase indicator for Erase time control procedure
    reg param_sec_erase_time = 0;
    // Chip erase indicator for Erase time control procedure
    reg chip_erase_time = 0;
    // indicator of wrong read frequency for Read Latency is xVCR
    reg wrong_rd_freq = 0;

    reg PoweredUp = 0;

    // FSM control signals
    reg MEM_ACT        = 0;//Memory array select flag, used in prog. procedure
    reg CR_ACT         = 0;//Configuration Register Read ASO
    reg STAT_ACT       = 0;//Status Register Read ASO
    reg NVCR_ACT       = 0;//NVCR Reading Active
    reg NVCR_LOAD_ACT  = 0;//NVCR Loading Active
    reg INT_CR_ACT     = 0;//Interrupt Config Register Read Active
    reg INT_SR_ACT     = 0;//Interrupt Status Register Read Active
    reg CRC_ACT        = 0;//Checkvalue Reading active
    reg CFI_ACT        = 0;//CFI/ID Reading Active
    reg POR_TR_ACT     = 0;//POR Timer Register Read Active
    reg PWD_ACT        = 0;//Password Read Active
    reg PPB_ACT        = 0;//PPB Active
    reg ESR_ACT        = 0;//Erase Suspend Latency Active
    reg OTP_ACT        = 0;//SSR (OTP) active
    reg PSR_ACT        = 0;//Program Suspend Latency Active
    reg ASPR_ACT       = 0;//ASPR register mode active
    reg DYB_ACT        = 0;//DYB ASO active
    reg PPBLB_ACT      = 0;//PPB Lock Bit active
    reg FIRST_WORD     = 1;//Status Register Read First Word flag
    reg CRC_RD_SETUP   = 0;
    reg FIDR_ACT       = 0;
    reg ECC_ACT        = 0;
    reg ECCR_ACT       = 0;
    reg SA_PROT_ACT    = 0;
    reg VCR_LOAD_FIRST = 0;
    reg READ_PROTECT   = 0;

    reg PORTreg_pg     = 0;// PORtime reg program indicator
    reg NVCR_pg        = 0;// NVCR program indicator
    reg NVCR_ers       = 0;// NVCR erase indicator
    reg PP_pg          = 0;// Password program indicator
    reg PPB_pg         = 0;// PPB prog. indicator
    reg PPB_ers        = 0;// PPB erase indicator
    reg FIDreg_pg      = 0;// Factory Interrupt Disable Register program

    //number of location to be writen in Write Buffer: 0-511 bytes.
    //if 256 word programming
    integer PCNT     = 0;
    integer LCNT     = 0; //Load Counter

    integer SecSiAddr;
    integer PassAddr = 0;

    reg PDONE    = 1; // Programming done
    reg PSTART   = 0; // Start programming

    reg PSUSP    = 0; // Suspend programming
    reg PRES     = 0; // Resume Programming

    reg EDONE    = 1; // Erase Done
    reg ESTART   = 0; // Start Erase

    reg ESUSP    = 0; // Suspend Erase
    reg ERES     = 0; // Resume Erase

    reg CRCSUSP  = 0; // Suspend CRC Calc
    reg CRCRES   = 0; // Resume CRC Calc

    reg BCDONE   = 1; // Blank Check Done
    reg BCSTART  = 0; // Start Blank Check

    reg EESDONE  = 1; // Evaluate Erase Status Done
    reg EESSTART = 0; // Start Evaluate Erase Status

    reg CRCSTART = 0;
    reg CRCDONE  = 0;

    // Erase attempt on protected sector error
    reg EERR ;
    // Program attempt on protected sector error
    reg PERR ;

    // Command Register
    reg write;
    reg change_addr;
    reg change_addr_event    = 1'b0;
    reg [15:0] DOut_burst;

    //reset timing
    reg RST     = 0;
    reg reseted = 0;

    integer Mem [0:MemSize];

    parameter CFI_ID_Size = 7'h79;
    integer CFI_ID_Array [0:CFI_ID_Size];

    parameter Mem_T    = 5'd0;
    parameter SR_T     = 5'd1;
    parameter CFI_T    = 5'd2;
    parameter CR_T     = 5'd3;
    parameter INT_CR_T = 5'd4;
    parameter INT_SR_T = 5'd5;
    parameter CRC_T    = 5'd6;
    parameter POR_TR_T = 5'd7;
    parameter PWD_T    = 5'd8;
    parameter SSR_T    = 5'd9;
    parameter ASPR_T   = 5'd10;
    parameter DYB_T    = 5'd11;
    parameter PPB_T    = 5'd12;
    parameter PPBLB_T  = 5'd13;
    parameter FID_T    = 5'd14;
    parameter ECC_T    = 5'd15;
    parameter ECCR_T   = 5'd16;
    parameter SA_PROT_T = 5'd17;
    reg [4:0] ReadTarget;

     //Sectors selected for erasure
    reg [SecNum : 0] corrupt_flags;
    // Lines selected for programming
    reg [LineNum : 0] corrupt_lines [SecNum : 0];

    //REGISTERS
    //Status Register
    reg [15:0] Status_reg = 16'h0080;
    //Volatile Configuration Register
    reg [15:0] VCR_Config_reg = 16'h8EBB;
    //Nonvolatile Configuration Register
    reg [15:0] NVCR_Config_reg = 16'h8EBB;
    // ECC Status register
    reg [15:0] ECC_Status_reg = 16'h0000;
    // ASP Configuration register (ASPR)
    reg [15:0] ASPR_reg = 16'hFEFF;
    reg [15:0] FIDR_reg = 16'hFFFF;
    reg [15:0] B_ERRU_reg = 16'h0000;
    reg [15:0] B_ERRL_reg = 16'h0000;

    // PORTime register
    reg [15:0] PORTime_reg = 16'hFFFF;

    // Interrupt Configuration register
    reg [15:0] INT_CR_reg = 16'hFFFF;
    // Interrupt Status register
    reg [15:0] INT_SR_reg = 16'hFFFB;

    // Persistent Protection Bits ASO
    reg [SecNum:0] PPB_Prot;
    // Dynamic Protection Bits ASO
    reg [SecNum:0] DYB_Prot;
    // PPB Lock bit
    reg PPBLock;
    // Password protection register
    integer Password[0:3] ;
    // Register to store match information for every Password word
    reg [3:0] PassMATCH;

    // Secure Silicon Region - SSR; total 32 regions
    // Each region has 32 bytes (32regions X 32B = 1024B)
    integer SSR_reg [0:SecSi_size];

    // SSR protection, from SSR ASO array, addr 0x010 to 0x013
    reg [31:0] ssr_region_prot = 32'hFFFF_FFFF;
    reg ssr_prot = 1;
    reg secsi_ssr_prot = 1;
    integer ssr_buff_part;

    // CRC Start Address register
    integer CRC_Start_Addr_reg;
    // CRC End Address register
    integer CRC_End_Addr_reg;
    // Start CRC calculation
    // Number of data locations for CRC calculation
    integer crc_data_num;
    reg [31:0] CRC_calc_out;
    reg CRC_calc_in;
    reg CRC_calc_tmp;

    // Volatile Result registers
    // 2b Error Lower Address Trap register
    reg [15:0] Err_Lo_Addr_reg;
    // 2b Error Higher Address Trap register
    reg [15:0] Err_Hi_Addr_reg;
    // Read Checkvalue Low Result register
    reg [15:0] Check_Val_Lo_reg;
    // Read Checkvalue High Result register
    reg [15:0] Check_Val_Hi_reg;

    // Read/Write bit of Command/Address assignment, bit 47
    reg RW = 0;

    // When multiple words are loaded into a buffer this flag is set to 1
    // It is used for timings in case of buffer multiple words load
    reg BURSTWRITE = 0;

    reg  Check_freq;
    reg  Check_wr_freq;
    time CK_PER;
    time LAST_CK;

    reg INIT_ACC_ELAPSED;
    reg Latency_Clk = 0;

    reg PR_FLAG  = 0;
    reg ER_FLAG  = 0;

    integer DQt_01;
    integer DQt_0Z;
    integer RWDSt_01;

    // timing check violation
    reg Viol = 1'b0;

    time CK_cycle = 0;
    time prev_CK;
    reg glitch_dq = 1'b0;
    reg glitch_rwds = 1'b0;
    reg [7:0] DataDriveOut_Dout = 8'bZ ;
    reg DataDriveOut_RWDS  = 1'bZ ;

    // Burst delay and burst delay, from Configuration register
    integer BurstDelay;
    integer BurstLength;

    // write buffer signals
    integer WBData[0:255];
    integer WBAddr[0:255];

    reg[15:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;

    integer D_tmp;
    integer D_tmp1;

    //Address for Command Decode Phase
    integer Addr; //
    integer Address; // entire address
    //Sector Address
    integer SecAddr;
    integer WPage;
    integer RdPage;
    integer RdPageStart;
    integer PageAddr;
    integer WLine;
    integer LineAddr; // Addres within the line
    integer PrmSecAddr;
    integer PSAddr; // Page address in sector SA

    integer SA_ERS;
    integer SA_PGM;
    integer SA_BC;
    integer SA_EES;
    integer SA_CFI;
    integer SA_SSR;
    integer WBLine;
    integer SA_PASSUnlock;
    integer WB_PASSUnlock;

    // Parameters that define read mode, burst or continuous
    parameter LINEAR     = 4'd0;
    parameter CONTINUOUS = 4'd1;

    reg [1:0] RD_MODE = CONTINUOUS;
    reg PORTreg_programmed = 0;

    // Parameter for internal (on-chip) clock period used to generate
    // extension to RSTONeg output.Min=25us, Max=42us
    // This parameters value is multiplied with the value programmed into
    // PORTime_reg register
    parameter tPOR_CK = 42000000;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////
    buf   (DQ7_ipd , DQ7 );
    buf   (DQ6_ipd , DQ6 );
    buf   (DQ5_ipd , DQ5 );
    buf   (DQ4_ipd , DQ4 );
    buf   (DQ3_ipd , DQ3 );
    buf   (DQ2_ipd , DQ2 );
    buf   (DQ1_ipd , DQ1 );
    buf   (DQ0_ipd , DQ0 );

    buf   (CK_ipd       , CK      );
    buf   (CKNeg_ipd    , CKNeg   );
    buf   (RESETNeg_ipd , RESETNeg);
    buf   (CSNeg_ipd    , CSNeg   );
    buf   (WPNeg_ipd    , WPNeg   );

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (DQ7 ,   DQ7_zd  , 1);
    nmos   (DQ6 ,   DQ6_zd  , 1);
    nmos   (DQ5 ,   DQ5_zd  , 1);
    nmos   (DQ4 ,   DQ4_zd  , 1);
    nmos   (DQ3 ,   DQ3_zd  , 1);
    nmos   (DQ2 ,   DQ2_zd  , 1);
    nmos   (DQ1 ,   DQ1_zd  , 1);
    nmos   (DQ0 ,   DQ0_zd  , 1);

    nmos   (RWDS, RWDS_zd, 1);
    nmos   (INTNeg  ,   INTNeg_pull_up   , 1);
    nmos   (RSTONeg ,   RSTONeg_pull_up  , 1);

    // Needed for TimingChecks
    // VHDL CheckEnable Equivalent
      wire BURSTWRITE_EQ_0;
      assign BURSTWRITE_EQ_0 = BURSTWRITE == 0;
      wire BURSTWRITE_EQ_1;
      assign BURSTWRITE_EQ_1 = BURSTWRITE == 1;
      wire BURSTW0_Dout_Z;
      assign BURSTW0_Dout_Z = (BURSTWRITE==0) && (Dout_zd==8'bzzzzzzzz);
      wire BURSTW1_Dout_Z;
      assign BURSTW1_Dout_Z = (BURSTWRITE==1) && (Dout_zd==8'bzzzzzzzz);

    specify
    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file

        // tpd delays
    specparam  tpd_CSNeg_RWDS                              = 1; //tDSV,tDSZ
    specparam  tpd_CK_RWDS                                 = 1; //tCKDS
    specparam  tpd_CSNeg_DQ0                               = 1; //tOZ
    specparam  tpd_CK_DQ0                                  = 1; //tCKDS+tDSS

        //tsetup values
    specparam  tsetup_CSNeg_CK                             = 1;  //tCSS  edge /
    specparam  tsetup_DQ0_CK_BURSTWRITE_EQ_0               = 1;  //tIS
    specparam  tsetup_DQ0_CK_BURSTWRITE_EQ_1               = 1;  //tIS

        //thold values
    specparam  thold_CSNeg_CK                              = 1;  //tCSH  edge \
    specparam  thold_DQ0_CK_BURSTWRITE_EQ_0                = 1;  //tIS
    specparam  thold_DQ0_CK_BURSTWRITE_EQ_1                = 1;  //tIS
    specparam  thold_CSNeg_RESETNeg                        = 1;  //tRPH

        //tpw values: pulse width
    specparam  tpw_CK_negedge                              = 1; //tCL
    specparam  tpw_CK_posedge                              = 1; //tCH
    specparam  tpw_CSNeg_posedge                           = 1; //tCSHI
    specparam  tpw_RESETNeg_negedge                        = 1; //tRP

        //tperiod values
    specparam  tperiod_CK_BURSTWRITE_EQ_0                  = 1; //tCK
    specparam  tperiod_CK_BURSTWRITE_EQ_1                  = 1; //tCK

     //tdevice values: values for internal delays
    `ifdef SPEEDSIM // scaled values
        // Single word programming time 126 us, only word program
        specparam tdevice_SWP    = 126e6;
        // Single word or page (16 byte) buffered programming time 100 us
        specparam tdevice_SWPB   = 100e6;
        // Write Buffer programming time 200 us
        specparam tdevice_WBP    = 200e6;
        // Sector Erase (256Kbyte) time 2.9 ms
        specparam tdevice_SEO    = 2900e6;
        // Parameter Sector Erase (4 Kbyte) time 725 us
        specparam tdevice_PSEO   = 725e6;
        // Chip Erase time 462 ms
        specparam tdevice_CE     = 462e9;
        // Erase Suspend/Resume time (tESL) 50 us
        specparam tdevice_ESL    = 50e6;
        // Program Suspend/Resume time (tPSL) 50 us
        specparam tdevice_PSL    = 50e6;
        // Erase resume to next Erase Suspend time (tERS) 100 us
        // 100 us is typical value, minimal is 60 us, but it is
        // needed more for Erase to progress to completion
        specparam tdevice_ERS    = 100e6;
        // Program resume to next Program Suspend time (tPRS) 100 us
        // 100 us is typical value, minimal is 60 us, but it is
        // needed more for Program to progress to completion
        specparam tdevice_PRS    = 100e6;
        // Blank Check (256KB Sector) time 15 ms (typical, max is 17 ms)
        specparam tdevice_BC     = 17e9;
        // Evaluate Erase Status time (tEES) 70 us typical, max is 100 us
        specparam tdevice_EES    = 100e6;
        // Read Initial Access Time tACC
        specparam tdevice_IACC166   = 96e3;
        specparam tdevice_IACC133   = 120e3;
        // Password Unlock 100 us
        specparam tdevice_UNLOCK = 100e6;
        // tRPH
        specparam tdevice_RPH = 30e6;
        // CRC setup time
        specparam tdevice_CRCSETUP = 30e6;
        // CRC suspend latency
        specparam tdevice_CRCSL = 25e6;
        // CRC Resume to next suspend
        specparam tdevice_CRCRL = 5e6;
        // Vcc setup time to first access
        specparam tdevice_VCS    = 300e6;
        // Deep POwer Down
        specparam tdevice_DPD = 300e6;
        // Exit Event from Deep Power Down
        specparam tdevice_DPDCSL = 25e3;
        // Temperature Measurement timeout
        specparam tdevice_MTS = 15e6;
    `else
        // Single word programming time 1260 us, only word program
        specparam tdevice_SWP    = 1260e6;
        // Single word or page (16 byte) buffered programming time 1000 us
        specparam tdevice_SWPB   = 1000e6;
        // Write Buffer programming time 2000 us
        specparam tdevice_WBP    = 2000e6;
        // Sector Erase (256Kbyte) time 2900 ms
        specparam tdevice_SEO    = 2900e9;
        // Parameter Sector Erase (4 Kbyte) time 725 ms
        specparam tdevice_PSEO   = 725e9;
        // Chip Erase time 462 s
        specparam tdevice_CE     = 462e12;
        // Erase Suspend/Resume time (tESL) 50 us
        specparam tdevice_ESL    = 50e6;
        // Program Suspend/Resume time (tPSL) 50 us
        specparam tdevice_PSL    = 50e6;
        // Erase resume to next Erase Suspend time (tERS) 100 us
        // 100 us is typical value, minimal is 60 us, but it is
        // needed more for Erase to progress to completion
        specparam tdevice_ERS    = 100e6;
        // Program resume to next Program Suspend time (tPRS) 100 us
        // 100 us is typical value, minimal is 60 us, but it is
        // needed more for Program to progress to completion
        specparam tdevice_PRS    = 100e6;
        // Blank Check (256KB Sector) time 15 ms (typical, max is 17 ms)
        specparam tdevice_BC     = 17e9;
        // Evaluate Erase Status time (tEES) 70 us typical, max is 100 us
        specparam tdevice_EES    = 100e6;
        // Read Initial Access Time tACC
        specparam tdevice_IACC166   = 96e3;
        specparam tdevice_IACC133   = 120e3;
        // Password Unlock 100 us
        specparam tdevice_UNLOCK = 100e6;
        // tRPH
        specparam tdevice_RPH = 30e6;
        // CRC setup time
        specparam tdevice_CRCSETUP = 30e6;
        // CRC suspend latency
        specparam tdevice_CRCSL = 25e6;
        // CRC Resume to next suspend
        specparam tdevice_CRCRL = 5e6;
        // Vcc setup time to first access
        specparam tdevice_VCS    = 300e6;
        // Deep POwer Down
        specparam tdevice_DPD = 300e6;
        // Exit Event from Deep Power Down
        specparam tdevice_DPDCSL = 25e3;
        // Temperature Measurement timeout
        specparam tdevice_MTS = 15e6;
    `endif

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////

    // Data output paths
    (CSNeg => DQ0) = tpd_CSNeg_DQ0;
    (CSNeg => DQ1) = tpd_CSNeg_DQ0;
    (CSNeg => DQ2) = tpd_CSNeg_DQ0;
    (CSNeg => DQ3) = tpd_CSNeg_DQ0;
    (CSNeg => DQ4) = tpd_CSNeg_DQ0;
    (CSNeg => DQ5) = tpd_CSNeg_DQ0;
    (CSNeg => DQ6) = tpd_CSNeg_DQ0;
    (CSNeg => DQ7) = tpd_CSNeg_DQ0;

    (CSNeg => RWDS) = tpd_CSNeg_RWDS;

    if (~glitch_dq) (CK => DQ0) = tpd_CK_DQ0;
    if (~glitch_dq) (CK => DQ1) = tpd_CK_DQ0;
    if (~glitch_dq) (CK => DQ2) = tpd_CK_DQ0;
    if (~glitch_dq) (CK => DQ3) = tpd_CK_DQ0;
    if (~glitch_dq) (CK => DQ4) = tpd_CK_DQ0;
    if (~glitch_dq) (CK => DQ5) = tpd_CK_DQ0;
    if (~glitch_dq) (CK => DQ6) = tpd_CK_DQ0;
    if (~glitch_dq) (CK => DQ7) = tpd_CK_DQ0;

    if (~glitch_rwds) (CK => RWDS) = tpd_CK_RWDS;

    ///////////////////////////////////////////////////////////////////////////
    // Timing Violation                                                      //
    ///////////////////////////////////////////////////////////////////////////
    /*$setup (CSNeg, posedge CK,   tsetup_CSNeg_CK);

    $setup (DQ0 &&& BURSTW0_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_0);
    $setup (DQ1 &&& BURSTW0_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_0);
    $setup (DQ2 &&& BURSTW0_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_0);
    $setup (DQ3 &&& BURSTW0_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_0);
    $setup (DQ4 &&& BURSTW0_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_0);
    $setup (DQ5 &&& BURSTW0_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_0);
    $setup (DQ6 &&& BURSTW0_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_0);
    $setup (DQ7 &&& BURSTW0_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_0);

    $setup (DQ0 &&& BURSTW1_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_1);
    $setup (DQ1 &&& BURSTW1_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_1);
    $setup (DQ2 &&& BURSTW1_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_1);
    $setup (DQ3 &&& BURSTW1_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_1);
    $setup (DQ4 &&& BURSTW1_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_1);
    $setup (DQ5 &&& BURSTW1_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_1);
    $setup (DQ6 &&& BURSTW1_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_1);
    $setup (DQ7 &&& BURSTW1_Dout_Z, CK, tsetup_DQ0_CK_BURSTWRITE_EQ_1);


    $hold (negedge CK, CSNeg, thold_CSNeg_CK);

    $hold (CK, DQ0 &&& BURSTW0_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_0, Viol);
    $hold (CK, DQ1 &&& BURSTW0_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_0, Viol);
    $hold (CK, DQ2 &&& BURSTW0_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_0, Viol);
    $hold (CK, DQ3 &&& BURSTW0_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_0, Viol);
    $hold (CK, DQ4 &&& BURSTW0_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_0, Viol);
    $hold (CK, DQ5 &&& BURSTW0_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_0, Viol);
    $hold (CK, DQ6 &&& BURSTW0_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_0, Viol);
    $hold (CK, DQ7 &&& BURSTW0_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_0, Viol);

    $hold (CK, DQ0 &&& BURSTW1_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_1, Viol);
    $hold (CK, DQ1 &&& BURSTW1_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_1, Viol);
    $hold (CK, DQ2 &&& BURSTW1_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_1, Viol);
    $hold (CK, DQ3 &&& BURSTW1_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_1, Viol);
    $hold (CK, DQ4 &&& BURSTW1_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_1, Viol);
    $hold (CK, DQ5 &&& BURSTW1_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_1, Viol);
    $hold (CK, DQ6 &&& BURSTW1_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_1, Viol);
    $hold (CK, DQ7 &&& BURSTW1_Dout_Z, thold_DQ0_CK_BURSTWRITE_EQ_1, Viol);

    $hold (posedge RESETNeg, CSNeg, thold_CSNeg_RESETNeg);

    $width (posedge CK                 , tpw_CK_posedge);
    $width (negedge CK                 , tpw_CK_negedge);
    $width (posedge CSNeg              , tpw_CSNeg_posedge);
    $width (negedge RESETNeg           , tpw_RESETNeg_negedge);

    $period(posedge CK &&& BURSTWRITE_EQ_1  ,tperiod_CK_BURSTWRITE_EQ_1);
    $period(posedge CK &&& BURSTWRITE_EQ_0  ,tperiod_CK_BURSTWRITE_EQ_0);*/

    endspecify

///////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                       //
///////////////////////////////////////////////////////////////////////////////

    // FSM states
    parameter READ          = 10'd0; //
    parameter READUL1       = 10'd1; //
    parameter READUL2       = 10'd2; //
    parameter PPTR          = 10'd3; //
    parameter RPTR          = 10'd4; //
    parameter PPTRX         = 10'd5; //
    parameter LICR          = 10'd6; //
    parameter RICR          = 10'd7; //
    parameter LISR          = 10'd8; //
    parameter RISR          = 10'd9; //
    parameter LVCR          = 10'd10;//
    parameter RVCR          = 10'd11;//
    parameter PNVCR         = 10'd12;//
    parameter PGNVCR        = 10'd13;//
    parameter RNVCR         = 10'd14;//
    parameter ENVCR         = 10'd15;//
    parameter PFIDR         = 10'd16;//
    parameter PFIDRX        = 10'd17;//
    parameter RFIDR         = 10'd18;//
    parameter ER            = 10'd19;//
    parameter ERUL1         = 10'd20;//
    parameter ERUL2         = 10'd21;//
    parameter CER           = 10'd22;//
    parameter SER           = 10'd23;//
    parameter ESR           = 10'd24;//
    parameter BLCK          = 10'd25;//
    parameter EES           = 10'd26;//
    parameter ES            = 10'd27;//
    parameter ESUL1         = 10'd28;//
    parameter ESUL2         = 10'd29;//
    parameter ES_WB         = 10'd30;//
    parameter ES_WB_D       = 10'd31;//
    parameter ES_WB_LOAD    = 10'd32;//
    parameter ES_WB_CONFIRM = 10'd33;//
    parameter ESPG1         = 10'd34;//
    parameter ESPG          = 10'd35;//
    parameter ESPSR         = 10'd36;//
    parameter ESPS          = 10'd37;//
    parameter ESPSUL1       = 10'd38;//
    parameter ESPSUL2       = 10'd39;//
    parameter WB            = 10'd40;//
    parameter WB_D          = 10'd41;//
    parameter WB_LOAD       = 10'd42;//
    parameter WB_CONFIRM    = 10'd43;//
    parameter PG1           = 10'd44;//
    parameter PG            = 10'd45;//
    parameter PSR           = 10'd46;//
    parameter PS            = 10'd47;//
    parameter PSUL1         = 10'd48;//
    parameter PSUL2         = 10'd49;//
    parameter PGE           = 10'd50;//
    parameter PGEUL1        = 10'd51;//
    parameter PGEUL2        = 10'd52;//
    parameter LR            = 10'd53;//
    parameter LRPG1         = 10'd54;//
    parameter LRPG          = 10'd55;//
    parameter LREXT         = 10'd56;//
    parameter CFI           = 10'd57;//
    parameter CFIUL1        = 10'd58;//
    parameter SSR           = 10'd59;//
    parameter SSRUL1        = 10'd60;//
    parameter SSRUL2        = 10'd61;//
    parameter SSRPG1        = 10'd62;//
    parameter SSR_WB        = 10'd63;//
    parameter SSR_WB_D      = 10'd64;//
    parameter SSR_WB_LOAD   = 10'd65;//
    parameter SSR_WB_CONFIRM= 10'd66;//
    parameter SSRPG         = 10'd67;//
    parameter SSREXT        = 10'd68;//
    parameter PP            = 10'd69;//
    parameter PPWB25        = 10'd70;//
    parameter PPD           = 10'd71;//
    parameter PPV           = 10'd72;//
    parameter PASSUNLOCK    = 10'd73;//
    parameter PPH           = 10'd74;//
    parameter PPPG1         = 10'd75;//
    parameter PPPG          = 10'd76;//
    parameter PPEXT         = 10'd77;//
    parameter PPB           = 10'd78;//
    parameter PPBPG1        = 10'd79;//
    parameter PPBPG         = 10'd80;//
    parameter PPBER1        = 10'd81;//
    parameter PPBER         = 10'd82;//
    parameter PPBEXT        = 10'd83;//
    parameter PPBLB         = 10'd84;//
    parameter PPBLBSET      = 10'd85;//
    parameter PPBLBEXT      = 10'd86;//
    parameter DYB           = 10'd87;//
    parameter DYBSET        = 10'd88;//
    parameter DYBEXT        = 10'd89;//
    parameter CRC           = 10'd90;//
    parameter CRC_Calc      = 10'd91;//
    parameter CRCT          = 10'd92;//
    parameter CRCS          = 10'd93;//
    parameter ECC           = 10'd94;//
    parameter ECCR          = 10'd95;//
    parameter MTS           = 10'd96;//
    parameter DPD           = 10'd97;//
    parameter ESDPD         = 10'd98;//
    parameter ESPSDPD       = 10'd99;//
    parameter PSDPD         = 10'd100;//
    parameter DPDS          = 10'd101;//

    // states
    reg [6:0] current_state = READ;
    reg [6:0] next_state    = READ;
    reg [6:0] return_state  = READ;

    reg FIRST_WORD_OUT = 0;

    //Bus cycle state
    parameter STAND_BY        = 3'd0;
    parameter CA_BITS         = 3'd1;
    parameter DATA_BITS       = 3'd2;

    reg [1:0] bus_cycle_state;

    //Power Up time;
    initial
    begin
        PoweredUp = 1'b0;
        RSTONeg_zd = 1'bx;
        RSTONeg_zd = #1 1'b0;
        // tVCS 300 us + (tPOR_CK x PORTime_reg)
        if (PORTime_reg == 16'hFFFF)
            #(tdevice_VCS) RSTONeg_zd = 1'b1;
        else
            #(tdevice_VCS + (tPOR_CK * PORTime_reg)) RSTONeg_zd = 1'b1;
    end

    always @(posedge RSTONeg_zd)
    begin
        PoweredUp = 1'b1;
    end

    initial
    begin : Init
    integer i;
        write    = 1'b1;
        Addr     = 0;
        Check_wr_freq = 0;
        WPage  = 0;
        RdPage = 0;
        RdPageStart = 0;
        LCNT  = 0;
        PCNT  = 0;

        PDONE    = 1'b1;
        PSTART   = 1'b0;
        PSUSP    = 1'b0;
        PRES     = 1'b0;
        EDONE    = 1'b1;
        ESTART   = 1'b0;
        ESUSP    = 1'b0;
        ERES     = 1'b0;
        BCDONE   = 1'b1;
        BCSTART  = 1'b0;
        EESDONE  = 1'b1;
        EESSTART = 1'b0;
        CRCSUSP  = 1'b0;
        CRCRES   = 1'b0;

        EERR = 1'b0;
        PERR = 1'b0;

        for(i=0;i<=3;i=i+1)
            Password[i] = MaxData;
        PPBLock = 1'b1;

        bus_cycle_state = STAND_BY;
    end

    // Timing control for Suspend/Resume operations
    always @(posedge START_T1_in)
    begin:TSTARTT1r
        if (CRC_ACT == 1)
            #tdevice_CRCSL sSTART_T1 = START_T1_in;
        else
            #tdevice_ESL sSTART_T1 = START_T1_in;
    end
    always @(negedge START_T1_in)
    begin:TSTARTT1f
        #1 sSTART_T1 = START_T1_in;
    end

    // Password Unlock timing control
    always @(posedge UNLOCKDONE_in)
    begin : UnlockTime
        UNLOCKDONE_out = 1'b0;
        #(tdevice_UNLOCK - 1) UNLOCKDONE_out = 1'b1;
    end

    // Temperature measurement time
    always @(posedge MTS_in)
    begin : TempMeasTime
        MTS_out = 1'b0;
        #(tdevice_MTS - 1) MTS_out = 1'b1;
    end

    // ------------------------------------------------------------------------
    // Deep Power Down time
    // ------------------------------------------------------------------------
    // DPDExit_in is any write or read access for which CSNeg_ipd is asserted
    // more than tDPDCSL time
    assign DPDExt_in = ((falling_edge_CSNeg == 1'b1) && (DPD_in == 1'b1)) ?
                         1'b1 : 1'b0;

    always @(posedge DPDExt_in)
    begin : DPDExtEvent
      #(tdevice_DPDCSL - 1) DPDExt_out = 1'b1;
      #1 DPDExt_out = 1'b0;
    end
    // Generate event to trigger exiting from DPD mode
    always @(posedge DPDExt_out or CSNeg_ipd or RESETNeg or falling_edge_RST or
             DPD_in)
    begin : DPDExtDetected
      if ((DPDExt_out == 1'b1) && (CSNeg_ipd == 1'b0) || 
          (!RESETNeg && falling_edge_RST && DPD_in))
      begin
        DPDExt = 1'b1;
        #1 DPDExt = 1'b0;
      end
    end
    // DPD exit event, generated after tDPDOUT time (maximal: 300 us)
    always @(posedge DPDExt)
    begin : DPDTime
        DPD_out = 1'b0;
        #(tdevice_DPD - 1) DPD_out = 1'b1;
    end

    // ------------------------------------------------------------------------
    // preload section modified for embedded memory management routines
    // ------------------------------------------------------------------------

    // initialize memory and load preoload files if any
    initial
    begin: InitMemory
    integer i,j,k;

    integer secure_silicon[0:SecSi_size];

        for (i=0;i<=MemSize;i=i+1)
        begin
           Mem[i]=MaxData;
        end

        for (i=0;i<=SecSi_size;i=i+1)
        begin
           secure_silicon[i]=MaxData;
        end

        if (UserPreload && !(mem_file_name == "none"))
        begin
            $readmemh(mem_file_name,Mem);
        end

        if ((UserPreload) && !(secsi_file_name == "none"))
        begin
           // Secure Silicon Sector Region preload
           // s26ks512s_secsi memory file
           //   //       - comment
           //   @aa     - <aa> stands for address within last defined sector
           //   dddd      - <dddd> is word to be written at SecSi(aa++)
           //  (aa is incremented at every load)
           $readmemh(secsi_file_name,secure_silicon);
        end

        for (i=0;i<=SecNum;i=i+1)
        begin
            PPB_Prot[i] = 1;
            corrupt_flags[i] = 0;
        end

        for (i=0; i<=SecNum; i=i+1)
        begin
            for (j=0; j<=LineNum; j=j+1)
                corrupt_lines[i][j] = 0;
        end

        for (i=0;i<=SecSi_size;i=i+1)
        begin
            SSR_reg[i] = secure_silicon[i];
        end

        for (i=0;i<=255;i=i+1)
        begin
            WBData[i] = 0;
            WBAddr[i] = -1;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    //// sequential process for reset control and FSM state transition
    ///////////////////////////////////////////////////////////////////////////
    always @(next_state or falling_edge_RST or RST_out or PoweredUp or RESETNeg
             or rising_edge_DPD_out or DPD_in)
    begin: StateTransition

        if (PoweredUp)
        begin
            // When exiting the DPD mode set the default settings
            if (rising_edge_DPD_out == 1'b1)
            begin
                reseted = #1 1'b0;
                current_state = #1 READ;
            end
            // Hardware Reset
            else if (RESETNeg_in && RST_out)
            begin
                current_state = #1 next_state;
                reseted = 1;
            end
            else if (!RESETNeg && !RST && !DPD_in)
            begin
                // no state transition while RESET# low
                current_state = READ;
                reseted   = 1'b0;
            end
        end
        else
        begin
            current_state = READ;      // reset
            reseted       = 1'b0;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    //// sequential process for RST_in control
    ///////////////////////////////////////////////////////////////////////////
    always @(falling_edge_RST or RESETNeg or DPD_in)
    begin: RST_inTransition
        if (!RESETNeg && !RST && !DPD_in)
        begin
            RST_in = 1'b1;
            #1 RST_in = 1'b0;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Hardware Reset
    ///////////////////////////////////////////////////////////////////////////
    always @(posedge RST_in)
    begin:Threset
        RST_out = 1'b0;
        #(tdevice_RPH-200000) RST_out = 1'b1;
    end

    always @(RESETNeg)
        begin
            RST <= #199000 RESETNeg;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Process for generating differential clock from CK and CKNeg
    ///////////////////////////////////////////////////////////////////////////
    always @(CK, CKNeg)
    begin : DiffCK
        if (CK && ~CKNeg)
            CKDiff = 1'b1;
        if (~CK && CKNeg)
            CKDiff = 1'b0;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Initial Access
    ///////////////////////////////////////////////////////////////////////////
    always @(posedge IACC_in)
    begin : TIACCB
        IACC_out = 0;
        if (TimingModel=="S26KS512SDPBHI000" || TimingModel=="s26ks512sdpbhi000")
            #(tdevice_IACC166 - 1) IACC_out = 1'b1;
        else
            #(tdevice_IACC166 - 1) IACC_out = 1'b1;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Check if device is selected during power up
    ///////////////////////////////////////////////////////////////////////////
    always @(negedge CSNeg_ipd)
    begin:CheckCSOnPowerUP
        if (~PoweredUp)
            $display ("Device is selected during Power Up");
    end

    ///////////////////////////////////////////////////////////////////////////
    // Process that determines clock frequency
    ///////////////////////////////////////////////////////////////////////////
    always @(rising_edge_CKDiff)
    begin : CLK_FREQ
        CK_PER = $time - LAST_CK;
        LAST_CK = $time;
        # 1;
        if (RW && Check_freq)
        begin
                if ((CK_PER < 19230  && BurstDelay <=  5) ||
                (CK_PER < 16130  && BurstDelay <= 6) ||
                (CK_PER < 13890  && BurstDelay <=  7) ||
                (CK_PER < 12050  && BurstDelay <=  8) ||
                (CK_PER < 10750  && BurstDelay <=  9) ||
                (CK_PER < 9620   && BurstDelay <= 10) ||
                (CK_PER < 8770   && BurstDelay <= 11) ||
                (CK_PER < 8000   && BurstDelay <= 12) ||
                (CK_PER < 7410   && BurstDelay <= 13) ||
                (CK_PER < 6900   && BurstDelay <= 14) ||
                (CK_PER < 6410   && BurstDelay <= 15) ||
                (CK_PER < 6000   && BurstDelay <= 16))
                begin
                    $display ("More wait states are required for");
                    $display ("this clock frequency value,");
                    wrong_rd_freq = 1'b1;
                end
        end
        else if (~RW && BURSTWRITE && Check_wr_freq && (CK_PER < 20000))
        begin
            $display ("WARNING: Buffer Loaded with multiple words!!!");
            $display ("Frequency should be 50 MHz or less");
            Check_wr_freq = 0;
        end
        Check_freq = 0;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Bus Cycle Decode
    ///////////////////////////////////////////////////////////////////////////
    integer ca_cnt      = 48;
    integer data_cycle  =  0;
    reg [47:0] ca_in        ;
    reg [15:0] Data_in      ;
    always @(rising_edge_CSNeg or falling_edge_CSNeg or
             rising_edge_CKDiff or falling_edge_CKDiff)
    begin: BusCycle

        integer i;

        case (bus_cycle_state)

        STAND_BY:
        begin
            if (falling_edge_CSNeg)
            begin
                write         = 1'b1;
                ca_cnt        = 48;
                data_cycle    = 0;
                Latency_Clk   = 1'b0;
                RW            = 1'b0;
                Check_freq    = 1'b0;
                bus_cycle_state = CA_BITS;
                BURSTWRITE    = 1'b0;
            end
        end

        CA_BITS:
        begin
            if ((rising_edge_CKDiff && ca_cnt == 48) ||
            ((rising_edge_CKDiff || falling_edge_CKDiff) && ca_cnt != 48))
            begin
                if (~CSNeg_ipd && reseted)
                begin
                    //Command/Address Bit Assignments
                    for(i=1;i<=8;i=i+1)
                    begin
                        ca_in[ca_cnt-i] = Din[8-i];
                    end
                    ca_cnt = ca_cnt - 8;
                    if (ca_cnt == 0)
                    // ca_cnt is 0, all CA bits [47:0] are captured
                    begin
                        if (ca_in[45])
                        begin
                            RD_MODE = CONTINUOUS;
                        end
                        else
                        begin
                            RD_MODE = LINEAR;
                        end
                        //Address Decoding
                        Addr      = {ca_in[24:16], ca_in[2:0]};
                        SecAddr   = ca_in[HiAddrBit:30];
                        Address   = {ca_in[HiAddrBit:16], ca_in[2:0]};
                        // Page Address in a Sector is determined by
                        // ca_in{29:16} which is A
                        PageAddr  = {ca_in[16], ca_in[2:0]};
                        PSAddr    = ca_in[29:24];
                        SecSiAddr = {ca_in[21:16], ca_in[2:0]};
                        WLine     = ca_in[29 : 21];
                        LineAddr  = {ca_in[20:16],ca_in[2:0]};

                        change_addr = 1'b1;
                        #1 change_addr = 1'b0;
                        bus_cycle_state = DATA_BITS;
                    end
                    else if (ca_cnt == 16)
                    // Read access from Flash array starts once CA1[23..16]
                    // is captured
                    begin
                        RW    = ca_in[47];
                        // WPage represents the address of pair of Pages
                        // Pages are 16bytes, read access is for pair of pages
                        WPage = ca_in[29:17];
                        RdPage = ca_in[29:16];
                        RdPageStart = RdPage;
                        if (ca_in[47])
                        begin
                            Latency_Clk <= #5 1'b1;
                            IACC_in  = 1'b1;
                            IACC_in <= #5 1'b0;
                            //Burst Length
                            INIT_ACC_ELAPSED = 0;
                            if (VCR_Config_reg[1:0] == 2'b01)
                            begin
                                BurstLength = 32;
                            end
                            else if (VCR_Config_reg[1:0] == 2'b10)
                            begin
                                BurstLength = 8;
                            end
                            else if (VCR_Config_reg[1:0] == 2'b11)
                            begin
                                BurstLength = 16;
                            end

                            if (VCR_Config_reg[7:4] < 4'b1100)
                            begin
                                BurstDelay = VCR_Config_reg[7:4] + 5;
                            end
                            else
                            begin
                                BurstDelay = 16;
                            end
                            Check_freq = 1'b1;
                        end
                    end
                end
            end
        end

        DATA_BITS:
        begin
            if (~RW) //Write Operation
            begin
                if (rising_edge_CKDiff)
                begin
                    // Buffer Burst Write Load
                    if (CSNeg==1'b0 && ((data_cycle>2 && data_cycle % 2==0 &&
                    (current_state==WB_LOAD || current_state==ES_WB_LOAD ||
                    current_state==SSR_WB_LOAD)) || (data_cycle==2 &&
                    (current_state==WB_D || current_state==ES_WB_D ||
                    current_state==SSR_WB_D) && LCNT > 0) ||

                    ((current_state==PG1 || current_state==ESPG1 ||
                     current_state==SSRPG1) && data_cycle >= 2 )) )
                    begin
                        D_tmp = Data_in[15:0];
                        D_tmp1 = Data_in[7:0];
                        write = 1;
                        write <= #1 0;
                        BURSTWRITE = 1'b1;
                    end
                    //The upper order byte (D[15..8])
                    Data_in[15:8] = Din;
                    data_cycle = data_cycle + 1;
                end
                else if (falling_edge_CKDiff)
                begin
                    //The lower order byte (D[7..0])
                    Data_in[7:0] = Din;
                    data_cycle = data_cycle + 1;
                end
                if (rising_edge_CSNeg)
                begin
                    if ((data_cycle == 2) || (data_cycle > 2 &&
                    data_cycle % 2 == 0 && (current_state==WB_LOAD ||
                    current_state==ES_WB_LOAD || current_state==SSR_WB_LOAD
                    || current_state==PG1 || current_state==ESPG1 ||
                    current_state==SSRPG1)))
                    begin
                        D_tmp = Data_in[15:0];
                        D_tmp1 = Data_in[7:0];
                        write = 1;
                        write <= #1 0;
                    end
                    bus_cycle_state = STAND_BY;
                end
            end
            else if (rising_edge_CSNeg)
            begin
                bus_cycle_state = STAND_BY;
            end
        end
        endcase

        if (rising_edge_CSNeg)
        begin
            bus_cycle_state = STAND_BY;
        end

    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Blank Check
    ///////////////////////////////////////////////////////////////////////////
    event bcdone_event;
    always @(rising_edge_BCSTART, reseted)
    begin:BCtime
        if (reseted)
        begin
            if (rising_edge_BCSTART && BCDONE)
            begin
                BCDONE <= #1 1'b0;
                ->bcdone_event;
            end
        end
    end

    always @(bcdone_event)
    begin:bcdone_process
        #tdevice_BC BCDONE = 1'b1;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Evaluate Erase Status (EES)
    ///////////////////////////////////////////////////////////////////////////
    event eesdone_event;
    always @(rising_edge_EESSTART, reseted)
    begin:EEStime
        if (reseted)
        begin
            if (rising_edge_EESSTART && EESDONE)
            begin
                EESDONE <= #1 1'b0;
                ->eesdone_event;
            end
        end
    end

    always @(eesdone_event)
    begin:eesdone_process
        #tdevice_EES EESDONE = 1'b1;
    end
    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Write Buffer Program
    ///////////////////////////////////////////////////////////////////////////
    integer cnt = 0;
    time wbpb, duration ;
    event pdone_event   ;
    time start_write    ;
    time elapsed_write  ;

    always @(rising_edge_reseted or rising_edge_PSTART or rising_edge_PSUSP
             or rising_edge_PRES)
    begin : ProgTime

        wbpb = tdevice_WBP/(WrBuffLength+1);

        if (rising_edge_reseted)
        begin
            PDONE = 1; // reset done, programing terminated
            disable pdone_process;
        end
        else if (reseted)
        begin
            if (rising_edge_PSTART && PDONE)
            begin
                if (((~((DYB_Prot[SA_PGM]==1'b0 && PPB_Prot[SA_PGM]==1'b1) ||
                PPB_Prot[SA_PGM]==1'b0) && MEM_ACT==1'b1)
                || (OTP_ACT==1'b1 && (ssr_prot == 1'b1 && secsi_ssr_prot == 1'b1))
                || ASPR_ACT==1'b1 ||
                PORTreg_pg==1'b1 || NVCR_pg==1'b1 || FIDreg_pg==1'b1 ||
                PP_pg==1'b1 || PPB_pg==1'b1) && WPNeg_in)
                begin
                    if (PCNT <= 7) // 8 words, one 16B Page
                        duration = tdevice_SWPB;
                    else if (PCNT<256)  //buffer
                    begin
                        cnt = PCNT+1;
                        duration = cnt* wbpb;
                    end
                    else   //Word program
                    begin
                        duration =  tdevice_SWP;
                    end
                    elapsed_write = 0;
                    PDONE <= #1 1'b0;
                    ->pdone_event;
                    start_write = $time;
                end
                else
                begin
                    PERR = 1'b1;
                    PERR <= #100000000  1'b0;
                end
            end
            else if (rising_edge_PSUSP && ~PDONE)
            begin
                elapsed_write = $time - start_write;
                duration = duration - elapsed_write;
                disable pdone_process;
                PDONE = 0;
            end
            else if (rising_edge_PRES && ~PDONE)
            begin
                start_write = $time;
                PDONE = 0;
                -> pdone_event;
            end
        end
    end

    always @(pdone_event)
    begin : pdone_process
        #(duration) PDONE = 1;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Sector Erase
    ///////////////////////////////////////////////////////////////////////////
    event edone_event;
    time erase_duration;
    time elapsed_erase, start_erase;

    always @(rising_edge_ESTART or rising_edge_reseted or rising_edge_ESUSP or
             rising_edge_ERES)
    begin : ErsTime

        if (rising_edge_reseted)
        begin
            EDONE = 1; // reset done, ERASE terminated
            disable edone_process;
        end
        else if (reseted)
        begin
            if (rising_edge_ESTART && EDONE)
            begin
                if (chip_erase_time==1'b1)
                begin
                    if (WPNeg_in )
                    begin
                        erase_duration = tdevice_CE;
                        elapsed_erase = 0;
                        EDONE = 0;
                        -> edone_event;
                        start_erase = $time;
                    end
                    else
                    begin
                        EERR = 1'b1;
                        EERR <= #100000000  1'b0;
                    end
                end
                else 
                begin
                    if (((~((DYB_Prot[SA_ERS]==1'b0 && PPB_Prot[SA_ERS]==1'b1) ||
                    PPB_Prot[SA_ERS]==1'b0) && MEM_ACT==1'b1)
                    || PPB_ers == 1'b1 || NVCR_ers == 1'b1) && WPNeg_in)
                    begin
                        if (param_sec_erase_time==1'b1)
                            // parameter 4KB sector erase
                            erase_duration = tdevice_PSEO;
                        else
                            erase_duration = tdevice_SEO;

                        elapsed_erase = 0;
                        EDONE = 0;
                        -> edone_event;
                        start_erase = $time;
                    end
                    else
                    begin
                        EERR = 1'b1;
                        EERR <= #100000000  1'b0;
                    end
                end
            end
            else if (rising_edge_ESUSP && ~EDONE)
            begin
                elapsed_erase = $time - start_erase;
                erase_duration = erase_duration - elapsed_erase;
                disable edone_process;
                EDONE = 0;
            end
            else if (rising_edge_ERES && ~EDONE)
            begin
                start_erase = $time;
                EDONE = 0;
                -> edone_event;
            end
        end
    end

    always @(edone_event)
    begin : edone_process
        #erase_duration EDONE = 1;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the CRC calculation
    ///////////////////////////////////////////////////////////////////////////
    time  crc_duration ;
    event crcdone_event;
    time elapsed_crc, start_crc;

    always @(rising_edge_reseted or rising_edge_CRCSTART or
    rising_edge_CRCSUSP or rising_edge_CRCRES)
    begin : CRCTime
        if (rising_edge_reseted)
        begin
            CRCDONE = 1; // reset done, CRC calculation terminated
            disable crcdone_process;
        end
        else if (reseted)
        begin
            if (rising_edge_CRCSTART && CRCDONE)
            begin
                crc_duration = tdevice_CRCSETUP;
                CRCDONE = 0;
                -> crcdone_event;
                elapsed_crc = 0;
                start_crc = $time;
            end
            else if (rising_edge_CRCSUSP && ~CRCDONE)
            begin
                elapsed_crc = $time - start_crc;
                crc_duration = crc_duration - elapsed_crc;
                disable crcdone_process;
                CRCDONE = 0;
            end
            else if (rising_edge_CRCRES && ~CRCDONE)
            begin
                start_crc = $time;
                CRCDONE = 0;
                -> crcdone_event;
            end
        end
    end

    always @(crcdone_event)
    begin : crcdone_process
        #(crc_duration) CRCDONE = 1;
    end

    ///////////////////////////////////////////////////////////////////
    // Process for clock frequency determination
    ///////////////////////////////////////////////////////////////////
    always @(posedge CK)
    begin : clock_period
        CK_cycle = $time - prev_CK;
        prev_CK = $time;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Main Behavior Process
    // combinational process for next state generation
    ///////////////////////////////////////////////////////////////////////////
    reg PATTERN_1  = 1'b0;
    reg PATTERN_2  = 1'b0;
    reg A_PAT_1  = 1'b0;

    integer DataLo   ; //DATA Low Byte
    integer Data     ; //Data word

    always @(falling_edge_write or reseted or rising_edge_EDONE or
             rising_edge_PDONE or rising_edge_BCDONE or falling_edge_RST or
             rising_edge_sSTART_T1 or rising_edge_UNLOCKDONE_out or
             rising_edge_EESDONE or rising_edge_CRCDONE or
             falling_edge_EERR or falling_edge_PERR or rising_edge_CSNeg or
             rising_edge_MTS_out or rising_edge_DPD_out)
    begin: StateGen

        if (falling_edge_write)
        begin
            DataLo    = D_tmp1;
            Data      = D_tmp;
            PATTERN_1 = (Addr==16'h555) && (DataLo==8'hAA);
            PATTERN_2 = (Addr==16'h2AA) && (DataLo==8'h55);
            A_PAT_1   = (Addr==16'h555);
        end

        if (reseted!=1'b1)
            next_state = current_state;
        else
        case (current_state)

            READ:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_1 && ~STAT_ACT)
                        //Unlock Cycle 1
                        next_state = READUL1;
                    else if (A_PAT_1 && DataLo==16'h33 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        //Blank Check
                        next_state = BLCK;
                    else if (A_PAT_1 && DataLo==16'hD0 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Evaluate Erase Status
                        next_state = EES;
                    else if (A_PAT_1 && DataLo==16'h98 && ~STAT_ACT)
                    begin
                        // ID_CFI
                        next_state = CFI;
                    end
                    else
                        next_state = READ;
                end
            end

            READUL1:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_2 && ~STAT_ACT)
                        //Unlock Cycle 2
                        next_state = READUL2;
                    else
                        next_state = READ;
                end
            end

            READUL2:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'hA0 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Word Program Entry
                        next_state = PG1;
                    else if (DataLo==16'h25 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Write Buffer Load Command
                        next_state = WB;
                    else if (A_PAT_1 && DataLo==16'h80 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Erase Enter
                        next_state = ER;
                    else if (A_PAT_1 && DataLo==16'h90 && ~STAT_ACT)
                    begin
                        // ID (Autoselect) Entry
                        next_state = CFI;
                    end
                    else if (A_PAT_1 && DataLo==16'h88 && ~STAT_ACT &&
                    ~READ_PROTECT)
                    begin
                        // SSR Entry
                        next_state = SSR;
                    end
                    else if (A_PAT_1 && DataLo==16'h40 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // ASP Register Entry
                        next_state = LR;
                    else if (A_PAT_1 && DataLo==16'h60 && ~STAT_ACT)
                        // Password ASO Entry
                        next_state = PP;
                    else if (A_PAT_1 && DataLo==16'h78 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // CRC ASO Entry
                        next_state = CRC;
                    else if (A_PAT_1 && DataLo==16'hC0 && ~STAT_ACT &&
                    ~READ_PROTECT && ASPR_reg[0]==1'b1)
                        // PPB Entry
                        next_state = PPB;
                    else if (A_PAT_1 && DataLo==16'h50 && ~STAT_ACT &&
                    ASPR_reg[0]==1'b1)
                        // PPB Entry
                        next_state = PPBLB;
                    else if (A_PAT_1 && DataLo==16'hE0 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // DYB ASO Entry
                        next_state = DYB;
                    else if (A_PAT_1 && DataLo==16'h75 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // ECC Status Enter
                        next_state = ECC;
                    else if (A_PAT_1 && DataLo==16'h34 && ~STAT_ACT &&
                    ~READ_PROTECT && ~PORTreg_programmed)
                        // Program POR Timer Register
                        next_state = PPTR;
                    else if (A_PAT_1 && DataLo==16'h3C && ~STAT_ACT &&
                    ~READ_PROTECT)
                        next_state = RPTR;
                    else if (A_PAT_1 && DataLo==16'h36 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Load Interrupt Config Register
                        next_state = LICR;
                    else if (A_PAT_1 && DataLo==16'hC4 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Read Interrupt Config Register
                        next_state = RICR;
                    else if (A_PAT_1 && DataLo==16'h37 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Load Interrupt Status Register
                        next_state = LISR;
                    else if (A_PAT_1 && DataLo==16'hC5 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Read Interrupt Status Register
                        next_state = RISR;
                    else if (A_PAT_1 && DataLo==16'h39 && ~STAT_ACT &&
                    ~READ_PROTECT && (VCR_Config_reg[11]==1'b1))
                        // Program NVCR
                        next_state = PNVCR;
                    else if (A_PAT_1 && DataLo==16'hC8 && ~STAT_ACT &&
                    ~READ_PROTECT && (VCR_Config_reg[11]==1'b1))
                        // Erase NVCR
                        next_state = ENVCR;
                    else if (A_PAT_1 && DataLo==16'h38 && ~STAT_ACT &&
                    ~READ_PROTECT && (VCR_Config_reg[11]==1'b1))
                        // Load VCR
                        next_state = LVCR;
                    else if (A_PAT_1 && DataLo==16'hC6 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Read NVCR
                        next_state = RNVCR;
                    else if (A_PAT_1 && DataLo==16'hC7 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Read VCR
                        next_state = RVCR;
                    else if (A_PAT_1 && DataLo==16'h3A && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Program FID Register
                        next_state = PFIDR;
                    else if (A_PAT_1 && DataLo==16'h3B && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Read FID Register
                        next_state = RFIDR;
                    else if (A_PAT_1 && DataLo==16'hA9 && ~STAT_ACT &&
                    ~READ_PROTECT)
                        // Measure Temperature
                        next_state = MTS;
                    else if (DataLo==16'hB9 && ~STAT_ACT)
                        // DPD Entry
                        next_state = DPD;
                    else
                        next_state = READ;
                end
            end

            PPTR:
            begin
                if (falling_edge_write)
                    next_state = PPTRX;
            end

            PPTRX:
            begin
                if (falling_edge_write)
                begin
                    if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'h00)
                    && Status_reg[7]==1'b1)
                        next_state = return_state;
                end
                if (rising_edge_PDONE || falling_edge_PERR)
                    next_state = return_state;
            end

            LICR, LISR, LVCR:
            begin
                if (falling_edge_write)
                    next_state = return_state;
            end

            PNVCR:
            begin
                if (falling_edge_write)
                    next_state = PGNVCR;
            end

            PGNVCR:
            begin
                if (falling_edge_write)
                begin
                    if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'h00)
                    && Status_reg[7]==1'b1)
                        next_state = return_state;
                end
                if (rising_edge_PDONE || falling_edge_PERR)
                    next_state = return_state;
            end

            ENVCR:
            begin
                if (rising_edge_EDONE || falling_edge_EERR)
                    next_state = return_state;
            end

            PFIDR:
            begin
                if (falling_edge_write)
                    next_state = PFIDRX;
            end

            PFIDRX:
            begin
                if (falling_edge_write)
                begin
                    if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'h00)
                    && Status_reg[7]==1'b1)
                        next_state = READ;
                end
                if (rising_edge_PDONE || falling_edge_PERR)
                    next_state = READ;
            end

            ER:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_1 && ~STAT_ACT)
                        //Sector Erase Unlock Cycle 1
                        next_state = ERUL1;
                    else
                        next_state = READ;
                end
            end

            ERUL1:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_2 && ~STAT_ACT)
                        //Sector Erase Unlock Cycle 2
                        next_state = ERUL2;
                    else
                        next_state = READ;
                end
            end

            ERUL2:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'h30)
                        //Sector Erase Start
                        next_state = SER;
                    else if (A_PAT_1 && DataLo==16'h10)
                        // Chip Erase
                        next_state = CER;
                    else
                        next_state = READ;
                end
            end

            CER:
            begin
                if (falling_edge_write)
                begin
                    if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    && Status_reg[7]==1'b1)
                        next_state = READ;
                end
                //CER state will automatically move to READ state at the
                //completion of the operation
                if (rising_edge_EDONE || falling_edge_EERR)
                    next_state = READ;
            end

            SER:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hB0 && EERR==1'b0)
                        next_state = ESR;
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    && Status_reg[7]==1'b1)
                        next_state = READ;
                end
                //SER state will automatically move to READ state at the
                //completion of the operation
                if (rising_edge_EDONE || falling_edge_EERR)
                    next_state = READ;
            end

            ESR:
            begin
                if (rising_edge_sSTART_T1)
                    next_state = ES;
                if (rising_edge_EDONE)
                    next_state = READ;
            end

            BLCK:
            begin
                if (falling_edge_write)
                begin
                    if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    && Status_reg[7]==1'b1)
                        next_state = READ;
                end
                if (rising_edge_BCDONE)
                    next_state = READ;
            end

            EES:
            begin
                if (rising_edge_EESDONE)
                    next_state = READ;
            end

            ES:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_1)
                        next_state = ESUL1;
                    else if (DataLo==16'h30)
                        next_state = SER;
                    else if (Addr==16'h55 && DataLo==16'h98)
                        next_state = CFI;
                    else
                        next_state = ES;
                end
            end

            ESUL1:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_2)
                        // Erase Suspend Unlock 2
                        next_state = ESUL2;
                    else 
                        // Erase Suspend
                        next_state = ES;
                end
            end

            ESUL2:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'hA0)
                        // Word Program Entry
                        next_state = ESPG1;
                    else if (DataLo==16'h25)
                        // Write Buffer Entry
                        next_state = ES_WB;
                    else if (DataLo==16'h30)
                        // Erase Resume
                        next_state = SER;
                    else if (A_PAT_1 && DataLo==16'h90)
                        // ID_CFI
                        next_state = CFI;
                    else if (A_PAT_1 && DataLo==16'h88)
                        // SSR Entry
                        next_state = SSR;
                    else if (A_PAT_1 && DataLo==16'h34)
                        // Program POR Timer Register
                        next_state = PPTR;
                    else if (A_PAT_1 && DataLo==16'h3C)
                        next_state = RPTR;
                    else if (A_PAT_1 && DataLo==16'h36)
                        // Load Interrupt Config Register
                        next_state = LICR;
                    else if (A_PAT_1 && DataLo==16'hC4)
                        // Read Interrupt Config Register
                        next_state = RICR;
                    else if (A_PAT_1 && DataLo==16'h37)
                        // Load Interrupt Status Register
                        next_state = LISR;
                    else if (A_PAT_1 && DataLo==16'hC5)
                        // Read Interrupt Status Register
                        next_state = RISR;
                    else if (A_PAT_1 && DataLo==16'hC6)
                        // Read NVCR
                        next_state = RNVCR;
                    else if (A_PAT_1 && DataLo==16'hC7)
                        // Read VCR
                        next_state = RVCR;
                    else if (DataLo==16'hB9)
                        // DPD Entry
                        next_state = ESDPD;
                    else
                        // Erase Suspend
                        next_state = ES;
                end
            end

            ES_WB:
            begin
                if (falling_edge_write)
                begin
                    //The Write Buffer Programming Sequence will be aborted
                    //if a value greater than the buffer size is loaded
                    if (SecAddr == SA_PGM && D_tmp <= WrBuffLength)
                        next_state = ES_WB_D;
                    else
                        next_state = PGE;// abort
                end
            end

            ES_WB_D:
            begin
                if (falling_edge_write)
                begin
                    if (SecAddr==SA_PGM)
                    begin 
                        if (LCNT>0)
                            next_state = ES_WB_LOAD;
                        else
                            next_state = ES_WB_CONFIRM;
                    end
                    else
                    //If SA is not equal to programming addres device
                    //shall return to initiating state, which is Erase Suspend
                        next_state = PGE;
                end
            end

            ES_WB_LOAD:
            begin
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (WLine == WBLine))
                    begin
                        if (LCNT>0)
                        begin
                            next_state = ES_WB_LOAD;
                        end
                        else
                        begin
                            next_state = ES_WB_CONFIRM;
                        end
                    end
                    else
                        next_state = PGE;
                end
            end

            ES_WB_CONFIRM:
            begin
                if (falling_edge_write)
                begin
                    if (SecAddr == SA_PGM && DataLo == 16'h29)
                        //Program Buffer To Flash (confirm) Command
                        next_state = ESPG;
                    else
                        next_state = PGE;
                end
            end

            ESPG1:
            begin
                //ESPG1 state will automatically move to ESR state at the
                // completion of the operation
                if (falling_edge_write)
                begin
                    if (CSNeg)
                        next_state = ESPG;
                end
            end

            ESPG:
            begin
                if (falling_edge_write)
                begin
                    if (Status_reg[7]== 1'b1)
                    begin
                        if (DataLo==16'hF0 || (A_PAT_1 && DataLo==16'h71))
                            next_state = ES;
                    end
                    else
                    begin
                        if (DataLo==16'h51 && PERR==0)
                            next_state = ESPSR;
                    end
                end
                //ESPG state will automatically move to ES state at the
                // completion of the operation
                if (rising_edge_PDONE || falling_edge_PERR)
                    next_state = ES;
            end

            ESPSR:
            begin
                if (rising_edge_sSTART_T1)
                    next_state = ESPS;
                if (rising_edge_PDONE)
                    next_state = ES;
            end

            ESPS:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_1)
                        // Unlock 1
                        next_state = ESPSUL1;
                    else if (DataLo==16'h50)
                        // Erase/Program resume
                        next_state = ESPG;
                    else if (Addr==16'h55 && DataLo==16'h98)
                        // ID_CFI entry
                        next_state = CFI;
                    else
                        next_state = ESPS;
                end
            end

            ESPSUL1:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_2)
                        // Unlock 2
                        next_state = ESPSUL2;
                    else
                        next_state = ESPS;
                end
            end

            ESPSUL2:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'h50)
                        // Program/Erase resume
                        next_state = ESPG;
                    else if (A_PAT_1 && DataLo==16'h90)
                        // ID Autoselect Entry
                        next_state = CFI;
                    else if (A_PAT_1 && DataLo==16'h88)
                        // SSR entry
                        next_state = SSR;
                    else if (A_PAT_1 && DataLo==16'h3C)
                        next_state = RPTR;
                    else if (A_PAT_1 && DataLo==16'h36)
                        // Load Interrupt Config Register
                        next_state = LICR;
                    else if (A_PAT_1 && DataLo==16'hC4)
                        // Read Interrupt Config Register
                        next_state = RICR;
                    else if (A_PAT_1 && DataLo==16'h37)
                        // Load Interrupt Status Register
                        next_state = LISR;
                    else if (A_PAT_1 && DataLo==16'hC5)
                        // Read Interrupt Status Register
                        next_state = RISR;
                    else if (A_PAT_1 && DataLo==16'hC6)
                        // Read NVCR
                        next_state = RNVCR;
                    else if (A_PAT_1 && DataLo==16'hC7)
                        // Read VCR
                        next_state = RVCR;
                    else if (DataLo==16'hB9)
                        // DPD Entry
                        next_state = ESPSDPD;
                    else
                        // Erase Suspend
                        next_state = ESPS;
                end
            end

            WB:
            begin
                if (falling_edge_write)
                begin
                    //The Write Buffer Programming Sequence will be aborted
                    //if a value greater than the buffer size is loaded
                    if (SecAddr == SA_PGM && D_tmp <= WrBuffLength)
                        next_state = WB_D;
                    else
                        next_state = PGE;
                end
            end

            WB_D:
            begin
                if (falling_edge_write)
                begin
                    if (SecAddr == SA_PGM)
                        if (LCNT > 0)
                            next_state = WB_LOAD;
                        else
                            next_state = WB_CONFIRM;
                    else
                    // If SA is not equal to programming addres device
                    // shall return to initiating state
                        next_state = PGE;
                end
            end

            WB_LOAD:
            begin
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (WLine == WBLine))
                    begin
                        if (LCNT>0)
                        begin
                            next_state = WB_LOAD;
                        end
                        else
                        begin
                            next_state = WB_CONFIRM;
                        end
                    end
                    else
                        next_state = PGE;
                end
            end

            WB_CONFIRM:
            begin
                if (falling_edge_write)
                begin
                    if (SecAddr == SA_PGM && DataLo == 16'h29)
                        //Program Buffer To Flash (confirm) Command
                        next_state = PG;
                    else
                        next_state = PGE;
                end
            end

            PG1:
            begin
                if (falling_edge_write)
                    if (CSNeg)
                        next_state = PG;
            end

            PG:
            begin
                if (falling_edge_write)
                begin
                    if (Status_reg[7]== 1'b1)
                    begin
                        if (DataLo==16'hF0 || (A_PAT_1 && DataLo==16'h71))
                            next_state = READ;
                    end
                    else
                    begin
                        if (DataLo==16'h51 && PERR==0)
                            next_state = PSR;
                    end
                end
                //ESPG state will automatically move to ES state at the
                // completion of the operation
                if (rising_edge_PDONE || falling_edge_PERR)
                    next_state = READ;
            end

            PSR:
            begin
                if (rising_edge_sSTART_T1)
                    next_state = PS;
                if (rising_edge_PDONE)
                    next_state = READ;
            end

            PS:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_1)
                        next_state = PSUL1;
                    else if ( DataLo == 16'h50)
                        next_state = PG;
                    else if (Addr==16'h55 && DataLo==16'h98)
                        next_state = CFI;
                    else
                        next_state = PS;
                end
            end

            PSUL1:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_2)
                        next_state = PSUL2;
                    else
                        next_state = PS;
                end
            end

            PSUL2:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo == 16'h50)
                        next_state = PG;
                    else if (A_PAT_1 && DataLo==16'h90)
                        next_state = CFI;
                    else if (A_PAT_1 && DataLo==16'h88)
                        next_state = SSR;
                    else if (A_PAT_1 && DataLo==16'h3C)
                        next_state = RPTR;
                    else if (A_PAT_1 && DataLo==16'h36)
                        // Load Interrupt Config Register
                        next_state = LICR;
                    else if (A_PAT_1 && DataLo==16'hC4)
                        // Read Interrupt Config Register
                        next_state = RICR;
                    else if (A_PAT_1 && DataLo==16'h37)
                        // Load Interrupt Status Register
                        next_state = LISR;
                    else if (A_PAT_1 && DataLo==16'hC5)
                        // Read Interrupt Status Register
                        next_state = RISR;
                    else if (A_PAT_1 && DataLo==16'hC6)
                        // Read NVCR
                        next_state = RNVCR;
                    else if (A_PAT_1 && DataLo==16'hC7)
                        // Read VCR
                        next_state = RVCR;
                    else if (DataLo==16'hB9)
                        // DPD Entry
                        next_state = PSDPD;
                    else
                        next_state = PS;
                end
            end

            PGE:
            begin
                if (falling_edge_write && !STAT_ACT)
                begin
                    if (PATTERN_1)
                        next_state = PGEUL1;
                    else if (A_PAT_1 && DataLo==16'h71)
                        next_state = return_state;
                end
            end

            PGEUL1:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_2)
                        next_state = PGEUL2;
                    else
                        next_state = PGE;
                end
            end

            PGEUL2:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'hF0)
                        next_state = return_state;
                    else
                        next_state = PGE;
                end
            end

            LR:
            begin
                if (falling_edge_write && !STAT_ACT)
                begin
                    if (DataLo==16'hF0)
                        next_state = READ;
                    else if (DataLo==16'h90)
                        next_state = LREXT;
                    else if (DataLo==16'hA0)
                        next_state = LRPG1;
                end
            end

            LRPG1:
            begin
                if (falling_edge_write)
                begin
                    if (!((Data[2]==0 && Data[1]==0)  ||
                     ASPR_reg[2]==0  ||
                     ASPR_reg[1]==0 ||
                    (ASPR_reg[5]==0 && Data[1]==0)))
                        next_state = LRPG;
                    else
                        next_state = LR;
                end
                else
                    next_state = LRPG1;
            end

            LRPG:
            begin
                if (falling_edge_write)
                begin
                    if (Status_reg[7]==1'b1 &&
                    (DataLo==16'hF0 || (A_PAT_1 && DataLo==16'h71)))
                        next_state = LR;
                end
                if (rising_edge_PDONE || falling_edge_PERR)
                    next_state = LR;
            end

            LREXT:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0 || Data==16'h0000)
                        next_state = READ;
                    else
                        next_state = LR;
                end
            end

            CFI:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0 || DataLo==16'hFF)
                        next_state = return_state;
                    else if (PATTERN_1 && READ_PROTECT)
                        next_state = CFIUL1;
                end
            end

            CFIUL1:
            begin
                if (falling_edge_write)
                    next_state = CFI;
            end

            SSR:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0)
                    begin
                        if (Status_reg[6]==1 && Status_reg[2]==1)
                            next_state = ESPS;
                        else if (Status_reg[6]==1)
                            next_state = ES;
                        else if (Status_reg[2]==1)
                            next_state = PS;
                        else
                            next_state = READ;
                    end
                    else if (PATTERN_1)
                        next_state = SSRUL1;
                end
            end

            SSRUL1:
            begin
                if (falling_edge_write)
                begin
                    if (PATTERN_2)
                        next_state = SSRUL2;
                    else
                        next_state = SSR;
                end
            end

            SSRUL2:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'hA0 && Status_reg[2]==0
                    && VCR_Config_reg[10]==1'b1)
                        next_state = SSRPG1;
                    else if (DataLo==16'h25 && Status_reg[2]==0
                    && VCR_Config_reg[10]==1'b1)
                        next_state = SSR_WB;
                    else if (A_PAT_1 && DataLo==16'h90)
                        next_state = SSREXT;
                    else if (DataLo==16'hB9)
                        next_state = DPDS;
                    else
                        next_state = SSR;
                end
            end

            SSRPG1:
            begin
                if (falling_edge_write)
                    if (CSNeg)
                        next_state = SSRPG;
            end

            SSR_WB:
            begin
                if (falling_edge_write)
                begin
                    if (SecAddr == SA_PGM && D_tmp <= WrBuffLength)
                        next_state = SSR_WB_D;
                    else
                        next_state = PGE;
                end
            end

            SSR_WB_D:
            begin
                if (falling_edge_write)
                begin
                    if (SecAddr==SA_PGM)
                    begin
                        if (LCNT>0)
                            next_state = SSR_WB_LOAD;
                        else
                            next_state = SSR_WB_CONFIRM;
                    end
                    else
                        next_state = PGE;
                end
            end

            SSR_WB_LOAD:
            begin
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (WLine == WBLine))
                    begin
                        if (LCNT>0)
                            next_state = SSR_WB_LOAD;
                        else
                            next_state = SSR_WB_CONFIRM;
                    end
                    else
                        next_state = PGE;
                end
            end

            SSR_WB_CONFIRM:
            begin
                if (falling_edge_write)
                begin
                    if (SecAddr == SA_PGM && DataLo == 16'h29)
                        //Program Buffer To Flash (confirm) Command
                        next_state = SSRPG;
                    else
                        next_state = PGE;
                end
            end

            SSRPG:
            begin
                if (falling_edge_write)
                begin
                    if (Status_reg[7]== 1'b1 &&
                    (DataLo==16'hF0 || (A_PAT_1 && DataLo==16'h71)))
                        next_state = SSR;
                end
                if (rising_edge_PDONE || falling_edge_PERR)
                    next_state = SSR;
            end

            SSREXT:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0 || Data==16'h0000)
                    begin
                        if (Status_reg[6]==1'b1 && Status_reg[2]==1'b1)
                            next_state = ESPS;
                        else if (Status_reg[6]==1'b1)
                            next_state = ES;
                        else if (Status_reg[2]==1'b1)
                            next_state = PS;
                        else
                            next_state = READ;
                    end
                    else if (PATTERN_1)
                        next_state = SSRUL1;
                    else
                        next_state = SSR;
                end
            end

            PP:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0)
                        next_state = READ;
                    else if (DataLo==16'h25)
                        next_state = PPWB25;
                    else if (DataLo==16'h90)
                        next_state = PPEXT;
                    else if (DataLo==16'hA0 && ASPR_reg[2] != 1'b0)
                        next_state = PPPG1;
                end
            end

            PPWB25:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'h03 && (Addr % 2048 == 0))
                        next_state = PPD;
                    else
                        next_state = PGE;
                end
            end

            PPD:
            begin
                if (falling_edge_write)
                begin
                    if (LCNT > 1)
                        next_state = PPD;
                    else
                        next_state = PPV;
                end
            end

            PPV:
            begin
                if (falling_edge_write)
                begin
                    if (Addr==0 && DataLo==16'h29)
                        if (PassMATCH==4'b1111)
                            next_state = PASSUNLOCK;
                        else
                            next_state = PPH;
                    else
                        next_state = PGE;
                end
            end

            PASSUNLOCK:
            begin
                if (rising_edge_UNLOCKDONE_out)
                    next_state = PP;
            end

            PPH:
            begin
                if (falling_edge_write)
                begin
                    if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    && UNLOCKDONE_out) 
                        next_state = PP;
                end
            end

            PPPG1:
            begin
                if (falling_edge_write)
                    next_state = PPPG;
            end

            PPPG:
            begin
                if (falling_edge_write)
                begin
                    if (Status_reg[7]== 1'b1 &&
                    (DataLo==16'hF0 || (A_PAT_1 && DataLo==16'h71)))
                        next_state = PP;
                end
                if (rising_edge_PDONE || falling_edge_PERR)
                    next_state = PP;
            end

            PPEXT:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0 || Data==16'h0000 )
                        next_state = READ;
                    else if ((DataLo==16'h25) && (Address==0) &&
                            READ_PROTECT && UNLOCKDONE_out==1'b0)
                        next_state = PPWB25;
                    else
                        next_state = PP;
                end
            end

            PPB:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0)
                        next_state = READ;
                    else if (DataLo==16'h90)
                        next_state = PPBEXT;
                    else if (DataLo==16'hA0)
                        next_state = PPBPG1;
                    else if (DataLo==16'h80 && ASPR_reg[3]==1)
                        next_state = PPBER1;
                end
            end

            PPBPG1:
            begin
                if (falling_edge_write)
                begin
                    if (Data==16'h00)
                        next_state = PPBPG;
                    else
                        next_state = PPB;
                end
            end

            PPBPG:
            begin
                if (falling_edge_write)
                begin
                    if (Status_reg[7]==1'b1 &&
                    (DataLo==16'hF0 || (A_PAT_1 && DataLo==16'h71)))
                        next_state = PPB;
                end

                if (rising_edge_PDONE || falling_edge_PERR)
                    next_state = PPB;
            end

            PPBER1:
            begin
                if (falling_edge_write)
                begin
                    if (Addr==16'h00 && DataLo==16'h30)
                        next_state = PPBER;
                    else if (A_PAT_1 && DataLo==16'h70)
                        next_state = PPBER1;
                    else
                        next_state = PPB;
                end
            end

            PPBER:
            begin
                if (falling_edge_write)
                begin
                    if (Status_reg[7]==1'b1 &&
                    (DataLo==16'hF0 || (A_PAT_1 && DataLo==16'h71)))
                        next_state = PPB;
                end
                if (rising_edge_EDONE || falling_edge_EERR)
                    next_state = PPB;
            end

            PPBEXT:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0 || Data==16'h00)
                        next_state = READ;
                    else
                        next_state = PPB;
                end
            end

            PPBLB:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0)
                        next_state = READ;
                    else if (DataLo==16'h90)
                        next_state = PPBLBEXT;
                    else if (DataLo==16'hA0)
                        next_state = PPBLBSET;
                end
            end

            PPBLBSET:
            begin
                if (falling_edge_write)
                    next_state = PPBLB;
            end

            PPBLBEXT:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0 || Data==16'h00)
                        next_state = READ;
                    else
                        next_state = PPBLB;
                end
            end

            DYB:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0)
                        next_state =return_state;
                    else if (DataLo==16'h90)
                        next_state = DYBEXT;
                    else if (DataLo==16'hA0)
                        next_state = DYBSET;
                end
            end

            DYBSET:
            begin
                if (falling_edge_write)
                    next_state = DYB;
            end

            DYBEXT:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0 || Data==16'h00)
                        next_state = return_state;
                    else
                        next_state = DYB;
                end
            end

            CRC:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0)
                        next_state = READ;
                    else if ((DataLo==16'h3C) &&
                             (Address >= CRC_Start_Addr_reg + 2))
                    // Condition for entering CRC_calc state is not complete
                    // it needs to have comparison of Addr to EndAddr
                    // Check datasheet for table of state transitions
                        next_state = CRC_Calc;

                    else
                        next_state = CRC;
                end
            end

            CRC_Calc:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hC0)
                        next_state = CRCT;
                end
                if (rising_edge_CRCDONE)
                    next_state = CRC;
            end

            CRCT:
            begin
                if (rising_edge_sSTART_T1)
                    next_state = CRCS;
                if (rising_edge_CRCDONE)
                    next_state = CRC;
            end

            CRCS:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hC1)
                        next_state = CRC_Calc;
                end
            end

            ECC:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0)
                        next_state = READ;
                    else if (DataLo==16'h60)
                        next_state = ECCR;
                end
            end

            DPD, ESDPD, ESPSDPD, PSDPD, DPDS:
            begin
                if (rising_edge_DPD_out)
                    next_state = READ;
            end

            MTS:
            begin
                if (rising_edge_MTS_out)
                    next_state = READ;
            end

            ECCR:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'hF0)
                        next_state = READ;
                    else
                        next_state = ECC;
                end
                if (rising_edge_CSNeg && RW)
                    next_state = ECC;
            end

            RPTR, RICR, RISR, RVCR, RNVCR, RFIDR:
            begin
                if (rising_edge_CSNeg && RW)
                    next_state = return_state;
            end

        endcase
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general functionality
    ///////////////////////////////////////////////////////////////////////////
    integer i,j,k;

    always @(rising_edge_PoweredUp or falling_edge_RST or reseted or
             falling_edge_write or rising_edge_PDONE or rising_edge_EDONE or
             rising_edge_BCDONE or rising_edge_EESDONE or 
             rising_edge_UNLOCKDONE_out or rising_edge_CRCDONE or
             rising_edge_sSTART_T1 or falling_edge_EERR or falling_edge_PERR or
             rising_edge_status_7 or falling_edge_PDONE or 
             falling_edge_EDONE or rising_edge_MTS_out or rising_edge_DPD_out)
    begin: Functional
        ///////////////////////////////////////////////////////////////////////
        // Functionality Section
        ///////////////////////////////////////////////////////////////////////
        if (rising_edge_PoweredUp)
        begin
            //At the end of POR the device conditions are:
            //Status Register is at default value
            Status_reg[7] = 1'b1;
            Status_reg[8] = 1'b0;
            Status_reg[6:0] = 7'b0000000;
            //Write Buffer is loaded with all "1"
            for(i=0;i<=WrBuffLength;i=i+1)
            begin
                WBData[i] = MaxData;
            end
            //Device is in read mode
            STAT_ACT   = 1'b0;
            CR_ACT     = 1'b0;
            FIRST_WORD = 1'b1;
            INT_CR_ACT = 1'b0;
            INT_SR_ACT = 1'b0;
            CRC_ACT    = 1'b0;
            CRC_RD_SETUP = 1'b0;
            CFI_ACT    = 1'b0;
            DYB_ACT    = 1'b0;
            ESR_ACT    = 1'b0;
            POR_TR_ACT = 1'b0;
            INT_CR_reg = 16'hFFFF;
            INT_SR_reg = 16'hFFFB;
            FIDR_ACT   = 1'b0;
            ECC_ACT    = 1'b0;
            ECCR_ACT   = 1'b0;
            SA_PROT_ACT  = 1'b0;
            INTNeg_zd    = 1'b1;
            if (ASPR_reg[4]==1'b1) // DYB Enable boot bit
            begin
                for(i=0;i<=SecNum;i=i+1)
                    DYB_Prot[i] = 1;
            end
            else
            begin
                for(i=0;i<=SecNum;i=i+1)
                    DYB_Prot[i] = 0;
            end
        end

        if ((falling_edge_RST && ~RESETNeg) ||
            // When exiting the DPD mode set default setting
             rising_edge_DPD_out)
        begin
            //Device is in read mode
            MEM_ACT       = 1'b1;
            STAT_ACT      = 1'b0;
            CR_ACT        = 1'b0;
            NVCR_ACT      = 1'b0;
            INT_CR_ACT    = 1'b0;
            INT_SR_ACT    = 1'b0;
            CRC_ACT       = 1'b0;
            CRC_RD_SETUP   = 1'b0;
            DYB_ACT       = 1'b0;
            CFI_ACT       = 1'b0;
            PWD_ACT       = 1'b0;
            PPBLB_ACT     = 1'b0;
            POR_TR_ACT    = 1'b0;
            PORTreg_pg    = 1'b0;
            NVCR_pg       = 1'b0;
            NVCR_ers      = 1'b0;
            PP_pg         = 1'b0;
            PPB_pg        = 1'b0;
            PPB_ers       = 1'b0;
            FIDreg_pg     = 1'b0;
            UNLOCKDONE_in = 1'b0;
            chip_erase_time = 1'b0;
            INTNeg_zd       = 1'b1;

            //When RESET# is driven low for at least a period of tRP,
            //the device immediately resets the Status Register
            Status_reg[7] = 1;
            Status_reg[8] = 0;
            Status_reg[6:0] = 7'b0000000;
            // INT# is driven back to HIGH state upon RESET
            INTNeg_zd = 1'b1;
            // Interrupt regsiters are set to default upon RESET
            INT_CR_reg = 16'hFFFF;
            INT_SR_reg = 16'hFFFF;
            // PPBLock bit set to '0' if ASPR_reg[5]=1'b0
            if (ASPR_reg[2]==1'b0)
                PPBLock = 1'b0; // Password Mode
            else
                PPBLock = 1'b1; // Persistent Mode

            if (ASPR_reg[4]==1'b1) // DYB Enable boot bit
            begin
                for(i=0;i<=SecNum;i=i+1)
                    DYB_Prot[i] = 1;
            end
            else
            begin
                for(i=0;i<=SecNum;i=i+1)
                    DYB_Prot[i] = 0;
            end
            FIDR_ACT   = 1'b0;
            ECC_ACT    = 1'b0;
            ECCR_ACT   = 1'b0;
            SA_PROT_ACT  = 1'b0;
            ER_FLAG    = 1'b0;
            PR_FLAG    = 1'b0;
        end

        if (falling_edge_write)
        begin
            DataLo = D_tmp1;
            Data   = D_tmp;
            PATTERN_1 = (Addr == 12'h555 && DataLo == 8'hAA);
            PATTERN_2 = (Addr == 12'h2AA && DataLo == 8'h55);
            A_PAT_1   = Addr == 12'h555;
        end

        if (reseted ==1)
        begin
        case (current_state)

            READ:
            begin
                MEM_ACT    = 1;
                CFI_ACT    = 0;
                OTP_ACT    = 0; // In READ state (RESET state) all flags are
                CRC_ACT    = 0;
                ASPR_ACT   = 0;
                DYB_ACT    = 0;
                PPB_ACT    = 0;
                PWD_ACT    = 0;
                PPBLB_ACT  = 0;
                PORTreg_pg = 0;
                NVCR_pg    = 0;
                NVCR_ers   = 0;
                FIDreg_pg  = 0;
                PP_pg      = 0;
                PPB_pg     = 0;
                PPB_ers    = 0;
                PSUSP      = 0; // cleared, Program/Erase suspend and SSR(OTP)
                ESUSP      = 0;
                CRCSUSP    = 0;
                FIDR_ACT   = 0;
                CRC_RD_SETUP = 0;
                ECC_ACT    = 0;
                ECCR_ACT   = 0;
                SA_PROT_ACT= 0;
                cnt  = 0;
                PR_FLAG = 0;
                ER_FLAG = 0;
                START_T1_in = 0;
                chip_erase_time = 0;
                NVCR_LOAD_ACT = 0;

                //There is no Embedded Algorithm in progress in the device
                Status_reg[7] = 1;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                    else if (A_PAT_1 && DataLo==16'h33 && STAT_ACT==1'b0 &&
                    ~READ_PROTECT)
                    begin
                        //Blank Check Command
                        BCSTART = 1'b1;
                        BCSTART <= #1 1'b0;
                        Status_reg[7] = 0;
                        Status_reg[5] = 0;
                        SA_BC = SecAddr;
                    end
                    else if (A_PAT_1 && DataLo==16'hD0 && STAT_ACT == 1'b0 &&
                    ~READ_PROTECT)
                    begin
                    // Evaluate Erase Status of last sector erase command
                        EESSTART = 1'b1;
                        EESSTART <= #1 1'b0;
                        Status_reg[7] = 0;//Device is busy during EES
                        Status_reg[0] = 1;//Sector Erase status will be updated
                        SA_EES = SecAddr;
                    end
                    else if (A_PAT_1 && DataLo==16'h98)
                    begin
                        CFI_ACT = 1'b1;
                        SA_CFI = SecAddr;
                    end
                end
            end

            READUL1:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
            end

            READUL2:
            begin
                CFI_ACT  = 1'b0;
                ASPR_ACT = 1'b0;
                return_state = READ;
                if (falling_edge_write)
                begin
                    if (DataLo==16'h25 && STAT_ACT == 1'b0 &&
                    ~READ_PROTECT)
                    begin
                        //Write Buffer Load Command
                        //fix Sector Address SA
                        SA_PGM = SecAddr;
                    end
                    else if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    // Status register read enter
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'hC6 && ~CR_ACT && 
                    STAT_ACT == 1'b0 && ~READ_PROTECT)
                    // Read NVCR entry
                    begin
                        CR_ACT = 1'b1;
                        NVCR_ACT = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'hC7 && ~CR_ACT &&
                    STAT_ACT == 1'b0 && ~READ_PROTECT)
                    // Read VCR entry
                    begin
                        CR_ACT = 1'b1;
                        NVCR_ACT = 1'b0;
                    end
                    else if (A_PAT_1 && DataLo==16'hC8 &&
                    STAT_ACT == 1'b0 && ~READ_PROTECT)
                    begin
                        if (VCR_Config_reg[11]==1'b1)
                        begin
                            NVCR_ers = 1'b1;
                            ESTART = 1'b1;
                            ESTART <= #1 1'b0;
                            Status_reg[7] = 1'b0;
                        end
                        else
                            $display ("xVCR FREEZE bit set, NVCR erase fail");
                    end
                    else if (A_PAT_1 && DataLo==16'hC4 && ~INT_CR_ACT &&
                    STAT_ACT == 1'b0 && ~READ_PROTECT)
                    // Read Interrupt Configuration register
                    begin
                        INT_CR_ACT = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'hC5 && ~INT_SR_ACT &&
                    STAT_ACT == 1'b0 && ~READ_PROTECT)
                    // Read Interrupt Status register
                    begin
                        INT_SR_ACT = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'h3C &&
                    STAT_ACT == 1'b0 && ~READ_PROTECT)
                    begin
                        POR_TR_ACT = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'h90 &&
                    STAT_ACT == 1'b0)
                    begin
                        CFI_ACT = 1'b1;
                        SA_CFI = SecAddr;
                    end
                    else if (A_PAT_1 && DataLo==16'hC0 &&
                    STAT_ACT == 1'b0 && ~READ_PROTECT)
                    begin
                        if (ASPR_reg[0]==1'b1)
                            PPB_ACT = 1;
                        else
                        begin
                            $display("PPB Capability is disabled");
                            $display("ASPR_reg[0] bit is set to 1");
                        end
                    end
                    else if (A_PAT_1 && DataLo==16'hE0 &&
                    STAT_ACT == 1'b0 && ~READ_PROTECT)
                        DYB_ACT = 1'b1;
                    else if (A_PAT_1 && DataLo==16'h50 && STAT_ACT == 1'b0
                    && ASPR_reg[0]==1'b1)
                        PPBLB_ACT = 1'b1;

                    else if (A_PAT_1 && DataLo==16'h88 && STAT_ACT == 1'b0
                    && ~READ_PROTECT)
                        SA_SSR = SecAddr;
                    else if (A_PAT_1 && DataLo==16'h3B && STAT_ACT == 1'b0
                    && ~READ_PROTECT)
                        FIDR_ACT = 1'b1;

                    else if (READ_PROTECT &&
                    ((A_PAT_1 && DataLo==16'hA0) || (A_PAT_1 && DataLo==16'h80)
                    || DataLo==16'h25))
                    begin
                        Status_reg[3] = 1;
                        Status_reg[4] = 1;
                    end
                    else if (A_PAT_1 && DataLo==16'hA9 && ~STAT_ACT)
                    begin
                       // Measure Temperature
                       MTS_in = 1'b1;
                       MTS_in <= #1 1'b0;
                       Status_reg[7] = 1'b0;
                    end
                    else if (DataLo==16'hB9)
                    begin
                       // DPD Entry
                       DPD_in = 1'b1;
//                        DPD_in <= #1 1'b0;
                    end
                end
            end

            PPTR:
            begin
                MEM_ACT = 1'b0;
                PORTreg_pg = 1'b1;
                if (falling_edge_write)
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    Status_reg[7] = 0;
                    Status_reg[4] = 0;
                    PR_FLAG = 0;
                    PCNT = 256;
                    WBData[0] = -1;
                    if (~Viol)
                        WBData[0] = Data;
                end
            end
                                                                                
            PPTRX:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    // Status register read enter
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end

                if (rising_edge_PDONE && ~PR_FLAG)
                begin
                    PR_FLAG = 1;
                    PORTime_reg = WBData[0];
                    Status_reg[7] = 1'b1;
                    WBData[0]= -1;
                    PORTreg_programmed <= 1'b1;
                end

                if (falling_edge_PERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[4] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end

            LICR:
            begin
                if (falling_edge_write)
                    INT_CR_reg = Data;

            end

            LISR:
            begin
                if (falling_edge_write)
                    INT_SR_reg = INT_SR_reg | Data;
            end

            LVCR:
            begin
                if (falling_edge_write)
                begin
                    if (VCR_Config_reg[11] == 1'b1)
                    begin
                        VCR_Config_reg = Data;
                        VCR_LOAD_FIRST <= 1'b1;
                    end
                    else
                        $display ("xVCR FREEZE bit set, loading of VCR failed");
                end
            end

            PNVCR:
            begin
                MEM_ACT = 1'b0;
                NVCR_pg = 1'b1;
                if (falling_edge_write)
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    Status_reg[7] = 0;
                    Status_reg[4] = 0;
                    PR_FLAG = 0;
                    PCNT = 256;
                    WBData[0] = -1;
                    if (~Viol)
                        WBData[0] = Data;
                end
            end

            PGNVCR:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    // Status register read enter
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
                if (rising_edge_PDONE && ~PR_FLAG)
                begin
                    PR_FLAG = 1;
                    NVCR_Config_reg = WBData[0];
                    WBData[0]= -1;
                    NVCR_LOAD_ACT = 1'b1;
                    Status_reg[7] = 1'b1;
                end
                if (falling_edge_PERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[4] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end

            ENVCR:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
                if (rising_edge_EDONE && ~ER_FLAG)
                begin
                    ER_FLAG = 1;
                    NVCR_Config_reg = 16'hFFFF;
                    Status_reg[7] = 1'b1;
                end
                if (falling_edge_EERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[5] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end

            PFIDR:
            begin
                MEM_ACT = 1'b0;
                FIDreg_pg = 1'b1;
                if (falling_edge_write)
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    Status_reg[7] = 0;
                    Status_reg[4] = 0;
                    PR_FLAG = 0;
                    PCNT = 256;
                    WBData[0] = -1;
                    if (~Viol)
                        WBData[0] = Data;
                end
            end

            PFIDRX:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    // Status register read enter
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
                if (rising_edge_PDONE && ~PR_FLAG)
                begin
                    PR_FLAG = 1;
                    FIDR_reg = FIDR_reg & WBData[0];
                    Status_reg[7] = 1'b1;
                    WBData[0]= -1;
                end
                if (falling_edge_PERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[4] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end

            ER, ERUL1:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
            end

            ERUL2:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (DataLo==16'h30)
                    begin
                        //Start Sector Erase
                        PrmSecAddr = PSAddr;
                        if ((SecAddr==8'h0 && VCR_Config_reg[9:8]==2'b00 &&
                            (PrmSecAddr < 8)) || (SecAddr==SecNum &&
                            VCR_Config_reg[9:8]==2'b01 && PrmSecAddr>55))
                        begin
                            param_sec_erase_time = 1'b1;
                        end
                        else
                        begin
                            param_sec_erase_time = 1'b0;
                        end
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        SA_ERS = SecAddr;
                        Status_reg[7] = 1'b0;
                        Status_reg[5] = 1'b0;
                        Status_reg[1] = 1'b0;
                        ER_FLAG = 0;
                    end
                    else if (DataLo==16'h10)
                    begin
                        // Chip Erase
                        ESTART = 1'b1;
                        ESTART <= #1 1'b0;
                        Status_reg[7] = 1'b0;
                        chip_erase_time = 1'b1;
                        Status_reg[7] = 1'b0;
                        Status_reg[5] = 1'b0;
                        Status_reg[1] = 1'b0;
                        ER_FLAG = 0;
                    end
                end
            end
            
            CER:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && (DataLo == 16'h70) && (STAT_ACT == 1'b0))
                    begin
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end

                if (falling_edge_EDONE)
                begin
                    if (~ER_FLAG)
                    begin
                        ER_FLAG = 1'b1;
                        for (i=0;i<=SecNum;i=i+1)
                        begin
                            if (~((DYB_Prot[i]==1'b0 && PPB_Prot[i]==1'b1) ||
                            PPB_Prot[i]==1'b0 ))
                                corrupt_flags[i] = 1'b1;
                        end
                    end
                end
                if (rising_edge_EDONE)//rising edge
                begin
                    Status_reg[7] = 1'b1;
                    chip_erase_time = 1'b0;
                    for (i=0;i<=SecNum;i=i+1)
                    begin
                        if (~((DYB_Prot[i] == 1'b0 && PPB_Prot[i]==1'b1) ||
                        PPB_Prot[i] == 1'b0))
                        begin
                            for (j=0;j<=SecSize;j=j+1)
                                Mem[i*(SecSize+1)+j] = MaxData;
                            corrupt_flags[i] = 1'b0;
                        end
                    end
                end
                if (falling_edge_EERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[5] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end
            
            SER:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (DataLo==16'hB0)
                    begin
                        START_T1_in = 1;
                        ESR_ACT = 1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end

                if (falling_edge_EDONE)
                begin
                    if (~ER_FLAG)
                    begin
                        ER_FLAG = 1;
                        corrupt_flags[SA_ERS] = 1'b1;
                    end
                end
                if (rising_edge_EDONE)
                begin
                    Status_reg[7] = 1'b1;
                    if (SA_ERS==8'h0 && VCR_Config_reg[9:8]==2'b00)
                    begin
                    // Parameter Sector mapping for Low address sector
                        if (PrmSecAddr > 7)
                        begin
                        // none of the parameter sectors were selected
                        // the rest (224KB) of the SA00 will be erased

                            for (j=SA_ERS * (SecSize + 1) + Lo_prm224KB_sa;
                            j<=SA_ERS * (SecSize + 1) + SecSize;
                            j=j+1)
                                Mem[j] = MaxData;
                            corrupt_flags[SA_ERS] = 1'b0;
                        end
                        else
                        begin
                        // erase selected parameter sector
                            for (j=SA_ERS*(SecSize + 1) +
                            PrmSecAddr*(PrmSecSize+1);
                            j<=SA_ERS*(SecSize + 1) +
                            PrmSecAddr*(PrmSecSize+1) +
                            PrmSecSize; j=j+1)
                                Mem[j] = MaxData;
                            corrupt_flags[SA_ERS] = 1'b0;
                        end
                    end
                    else if (SA_ERS==SecNum && VCR_Config_reg[9:8]==2'b01)
                    begin
                    // Parameter Sector mapping for High address sector
                        if (PrmSecAddr < 56)
                        begin
                        // PrmSec 224KB is selected for erasure
                            for (j=SA_ERS * (SecSize + 1);
                            j<=SA_ERS * (SecSize + 1) + Hi_prm224KB_sa;
                            j=j+1)
                                Mem[j] = MaxData;
                            corrupt_flags[SA_ERS] = 1'b0;
                        end
                        else
                        begin
                        // erase selected parameter sector
                            for (j=SA_ERS*(SecSize + 1) +
                            PrmSecAddr*(PrmSecSize+1);
                            j<=SA_ERS*(SecSize + 1) +
                            PrmSecAddr*(PrmSecSize+1) + PrmSecSize;
                            j=j+1)
                                Mem[j] = MaxData;
                            corrupt_flags[SA_ERS] = 1'b0;
                        end
                    end
                    else
                    begin
                        for (j=SA_ERS * (SecSize + 1);
                        j<=SA_ERS * (SecSize + 1) + SecSize;
                        j=j+1)
                            Mem[j] = MaxData;
                        corrupt_flags[SA_ERS] = 1'b0;
                    end
                end
                if (falling_edge_EERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[5] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end

            ESR:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
                if (rising_edge_sSTART_T1)
                begin
                    Status_reg[7] = 1;
                    Status_reg[6] = 1;
                    START_T1_in = 0;
                    ESR_ACT     = 0;
                    ESUSP = 1;
                end
                if (rising_edge_EDONE)
                begin
                    Status_reg[7] = 1'b1;
                    if (SA_ERS==8'h0 && VCR_Config_reg[9:8]==2'b00)
                    begin
                    // Parameter Sector mapping for Low address sector
                        if (PrmSecAddr > 7)
                        begin
                        // none of the parameter sectors were selected
                        // the rest (224KB) of the SA00 will be erased

                            for (j=SA_ERS * (SecSize + 1) + Lo_prm224KB_sa;
                            j<=SA_ERS * (SecSize + 1) + SecSize;
                            j=j+1)
                                Mem[j] = MaxData;
                            corrupt_flags[SA_ERS] = 1'b0;
                        end
                        else
                        begin
                        // erase selected parameter sector
                            for (j=SA_ERS*(SecSize + 1) +
                            PrmSecAddr*(PrmSecSize+1);
                            j<=SA_ERS*(SecSize + 1) +
                            PrmSecAddr*(PrmSecSize+1) +
                            PrmSecSize; j=j+1)
                                Mem[j] = MaxData;
                            corrupt_flags[SA_ERS] = 1'b1;
                        end
                    end
                    else if (SA_ERS==SecNum && VCR_Config_reg[9:8]==2'b01)
                    begin
                    // Parameter Sector mapping for High address sector
                        if (PrmSecAddr < 56)
                        begin
                        // PrmSec 224KB is selected for erasure
                            for (j=SA_ERS * (SecSize + 1);
                            j<=SA_ERS * (SecSize + 1) + Hi_prm224KB_sa;
                            j=j+1)
                                Mem[j] = MaxData;
                            corrupt_flags[SA_ERS] = 1'b0;
                        end
                        else
                        begin
                        // erase selected parameter sector
                            for (j=SA_ERS*(SecSize + 1) +
                            PrmSecAddr*(PrmSecSize+1);
                            j<=SA_ERS*(SecSize + 1) +
                            PrmSecAddr*(PrmSecSize+1) + PrmSecSize;
                            j=j+1)
                                Mem[j] = MaxData;
                            corrupt_flags[SA_ERS] = 1'b0;
                        end
                    end
                    else
                    begin
                        for (j=SA_ERS * (SecSize + 1);
                        j<=SA_ERS * (SecSize + 1) + SecSize;
                        j=j+1)
                            Mem[j] = MaxData;
                        corrupt_flags[SA_ERS] = 1'b0;
                    end
                end
            end

            BLCK:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin // read status register during BLCK
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
                else if (rising_edge_BCDONE)
                begin //when BC is done,after tdevice_BC,set the BUSY bit ot 0
                    Status_reg[7] = 1;
                end
                else
                begin
                    Status_reg[7] = 0;
                    Status_reg[5] = 0;
                    for (j=SA_BC*(SecSize+1);j<=SA_BC*(SecSize+1) +
                    SecSize;j=j+1)
                    begin
                        if (Mem[j] != MaxData)
                            Status_reg[5] = 1;
                    end
                end
            end

            EES:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin // read status register during EES
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
                else if (rising_edge_EESDONE)
                begin // when EES is done, after tEES, set the BUSY bit ot 0
                    Status_reg[7] = 1;
                    if (corrupt_flags[SA_EES] == 1'b1)
                        Status_reg[0] = 0;
                    else
                        Status_reg[0] = 1;
                end
                else
                begin // check the status of last erase operation
                    Status_reg[7] = 0;

                end
            end

            ES:
            begin
                CFI_ACT = 1'b0;
                DYB_ACT = 1'b0;
                MEM_ACT = 1'b1;
                ESUSP = 0;
                return_state = ES;
                cnt = 0;
                if(falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if ((A_PAT_1 && DataLo==16'h71) ||  DataLo==16'hF0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                    else if (DataLo == 16'h30)
                    begin
                        //resume erase
                        Status_reg[6] = 1'b0;
                        Status_reg[7] = 1'b0;
                        ERES = 1'b1;
                        ERES <= #1 1'b0;
                        ESUSP   = 1'b0;
                    end
                    else if (Addr==16'h55 && DataLo==16'h98)
                    begin
                        CFI_ACT = 1'b1;
                        SA_CFI = SecAddr;
                    end
                end
                if (rising_edge_sSTART_T1)
                    START_T1_in = 0;

            end

            ESUL1:
            begin
                if (falling_edge_write && A_PAT_1 && DataLo == 16'h70 &&
                    STAT_ACT == 1'b0)
                begin
                    //Status Register Enter Command
                    STAT_ACT   = 1'b1;
                    FIRST_WORD = 1'b1;
                end
            end

            ESUL2:
            begin
                CFI_ACT = 1'b0;
                DYB_ACT = 1'b0;
                return_state = ES;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    // Status register read enter
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (DataLo==16'h25)
                    begin
                        SA_PGM = SecAddr;
                        Status_reg[4] = 1'b0;
                        if (SecAddr == SA_ERS)
                            Status_reg[4] = 1'b1;
                    end
                    else if (DataLo==16'h30)
                    begin
                        // erase resume
                        Status_reg[6] = 0;
                        Status_reg[7] = 0;
                        ERES = 1'b1;
                        ERES <= #1 1'b0;
                        ESUSP = 1'b0;
                    end
                    else if (A_PAT_1 && DataLo==16'h90)
                    begin
                        CFI_ACT = 1'b1;
                        SA_CFI  = SecAddr;
                    end
                    else if (A_PAT_1 && DataLo==16'h88)
                        SA_SSR  = SecAddr;
                    else if (A_PAT_1 && DataLo==16'hE0)
                        DYB_ACT = 1'b1;
                    else if (A_PAT_1 && DataLo==16'h80)
                    // Erase operation attempt in Erase Suspend mode
                    // will cause Erase failure
                        Status_reg[5] = 1'b1;
                    else if (A_PAT_1 && DataLo==16'hC6 && ~CR_ACT)
                    begin
                        CR_ACT = 1'b1;
                        NVCR_ACT = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'hC7 && ~CR_ACT)
                    begin
                        CR_ACT = 1'b1;
                        NVCR_ACT = 1'b0;
                    end
                    else if (A_PAT_1 && DataLo==16'hC4 && ~INT_CR_ACT)
                        INT_CR_ACT = 1'b1;
                    else if (A_PAT_1 && DataLo==16'hC5 && ~INT_SR_ACT)
                        INT_SR_ACT = 1'b1;
                    else if (A_PAT_1 && DataLo==16'h3C)
                        POR_TR_ACT = 1'b1;
                    else if (DataLo==16'hB9)
                    begin
                       // DPD Entry
                       DPD_in = 1'b1;
//                        DPD_in <= #1 1'b0;
                    end
                end
            end

            ES_WB:
            begin
                return_state = ES;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (D_tmp <= WrBuffLength))
                    begin
                        //The system writes the number of word locations - 1
                        cnt = D_tmp;
                        PCNT = cnt;
                        LCNT = cnt;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1; //Program Status Bit - fail
                        Status_reg[3] = 1'b1; //Write to Buff Abort
                    end
                end
            end

            ES_WB_D:
            begin
                return_state = ES;
                if (falling_edge_write)
                begin
                    if(SecAddr == SA_PGM)
                    begin
                        //The starting address/data combination is written
                        WBData[cnt] = -1;
                        if (~Viol)
                        begin
                            WBData[cnt] = Data;
                        end
                        WBAddr[cnt] = LineAddr;

                        if (BURSTWRITE == 1'b1 && LineAddr < 255)
                        begin
                            LineAddr = LineAddr + 1;
                        end

                        if (cnt>0)
                        begin
                            cnt = cnt -1;
                        end
                        //The write-buffer-Line address is selected
                        WBLine = WLine;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1; //Program Status Bit - fail
                        Status_reg[3] = 1'b1; //Write to Buff Abort
                    end
                    LCNT <= cnt;
                end
            end

            ES_WB_LOAD:
            begin
                return_state = ES;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (WLine == WBLine))
                    begin
                        WBData[cnt] = -1;
                        if (~Viol)
                        begin
                            WBData[cnt] = Data;
                        end
                        WBAddr[cnt] = LineAddr;

                        if (BURSTWRITE == 1'b1 && LineAddr < 255)
                        begin
                            LineAddr = LineAddr + 1;
                        end

                        if (cnt>0)
                        begin
                            cnt = cnt -1;
                        end
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1; //Program Status Bit - fail
                        Status_reg[3] = 1'b1; //Write to Buff Abort
                    end
                    LCNT <= cnt;
                end
                Check_wr_freq   = 1'b1;
            end

            ES_WB_CONFIRM:
            begin
                return_state = ES;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (DataLo == 16'h29))
                    begin
                        if (SA_PGM != SA_ERS)
                        begin
                            //Program Buffer To Flash (confirm) Command
                            PSTART = 1'b1;
                            PSTART <= #1 1'b0;
                            Status_reg[7] = 0;
                            Status_reg[4] = 0;
                            Status_reg[1] = 0;
                            PR_FLAG = 0;
                        end
                        else
                        begin
                            PR_FLAG = 1;
                            Status_reg[4] = 1;
                        end
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1;
                        Status_reg[3] = 1'b1;
                    end
                end
                Check_wr_freq = 0;
            end

            ESPG1:
            begin
                if (falling_edge_write)
                begin
                    if (SecAddr != SA_ERS)
                    begin
                        if (~BURSTWRITE)
                        begin
                            PSTART = 1'b1;
                            PSTART <= #1 1'b0;
                            Status_reg[7] = 0;
                            Status_reg[4] = 0;
                            Status_reg[1] = 0;
                            PR_FLAG = 0;
                            PCNT = 256;
                            WBData[0] = -1;
                            if (~Viol)
                                WBData[0] = Data;
                            WBAddr[0] = LineAddr;
                            WBLine = WLine;
                            SA_PGM = SecAddr;
                            WBAddr[1] = -1;
                        end
                        else
                        begin
                            WBLine = WLine;
                            SA_PGM = SecAddr;
                            WBData[cnt] = -1;
                            if (~Viol)
                                WBData[cnt] = Data;
                            WBAddr[cnt] = LineAddr;
                            if (LineAddr < 255)
                                LineAddr = LineAddr + 1;
                            if (cnt<255) 
                                cnt = cnt +1;
                            if (CSNeg)
                            begin
                                PSTART = 1'b1;
                                PSTART <= #1 1'b0;
                                Status_reg[7] = 0;
                                Status_reg[4] = 0;
                                Status_reg[1] = 0;
                                PR_FLAG = 0;
                                PCNT = cnt;
                            end
                        end
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1;
                        PR_FLAG = 1;
                    end
                end
            end

            ESPG:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    // Status register read enter
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (DataLo==16'h51)
                    begin
                        START_T1_in = 1;
                        PSR_ACT = 1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end

                if (falling_edge_PDONE)
                begin
                    if (~PR_FLAG)
                    begin
                        PR_FLAG = 1;
                        if (PCNT < 256)   //buffer
                        begin
                            wr_cnt = PCNT;
                        end
                        else   //Word program
                        begin
                            wr_cnt = 0;
                        end
                        for (i=wr_cnt-1;i>=0;i=i-1)
                        begin
                            new_int= WBData[i];
                            if (corrupt_flags[SA_PGM] == 1'b1)
                            begin
                                old_int = -1;
                            end
                            else
                            begin
                                old_int = Mem[SA_PGM*(SecSize+1)
                                + WBLine*(WrBuffLength+1)+ WBAddr[i]];
                            end

                            if (new_int>-1)
                            begin
                                new_bit = new_int;

                                if (old_int>-1)
                                begin
                                    old_bit = old_int;
                                    for(j=0;j<=15;j=j+1)
                                        if (~old_bit[j])
                                            new_bit[j]=1'b0;
                                end
                                else
                                begin
                                    new_bit[0] = 1'bx;
                                end

                                if( new_bit[0] !== 1'bx )
                                begin
                                    new_int=new_bit;
                                    WBData[i]= new_int;
                                end
                            end
                            else
                                WBData[i]= -1;
                        end

                        for (i=wr_cnt-1;i>=0;i=i-1)
                        begin
                            Mem[SA_PGM*(SecSize+1)+
                            WBLine*(WrBuffLength+1)+WBAddr[i]] = -1;
                        end
                        corrupt_lines[SA_PGM][WBLine] = 1'b1;
                    end
                end

                if (rising_edge_PDONE)
                begin
                    for (i=wr_cnt;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1 && WBData[i] > -1)
                        begin
                            Mem[SA_PGM*(SecSize+1)+
                            WBLine*(WrBuffLength+1)+WBAddr[i]] =
                            WBData[i];
                        end
                        WBData[i]= -1;
                    end
                    Status_reg[7] = 1'b1;
                    corrupt_lines[SA_PGM][WBLine] = 1'b0;
                end
                if (falling_edge_PERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[4] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end

            ESPSR:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end

                if (rising_edge_sSTART_T1)
                begin
                    PSUSP = 1;
                    Status_reg[7] = 1;
                    Status_reg[2] = 1;
                    START_T1_in = 0;
                    PSR_ACT = 0;
                end
                if (rising_edge_PDONE)
                begin
                    for (i=wr_cnt-1;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1 && WBData[i] > -1)
                        begin
                            Mem[SA_PGM*(SecSize+1)+
                            WBLine*(WrBuffLength+1)+WBAddr[i]] =
                            WBData[i];
                        end
                        WBData[i]= -1;
                    end
                    Status_reg[7] = 1'b1;
                    corrupt_lines[SA_PGM][WBLine] = 1'b0;
                end
            end

            ESPS:
            begin
                return_state <= current_state;
                CFI_ACT = 1'b0;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT = 1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                    else if (DataLo==16'h50)
                    begin
                        PRES = 1'b1;
                        PRES <= #1 1'b0;
                        PSUSP = 0;
                        Status_reg[2] = 0;
                        Status_reg[7] = 0;
                    end
                    else if (DataLo==16'h98)
                    begin
                        CFI_ACT = 1'b1;
                        SA_CFI = SecAddr;
                    end
                end
            end

            ESPSUL1:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
            end

            ESPSUL2:
            begin
                CFI_ACT = 1'b0;
                return_state = ESPS;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (DataLo==16'h50)
                    begin
                        PRES = 1'b1;
                        PRES <= #1 1'b0;
                        PSUSP = 0;
                        Status_reg[2] = 0;
                        Status_reg[7] = 0;
                    end
                    else if (A_PAT_1 && DataLo==16'h90)
                    begin
                        // ID Autoselect Entry
                        CFI_ACT = 1'b1;
                        SA_CFI = SecAddr;
                    end
                    else if ((A_PAT_1 && DataLo==16'hA0) || (DataLo==16'h25))
                        // Word or Buffer Program attempt in program suspend 
                        // will cause program failure
                        Status_reg[4] = 1'b1;
                    else if (A_PAT_1 && DataLo==16'h80)
                        // Erase attempt while in program suspend will cause
                        // Erase failure
                        Status_reg[5] = 1'b1;
                    else if (A_PAT_1 && DataLo==16'h88)
                        SA_SSR  = SecAddr;
                    else if (A_PAT_1 && DataLo==16'hC6 && ~CR_ACT)
                    begin
                        CR_ACT = 1'b1;
                        NVCR_ACT = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'hC7 && ~CR_ACT)
                    begin
                        CR_ACT = 1'b1;
                        NVCR_ACT = 1'b0;
                    end
                    else if (A_PAT_1 && DataLo==16'hC4 && ~INT_CR_ACT)
                        INT_CR_ACT = 1'b1;
                    else if (A_PAT_1 && DataLo==16'hC5 && ~INT_SR_ACT)
                        INT_SR_ACT = 1'b1;
                    else if (A_PAT_1 && DataLo==16'h3C)
                        POR_TR_ACT = 1'b1;
                    else if (DataLo==16'hB9)
                    begin
                       // DPD Entry
                       DPD_in = 1'b1;
//                        DPD_in <= #1 1'b0;
                    end
                end
            end

            WB:
            begin
                return_state = READ;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (D_tmp <= WrBuffLength))
                    begin
                        //The system writes the number of word locations - 1
                        cnt = D_tmp;
                        PCNT = cnt;
                        LCNT = cnt;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1; //Program Status Bit - fail
                        Status_reg[3] = 1'b1; //Write to Buff Abort
                    end
                end
            end

            WB_D:
            begin
                return_state = READ;
                if (falling_edge_write)
                begin
                    if(SecAddr == SA_PGM)
                    begin
                        //The starting address/data combination is written
                        WBData[cnt] = -1;
                        if (~Viol)
                        begin
                            WBData[cnt] = Data;
                        end
                        WBAddr[cnt] = LineAddr;

                        if (BURSTWRITE == 1'b1 && LineAddr < 255)
                        begin
                            LineAddr = LineAddr + 1;
                        end

                        if (cnt>0)
                        begin
                            cnt = cnt -1;
                        end
                        //The write-buffer-Line address is selected
                        WBLine = WLine;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1; //Program Status Bit - fail
                        Status_reg[3] = 1'b1; //Write to Buff Abort
                    end
                    LCNT <= cnt;
                end
            end

            WB_LOAD:
            begin
                return_state = READ;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (WLine == WBLine))
                    begin
                        WBData[cnt] = -1;
                        if (~Viol)
                        begin
                            WBData[cnt] = Data;
                        end
                        WBAddr[cnt] = LineAddr;

                        if (BURSTWRITE == 1'b1 && LineAddr < 255)
                        begin
                            LineAddr = LineAddr + 1;
                        end
                        if (cnt>0)
                        begin
                            cnt = cnt -1;
                        end
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1; //Program Status Bit - fail
                        Status_reg[3] = 1'b1; //Write to Buff Abort
                    end
                    LCNT <= cnt;
                end
                Check_wr_freq   = 1'b1;
            end

            WB_CONFIRM:
            begin
                return_state = READ;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (DataLo == 16'h29))
                    begin
                        //Program Buffer To Flash (confirm) Command
                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;
                        Status_reg[7] = 0;
                        Status_reg[4] = 0;
                        PR_FLAG = 0;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1;
                        Status_reg[3] = 1'b1;
                    end
                end
                Check_wr_freq = 0;
            end

            PG1:
            begin
                if (falling_edge_write)
                begin
                    if (BURSTWRITE == 1'b0)
                    begin
                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;
                        Status_reg[7] = 0;
                        Status_reg[4] = 0;
                        Status_reg[1] = 0;
                        PR_FLAG = 0;
                        PCNT = 256;
                        WBData[0] = -1;
                        if (~Viol)
                            WBData[0] = Data;
                        WBAddr[0] = LineAddr;
                        WBLine = WLine;
                        SA_PGM = SecAddr;
                        WBAddr[1] = -1;
                    end
                    else
                    begin
                        WBLine = WLine;
                        SA_PGM = SecAddr;

                        WBData[cnt] = -1;
                        if (~Viol)
                            WBData[cnt] = Data;
                        WBAddr[cnt] = LineAddr;

                        if (LineAddr < 255)
                            LineAddr = LineAddr + 1;

                        if (cnt < 255) 
                            cnt = cnt +1;

                        if (CSNeg)
                        begin
                            PSTART = 1'b1;
                            PSTART <= #1 1'b0;
                            Status_reg[7] = 0;
                            Status_reg[4] = 0;
                            Status_reg[1] = 0;
                            PR_FLAG = 0;
                            PCNT = cnt;
                        end
                    end
                end
            end

            PG:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    // Status register read enter
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (DataLo==16'h51)
                        START_T1_in = 1;
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end

                if (falling_edge_PDONE)
                begin
                    if (~PR_FLAG)
                    begin
                        PR_FLAG = 1;
                        if (PCNT < 256)   //buffer
                        begin
                            wr_cnt = PCNT;
                        end
                        else   //Word program
                        begin
                            wr_cnt = 0;
                        end
                        for (i=wr_cnt-1;i>=0;i=i-1)
                        begin
                            new_int= WBData[i];
                            if (corrupt_flags[SA_PGM] == 1'b1)
                            begin
                                old_int = -1;
                            end
                            else
                            begin
                                old_int = Mem[SA_PGM*(SecSize+1)
                                + WBLine*(WrBuffLength+1)+ WBAddr[i]];
                            end

                            if (new_int>-1)
                            begin
                                new_bit = new_int;

                                if (old_int>-1)
                                begin
                                    old_bit = old_int;
                                    for(j=0;j<=15;j=j+1)
                                        if (~old_bit[j])
                                            new_bit[j]=1'b0;
                                end
                                else
                                begin
                                    new_bit[0] = 1'bx;
                                end

                                if( new_bit[0] !== 1'bx )
                                begin
                                    new_int=new_bit;
                                    WBData[i]= new_int;
                                end
                            end
                            else
                                WBData[i]= -1;
                        end

                        for (i=wr_cnt-1;i>=0;i=i-1)
                        begin
                            Mem[SA_PGM*(SecSize+1)+
                            WBLine*(WrBuffLength+1)+WBAddr[i]] = -1;
                        end
                        corrupt_lines[SA_PGM][WBLine] = 1'b1;
                    end
                end
                if (rising_edge_PDONE)
                begin
                    for (i=wr_cnt;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1 && WBData[i] > -1)
                        begin
                            Mem[SA_PGM*(SecSize+1)+
                            WBLine*(WrBuffLength+1)+WBAddr[i]] =
                            WBData[i];
                        end
                        WBData[i]= -1;
                    end
                    Status_reg[7] = 1'b1;
                    corrupt_lines[SA_PGM][WBLine] = 1'b0;
                end
                if (falling_edge_PERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[4] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end

            PSR:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
                if (rising_edge_sSTART_T1)
                begin
                    PSUSP   = 1;
                    Status_reg[7] = 1;
                    Status_reg[2] = 1;
                    START_T1_in = 0;
                end
                if (rising_edge_PDONE)
                begin
                    for (i=wr_cnt-1;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1 && WBData[i] > -1)
                        begin
                            Mem[SA_PGM*(SecSize+1)+
                            WBLine*(WrBuffLength+1)+WBAddr[i]] =
                            WBData[i];
                        end
                        WBData[i]= -1;
                    end
                    Status_reg[7] = 1'b1;
                    corrupt_lines[SA_PGM][WBLine] = 1'b0;
                end
            end

            PS:
            begin
                CFI_ACT = 1'b0;
                return_state = PS;
                if(falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'h71)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                    else if (DataLo==16'h50)
                    begin
                        //resume program
                        Status_reg[2] = 1'b0;
                        Status_reg[7] = 1'b0;
                        PRES = 1'b1;
                        PRES <= #1 1'b0;
                        PSUSP   = 1'b0;
                    end
                    else if (Addr==16'h55 && DataLo==16'h98)
                    begin
                        CFI_ACT = 1'b1;
                        SA_CFI = SecAddr;
                    end
                end
            end

            PSUL1:
            begin
                if (falling_edge_write && A_PAT_1 && DataLo == 16'h70 &&
                    STAT_ACT == 1'b0)
                begin
                    //Status Register Enter Command
                    STAT_ACT   = 1'b1;
                    FIRST_WORD = 1'b1;
                end
            end

            PSUL2:
            begin
                CFI_ACT = 1'b0;
                return_state = PS;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (DataLo==16'h50)
                    begin
                        // resume programming
                        PRES = 1'b1;
                        PRES <= #1 1'b0;
                        Status_reg[2] = 0;
                        Status_reg[7] = 0;
                        PSUSP = 0;
                    end
                    else if (A_PAT_1 && DataLo==16'h90)
                    begin
                        // CFI Entry
                        CFI_ACT = 1'b1;
                        SA_CFI  = SecAddr;
                    end
                    else if ((A_PAT_1 && DataLo==16'hA0) || (DataLo==16'h25))
                        // Word or Buffer Program attempt in program suspend 
                        // will cause program failure
                        Status_reg[4] = 1'b1;
                    else if (A_PAT_1 && DataLo==16'h80)
                        // Erase attempt while in program suspend will cause
                        // Erase failure
                        Status_reg[5] = 1'b1;
                    else if (A_PAT_1 && DataLo==16'h88)
                        SA_SSR  = SecAddr;
                    else if (A_PAT_1 && DataLo==16'hC6 && ~CR_ACT)
                    begin
                        CR_ACT = 1'b1;
                        NVCR_ACT = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'hC7 && ~CR_ACT)
                    begin
                        CR_ACT = 1'b1;
                        NVCR_ACT = 1'b0;
                    end
                    else if (A_PAT_1 && DataLo==16'hC4 && ~INT_CR_ACT)
                        INT_CR_ACT = 1'b1;
                    else if (A_PAT_1 && DataLo==16'hC5 && ~INT_SR_ACT)
                        INT_SR_ACT = 1'b1;
                    else if (A_PAT_1 && DataLo==16'h3C)
                        POR_TR_ACT = 1'b1;
                    else if (DataLo==16'hB9)
                    begin
                       // DPD Entry
                       DPD_in = 1'b1;
//                        DPD_in <= #1 1'b0;
                    end
                end
            end

            PGE, PGEUL1, PGEUL2:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
            end

            LR:
            begin
                ASPR_ACT = 1'b1;
                MEM_ACT  = 1'b0;
                Status_reg[7] = 1'b1;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
            end

            LRPG1:
            begin
                if (falling_edge_write)
                begin
                    if (!((Data[2]==0 && Data[1]==0)  ||
                     ASPR_reg[2]==0  ||
                     ASPR_reg[1]==0 ||
                    (ASPR_reg[5]==0 && Data[1]==0)))
                    begin
                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;
                        Status_reg[7] = 1'b0;
                        PCNT  = 256;
                        WBData[0] = -1;
                        if (~Viol)
                            WBData[0] = Data;
                        WBAddr[0] = 0; // Addr don't care XXX
                        PR_FLAG = 0;
                        WBAddr[1] = -1;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1;
                        Status_reg[1] = 1'b1;
                    end
                end
            end

            LRPG:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end

                if (falling_edge_PDONE)
                begin
                    if (~PR_FLAG)
                    begin
                        PR_FLAG = 1;
                        wr_cnt = 0;

                        for (i=wr_cnt-1;i>=0;i=i-1)
                        begin
                            new_int= WBData[i];
                            old_bit=ASPR_reg[15:0];

                            if (new_int>-1)
                            begin
                                new_bit = new_int;
                                if (old_bit[0] !== 1'bx)
                                begin
                                    for(j=0;j<=15;j=j+1)
                                        if (~old_bit[j])
                                            new_bit[j]=1'b0;
                                end
                                else
                                begin
                                    new_bit[0] = 1'bx;
                                end
                                if( new_bit[0] !== 1'bx )
                                begin
                                    new_int=new_bit;
                                    WBData[i]= new_int;
                                end
                                else
                                    WBData[i]= -1;
                            end
                            else
                                WBData[i]= -1;
                        end
                    end
                end
                if (rising_edge_PDONE)
                begin
                    for (i=wr_cnt;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1 && WBData[i] > -1)
                        begin
                            ASPR_reg[15:0] = WBData[i];
                        end
                        WBData[i]= -1;
                    end
                    Status_reg[7] = 1'b1;
                end
                if (falling_edge_PERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[4] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end

            LREXT:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
            end

            CFI:
            begin
                if(falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if ((A_PAT_1 && DataLo==16'h71) ||  Data==16'h00F0 ||
                    Data==16'h00FF)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
            end

            SSR:
            begin
                OTP_ACT = 1;
                MEM_ACT = 0;
                cnt = 0;
                ssr_prot = 1;
                secsi_ssr_prot = 1;
                ssr_region_prot[15 : 0] = SSR_reg[8];
                ssr_region_prot[31: 16] = SSR_reg[9];
                Status_reg[7] = 1'b1;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if ((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
            end

            SSRUL1:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
            end

            SSRUL2:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (DataLo==16'hB9)
                    begin
                       // DPD Entry
                       DPD_in = 1'b1;
                    end
                    if ((DataLo == 16'h25) || (A_PAT_1 && DataLo==16'hA0))
                    begin
                        Status_reg[4] = 1'b0;
                        Status_reg[1] = 1'b0;
                        if (DataLo == 16'h25)
                            SA_PGM = SecAddr;
                    end
                end
            end

            SSRPG1:
            begin
                if (falling_edge_write)
                begin
                    if (BURSTWRITE==0)
                    begin
                        PSTART = 1'b1;
                        PSTART <= #1 1'b0;
                        Status_reg[7] = 0;
                        Status_reg[4] = 0;
                        Status_reg[1] = 0;
                        PR_FLAG = 0;
                        PCNT = 256;
                        WBData[0] = -1;
                        if (~Viol)
                            WBData[0] = Data;
                        WBAddr[0] = LineAddr;
                        WBAddr[1] = -1;
                        ssr_buff_part = SecSiAddr / 256;
                        // attempt to program in SSR protected region
                        if (ssr_region_prot[SecSiAddr / 16] == 0)
                            ssr_prot = 0;
                        if (SecSiAddr / 16 == 0)
                            secsi_ssr_prot = 0;
                    end
                    else
                    begin
                        ssr_buff_part = SecSiAddr / 256;
                        WBData[cnt] = -1;
                        if (~Viol)
                            WBData[cnt] = Data;
                        WBAddr[cnt] = LineAddr;

                        if (LineAddr < 255)
                            LineAddr = LineAddr + 1;

                        if (cnt < 255)
                            cnt = cnt +1;

                        if (ssr_region_prot[SecSiAddr / 16] == 0)
                            ssr_prot = 0;
                        if (SecSiAddr / 16 == 0)
                            secsi_ssr_prot = 0;

                        if (CSNeg)
                        begin
                            PSTART = 1'b1;
                            PSTART <= #1 1'b0;
                            Status_reg[7] = 0;
                            Status_reg[4] = 0;
                            Status_reg[1] = 0;
                            PR_FLAG = 0;
                            PCNT = cnt;
                        end
                    end
                end
            end

            SSR_WB:
            begin
                return_state = SSR;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (D_tmp <= WrBuffLength))
                    begin
                        //The system writes the number of word locations - 1
                        cnt = D_tmp;
                        PCNT = cnt;
                        LCNT = cnt;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1; //Program Status Bit - fail
                        Status_reg[3] = 1'b1; //Write to Buff Abort
                    end
                end
            end

            SSR_WB_D:
            begin
                return_state = SSR;
                if (falling_edge_write)
                begin
                    if(SecAddr == SA_PGM)
                    begin
                        //The starting address/data combination is written
                        WBData[cnt] = -1;
                        if (~Viol)
                        begin
                            WBData[cnt] = Data;
                        end
                        WBAddr[cnt] = LineAddr;

                        if (BURSTWRITE == 1'b1 && LineAddr < 255)
                        begin
                            LineAddr = LineAddr + 1;
                        end

                        if (cnt>0)
                        begin
                            cnt = cnt -1;
                        end
                        //The write-buffer-Line address is selected
                        WBLine = WLine;
                        ssr_buff_part = SecSiAddr / 256;
                        if (ssr_region_prot[SecSiAddr / 16] == 0)
                            ssr_prot = 0;
                        if (SecSiAddr / 16 == 0)
                            secsi_ssr_prot = 0;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1; //Program Status Bit - fail
                        Status_reg[3] = 1'b1; //Write to Buff Abort
                    end
                    LCNT <= cnt;
                end
            end

            SSR_WB_LOAD:
            begin
                return_state = SSR;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (WLine == WBLine))
                    begin
                        WBData[cnt] = -1;
                        if (~Viol)
                        begin
                            WBData[cnt] = Data;
                        end
                        WBAddr[cnt] = LineAddr;

                        if (BURSTWRITE == 1'b1 && LineAddr < 255)
                        begin
                            LineAddr = LineAddr + 1;
                        end
                        if (cnt>0)
                            cnt = cnt -1;

                        if (ssr_region_prot[SecSiAddr / 16] == 0)
                            ssr_prot = 0;
                        if (SecSiAddr / 16 == 0)
                            secsi_ssr_prot = 0;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1; //Program Status Bit - fail
                        Status_reg[3] = 1'b1; //Write to Buff Abort
                    end
                    LCNT <= cnt;
                end
                Check_wr_freq = 1'b1;
            end

            SSR_WB_CONFIRM:
            begin
                return_state = SSR;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PGM) && (DataLo == 16'h29))
                    begin
                        //Program Buffer To Flash (confirm) Command
                        if (Status_reg[4] == 0)
                        begin
                            PSTART = 1'b1;
                            PSTART <= #1 1'b0;
                            Status_reg[7] = 0;
                            Status_reg[4] = 0;
                            Status_reg[1] = 0;
                            PR_FLAG = 0;
                        end
                        else
                            PR_FLAG = 1;
                    end
                    else
                    begin
                        Status_reg[4] = 1'b1;
                        Status_reg[3] = 1'b1;
                    end
                end
            end

            SSRPG:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    // Status register read enter
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if ((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
                
                if (falling_edge_PDONE)
                begin
                    if (~PR_FLAG)
                    begin
                        PR_FLAG = 1;
                        if (PCNT < 256)   //buffer
                        begin
                            wr_cnt = PCNT;
                        end
                        else   //Word program
                        begin
                            wr_cnt = 0;
                        end
                        for (i=wr_cnt;i>=0;i=i-1)
                        begin
                            new_int= WBData[i];
                            old_int = SSR_reg[ssr_buff_part*256 + WBAddr[i]];

                            if (new_int>-1)
                            begin
                                new_bit = new_int;

                                if (old_int>-1)
                                begin
                                    old_bit = old_int;
                                    for(j=0;j<=15;j=j+1)
                                        if (~old_bit[j])
                                            new_bit[j]=1'b0;
                                end
                                else
                                begin
                                    new_bit[0] = 1'bx;
                                end

                                if( new_bit[0] !== 1'bx )
                                begin
                                    new_int=new_bit;
                                    WBData[i]= new_int;
                                end
                            end
                            else
                                WBData[i]= -1;
                        end

                        for (i=wr_cnt;i>=0;i=i-1)
                        begin
                            SSR_reg[ssr_buff_part*256 + WBAddr[i]] = -1;
                        end
                    end
                end

                if (rising_edge_PDONE)
                begin
                    for (i=wr_cnt;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1 && WBData[i] > -1)
                        begin
                            SSR_reg[ssr_buff_part*256+WBAddr[i]] =
                            WBData[i];
                        end
                        WBData[i]= -1;
                    end
                    Status_reg[7] = 1'b1;
                end
                if (falling_edge_PERR)
                begin
                    Status_reg[7] = 1'b1;
                    Status_reg[4] = 1'b1;
                    Status_reg[1] = 1'b1;
                end
            end

            SSREXT:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    // Status register read enter
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if ((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
            end

            PP:
            begin
                MEM_ACT = 1'b0;
                PWD_ACT = 1'b1;
                Status_reg[7] = 1'b1;
                return_state = PP;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                     && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                    else if (DataLo==16'hA0 && ASPR_reg[2]==0)
                    begin
                        Status_reg[4] = 1'b1;
                        Status_reg[1] = 1'b1;
                    end
                end
            end

            PPWB25:
            begin
                return_state = PP;
                if (falling_edge_write)
                    if (Data==16'h0003 && (Addr % 2048 == 0))
                    begin
                        cnt = Data + 1; // Data contains Word count
                        LCNT = cnt;
                        SA_PASSUnlock = SecAddr;
                        WB_PASSUnlock = WLine;
                    end
                PassMATCH = 4'b0000;
            end

            PPD:
            begin
                return_state = PP;
                if (falling_edge_write)
                begin
                    if ((SecAddr == SA_PASSUnlock) &&
                    (WLine == WB_PASSUnlock) && (LineAddr/4 == 0) )
                    begin
                        if (cnt>0)
                            cnt = cnt -1;
                        PassAddr = LineAddr % 4;
                        PassMATCH[PassAddr] =
                        (Password[PassAddr] == Data);
                        LCNT <= cnt;
                    end
                end
            end

            PPV:
            begin
                return_state = PP;
                if (falling_edge_write)
                    if (Addr==0 && DataLo==16'h29 && LCNT==0)
                    begin
                        UNLOCKDONE_in = 1'b0;
                        UNLOCKDONE_in <= #1 1'b1;
                        Status_reg[7] = 1'b0;
                        Status_reg[4] = 1'b0;
                        Status_reg[1] = 1'b0;
                    end
            end

            PASSUNLOCK:
            begin
                return_state = PP;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end

                if(rising_edge_UNLOCKDONE_out)
                begin
                    PPBLock = 1;
                    UNLOCKDONE_in = 0;
                    Status_reg[7]   = 1'b1;
                end
            end

            PPH:
            begin
                return_state = PP;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                     && UNLOCKDONE_out && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                        Status_reg[7]   = 1'b1;
                    end
                end

                if(rising_edge_UNLOCKDONE_out)
                begin
                    Status_reg[7]   = 1'b1;
                    Status_reg[4]   = 1'b1;
                    Status_reg[1]   = 1'b1;
                    UNLOCKDONE_in   = 0;
                end
            end

            PPPG1:
            begin
                PP_pg = 1'b1;
                if(falling_edge_write)
                begin
                    PSTART = 1'b1;
                    PSTART <= #1 1'b0;
                    Status_reg[7] = 0;
                    PCNT = 256;
                    WBData[0] = -1;
                    if (~Viol)
                        WBData[0] = Data;

                    WBAddr[0] = Addr % 4;
                    PR_FLAG = 0;
                end
            end

            PPPG:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end

                if (falling_edge_PDONE)
                begin
                    if (~PR_FLAG)
                    begin
                        PR_FLAG = 1;
                        wr_cnt = 0;
                        for (i=wr_cnt;i>=0;i=i-1)
                        begin
                            new_int= WBData[i];
                            old_bit=Password[WBAddr[i]];
                            if (new_int>-1)
                            begin
                                new_bit = new_int;
                                if (old_bit[0]!==1'bx)
                                begin
                                    for (j=0;j<=15;j=j+1)
                                        if (~old_bit[j])
                                            new_bit[j]=1'b0;
                                end
                                else
                                begin
                                    new_bit[0] = 1'bx;
                                end
                                if( new_bit[0] !== 1'bx )
                                begin
                                    new_int=new_bit;
                                    WBData[i]= new_int;
                                end
                                else
                                    WBData[i]= -1;
                            end
                            else
                                WBData[i]= -1;
                        end

                        for (i=wr_cnt;i>=0;i=i-1)
                        begin
                            Password[WBAddr[i]] = 16'bx;
                        end
                    end
                end

                if (rising_edge_PDONE)
                begin
                    Status_reg[7] = 1;
                    for (i=wr_cnt;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1 && WBData[i] > -1)
                        begin
                            Password[WBAddr[i]] =WBData[i];
                        end
                        WBData[i]= -1;
                    end
                end
                if(falling_edge_PERR)
                begin
                    Status_reg[7]   = 1'b1;
                    Status_reg[4]   = 1'b1;
                    Status_reg[1]   = 1'b1;
                end
            end

            PPEXT:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                     && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
            end

            PPB:
            begin
                MEM_ACT = 1'b0;
                Status_reg[7] = 1'b1;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                     && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                    else if  (DataLo==16'h60 && SA_PROT_ACT==1'b0)
                    begin
                        SA_PROT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
            end

            PPBPG1:
            begin
                PPB_pg = 1'b1;
                if (falling_edge_write)
                begin
                    if (Data==16'h00)
                    begin
                        if (PPBLock == 1'b1)
                        begin
                            Status_reg[7] = 1'b0;
                            Status_reg[4] = 1'b0;
                            Status_reg[1] = 1'b0;
                            SA_PGM = SecAddr;
                            PSTART = 1'b1;
                            PSTART <= #1 1'b0;
                            WBAddr[0] = 0; // Addr don't care XXX
                            WBData[0] = -1;
                            PR_FLAG = 0;
                            if(~Viol)
                                WBData[0] = Data;
                        end
                        else
                        begin
                            Status_reg[4] = 1'b1;
                            PR_FLAG = 1;
                        end
                    end
                end
            end

            PPBPG:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end

                if (falling_edge_PDONE)
                begin
                    if (~PR_FLAG)
                    begin
                        PR_FLAG = 1;
                        wr_cnt = 0;
                        for (i=wr_cnt;i>=0;i=i-1)
                        begin
                            new_int= WBData[i];
                            old_bit[0]=PPB_Prot[SA_PGM];

                            if (new_int>-1)
                            begin
                                new_bit = new_int;
                                if (old_bit[0]==1'b0)
                                    new_bit[0] = 1'b0;
                                new_bit[15:1] = 15'b0;
                                if( new_bit[0] !== 1'bx )
                                begin
                                    new_int=new_bit;
                                    WBData[i]= new_int;
                                end
                                else
                                    WBData[i]= -1;
                            end
                            else
                                WBData[i]= -1;
                        end
                    end
                end
                if (rising_edge_PDONE)
                begin
                    for (i=wr_cnt;i>=0;i=i-1)
                    begin
                        if (WBAddr[i]> -1 && WBData[i] > -1)
                        begin
                            if (PPBLock)
                                PPB_Prot[SA_PGM] = WBData[i];
                        end
                        WBData[i]= -1;
                    end
                    Status_reg[7] = 1'b1;
                end
                if(falling_edge_PERR)
                begin
                    Status_reg[7]   = 1'b1;
                    Status_reg[4]   = 1'b1;
                    Status_reg[1]   = 1'b1;
                end
            end

            PPBER1:
            begin
                PPB_ers = 1'b1;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (Addr==16'h00 && DataLo==16'h30)
                    begin
                        if (PPBLock == 1'b1)
                        begin
                            Status_reg[7] = 0;
                            Status_reg[5] = 1'b0;
                            Status_reg[1] = 1'b0;
                            ESTART = 1'b1;
                            ESTART = #1 1'b0;
                            SA_ERS = SecAddr;
                            ER_FLAG = 0;
                        end
                        else
                        begin
                            Status_reg[5] = 1'b1;
                            ER_FLAG = 1;
                        end
                    end
                end
            end

            PPBER:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                    &&  Status_reg[7]==1'b1)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end

                if (falling_edge_EDONE)
                begin
                    if (~ER_FLAG)
                    begin
                        ER_FLAG = 1;
                        for (i=0;i<=SecNum;i=i+1)
                        begin
                            if (PPBLock)
                                PPB_Prot[i] = 1'bx;
                        end
                    end
                end
                if (rising_edge_EDONE)
                begin
                    for (i=0;i<=SecNum;i=i+1)
                        PPB_Prot[i] = 1'b1;
                    Status_reg[7] = 1;
                end
                if(falling_edge_EERR)
                begin
                    Status_reg[7]   = 1'b1;
                    Status_reg[5]   = 1'b1;
                    Status_reg[1]   = 1'b1;
                end
            end

            PPBEXT:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                     && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
            end

            PPBLB, PPBLBEXT:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                     && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
            end

            PPBLBSET:
            begin
                if (falling_edge_write)
                begin
                    if (DataLo==16'h00)
                        PPBLock = 1'b0;
                    else
                        $display("PPB Lock bit not cleared,data is not 00h");
                end
            end

            DYB:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                     && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                    else if (DataLo==16'h60 && SA_PROT_ACT==1'b0)
                    begin
                        SA_PROT_ACT = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
            end

            DYBSET:
            begin
                if (falling_edge_write)
                begin
                    if(DataLo == 16'h00)
                        DYB_Prot[SecAddr] = 0;
                    else if (DataLo == 16'h01)
                        DYB_Prot[SecAddr] = 1;
                end
            end

            DYBEXT:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                     && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                end
            end

            CRC:
            begin
                CRC_ACT = 1'b1;
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (((A_PAT_1 && DataLo==16'h71) || DataLo==16'hF0)
                     && STAT_ACT==1'b0)
                    begin
                        //Status Register Clear Command
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                    else if (DataLo==16'h60)
                        CRC_RD_SETUP = 1'b1;
                    else if (DataLo==16'hC3)
                        CRC_Start_Addr_reg = Address;
                    else if (DataLo==16'h3C)
                    begin
                        CRC_End_Addr_reg = Address;
                        if (CRC_End_Addr_reg >= CRC_Start_Addr_reg + 2)
                        begin
                            CRCSTART = 1'b1;
                            CRCSTART <= #1 1'b0;
                            Status_reg[7]  = 1'b0;
                            Status_reg[3]  = 1'b0;
                            Check_Val_Lo_reg = 16'h0;
                            Check_Val_Hi_reg = 16'h0;
                            crc_data_num=CRC_End_Addr_reg-CRC_Start_Addr_reg;
                        end
                        else
                        begin
                            // Abort CRC calculation
                            Status_reg[3]  = 1'b1;
                            $display("CRC EndAddr is not StartAddr+2 ");
                            $display("or greater; CRC calculation is aborted");
                        end
                    end
                end
            end

            CRC_Calc:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (DataLo==16'hC0)
                        START_T1_in = 1'b1;
                end

                if (rising_edge_CRCDONE)
                begin
                    CRC_calc_out = 32'h0;
                    for(i=CRC_Start_Addr_reg;i<=CRC_End_Addr_reg;i=i+1)
                    begin
                        for(j=15;j>=0;j=j-1)
                        begin
                            CRC_calc_in = Mem[i][j];
                            CRC_calc_tmp = CRC_calc_out[31] ^ CRC_calc_in;

                            CRC_calc_out[31] = CRC_calc_out[30];
                            CRC_calc_out[30] = CRC_calc_out[29];
                            CRC_calc_out[29] = CRC_calc_out[28];
                            CRC_calc_out[28] = CRC_calc_out[27] ^ CRC_calc_tmp;
                            CRC_calc_out[27] = CRC_calc_out[26] ^ CRC_calc_tmp;
                            CRC_calc_out[26] = CRC_calc_out[25] ^ CRC_calc_tmp;
                            CRC_calc_out[25] = CRC_calc_out[24] ^ CRC_calc_tmp;
                            CRC_calc_out[24] = CRC_calc_out[23];
                            CRC_calc_out[23] = CRC_calc_out[22] ^ CRC_calc_tmp;
                            CRC_calc_out[22] = CRC_calc_out[21] ^ CRC_calc_tmp;
                            CRC_calc_out[21] = CRC_calc_out[20];
                            CRC_calc_out[20] = CRC_calc_out[19] ^ CRC_calc_tmp;
                            CRC_calc_out[19] = CRC_calc_out[18] ^ CRC_calc_tmp;
                            CRC_calc_out[18] = CRC_calc_out[17] ^ CRC_calc_tmp;
                            CRC_calc_out[17] = CRC_calc_out[16];
                            CRC_calc_out[16] = CRC_calc_out[15];
                            CRC_calc_out[15] = CRC_calc_out[14];
                            CRC_calc_out[14] = CRC_calc_out[13] ^ CRC_calc_tmp;
                            CRC_calc_out[13] = CRC_calc_out[12] ^ CRC_calc_tmp;
                            CRC_calc_out[12] = CRC_calc_out[11];
                            CRC_calc_out[11] = CRC_calc_out[10] ^ CRC_calc_tmp;
                            CRC_calc_out[10] = CRC_calc_out[9] ^ CRC_calc_tmp;
                            CRC_calc_out[9] = CRC_calc_out[8] ^ CRC_calc_tmp;
                            CRC_calc_out[8] = CRC_calc_out[7] ^ CRC_calc_tmp;
                            CRC_calc_out[7] = CRC_calc_out[6];
                            CRC_calc_out[6] = CRC_calc_out[5] ^ CRC_calc_tmp;
                            CRC_calc_out[5] = CRC_calc_out[4];
                            CRC_calc_out[4] = CRC_calc_out[3];
                            CRC_calc_out[3] = CRC_calc_out[2];
                            CRC_calc_out[2] = CRC_calc_out[1];
                            CRC_calc_out[1] = CRC_calc_out[0];
                            CRC_calc_out[0] =  CRC_calc_tmp;
                        end
                    end

                    Check_Val_Lo_reg = CRC_calc_out[15:0];
                    Check_Val_Hi_reg = CRC_calc_out[31:16];
                    Status_reg[7] = 1'b1;
                end
            end

            CRCT:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo == 16'h70 && STAT_ACT == 1'b0)
                    begin
                        //Status Register Enter Command
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end

                if (rising_edge_sSTART_T1)
                begin
                    CRCSUSP = 1'b1;
                    START_T1_in = 1'b0;
                    Status_reg[7] = 1'b1;
                    Status_reg[8] = 1'b1;
                end

                if (rising_edge_CRCDONE)
                begin
                    CRC_calc_out = 32'h0;
                    for(i=CRC_Start_Addr_reg;i<=CRC_End_Addr_reg;i=i+1)
                    begin
                        for(j=15;j>=0;j=j-1)
                        begin
                            CRC_calc_in = Mem[i][j];
                            CRC_calc_tmp = CRC_calc_out[31] ^ CRC_calc_in;

                            CRC_calc_out[31] = CRC_calc_out[30];
                            CRC_calc_out[30] = CRC_calc_out[29];
                            CRC_calc_out[29] = CRC_calc_out[28];
                            CRC_calc_out[28] = CRC_calc_out[27] ^ CRC_calc_tmp;
                            CRC_calc_out[27] = CRC_calc_out[26] ^ CRC_calc_tmp;
                            CRC_calc_out[26] = CRC_calc_out[25] ^ CRC_calc_tmp;
                            CRC_calc_out[25] = CRC_calc_out[24] ^ CRC_calc_tmp;
                            CRC_calc_out[24] = CRC_calc_out[23];
                            CRC_calc_out[23] = CRC_calc_out[22] ^ CRC_calc_tmp;
                            CRC_calc_out[22] = CRC_calc_out[21] ^ CRC_calc_tmp;
                            CRC_calc_out[21] = CRC_calc_out[20];
                            CRC_calc_out[20] = CRC_calc_out[19] ^ CRC_calc_tmp;
                            CRC_calc_out[19] = CRC_calc_out[18] ^ CRC_calc_tmp;
                            CRC_calc_out[18] = CRC_calc_out[17] ^ CRC_calc_tmp;
                            CRC_calc_out[17] = CRC_calc_out[16];
                            CRC_calc_out[16] = CRC_calc_out[15];
                            CRC_calc_out[15] = CRC_calc_out[14];
                            CRC_calc_out[14] = CRC_calc_out[13] ^ CRC_calc_tmp;
                            CRC_calc_out[13] = CRC_calc_out[12] ^ CRC_calc_tmp;
                            CRC_calc_out[12] = CRC_calc_out[11];
                            CRC_calc_out[11] = CRC_calc_out[10] ^ CRC_calc_tmp;
                            CRC_calc_out[10] = CRC_calc_out[9] ^ CRC_calc_tmp;
                            CRC_calc_out[9] = CRC_calc_out[8] ^ CRC_calc_tmp;
                            CRC_calc_out[8] = CRC_calc_out[7] ^ CRC_calc_tmp;
                            CRC_calc_out[7] = CRC_calc_out[6];
                            CRC_calc_out[6] = CRC_calc_out[5] ^ CRC_calc_tmp;
                            CRC_calc_out[5] = CRC_calc_out[4];
                            CRC_calc_out[4] = CRC_calc_out[3];
                            CRC_calc_out[3] = CRC_calc_out[2];
                            CRC_calc_out[2] = CRC_calc_out[1];
                            CRC_calc_out[1] = CRC_calc_out[0];
                            CRC_calc_out[0] = CRC_calc_tmp;
                        end
                    end

                    Check_Val_Lo_reg = CRC_calc_out[15:0];
                    Check_Val_Hi_reg = CRC_calc_out[31:16];
                    Status_reg[7] = 1'b1;
                end
            end

            CRCS:
            begin
                MEM_ACT = 1'b1;
                if(falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                    else if (A_PAT_1 && DataLo==16'h71)
                    begin
                        Status_reg[5:3] = 3'b000;
                        Status_reg[1:0] = 2'b00;
                    end
                    else if (DataLo==16'hC1)
                    begin
                        //resume program
                        Status_reg[8] = 1'b0;
                        Status_reg[7] = 1'b0;
                        CRCRES = 1'b1;
                        CRCRES <= #1 1'b0;
                        CRCSUSP   = 1'b0;
                    end
                end
            end

            ECC:
            begin
                ECC_ACT = 1'b1;
                ECCR_ACT = 1'b0;
            end

            ECCR:
            begin
                ECC_ACT = 1'b0;
                ECCR_ACT = 1'b1;
            end

            DPD, ESDPD, ESPSDPD, PSDPD, DPDS:
            begin
                if (rising_edge_DPD_out)
                    DPD_in = 1'b0;
            end

            MTS:
            begin
                if (falling_edge_write)
                begin
                    if (A_PAT_1 && DataLo==16'h70 && STAT_ACT==1'b0)
                    begin
                        STAT_ACT   = 1'b1;
                        FIRST_WORD = 1'b1;
                    end
                end
                if (rising_edge_MTS_out)
                    Status_reg[7] =  1'b1;
            end

        endcase
        end

        if (ASPR_reg[2]==0 && ASPR_reg[5]==0 && PPBLock==0)
            READ_PROTECT = 1'b1;
        else
            READ_PROTECT = 1'b0;

        if (rising_edge_status_7)
        begin
            INT_SR_reg[4] = 1'b0;
            if (INT_CR_reg[4]==1'b0 && INT_CR_reg[15]==1'b0 &&
            FIDR_reg[4]==1'b1 && FIDR_reg[15]==1'b1)
                INTNeg_zd = 1'b0;
        end

        if (INT_CR_reg[4]==1'b1 || INT_CR_reg[15]==1'b1 ||
        FIDR_reg[4]==1'b0 || FIDR_reg[15]==1'b0)
        begin
           INT_SR_reg[4] = 1'b1;
           INTNeg_zd = 1'b1;
        end

    end //functionality

    ///////////////////////////////////////////////////////////////////////////
    // Select Read Target
    ///////////////////////////////////////////////////////////////////////////
    // Burst variables
    integer BurstAddr;
    integer BurstSec;
    integer BurstLine;
    integer WS_Boundary_cnt;
    integer init_lat;

    always @(posedge change_addr)
    begin : RD_parameters

        BurstAddr = WPage*(PageSize+1) + PageAddr;
        BurstSec  = SecAddr;
        if (READ_PROTECT)
            if (VCR_Config_reg[8] == 0)
                BurstSec = 0;
            else
                BurstSec = SecNum;
        else
            BurstSec  = SecAddr;

        BurstLine = WLine;
        init_lat  = VCR_Config_reg[7:4]+5;

        if ((init_lat + (PageAddr % 8)) > 16)
            WS_Boundary_cnt = (init_lat + PageAddr) % 8;
        else
            WS_Boundary_cnt = 0;

        if (CFI_ACT && ~STAT_ACT)
            ReadTarget = CFI_T;
        else if (STAT_ACT)
            ReadTarget = SR_T;
        else if (CR_ACT)
            ReadTarget = CR_T;
        else if (INT_CR_ACT)
            ReadTarget = INT_CR_T;
        else if (INT_SR_ACT)
            ReadTarget = INT_SR_T;
        else if (CRC_RD_SETUP)
            ReadTarget = CRC_T;
        else if (POR_TR_ACT)
            ReadTarget = POR_TR_T;
        else if (PWD_ACT)
            ReadTarget = PWD_T;
        else if (OTP_ACT && SecAddr==SA_SSR)
            ReadTarget = SSR_T;
        else if (ASPR_ACT)
            ReadTarget = ASPR_T;
        else if (DYB_ACT)
            ReadTarget = DYB_T;
        else if (PPB_ACT)
            ReadTarget = PPB_T;
        else if (PPBLB_ACT)
            ReadTarget = PPBLB_T;
        else if (FIDR_ACT)
            ReadTarget = FID_T;
        else if (ECC_ACT)
            ReadTarget = ECC_T;
        else if (ECCR_ACT)
            ReadTarget = ECCR_T;
        else if (SA_PROT_ACT)
            ReadTarget = SA_PROT_T;
        else
            ReadTarget = Mem_T;
    end

    reg ReadStart = 0;

    always @(rising_edge_CKDiff or falling_edge_CKDiff or falling_edge_CSNeg
            or rising_edge_IACC_out )
    begin : RD_Functional

        ///////////////////////////////////////////////////////////////////////
        // Read Functionality Section
        ///////////////////////////////////////////////////////////////////////

        if (~CSNeg_ipd && reseted && Latency_Clk)
        begin
            // Burst functionality
            case (RD_MODE)
            LINEAR:
            begin
                // linear mode
                if (rising_edge_CKDiff)
                begin
                    if (INIT_ACC_ELAPSED == 1 && IACC_out == 1)
                    begin 
                        if (BurstDelay == 0)
                        begin
                            if (BurstLength == 32)
                            begin
                                if ((RdPage == RdPageStart + 2) &&
                                     (WS_Boundary_cnt != 0))
                                    begin
                                        WS_Boundary_cnt = WS_Boundary_cnt - 1;
                                        RWDS_temp = 1'b0;
                                    end
                                else
                                begin
                                    READ_BURST_DATA(BurstAddr,BurstSec,
                                    BurstLine,ReadTarget);
                                    ReadStart = 1'b1;                              
                                    RWDS_temp = 1'b1;
                                    if (ReadTarget==Mem_T || ReadTarget==SSR_T
                                    || ReadTarget==CFI_T)
                                        DataDriveOut_Dout = DOut_burst[15:8];
                                    else
                                    begin
                                        if (FIRST_WORD_OUT)
                                            DataDriveOut_Dout = DOut_burst[15:8];
                                        else
                                            DataDriveOut_Dout = 8'bxxxxxxxx;
                                    end
                                end
                            end
                            else
                            begin
                                READ_BURST_DATA(BurstAddr,BurstSec,
                                BurstLine,ReadTarget);
                                ReadStart = 1'b1;  
                                RWDS_temp = 1'b1;
                                if (ReadTarget==Mem_T || ReadTarget==SSR_T
                                || ReadTarget==CFI_T)
                                    DataDriveOut_Dout = DOut_burst[15:8];
                                else
                                begin
                                    if (FIRST_WORD_OUT)
                                        DataDriveOut_Dout = DOut_burst[15:8];
                                    else
                                        DataDriveOut_Dout = 8'bxxxxxxxx;
                                end
                            end
                            wrong_rd_freq = 1'b0;
                        end
                    end
                    if (((BurstAddr % 8)==7) && (RdPage==RdPageStart+1)
                       && (IACC_out == 1))
                        RdPage = RdPage + 1;
                end
                else if (falling_edge_CKDiff)
                begin
                    if (BurstDelay > 0)
                    begin
                        BurstDelay = BurstDelay - 1;
                        if  (BurstDelay == 0)
                        begin
                            INIT_ACC_ELAPSED = 1;
                            FIRST_WORD_OUT = 1;
                        end
                        ReadStart = 1'b0;
                    end
                    else
                    begin
                        if (IACC_out == 1 && wrong_rd_freq != 1)
                        begin
                            if (BurstLength == 32)
                            begin
                                if (RdPage == RdPageStart + 2)
                                begin
                                    if (WS_Boundary_cnt == 0)
                                    begin
                                        NEXT_ADDR_LIN(BurstAddr,BurstLength);
                                        RdPageStart = RdPage;
                                    end
                                    RWDS_temp = 1'b0;
                                    DataDriveOut_Dout = DOut_burst[7:0];
                                end
                                else
                                begin
                                    if (ReadStart == 1'b0)
                                        ReadStart = 1'b1;
                                    else
                                    begin
                                        if (~((RdPage==RdPageStart+1) &&
                                        ((BurstAddr % 8)==7)))
                                            NEXT_ADDR_LIN(BurstAddr,BurstLength);
                                        RWDS_temp = 1'b0;
                                        if (ReadTarget==Mem_T || ReadTarget==SSR_T
                                        || ReadTarget==CFI_T)
                                            DataDriveOut_Dout = DOut_burst[7:0];
                                        else
                                        begin
                                            if (FIRST_WORD_OUT)
                                            begin
                                                DataDriveOut_Dout = DOut_burst[7:0];
                                                FIRST_WORD_OUT = 0;
                                            end
                                            else
                                                DataDriveOut_Dout = 8'bxxxxxxxx;
                                        end
                                    end
                                end
                            end
                            else
                            begin
                                if (ReadStart == 1'b0)
                                    ReadStart = 1'b1;
                                else
                                begin
                                    NEXT_ADDR_LIN(BurstAddr,BurstLength);
                                    RWDS_temp = 1'b0;
                                    if (ReadTarget==Mem_T || ReadTarget==SSR_T
                                    || ReadTarget==CFI_T)
                                        DataDriveOut_Dout = DOut_burst[7:0];
                                    else
                                    begin
                                        if (FIRST_WORD_OUT)
                                        begin
                                            DataDriveOut_Dout = DOut_burst[7:0];
                                            FIRST_WORD_OUT = 0;
                                        end
                                        else
                                            DataDriveOut_Dout = 8'bxxxxxxxx;
                                    end
                                end
                            end
                        end
                        else
                            $display("More wait states should be programmed");
                    end
                    if (((BurstAddr % 8) == 0) && (IACC_out == 1) &&
                        (RdPage != RdPageStart + 2))
                        RdPage = RdPage + 1;
                end
            end

            CONTINUOUS:
            begin
                // continuous mode
                if (rising_edge_CKDiff)
                begin
                    if (INIT_ACC_ELAPSED == 1 && IACC_out == 1)
                    begin
                        if (BurstDelay == 0)
                        begin
                            if (RdPage == RdPageStart + 2)
                            begin
                                if (WS_Boundary_cnt != 0)
                                begin
                                    WS_Boundary_cnt = WS_Boundary_cnt - 1;
                                    RWDS_temp = 1'b0;
                                end
                            end
                            else
                            begin
                                READ_BURST_DATA(BurstAddr,BurstSec,
                                BurstLine,ReadTarget);
                                ReadStart = 1'b1;  
                                if (ReadTarget==Mem_T || ReadTarget==SSR_T
                                || ReadTarget==CFI_T)
                                    DataDriveOut_Dout = DOut_burst[15:8];
                                else
                                begin
                                    if (FIRST_WORD_OUT)
                                        DataDriveOut_Dout = DOut_burst[15:8];
                                    else
                                        DataDriveOut_Dout = 8'bxxxxxxxx;
                                end
                                RWDS_temp = 1'b1;
                            end
                            wrong_rd_freq = 1'b0;
                        end
                    end
                    if (((BurstAddr % 8)==7) && (RdPage==RdPageStart+1)
                       && (IACC_out == 1) && (INIT_ACC_ELAPSED==1))
                        RdPage = RdPage + 1;
                end
                else if (falling_edge_CKDiff)
                begin
                    if (BurstDelay > 0)
                    begin
                        BurstDelay = BurstDelay - 1;
                        if  (BurstDelay == 0)
                        begin
                            INIT_ACC_ELAPSED = 1;
                            FIRST_WORD_OUT = 1;
                        end
                        ReadStart = 1'b0;
                    end
                    else
                    begin
                        if (IACC_out == 1 && wrong_rd_freq != 1)
                        begin
                            if (RdPage==RdPageStart + 2)
                            begin
                                if (WS_Boundary_cnt == 0)
                                begin
                                    NEXT_ADDR_CNT(BurstAddr,BurstSec);
                                    RdPageStart = RdPage;
                                end
                                RWDS_temp = 1'b0;
                                DataDriveOut_Dout = DOut_burst[7:0];

                            end
                            else
                            begin
                                if (ReadStart == 1'b0)
                                    ReadStart = 1'b1;
                                else
                                begin
                                    if (~((RdPage==RdPageStart+1) &&
                                    ((BurstAddr % 8)==7)))
                                        NEXT_ADDR_CNT(BurstAddr,BurstSec);
                                    RWDS_temp = 1'b0;
                                    if (ReadTarget==Mem_T || ReadTarget==SSR_T
                                    || ReadTarget==CFI_T)
                                        DataDriveOut_Dout = DOut_burst[7:0];
                                    else
                                    begin
                                        if (FIRST_WORD_OUT)
                                        begin
                                            DataDriveOut_Dout = DOut_burst[7:0];
                                            FIRST_WORD_OUT = 0;
                                        end
                                        else
                                            DataDriveOut_Dout = 8'bxxxxxxxx;
                                    end
                                end
                            end
                        end
                        else
                            $display("More wait states should be programmed");
                    end
                    if (((BurstAddr % 8)==0) && (RdPage!=RdPageStart+2)
                        && (IACC_out == 1) && (INIT_ACC_ELAPSED==1))
                        RdPage = RdPage + 1;
                end
            end
            endcase
        end

        if (falling_edge_CSNeg)
        begin
            RWDS_temp = 1'b0;
            RWDS_zd <= 1'b0;
        end

        if (rising_edge_IACC_out)
            ReadStart = 1'b0;

    end//Read functional

    ///////////////////////////////////////////////////////////////////////////
    // Read Burst
    ///////////////////////////////////////////////////////////////////////////
    task READ_BURST_DATA;
        input integer BAddr;
        input integer BSec;
        input integer BLine;
        input reg[7:0] Targ;
        integer mem_data;
        integer Addr_tmp;
    begin
        DOut_burst = 16'bx;

        case (Targ)
        Mem_T:
        begin
            if (current_state != BLCK)
            begin
                READMEM(BSec, BAddr, BLine, DOut_burst[15:0]);
            end
        end

        SR_T:
        begin
            if (FIRST_WORD == 1)
            begin
                DOut_burst = Status_reg;
                FIRST_WORD = 1'b0;
            end
        end

        CR_T:
        begin
            if (NVCR_ACT == 0)
                DOut_burst = VCR_Config_reg;
            else
                DOut_burst = NVCR_Config_reg;
        end

        CFI_T:
        begin
            if ((SA_CFI == SecAddr) && (BAddr <= 16'h80))
            begin
                DOut_burst = CFI_ID_Array[BAddr];
            end
            else
                DOut_burst = 16'bx;
        end

        INT_CR_T:
        begin
            DOut_burst = INT_CR_reg;
        end

        INT_SR_T:
        begin
            DOut_burst = INT_SR_reg;
        end

        CRC_T:
        begin
            if (Addr==16'h00)
                DOut_burst = Check_Val_Lo_reg;
            else if (Addr==16'h01)
                DOut_burst = Check_Val_Hi_reg;
        end

        SSR_T:
        begin
            if (BAddr <= SecSi_size)
                DOut_burst = SSR_reg[BAddr];
        end

        POR_TR_T:
        begin
            DOut_burst = PORTime_reg;
        end

        PWD_T:
        begin
            if (ASPR_reg[2] != 0 && (Addr==16'h00 || Addr==16'h01 ||
            Addr==16'h02 || Addr==16'h03))
                DOut_burst = Password[Addr];
            else
                DOut_burst = 16'hFFFF;
        end

        ASPR_T:
        begin
            DOut_burst = ASPR_reg;
        end

        DYB_T:
        begin
            DOut_burst[15:1] = 15'b1;
            DOut_burst[0]    = DYB_Prot[SecAddr];
        end

        PPB_T:
        begin
            DOut_burst[15:1] = 15'b1;
            DOut_burst[0]    = PPB_Prot[SecAddr];
        end

        PPBLB_T:
        begin
            DOut_burst[15:1] = 15'b1;
            DOut_burst[0]    = PPBLock;
        end

        FID_T:
            DOut_burst = FIDR_reg;

        ECC_T:
            DOut_burst = ECC_Status_reg;

        ECCR_T:
        begin
            if ((BSec*(SecSize+1) + BAddr) == 1)
                DOut_burst = B_ERRL_reg;
            else if ((BSec*(SecSize+1) + BAddr) == 2)
                DOut_burst = B_ERRU_reg;
        end

        SA_PROT_T:
        begin
            if (FIRST_WORD)
            begin
                DOut_burst[15:4] = {12{1'b1}};
                DOut_burst[3]    = WPNeg_in;
                DOut_burst[2]    = PPB[SecAddr];
                DOut_burst[1]    = DYB[SecAddr];
                DOut_burst[0]    = WPNeg_in & PPB_Prot[SecAddr] & DYB_Prot[SecAddr];
                FIRST_WORD = 1'b0;
            end
        end

        endcase
    end
    endtask

    ///////////////////////////////////////////////////////////////////////////
    // Process for RWDS generation
    ///////////////////////////////////////////////////////////////////////////
    always @(RWDS_temp, falling_edge_CSNeg, rising_edge_CSNeg, reseted)
    begin : RWDSGenerate
        if (~CSNeg && RW && reseted)
            DataDriveOut_RWDS = RWDS_temp;
        else if (~CSNeg && ~RW && reseted)
            DataDriveOut_RWDS = 0;
        else if (rising_edge_CSNeg)
            DataDriveOut_RWDS = 1'bz;
    end

    //////////////////////////////////////////////////////////////////////////
    //Output control
    //////////////////////////////////////////////////////////////////////////
    always @(posedge CSNeg)
    begin
        DOut_burst =  16'bZ;
        DataDriveOut_Dout = 8'bZ;
        Dout_zd <= #DQt_0Z 8'bZ;
        RWDS_zd <= #DQt_0Z  1'bZ;
        if (RW)
        begin
            STAT_ACT   = 1'b0;
            CR_ACT     = 1'b0;
            POR_TR_ACT = 1'b0;
            INT_CR_ACT = 1'b0;
            INT_SR_ACT = 1'b0;
            FIDR_ACT   = 1'b0;
            CRC_RD_SETUP = 1'b0;
            SA_PROT_ACT  = 1'b0;
        end
        disable read_process;
    end

    always @(RESETNeg or RST)
    begin
        //Output Disable Control
        if (~RESETNeg && ~RST)
        begin
            Dout_zd = 8'bZ;
            DOut_burst =  16'bZ;
            DataDriveOut_Dout = 16'bZ;
            RWDS_zd = 1'bz;
            DataDriveOut_RWDS = 1'bz;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    // edge controll processes
    ///////////////////////////////////////////////////////////////////////////
    always @(posedge PoweredUp)
    begin
        rising_edge_PoweredUp = 1;
        #1 rising_edge_PoweredUp = 0;
    end

    always @(negedge CKDiff)
    begin
        falling_edge_CKDiff = 1;
        #1 falling_edge_CKDiff = 0;
    end

    always @(posedge CKDiff)
    begin
        rising_edge_CKDiff = 1;
        #1 rising_edge_CKDiff = 0;
    end

    always @(negedge write)
    begin
        falling_edge_write = 1;
        #1 falling_edge_write = 0;
    end

    always @(posedge reseted)
    begin
        rising_edge_reseted = 1;
        #1 rising_edge_reseted = 0;
    end

    always @(negedge RESETNeg)
    begin
        falling_edge_RESETNeg = 1;
        #1 falling_edge_RESETNeg = 0;
    end

    always @(posedge RESETNeg)
    begin
        rising_edge_RESETNeg = 1;
        #1 rising_edge_RESETNeg = 0;
    end

    always @(negedge RST)
    begin
        falling_edge_RST = 1;
        #1 falling_edge_RST = 0;
    end

    always @(negedge CSNeg)
    begin
        falling_edge_CSNeg = 1;
        #1 falling_edge_CSNeg = 0;
    end

    always @(posedge CSNeg)
    begin
        rising_edge_CSNeg = 1;
        #1 rising_edge_CSNeg = 0;
    end

    always @(posedge ESTART)
    begin
        rising_edge_ESTART = 1'b1;
        #1 rising_edge_ESTART = 1'b0;
    end

    always @(posedge EDONE)
    begin
        rising_edge_EDONE = 1'b1;
        #1 rising_edge_EDONE = 1'b0;
    end

    always @(negedge EDONE)
    begin
        #1 falling_edge_EDONE = 1'b1;
        #2 falling_edge_EDONE = 1'b0;
    end

    always @(posedge PSTART)
    begin
        rising_edge_PSTART = 1'b1;
        #1 rising_edge_PSTART = 1'b0;
    end

    always @(posedge PDONE)
    begin
        rising_edge_PDONE = 1'b1;
        #1 rising_edge_PDONE = 1'b0;
    end

    always @(negedge PDONE)
    begin
        #1 falling_edge_PDONE = 1'b1;
        #2 falling_edge_PDONE = 1'b0;
    end

    always @(posedge BCSTART)
    begin
        rising_edge_BCSTART = 1;
        #1 rising_edge_BCSTART = 0;
    end

    always @(posedge BCDONE)
    begin
        rising_edge_BCDONE = 1;
        #1 rising_edge_BCDONE = 0;
    end

    always @(posedge EESSTART)
    begin
        rising_edge_EESSTART = 1;
        #1 rising_edge_EESSTART = 0;
    end

    always @(posedge EESDONE)
    begin
        rising_edge_EESDONE = 1;
        #1 rising_edge_EESDONE = 0;
    end

    always @(posedge sSTART_T1)
    begin
        rising_edge_sSTART_T1 = 1'b1;
        #1 rising_edge_sSTART_T1 = 1'b0;
    end

    always @(posedge PSUSP)
    begin
        rising_edge_PSUSP = 1'b1;
        #1 rising_edge_PSUSP = 1'b0;
    end

    always @(posedge ESUSP)
    begin
        rising_edge_ESUSP = 1'b1;
        #1 rising_edge_ESUSP = 1'b0;
    end

    always @(posedge CRCSUSP)
    begin
        rising_edge_CRCSUSP = 1'b1;
        #1 rising_edge_CRCSUSP = 1'b0;
    end

    always @(posedge PRES)
    begin
        rising_edge_PRES = 1'b1;
        #1 rising_edge_PRES = 1'b0;
    end

    always @(posedge ERES)
    begin
        rising_edge_ERES = 1'b1;
        #1 rising_edge_ERES = 1'b0;
    end

    always @(posedge CRCRES)
    begin
        rising_edge_CRCRES = 1'b1;
        #1 rising_edge_CRCRES = 1'b0;
    end

    always @(negedge EERR)
    begin
        falling_edge_EERR = 1;
        #1 falling_edge_EERR = 0;
    end

    always @(negedge PERR)
    begin
        falling_edge_PERR = 1;
        #1 falling_edge_PERR = 0;
    end

    always @(posedge CRCSTART)
    begin
        rising_edge_CRCSTART = 1'b1;
        #1 rising_edge_CRCSTART = 1'b0;
    end

    always @(posedge CRCDONE)
    begin
        rising_edge_CRCDONE = 1'b1;
        #1 rising_edge_CRCDONE = 1'b0;
    end

    always @(posedge UNLOCKDONE_out)
    begin
        rising_edge_UNLOCKDONE_out = 1;
        #1 rising_edge_UNLOCKDONE_out = 0;
    end

    always @(posedge NVCR_LOAD_ACT)
    begin
        rising_edge_NVCR_LOAD_ACT= 1;
        #1 rising_edge_NVCR_LOAD_ACT = 0;
    end

    always @(change_addr)
    begin
        change_addr_event = 1'b1;
        #1 change_addr_event = 1'b0;
    end

    always @(posedge Status_reg[7])
    begin
        rising_edge_status_7 = 1;
        #1 rising_edge_status_7 = 0;
    end

    always @(posedge IACC_out)
    begin
        rising_edge_IACC_out = 1;
        #1 rising_edge_IACC_out = 0;
    end

    always @(posedge MTS_out)
    begin
        rising_edge_MTS_out = 1;
        #1 rising_edge_MTS_out = 0;
    end

    always @(posedge DPD_out)
    begin
        rising_edge_DPD_out = 1;
        #1 rising_edge_DPD_out = 0;
    end

    // Device Configuration Control
    always @(rising_edge_PoweredUp, falling_edge_RST, rising_edge_NVCR_LOAD_ACT,
             rising_edge_DPD_out)
    begin
        if (rising_edge_PoweredUp || (falling_edge_RST && RESETNeg==0) ||
        // When exiting the DPD mode set default setting
            rising_edge_DPD_out                                        ||
        (rising_edge_NVCR_LOAD_ACT && ~VCR_LOAD_FIRST))
            VCR_Config_reg = NVCR_Config_reg;
    end

    task READMEM;
    input sector;
    input Address;
    input Line;
    inout [15:0] Data;
    integer sector;
    integer Address;
    integer Line;
    integer AddrBASE;
    integer mem_data;
    begin

        AddrBASE  = sector * (SecSize+1);

        if (corrupt_flags[sector] == 1'b1 || corrupt_lines[sector][Line] == 1'b1)
            Data = 16'bx;
        else if (Mem[AddrBASE + Address] == -1)
            Data = 16'bx;
        else
            Data = Mem[AddrBASE + Address];


    end
    endtask

    ///////////////////////////////////////////////////////////////////////////
    // Generate Next Address / Continuous Burst Read
    ///////////////////////////////////////////////////////////////////////////
    task NEXT_ADDR_CNT;
        inout integer BAddr;
        inout integer BSec;
    begin
        if (BAddr == SecSize)
        begin
            BAddr = 0;
            if (BSec == SecNum)
            begin
                BSec = 0;
            end
            else
            begin
                BSec = BSec+1;
            end
        end
        else
        begin
            BAddr = BAddr +1;
        end
    end
    endtask

    ///////////////////////////////////////////////////////////////////////////
    // Generate Next Address / Linear Burst Read
    ///////////////////////////////////////////////////////////////////////////
    task NEXT_ADDR_LIN;
        inout integer BAddr;
        input integer Length;
    begin
        BAddr = BAddr +1;
        if (BAddr % Length == 0)
            BAddr = BAddr - Length;
    end
    endtask

    //TimingChecks for Read
    always @(rising_edge_CKDiff or falling_edge_CKDiff)
    begin: read_process
        if (~CSNeg_ipd)
        begin
            if (DPD_out == 1'b0)  // In DPD mode data will not be output
            begin
                glitch_dq = 0;
                Dout_zd <= 8'bZ;
            end
            else if (DQt_01 > CK_cycle/2 || DataDriveOut_Dout===8'bx)
            begin
                glitch_dq = 1;
                Dout_zd <= #DQt_01 DataDriveOut_Dout;
            end
            else if (DQt_01 <= CK_cycle/2)
            begin
                glitch_dq = 0;
                Dout_zd <= DataDriveOut_Dout;
            end
        end
    end

    always @(rising_edge_CKDiff, falling_edge_CKDiff)
    begin
        if (~CSNeg_ipd)
        begin
      // In DPD mode RWDS will not toggle during an attempted read transaction
            if (DPD_out == 1'b0)
            begin
                glitch_rwds = 0;
                RWDS_zd  <= 1'b0;
            end
      // Detect glitch
            else if (RWDSt_01 > CK_cycle/2)
            begin
                glitch_rwds = 1;
                RWDS_zd  <= #RWDSt_01 DataDriveOut_RWDS;
            end
      // Read/Write transactions
            else
            begin
                glitch_rwds = 0;
                RWDS_zd  <= DataDriveOut_RWDS;
            end
        end
    end

    reg  BuffInDQ;
    wire BuffOutDQ;

    reg  BuffInDQZ;
    wire BuffOutDQZ;

    reg  BuffInRWDS;
    wire BuffOutRWDS;

    BUFFERs26ks512s    BUF_DOut   (BuffOutDQ, BuffInDQ);
    BUFFERs26ks512s    BUF_DOutZ  (BuffOutDQZ, BuffInDQZ);
    BUFFERs26ks512s    BUF_RWDS   (BuffOutRWDS, BuffInRWDS);

    initial
    begin
        BuffInDQ   = 1'b1;
        BuffInDQZ  = 1'b1;
        BuffInRWDS = 1'b1;
    end

    always @(posedge BuffOutDQ)
    begin
        DQt_01 = $time;
    end

    always @(posedge BuffOutDQZ)
    begin
        DQt_0Z = $time;
    end

    always @(posedge BuffOutRWDS)
    begin
        RWDSt_01 = $time;
    end

///////////////////////////////////////////////////////////////////////////////
// CFI ID preload process
///////////////////////////////////////////////////////////////////////////////
    initial 
    begin: CFIPreload

        // ID (Autoselect) address map
        CFI_ID_Array[7'h00] = 16'h0001; // Manufacturer ID
        CFI_ID_Array[7'h01] = 16'h007E; // Device ID
        CFI_ID_Array[7'h02] = 16'hFFFF; /////////////////////
        CFI_ID_Array[7'h03] = 16'hFFFF;
        CFI_ID_Array[7'h04] = 16'hFFFF;
        CFI_ID_Array[7'h05] = 16'hFFFF;
        CFI_ID_Array[7'h06] = 16'hFFFF; // RFU
        CFI_ID_Array[7'h07] = 16'hFFFF;
        CFI_ID_Array[7'h08] = 16'hFFFF;
        CFI_ID_Array[7'h09] = 16'hFFFF;
        CFI_ID_Array[7'h0A] = 16'hFFFF;
        CFI_ID_Array[7'h0B] = 16'hFFFF; /////////////////////
        CFI_ID_Array[7'h0C] = 16'h0005; // Lower Software bits
        CFI_ID_Array[7'h0D] = 16'h0000; // Upper Software bits, Reserved (0000)
        CFI_ID_Array[7'h0E] = 16'h0070; // Device ID
        CFI_ID_Array[7'h0F] = 16'h0000; // Device ID
        // CFI Query Identification string
        CFI_ID_Array[7'h10] = 16'h0051; /////////////////////////////////
        CFI_ID_Array[7'h11] = 16'h0052; //Query unique ASCII string "QRY"
        CFI_ID_Array[7'h12] = 16'h0059; /////////////////////////////////
        CFI_ID_Array[7'h13] = 16'h0002; // Primary OEM command set
        CFI_ID_Array[7'h14] = 16'h0000; // Primary OEM command set
        CFI_ID_Array[7'h15] = 16'h0040; // Address for Primary Extended Table
        CFI_ID_Array[7'h16] = 16'h0000; // Address for Primary Extended Table
        CFI_ID_Array[7'h17] = 16'h0000; // Alternate OEM Command set 
        CFI_ID_Array[7'h18] = 16'h0000; // Alternate OEM Command set 
        CFI_ID_Array[7'h19] = 16'h0000; // Address for Alternate OEM Extended
        CFI_ID_Array[7'h1A] = 16'h0000; // Table
        // CFI System Interface string
        if (TimingModel=="S26KL512SDABHI000" || TimingModel=="s26kl512sdabhi000")
            CFI_ID_Array[7'h1B] = 16'h0027; // VCC min
        else 
            CFI_ID_Array[7'h1B] = 16'h0017; // VCC min
        if (TimingModel=="S26KL512SDABHI000" || TimingModel=="s26kl512sdabhi000")
            CFI_ID_Array[7'h1C] = 16'h0036; // VCC max
        else 
            CFI_ID_Array[7'h1C] = 16'h0019; // VCC max
        CFI_ID_Array[7'h1D] = 16'h0000; // VPP min
        CFI_ID_Array[7'h1E] = 16'h0000; // VPP max
        CFI_ID_Array[7'h1F] = 16'h0009; // Typ timeout per single word write
        CFI_ID_Array[7'h20] = 16'h0009; // Typ timeout for max multiB pg.
        CFI_ID_Array[7'h21] = 16'h000A; // Typ timeout per block erase, 2eN ms
        CFI_ID_Array[7'h22] = 16'h0012; // Typ timeout for chip erase, 2eN ms
        CFI_ID_Array[7'h23] = 16'h0002; // Max timeout for single word wr.2eN
        CFI_ID_Array[7'h24] = 16'h0002; // Max timeout for buf write, 2eN
        CFI_ID_Array[7'h25] = 16'h0002; // Max timeout for block erase, 2eN
        CFI_ID_Array[7'h26] = 16'h0002; // Max timeout for chip erase, 2eN
        // Device Geometry Definition
        CFI_ID_Array[7'h27] = 16'h001A; // Device Size, 2eN bytes
        CFI_ID_Array[7'h28] = 16'h0000; // Flash Device Interface Description
        CFI_ID_Array[7'h29] = 16'h0000; // Flash Device Interface Description
        CFI_ID_Array[7'h2A] = 16'h0009; // Max num of B in multi-byte wr, 2eN
        CFI_ID_Array[7'h2B] = 16'h0000; // Max num of B in multi-byte wr, 2eN
        CFI_ID_Array[7'h2C] = 16'h0001; // Num of Erase Blck regions within dev
        CFI_ID_Array[7'h2D] = 16'h00FF; /////////////////////////////////
        CFI_ID_Array[7'h2E] = 16'h0000; // Erase block region 1 Information
        CFI_ID_Array[7'h2F] = 16'h0000; //
        CFI_ID_Array[7'h30] = 16'h0004; /////////////////////////////////
        CFI_ID_Array[7'h31] = 16'h0000; /////////////////////////////////
        CFI_ID_Array[7'h32] = 16'h0000; // Erase block region 2 Information
        CFI_ID_Array[7'h33] = 16'h0000; // 
        CFI_ID_Array[7'h34] = 16'h0000; /////////////////////////////////
        CFI_ID_Array[7'h35] = 16'h0000; /////////////////////////////////
        CFI_ID_Array[7'h36] = 16'h0000; // Erase block region 3 Information
        CFI_ID_Array[7'h37] = 16'h0000; // 
        CFI_ID_Array[7'h38] = 16'h0000; /////////////////////////////////
        CFI_ID_Array[7'h39] = 16'h0000; /////////////////////////////////
        CFI_ID_Array[7'h3A] = 16'h0000; // Erase block region 4 Information
        CFI_ID_Array[7'h3B] = 16'h0000; // 
        CFI_ID_Array[7'h3C] = 16'h0000; /////////////////////////////////

        CFI_ID_Array[7'h3D] = 16'h0000; //
        CFI_ID_Array[7'h3E] = 16'h0000; //
        CFI_ID_Array[7'h3F] = 16'h0000; //

        // CFI Primary Vendor-Specific Extended Query
        CFI_ID_Array[7'h40] = 16'h0050; ///////////////////////////////// 
        CFI_ID_Array[7'h41] = 16'h0052; // Query-unique ASCII string "PRI"
        CFI_ID_Array[7'h42] = 16'h0049; ///////////////////////////////// 
        CFI_ID_Array[7'h43] = 16'h0031; // Major verison number, ASCII
        CFI_ID_Array[7'h44] = 16'h0035; // Minor verison number, ASCII
        CFI_ID_Array[7'h45] = 16'h001C; // Addr Sens. Unlock & Process Tech.
        CFI_ID_Array[7'h46] = 16'h0002; // Erase suspend suported (R & W)
        CFI_ID_Array[7'h47] = 16'h0001; // Sector Protect 
        CFI_ID_Array[7'h48] = 16'h0000; // Temporary Sector unprotect 
        CFI_ID_Array[7'h49] = 16'h0008; // Sector protect/unprotect scheme
        CFI_ID_Array[7'h4A] = 16'h0000; // Simultaneous operation
        CFI_ID_Array[7'h4B] = 16'h0001; // Burst Mode Type
        CFI_ID_Array[7'h4C] = 16'h0000; // Page Mode Type
        CFI_ID_Array[7'h4D] = 16'h0000; // ACC supply minimum
        CFI_ID_Array[7'h4E] = 16'h0000; // ACC supply maximum
        CFI_ID_Array[7'h4F] = 16'h0006; // WP# prtocetion
        CFI_ID_Array[7'h50] = 16'h0001; // Program Suspend supported
        CFI_ID_Array[7'h51] = 16'h0000; // Unlock Bypass not supported
        CFI_ID_Array[7'h52] = 16'h000A; // SecSi sector size, 2eN
        CFI_ID_Array[7'h53] = 16'h008D; // Software Features
        CFI_ID_Array[7'h54] = 16'h0005; // Page Size 2eN bytes
        CFI_ID_Array[7'h55] = 16'h0006; // Erase Suspend Timeout maximum <2eN
        CFI_ID_Array[7'h56] = 16'h0006; // Program Suspend Timeout maximum <2eN
        for(i=0;i<=6'h20;i=i+1)
            CFI_ID_Array[7'h57+i] = 16'hFFFF;
        CFI_ID_Array[7'h78] = 16'h0006; // Embedded Hard Reset Timeout Max 2eN
        CFI_ID_Array[7'h79] = 16'h0009; // Non-Embedded Hard Rst Timeout Max

    end // End of CFI preload process
///////////////////////////////////////////////////////////////////////////////

endmodule

module BUFFERs26ks512s (OUT,IN);
    input IN;
    output OUT;
    buf   ( OUT, IN);
endmodule
