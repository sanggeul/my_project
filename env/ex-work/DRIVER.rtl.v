// Last Modified : 2015-12-04 21:34 by sglee86
`timescale 1ns/1ps

module	TEST_TOP;

`define RTL

parameter       NA = 14;
parameter       ND = 64;
parameter       BA = NA - 1;
parameter       BD = ND - 1;
parameter       NS = ND / 8;
parameter       BS = NS - 1;
parameter       NO = NA + 4; 
parameter       BO = NO - 1;

//##################################################
// Wire & Reg Definition
//##################################################

// Clock & Reset
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//input
reg     		    XIN;
reg     		    PORn;

reg     		    ACLK_CMB;
reg     		    ARESETn_CMB;

wire    [03:00]     PERICLK;
reg                 rPERICLK;
reg     		    Int_OSC;

    // clock
    initial XIN         = 0;
    always  XIN         = #( `XIN_PERIOD/2) ~XIN;
    
    initial ACLK_CMB    = 0;
    always  ACLK_CMB    = #( `ACLK_PERIOD/2) ~ACLK_CMB;

    initial rPERICLK    = 0;
    always  rPERICLK    = #( `PCLK_PERIOD/2) ~rPERICLK;

    initial Int_OSC     = 0;
    always  Int_OSC     = #( `OSC_PERIOD/2) ~Int_OSC;

assign  PERICLK = {rPERICLK, rPERICLK,rPERICLK,rPERICLK};

    // reset
    initial begin
        PORn            = 0;
        repeat (90) @(negedge XIN);
        PORn            = 1;
    end

    initial begin
        ARESETn_CMB     = 0;
        repeat (100) @(negedge XIN);
        ARESETn_CMB     = 1;
    end

// EV input
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//input
reg	                EVENT_0_IN_REQ;
reg	                EVENT_1_IN_REQ;
reg	                EVENT_0_OUT_ACK;
reg	                EVENT_1_OUT_ACK;

    initial  begin
        EVENT_0_IN_REQ      = 0;
        EVENT_1_IN_REQ      = 0;
        EVENT_0_OUT_ACK     = 0;
        EVENT_1_OUT_ACK     = 0;
    end

// EV output
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire	            EVENT_0_IN_ACK;
wire	            EVENT_1_IN_ACK;
wire	            EVENT_0_OUT_REQ;
wire	            EVENT_1_OUT_REQ;

// watch dog req
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire            	CMB_WDRST_REQ;

//	NSK
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//input

//reg                 PERICLK_SC;

reg      		    TYPE2_INDICATOR;

reg     [7:0]       NSK_ONESHOT;

    initial begin
        //PERICLK_SC          = Int_OSC;
        
        TYPE2_INDICATOR     = 0;
        
        NSK_ONESHOT         = 8'h5;
    end

// JTAG Passwords 
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire	[127:0]	    MainProc_PW;
wire		        MainProc_PW_Valid;
wire	[127:0]	    AudioProc_PW;
wire		        AudioProc_PW_Valid;
wire	[127:0]	    StreamProc_PW;
wire		        StreamProc_PW_Valid;

// TestMode Password 
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire    [127:00]    TESTMODE_PW_DATA;
wire                TESTMODE_PW_VALID;

// TestNotOpened
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//input
reg                 TestNotOpened_MainProc;	
reg                 TestNotOpened_AudioProc;
reg                 TestNotOpened_StreamProc;

    initial begin
        TestNotOpened_MainProc      = 0;
        TestNotOpened_AudioProc     = 0;
        TestNotOpened_StreamProc    = 0;
    end

// PVT monitor signals
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//input
reg                 OTP_POWER_OUTRANGE;
reg                 CORE_POWER_OUTRANGE;
reg                 XIN_OUTRANGE;

    initial begin
        OTP_POWER_OUTRANGE          = 0;
        CORE_POWER_OUTRANGE         = 0;
        XIN_OUTRANGE                = 0;
    end

// OTP Wrapper H2H master
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire    [BD:0]		HAB_HRDATA;
wire   				HAB_HRESPERR;
wire   				HAB_HTRANSACK;

//input
reg     [BA:0]		HAB_HADDR;
reg    				HAB_HLOCK;
reg     [2:0]		HAB_HSIZE;
reg     [BS:0]		HAB_HSTRB;
reg    				HAB_HTRANSREQ;
reg    				HAB_HUNLOCK;
reg     [BD:0]		HAB_HWDATA;
reg    				HAB_HWRITE;
reg     [15:0]		HAB_HMASTER;

    initial begin
        HAB_HADDR       = 0;
        HAB_HLOCK       = 0;
        HAB_HSIZE       = 0;
        HAB_HSTRB       = 0;
        HAB_HTRANSREQ   = 0;
        HAB_HUNLOCK     = 0;
        HAB_HWDATA      = 0;
        HAB_HWRITE      = 0;
        HAB_HMASTER     = 0;
    end

// OTP TEST
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire    [7:0]		OTPTEST_D;
wire				OTPTEST_LOCK;

//input
reg    				OTPTEST;
reg     [BO:00]		OTPTEST_A;
reg    				OTPTEST_CEB;
reg    				OTPTEST_CLE;
reg    				OTPTEST_CPUMPEN;
reg    				OTPTEST_DIN;
reg    				OTPTEST_DLE;
reg    				OTPTEST_PGMEN;
reg    				OTPTEST_READEN;
reg    				OTPTEST_RSTB;
reg     [2:0]		OTPTEST_TVBG;
reg     [2:0]		OTPTEST_TVPP;
reg    				OTPTEST_WEB;

reg 				OTP_OTHERTEST;

    initial begin // non-active state
        OTP_OTHERTEST   = 0;
        OTPTEST         = 0;

        OTPTEST_A       = 0;
        OTPTEST_CEB     = 1;
        OTPTEST_CLE     = 0;
        OTPTEST_CPUMPEN = 0;
        OTPTEST_DIN     = 1;
        OTPTEST_DLE     = 0;
        OTPTEST_PGMEN   = 0;
        OTPTEST_READEN  = 0;
        OTPTEST_RSTB    = 1;
        OTPTEST_TVBG    = 0;
        OTPTEST_TVPP    = 0;
        OTPTEST_WEB     = 1;
    end

// OTP ROM interface
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire    [BO:00]	    OTP_A;
wire    			OTP_CEB;
wire    			OTP_CLE;
wire    			OTP_CPUMPEN;
wire    			OTP_DIN;
wire    			OTP_DLE;
wire    			OTP_PGMEN;
wire    			OTP_READEN;
wire    			OTP_RSTB;
wire    [2:0]		OTP_TVBG;
wire    [2:0]		OTP_TVPP;
wire    			OTP_WEB;

//input
//reg     [7:0]		OTP_D;
//reg       			OTP_LOCK;
reg                 OTP_WP; // write protect from pin
                            // 0 for not-protected
                            // 1 for protected

    initial begin
        OTP_WP      = 0;
    end

//  Interface Between OTP Wrapper and PMU
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire            	OTP_INIT_VALID;
wire    [127:00] 	OTP_INIT_DATA;
wire    [4:00] 		OTP_INIT_ADDR;

//input
//reg            		OTP_INIT_DONE;
//reg            		OTP_INIT_READY;

// IREQ
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire    [03:00]     IREQ_CMB;
//wire                IRQ_RDMA_PG_CMB;

//input
reg     [111:00]    VPIC_IRQI;

    initial begin
        VPIC_IRQI       = 112'b0;
    end

// CM 
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire    [11:0]		TEST_CM_OUT;

//input
reg     [30:0]		TEST_CM_IN;
reg       			TEST_CM_MODE;
reg       			TEST_CM_PLLCLK;

//    initial begin
//        TEST_CM_IN      = 32'b0;
//        TEST_CM_MODE    = 1'b0;
//        TEST_CM_PLLCLK  = 1'b0;
//    end

// debug
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire        		CM_O_TDO;
wire        		CM_O_CDBGPWRUPREQ;

//input
reg           		CM_I_nTRST; 
reg           		CM_I_TMS; 
reg           		CM_I_TCK; 
reg           		CM_I_TDI; 
reg           		CM_I_CDBGPWRUPACK;

    initial begin
        CM_I_nTRST          = 1'b1;
        CM_I_TMS            = 1'b1;
        CM_I_TCK            = 1'b1;
        CM_I_TDI            = 1'b1;
        CM_I_CDBGPWRUPACK   = 1'b1;
    end

// Memory Configuration
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//input
reg     [02:00]     CMBUS_EMA_RA1_HD;
reg     [01:00]     CMBUS_EMAW_RA1_HD;
reg     [02:00]     CMBUS_EMA_RA1_HS;
reg     [01:00]     CMBUS_EMAW_RA1_HS;
reg                 CMBUS_EMAS_RA1_HS;
reg     [02:00]     CMBUS_EMA_RA2_HD;
reg     [01:00]     CMBUS_EMAW_RA2_HD;
reg     [02:00]     CMBUS_EMA_RA2_HS;
reg     [01:00]     CMBUS_EMAW_RA2_HS;
reg                 CMBUS_EMAS_RA2_HS;
reg     [02:00]     CMBUS_EMA_RF1_HD;
reg     [01:00]     CMBUS_EMAW_RF1_HD;
reg     [02:00]     CMBUS_EMA_RF1_HS;
reg     [01:00]     CMBUS_EMAW_RF1_HS;
reg                 CMBUS_EMAS_RF1_HS;
reg     [02:00]     CMBUS_EMA_RF2_HD;
reg     [02:00]     CMBUS_EMA_VROMP_HD;

reg                 CM4_PGEN_RAM;
reg                 CM4_RET1N_RAM;
reg		            CM4_PGEN_NSKROM;

    initial begin
        CMBUS_EMA_RA1_HD        = 3;
        CMBUS_EMAW_RA1_HD       = 0;
        CMBUS_EMA_RA1_HS        = 3;
        CMBUS_EMAW_RA1_HS       = 0;
        CMBUS_EMAS_RA1_HS       = 0;
        CMBUS_EMA_RA2_HD        = 3;
        CMBUS_EMAW_RA2_HD       = 0;
        CMBUS_EMA_RA2_HS        = 3;
        CMBUS_EMAW_RA2_HS       = 0;
        CMBUS_EMAS_RA2_HS       = 0;
        CMBUS_EMA_RF1_HD        = 3;
        CMBUS_EMAW_RF1_HD       = 0;
        CMBUS_EMA_RF1_HS        = 3;
        CMBUS_EMAW_RF1_HS       = 0;
        CMBUS_EMAS_RF1_HS       = 0;
        CMBUS_EMA_RF2_HD        = 3;
        CMBUS_EMA_VROMP_HD      = 3;

        CM4_PGEN_RAM            = 0;
        CM4_RET1N_RAM           = 1;
        CM4_PGEN_NSKROM         = 0;
    end

// TS I/F, Port  
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//input
reg     [7:0]		EXT_TSCLKI;
reg     [7:0]		EXT_TSDI0;
reg     [7:0]		EXT_TSDI1;
reg     [7:0]		EXT_TSDI2;
reg     [7:0]		EXT_TSDI3;
reg     [7:0]		EXT_TSDI4;
reg     [7:0]		EXT_TSDI5;
reg     [7:0]		EXT_TSDI6;
reg     [7:0]		EXT_TSDI7;
reg     [7:0]		EXT_TSSYNCI;
reg     [7:0]		EXT_TSVALIDI;

    initial begin
        EXT_TSCLKI          = 0;
        EXT_TSDI0           = 0;
        EXT_TSDI1           = 0;
        EXT_TSDI2           = 0;
        EXT_TSDI3           = 0;
        EXT_TSDI4           = 0;
        EXT_TSDI5           = 0;
        EXT_TSDI6           = 0;
        EXT_TSDI7           = 0;
        EXT_TSSYNCI         = 0;
        EXT_TSVALIDI        = 0;
    end

// TS I/F TX, internal
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//input
reg     [1:0]		TX_TSCLKI;
reg     [1:0]		TX_TSDI0;
reg     [1:0]		TX_TSDI1;
reg     [1:0]		TX_TSDI2;
reg     [1:0]		TX_TSDI3;
reg     [1:0]		TX_TSDI4;
reg     [1:0]		TX_TSDI5;
reg     [1:0]		TX_TSDI6;
reg     [1:0]		TX_TSDI7;
reg     [1:0]		TX_TSSYNCI;
reg     [1:0]		TX_TSVALIDI;

    initial begin
        TX_TSCLKI           = 0;
        TX_TSDI0            = 0;
        TX_TSDI1            = 0;
        TX_TSDI2            = 0;
        TX_TSDI3            = 0;
        TX_TSDI4            = 0;
        TX_TSDI5            = 0;
        TX_TSDI6            = 0;
        TX_TSDI7            = 0;
        TX_TSSYNCI          = 0;
        TX_TSVALIDI         = 0;
    end

// SCANTEST
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//input
reg                 SCANTEST;
reg                 SCANEN_FF;
reg                 SCANEN;
reg                 SCANCLK;
reg                 SCANRSTN;

    initial begin
        SCANTEST            = 0;
        SCANEN_FF           = 0;
        SCANEN              = 0;
        SCANCLK             = 0;
    end

    initial begin
        SCANRSTN           = 0;
        repeat (90) @(negedge XIN);
        SCANRSTN           = 1;
    end


// h2h master
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire    [31:0]		MBPH2CMBPH_HAB_HRDATA;
wire    			MBPH2CMBPH_HAB_HRESPERR;
wire    			MBPH2CMBPH_HAB_HTRANSACK;

//input
reg     [31:0]		MBPH2CMBPH_HAB_HADDR;
reg       			MBPH2CMBPH_HAB_HLOCK;
reg     [3:0]		MBPH2CMBPH_HAB_HPROT;
reg     [2:0]		MBPH2CMBPH_HAB_HSIZE;
reg       			MBPH2CMBPH_HAB_HTRANSREQ;
reg       			MBPH2CMBPH_HAB_HUNLOCK;
reg     [31:0]		MBPH2CMBPH_HAB_HWDATA;
reg       			MBPH2CMBPH_HAB_HWRITE;

    initial begin
        MBPH2CMBPH_HAB_HADDR        = 0;
        MBPH2CMBPH_HAB_HLOCK        = 0;
        MBPH2CMBPH_HAB_HPROT        = 0;
        MBPH2CMBPH_HAB_HSIZE        = 0;
        MBPH2CMBPH_HAB_HTRANSREQ    = 0;
        MBPH2CMBPH_HAB_HUNLOCK      = 0;
        MBPH2CMBPH_HAB_HWDATA       = 0;
        MBPH2CMBPH_HAB_HWRITE       = 0;
    end

// x2x adb400
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire                CMBX2MBX_XAB_CACTIVE_S_TO_M;
wire                CMBX2MBX_XAB_PWRDNREQN;
wire    [3:0]       CMBX2MBX_XAB_AW_WR_PTR;
wire    [263:0]     CMBX2MBX_XAB_AW_PAYLD;
wire                CMBX2MBX_XAB_AW_PWRDNREQN;
wire    [5:0]       CMBX2MBX_XAB_W_WR_PTR;
wire    [479:0]     CMBX2MBX_XAB_W_PAYLD;
wire                CMBX2MBX_XAB_W_PWRDNREQN;
wire    [1:0]       CMBX2MBX_XAB_B_RD_PTR;
wire                CMBX2MBX_XAB_B_PWRDNACKN;
wire    [3:0]       CMBX2MBX_XAB_AR_WR_PTR;
wire    [263:0]     CMBX2MBX_XAB_AR_PAYLD;
wire                CMBX2MBX_XAB_AR_PWRDNREQN;
wire    [5:0]       CMBX2MBX_XAB_R_RD_PTR;
wire                CMBX2MBX_XAB_R_PWRDNACKN;

 //input
reg                 CMBX2MBX_XAB_CACTIVE_M_TO_S;
reg                 CMBX2MBX_XAB_PWRDNACKN;
reg     [3:0]       CMBX2MBX_XAB_AW_RD_PTR;
reg                 CMBX2MBX_XAB_AW_PWRDNACKN;
reg     [5:0]       CMBX2MBX_XAB_W_RD_PTR;
reg                 CMBX2MBX_XAB_W_PWRDNACKN;
reg     [1:0]       CMBX2MBX_XAB_B_WR_PTR;
reg     [17:0]      CMBX2MBX_XAB_B_PAYLD;
reg                 CMBX2MBX_XAB_B_PWRDNREQN;
reg     [3:0]       CMBX2MBX_XAB_AR_RD_PTR;
reg                 CMBX2MBX_XAB_AR_PWRDNACKN;
reg     [5:0]       CMBX2MBX_XAB_R_WR_PTR;
reg     [443:0]     CMBX2MBX_XAB_R_PAYLD;
reg                 CMBX2MBX_XAB_R_PWRDNREQN;

    initial begin
		CMBX2MBX_XAB_CACTIVE_M_TO_S         = 1'b0;
		CMBX2MBX_XAB_PWRDNACKN              = 1'b1;

		CMBX2MBX_XAB_AW_RD_PTR              = 4'b0000;
		CMBX2MBX_XAB_AW_PWRDNACKN           = 1'b1;

		CMBX2MBX_XAB_W_RD_PTR               = 6'b00_0000;
		CMBX2MBX_XAB_W_PWRDNACKN            = 1'b1;

		CMBX2MBX_XAB_B_WR_PTR               = 2'b00;
		CMBX2MBX_XAB_B_PAYLD                = 18'b0;
		CMBX2MBX_XAB_B_PWRDNREQN            = 1'b1;

		CMBX2MBX_XAB_AR_RD_PTR              = 4'b0000;
		CMBX2MBX_XAB_AR_PWRDNACKN           = 1'b1;

		CMBX2MBX_XAB_R_WR_PTR               = 6'b00_0000;
		CMBX2MBX_XAB_R_PAYLD                = 444'b0;
		CMBX2MBX_XAB_R_PWRDNREQN            = 1'b1;
    end

//	PMU_PM
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 //input
reg    				CFG_PMU_PM;

    initial begin
        CFG_PMU_PM      = 0;
    end


//	OTPROM Interface
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire    [7:0]       OTP_D;
wire                OTP_LOCK;
wire                OTP_VTDO;

// Inouts
wire                OTP_VPP;
pullup (weak1) (OTP_VPP);
wire                OTP_VREFM;

    `ifdef AFTER
    `else
        defparam    `TEST_TOP.x_otprom_wrap.x_otp.INFO_ON = 1;
        defparam    `TEST_TOP.x_otprom_wrap.x_otp.LOCK_BIT = 0;
        defparam    `TEST_TOP.x_otprom_wrap.x_otp.DIS_ON = 1;
    
        assign      `TEST_TOP.OTP_VPP  = 1;
    `endif


// Inputs
reg                 ISO_EN;
reg                 ISO_ENn;

//reg     [17:0]      OTP_A;
//reg                 OTP_CEB;
//reg                 OTP_CLE;
//reg                 OTP_CPUMPEN;
//reg                 OTP_DIN;
//reg                 OTP_DLE;
//reg                 OTP_PGMEN;
//reg                 OTP_READEN;
//reg                 OTP_RSTB;
//reg     [2:0]       OTP_TVBG;
//reg     [2:0]       OTP_TVPP;
//reg                 OTP_WEB;

reg                 OTP_VBG;
//pullup (weak1) (OTP_VBG);

    initial begin
        ISO_EN          = 0;
        ISO_ENn         = 1;

        //OTP_A           = 0;
        //OTP_CEB         = 1;
        //OTP_CLE         = 0;
        //OTP_CPUMPEN     = 0;
        //OTP_DIN         = 1;
        //OTP_DLE         = 0;
        //OTP_PGMEN       = 0;
        //OTP_READEN      = 0;
        //OTP_RSTB        = 1;
        //OTP_TVBG        = 0;
        //OTP_TVPP        = 0;
        OTP_VBG         = 0; // 0 or 1 ?
        //OTP_WEB         = 1;
    end

//	PMU_COREIF Interface
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//output
wire           		OTP_INIT_DONE;
wire           		OTP_INIT_READY;

//input
//reg             	OTP_INIT_VALID;
//reg     [127:00] 	OTP_INIT_DATA;
//reg     [4:00] 	    OTP_INIT_ADDR;

//##################################################
// Virtual IO
//##################################################
virtual_FILEIO_m4 x_fileio_m4 (
    .HCLKEN							      (1'b1                                 ),
    .CLK							      (`CORTEX_M4.HCLK                      ),
    .HRESETn						      (`CORTEX_M4.PORESETn                  ),
    .HADDR							      (`CORTEX_M4.HADDRS[31:00]             ),
    .HTRANS							      (`CORTEX_M4.HTRANSS[01:00]            ),
    .HWRITE							      (`CORTEX_M4.HWRITES                   ),
    .HWDATA							      (`CORTEX_M4.HWDATAS[31:00]            ),
    .HREADY							      (`CORTEX_M4.HREADYS)                  );

//##################################################
// TOP Module
//##################################################
cmbus_top xCMBUS (
    // Outputs
    .EVENT_0_IN_ACK                       (EVENT_0_IN_ACK                       ),
    .EVENT_1_IN_ACK                       (EVENT_1_IN_ACK                       ),
    .EVENT_0_OUT_REQ                      (EVENT_0_OUT_REQ                      ),
    .EVENT_1_OUT_REQ                      (EVENT_1_OUT_REQ                      ),

    .CMB_WDRST_REQ                        (CMB_WDRST_REQ                        ),

    .MainProc_PW                          (MainProc_PW                          ),
    .MainProc_PW_Valid                    (MainProc_PW_Valid                    ),

    .AudioProc_PW                         (AudioProc_PW                         ),
    .AudioProc_PW_Valid                   (AudioProc_PW_Valid                   ),

    .StreamProc_PW                        (StreamProc_PW                        ),
    .StreamProc_PW_Valid                  (StreamProc_PW_Valid                  ),

    .TESTMODE_PW_DATA                     (TESTMODE_PW_DATA                     ),
    .TESTMODE_PW_VALID                    (TESTMODE_PW_VALID                    ),

    .HAB_HRDATA                           (HAB_HRDATA                           ),
    .HAB_HRESPERR                         (HAB_HRESPERR                         ),
    .HAB_HTRANSACK                        (HAB_HTRANSACK                        ),

    .OTPTEST_D                            (OTPTEST_D                            ),
    .OTPTEST_LOCK                         (OTPTEST_LOCK                         ),

    .OTP_A                                (OTP_A                                ),
    .OTP_CEB                              (OTP_CEB                              ),
    .OTP_CLE                              (OTP_CLE                              ),
    .OTP_CPUMPEN                          (OTP_CPUMPEN                          ),
    .OTP_DIN                              (OTP_DIN                              ),
    .OTP_DLE                              (OTP_DLE                              ),
    .OTP_PGMEN                            (OTP_PGMEN                            ),
    .OTP_READEN                           (OTP_READEN                           ),
    .OTP_RSTB                             (OTP_RSTB                             ),
    .OTP_TVBG                             (OTP_TVBG                             ),
    .OTP_TVPP                             (OTP_TVPP                             ),
    .OTP_WEB                              (OTP_WEB                              ),

    .OTPNORM_INIT_VALID                   (OTP_INIT_VALID                       ),
    .OTPNORM_INIT_DATA                    (OTP_INIT_DATA                        ),
    .OTPNORM_INIT_ADDR                    (OTP_INIT_ADDR                        ),

    .IREQ_CMB                             (IREQ_CMB                             ),
    //.IRQ_RDMA_PG_CMB                      (IRQ_RDMA_PG_CMB                      ),

    .TEST_CM_OUT                          (TEST_CM_OUT                          ),

    .CM_O_TDO                             (CM_O_TDO                             ),
    .CM_O_CDBGPWRUPREQ                    (CM_O_CDBGPWRUPREQ                    ),

    .MBPH2CMBPH_HAB_HRDATA                (MBPH2CMBPH_HAB_HRDATA                ),
    .MBPH2CMBPH_HAB_HRESPERR              (MBPH2CMBPH_HAB_HRESPERR              ),
    .MBPH2CMBPH_HAB_HTRANSACK             (MBPH2CMBPH_HAB_HTRANSACK             ),

    .CMBX2MBX_XAB_CACTIVE_S_TO_M          (CMBX2MBX_XAB_CACTIVE_S_TO_M          ),
    .CMBX2MBX_XAB_PWRDNREQN               (CMBX2MBX_XAB_PWRDNREQN               ),

    .CMBX2MBX_XAB_AW_WR_PTR               (CMBX2MBX_XAB_AW_WR_PTR               ),
    .CMBX2MBX_XAB_AW_PAYLD                (CMBX2MBX_XAB_AW_PAYLD                ),
    .CMBX2MBX_XAB_AW_PWRDNREQN            (CMBX2MBX_XAB_AW_PWRDNREQN            ),

    .CMBX2MBX_XAB_W_WR_PTR                (CMBX2MBX_XAB_W_WR_PTR                ),
    .CMBX2MBX_XAB_W_PAYLD                 (CMBX2MBX_XAB_W_PAYLD                 ),
    .CMBX2MBX_XAB_W_PWRDNREQN             (CMBX2MBX_XAB_W_PWRDNREQN             ),

    .CMBX2MBX_XAB_B_RD_PTR                (CMBX2MBX_XAB_B_RD_PTR                ),
    .CMBX2MBX_XAB_B_PWRDNACKN             (CMBX2MBX_XAB_B_PWRDNACKN             ),

    .CMBX2MBX_XAB_AR_WR_PTR               (CMBX2MBX_XAB_AR_WR_PTR               ),
    .CMBX2MBX_XAB_AR_PAYLD                (CMBX2MBX_XAB_AR_PAYLD                ),
    .CMBX2MBX_XAB_AR_PWRDNREQN            (CMBX2MBX_XAB_AR_PWRDNREQN            ),

    .CMBX2MBX_XAB_R_RD_PTR                (CMBX2MBX_XAB_R_RD_PTR                ),
    .CMBX2MBX_XAB_R_PWRDNACKN             (CMBX2MBX_XAB_R_PWRDNACKN             ),

    // Inputs
    .ACLK_CMB                             (ACLK_CMB                             ),
    .ARESETn_CMB                          (ARESETn_CMB                          ),
    .PERICLK                              (PERICLK                              ),

    .EVENT_0_IN_REQ                       (EVENT_0_IN_REQ                       ),
    .EVENT_1_IN_REQ                       (EVENT_1_IN_REQ                       ),
    .EVENT_0_OUT_ACK                      (EVENT_0_OUT_ACK                      ),
    .EVENT_1_OUT_ACK                      (EVENT_1_OUT_ACK                      ),

    //.PERICLK_SC                           (PERICLK_SC                           ),
    .PERICLK_SC                           (Int_OSC                              ),
    .TYPE2_INDICATOR                      (TYPE2_INDICATOR                      ),

    .NSK_ONESHOT                          (NSK_ONESHOT                          ),

    .TestNotOpened_MainProc               (TestNotOpened_MainProc               ),
    .TestNotOpened_AudioProc              (TestNotOpened_AudioProc              ),
    .TestNotOpened_StreamProc             (TestNotOpened_StreamProc             ),

    .OTP_POWER_OUTRANGE                   (OTP_POWER_OUTRANGE                   ),
    .CORE_POWER_OUTRANGE                  (CORE_POWER_OUTRANGE                  ),
    .XIN_OUTRANGE                         (XIN_OUTRANGE                         ),

    .XIN                                  (XIN                                  ),
    .PORn                                 (PORn                                 ),
    .OTP_WP                               (OTP_WP                               ),

    .HAB_HADDR                            (HAB_HADDR                            ),
    .HAB_HLOCK                            (HAB_HLOCK                            ),
    .HAB_HSIZE                            (HAB_HSIZE                            ),
    .HAB_HSTRB                            (HAB_HSTRB                            ),

    .HAB_HTRANSREQ                        (HAB_HTRANSREQ                        ),
    .HAB_HUNLOCK                          (HAB_HUNLOCK                          ),
    .HAB_HWDATA                           (HAB_HWDATA                           ),
    .HAB_HWRITE                           (HAB_HWRITE                           ),
    .HAB_HMASTER                          (HAB_HMASTER                          ),

    .OTPTEST                              (OTPTEST                              ),
    .OTPTEST_A                            (OTPTEST_A                            ),
    .OTPTEST_CEB                          (OTPTEST_CEB                          ),
    .OTPTEST_CLE                          (OTPTEST_CLE                          ),
    .OTPTEST_CPUMPEN                      (OTPTEST_CPUMPEN                      ),

    .OTPTEST_DIN                          (OTPTEST_DIN                          ),
    .OTPTEST_DLE                          (OTPTEST_DLE                          ),
    .OTPTEST_PGMEN                        (OTPTEST_PGMEN                        ),
    .OTPTEST_READEN                       (OTPTEST_READEN                       ),

    .OTPTEST_RSTB                         (OTPTEST_RSTB                         ),
    .OTPTEST_TVBG                         (OTPTEST_TVBG                         ),
    .OTPTEST_TVPP                         (OTPTEST_TVPP                         ),
    .OTPTEST_WEB                          (OTPTEST_WEB                          ),

    .OTP_D                                (OTP_D[7:0]                           ),
    .OTP_LOCK                             (OTP_LOCK                             ),

    .OTP_OTHERTEST                        (OTP_OTHERTEST                        ),

    .OTPNORM_INIT_READY                   (OTP_INIT_READY                       ),
    .OTPNORM_INIT_DONE                    (OTP_INIT_DONE                        ),

    .VPIC_IRQI                            (VPIC_IRQI                            ),

    .TEST_CM_IN                           (TEST_CM_IN                           ),
    .TEST_CM_MODE                         (TEST_CM_MODE                         ),

    .TEST_CM_PLLCLK                       (TEST_CM_PLLCLK                       ),

    .CM_I_nTRST                           (CM_I_nTRST                           ),
    .CM_I_TMS                             (CM_I_TMS                             ),
    .CM_I_TCK                             (CM_I_TCK                             ),
    .CM_I_TDI                             (CM_I_TDI                             ),
    .CM_I_CDBGPWRUPACK                    (CM_I_CDBGPWRUPACK                    ),

    .CMBUS_EMA_RA1_HD                     (CMBUS_EMA_RA1_HD                     ),
    .CMBUS_EMAW_RA1_HD                    (CMBUS_EMAW_RA1_HD                    ),
    .CMBUS_EMA_RA1_HS                     (CMBUS_EMA_RA1_HS                     ),
    .CMBUS_EMAW_RA1_HS                    (CMBUS_EMAW_RA1_HS                    ),
    .CMBUS_EMAS_RA1_HS                    (CMBUS_EMAS_RA1_HS                    ),
    .CMBUS_EMA_RA2_HD                     (CMBUS_EMA_RA2_HD                     ),
    .CMBUS_EMAW_RA2_HD                    (CMBUS_EMAW_RA2_HD                    ),
    .CMBUS_EMA_RA2_HS                     (CMBUS_EMA_RA2_HS                     ),
    .CMBUS_EMAW_RA2_HS                    (CMBUS_EMAW_RA2_HS                    ),
    .CMBUS_EMAS_RA2_HS                    (CMBUS_EMAS_RA2_HS                    ),
    .CMBUS_EMA_RF1_HD                     (CMBUS_EMA_RF1_HD                     ),
    .CMBUS_EMAW_RF1_HD                    (CMBUS_EMAW_RF1_HD                    ),
    .CMBUS_EMA_RF1_HS                     (CMBUS_EMA_RF1_HS                     ),
    .CMBUS_EMAW_RF1_HS                    (CMBUS_EMAW_RF1_HS                    ),
    .CMBUS_EMAS_RF1_HS                    (CMBUS_EMAS_RF1_HS                    ),
    .CMBUS_EMA_RF2_HD                     (CMBUS_EMA_RF2_HD                     ),
    .CMBUS_EMA_VROMP_HD                   (CMBUS_EMA_VROMP_HD                   ),

    .CM4_PGEN_RAM                         (CM4_PGEN_RAM                         ),
    .CM4_RET1N_RAM                        (CM4_RET1N_RAM                        ),
    .CM4_PGEN_NSKROM                      (CM4_PGEN_NSKROM                      ),

    .EXT_TSCLKI                           (EXT_TSCLKI                           ),
    .EXT_TSDI0                            (EXT_TSDI0                            ),
    .EXT_TSDI1                            (EXT_TSDI1                            ),
    .EXT_TSDI2                            (EXT_TSDI2                            ),
    .EXT_TSDI3                            (EXT_TSDI3                            ),
    .EXT_TSDI4                            (EXT_TSDI4                            ),
    .EXT_TSDI5                            (EXT_TSDI5                            ),
    .EXT_TSDI6                            (EXT_TSDI6                            ),
    .EXT_TSDI7                            (EXT_TSDI7                            ),
    .EXT_TSSYNCI                          (EXT_TSSYNCI                          ),
    .EXT_TSVALIDI                         (EXT_TSVALIDI                         ),

    .TX_TSCLKI                            (TX_TSCLKI                            ),
    .TX_TSDI0                             (TX_TSDI0                             ),
    .TX_TSDI1                             (TX_TSDI1                             ),
    .TX_TSDI2                             (TX_TSDI2                             ),
    .TX_TSDI3                             (TX_TSDI3                             ),
    .TX_TSDI4                             (TX_TSDI4                             ),
    .TX_TSDI5                             (TX_TSDI5                             ),
    .TX_TSDI6                             (TX_TSDI6                             ),
    .TX_TSDI7                             (TX_TSDI7                             ),
    .TX_TSSYNCI                           (TX_TSSYNCI                           ),
    .TX_TSVALIDI                          (TX_TSVALIDI                          ),

    .SCANTEST                             (SCANTEST                             ),
    .SCANEN_FF                            (SCANEN_FF                            ),
    .SCANEN                               (SCANEN                               ),
    .SCANCLK                              (SCANCLK                              ),
    .SCANRSTN                             (SCANRSTN                             ),

    .MBPH2CMBPH_HAB_HADDR                 (MBPH2CMBPH_HAB_HADDR                 ),
    .MBPH2CMBPH_HAB_HLOCK                 (MBPH2CMBPH_HAB_HLOCK                 ),

    .MBPH2CMBPH_HAB_HPROT                 (MBPH2CMBPH_HAB_HPROT                 ),
    .MBPH2CMBPH_HAB_HSIZE                 (MBPH2CMBPH_HAB_HSIZE                 ),

    .MBPH2CMBPH_HAB_HTRANSREQ             (MBPH2CMBPH_HAB_HTRANSREQ             ),
    .MBPH2CMBPH_HAB_HUNLOCK               (MBPH2CMBPH_HAB_HUNLOCK               ),

    .MBPH2CMBPH_HAB_HWDATA                (MBPH2CMBPH_HAB_HWDATA                ),
    .MBPH2CMBPH_HAB_HWRITE                (MBPH2CMBPH_HAB_HWRITE                ),

    .CMBX2MBX_XAB_CACTIVE_M_TO_S          (CMBX2MBX_XAB_CACTIVE_M_TO_S          ),
    .CMBX2MBX_XAB_PWRDNACKN               (CMBX2MBX_XAB_PWRDNACKN               ),

    .CMBX2MBX_XAB_AW_RD_PTR               (CMBX2MBX_XAB_AW_RD_PTR               ),
    .CMBX2MBX_XAB_AW_PWRDNACKN            (CMBX2MBX_XAB_AW_PWRDNACKN            ),

    .CMBX2MBX_XAB_W_RD_PTR                (CMBX2MBX_XAB_W_RD_PTR                ),
    .CMBX2MBX_XAB_W_PWRDNACKN             (CMBX2MBX_XAB_W_PWRDNACKN             ),

    .CMBX2MBX_XAB_B_WR_PTR                (CMBX2MBX_XAB_B_WR_PTR                ),
    .CMBX2MBX_XAB_B_PAYLD                 (CMBX2MBX_XAB_B_PAYLD                 ),

    .CMBX2MBX_XAB_B_PWRDNREQN             (CMBX2MBX_XAB_B_PWRDNREQN             ),
    .CMBX2MBX_XAB_AR_RD_PTR               (CMBX2MBX_XAB_AR_RD_PTR               ),

    .CMBX2MBX_XAB_AR_PWRDNACKN            (CMBX2MBX_XAB_AR_PWRDNACKN            ),
    .CMBX2MBX_XAB_R_WR_PTR                (CMBX2MBX_XAB_R_WR_PTR                ),

    .CMBX2MBX_XAB_R_PAYLD                 (CMBX2MBX_XAB_R_PAYLD                 ),
    .CMBX2MBX_XAB_R_PWRDNREQN             (CMBX2MBX_XAB_R_PWRDNREQN             ),

    .CFG_PMU_PM                           (CFG_PMU_PM                           ));

otprom_wrap	x_otprom_wrap
    (/*AUTOINST*/
    // Outputs
    .OTP_D                               (OTP_D[7:0]                           ),
    .OTP_LOCK                            (OTP_LOCK                             ),
    .OTP_VTDO                            (OTP_VTDO                             ),

    // Inouts
    .OTP_VPP                             (OTP_VPP                              ),
    .OTP_VREFM                           (OTP_VREFM                            ),

    // Inputs
    .SCANTEST                            (SCANTEST                             ),
    .SCANCLK                             (SCANCLK                              ),
    .SCANRSTN                            (SCANRSTN                             ),

    .ISO_EN                              (ISO_EN                               ),
    .ISO_ENn                             (ISO_ENn                              ),

    .OTP_A                               (OTP_A[17:0]                          ),
    .OTP_CEB                             (OTP_CEB                              ),
    .OTP_CLE                             (OTP_CLE                              ),
    .OTP_CPUMPEN                         (OTP_CPUMPEN                          ),
    .OTP_DIN                             (OTP_DIN                              ),
    .OTP_DLE                             (OTP_DLE                              ),
    .OTP_PGMEN                           (OTP_PGMEN                            ),
    .OTP_READEN                          (OTP_READEN                           ),
    .OTP_RSTB                            (OTP_RSTB                             ),
    .OTP_TVBG                            (OTP_TVBG[2:0]                        ),
    .OTP_TVPP                            (OTP_TVPP[2:0]                        ),
    .OTP_WEB                             (OTP_WEB                              ),
    .OTP_VBG                             (OTP_VBG                              ));

pmu_coreif x_pmu_coreif
    (/*AUTOINST*/
    // Output
	.OTP_INIT_READY                       (OTP_INIT_READY                       ),
    .OTP_INIT_DONE                        (OTP_INIT_DONE                        ),

    // Input
    .GCLK                                 (XIN                                  ),
    .RESETn                               (PORn                                 ),

	.OTP_INIT_VALID                       (OTP_INIT_VALID                       ),
	.OTP_INIT_DATA                        (OTP_INIT_DATA                        ),
	.OTP_INIT_ADDR                        (OTP_INIT_ADDR                        ));


//--------------------------------------------------
// M4 ROM BOOT
//--------------------------------------------------
// `define TEST_TOP
// ./cmbus.v in duv.rtl.fnc.v

parameter   BW = 32;
parameter   depth = 64 * 256; //8960 32KB

reg [BW-1:00]   memory[(depth*2)-1:0];
reg [543:0]     mem[511:0]; // cm memory

integer     i,j;

`define DIRECT
`define CODE_PROTECT

`define cm_imem     `CMBUS_TOP.x_cmb_core.xTSDEMUX_TOP.x_tsdemux_core.x_cm_imem_code
`define cm_dmem     `CMBUS_TOP.x_cmb_core.xTSDEMUX_TOP.x_tsdemux_core.x_cm_imem_data

reg                 Clock;
initial             Clock = 1;
always  #1.5        Clock = ~Clock;

reg     [31:0]      WData;
reg     [31:0]      RData;

reg                 HSELS;	
reg     [15:0]      HADDRS;	
reg     [1:0]       HTRANSS;	
reg                 HWRITES;
reg     [2:0]       HSIZES;
reg     [31:0]      HWDATAS;
reg                 HREADYS;

wire			    HREADYOUTS;
wire    [31:0]      HRDATAS;

reg     [31:0]      cmrom_size;

reg     [1023:0]    mem_tmp;

//-------------------------------------------------
// CM_ROM INIT
//-------------------------------------------------
task CM_ROM_INIT;
    begin
        i = 0;
        HREADYS = `cm_imem.HREADY ;

        $display("%t : cm4 rom_init !!",$time);
        for ( i = 0 ; i < depth*2 ; i = i + 1 ) begin
             memory[i] = 'hf1234567;
        end
        for ( i = 0 ; i < 512 ; i = i + 1 ) begin
             mem[i] = 0;
        end
        cmrom_size = `CMROM_SIZE;
        $display("%t : rom_read !!",$time);
        $display("%t : line number=%d !!",$time,cmrom_size);
        $readmemh(`CM_ROM, memory);

        force `cm_imem.MCLK     = Clock;
        force `cm_imem.HCLK     = Clock;
        force `cm_imem.HADDR    = HADDRS;
        force `cm_imem.HWRITE   = HWRITES;
        force `cm_imem.HSEL     = HSELS;
        force `cm_imem.HTRANS   = HTRANSS;
        force `cm_imem.HSIZE    = HSIZES;
        force `cm_imem.HWDATA   = HWDATAS;
        //force `cm_imem.HREADY   = HREADYS;
        force `cm_imem.HRESETn  = 1'b1;
        force HRDATAS           = `cm_imem.HRDATA; 
        force HREADYOUTS        = `cm_imem.HREADYOUT; 

        $display("%t : task start !!",$time);
        wait (`CMBUS_TOP.ARESETn_CMB == 1'b1);
        for ( i = 0 ; i < cmrom_size + 1 ; i = i + 1 ) begin
            $display("%t : i = %x !!",$time, i);
            AHBWrite('h0000+i*4, 2, memory[i],0);
            AHBRead ('h0000+i*4, 2, RData, 0);
            $display("read data : 0x%h",RData);
        end

        release `cm_imem.MCLK ;
        release `cm_imem.HCLK ;
        release `cm_imem.HADDR ;
        release `cm_imem.HWRITE ;
        release `cm_imem.HSEL ;
        release `cm_imem.HTRANS ;
        release `cm_imem.HSIZE ;
        release `cm_imem.HWDATA ;
        //release `cm_imem.HREADY ;
        release `cm_imem.HRESETn ;

        $display("%t : rom_end !!",$time);

        //force TEST_TOP.duv.xCORE.xCMBUS.x_cmb_core.xTSDEMUX_TOP.x_tsdemux_core.x_tsdemux_ip_top.CIPHER_I_OTP[31:0] = 32'h83a00057;
        `ifdef CODE_PROTECT
            force TEST_TOP.CFG_PMU_PM = 1'b1;          
        `endif

        //force `CMBUS_TOP.ACLK = Clock;
        #100;
        wait (TEST_TOP.xCMBUS.x_otp_wrap.x_otp_cmbinitif.oINITDONE);
        `ifdef RTL
            force `TSDEMUX_TOP.x_tsdemux_core.x_cfg.SWRESETN0[2:1] = 0 ; 
        `else
            force `TSDEMUX_TOP.x_tsdemux_core.x_cfg.SWRESETN[2] = 0 ; 
            force `TSDEMUX_TOP.x_tsdemux_core.x_cfg.SWRESETN[1] = 0 ; 
        `endif
    end
endtask
task CM_ROM_INIT_CELL; // TCC896x, TCC897x, TCC898x
    begin
        $display("%t : cm4 memory cell init !!",$time);
        for ( i = 0 ; i < depth*2 ; i = i + 1 ) begin
             memory[i] = 'hf1234567;
        end
        $display("%t : rom_read !!",$time);
        $readmemh(`CM_ROM, memory);

        for ( i = 0 ; i < depth ; i = i + 32 ) begin
            mem_tmp[(32* 1)-1:(32* 0)] = memory[i+ 0];
            mem_tmp[(32* 2)-1:(32* 1)] = memory[i+ 1];
            mem_tmp[(32* 3)-1:(32* 2)] = memory[i+ 2];
            mem_tmp[(32* 4)-1:(32* 3)] = memory[i+ 3];
            mem_tmp[(32* 5)-1:(32* 4)] = memory[i+ 4];
            mem_tmp[(32* 6)-1:(32* 5)] = memory[i+ 5];
            mem_tmp[(32* 7)-1:(32* 6)] = memory[i+ 6];
            mem_tmp[(32* 8)-1:(32* 7)] = memory[i+ 7];
            mem_tmp[(32* 9)-1:(32* 8)] = memory[i+ 8];
            mem_tmp[(32*10)-1:(32* 9)] = memory[i+ 9];
            mem_tmp[(32*11)-1:(32*10)] = memory[i+10];
            mem_tmp[(32*12)-1:(32*11)] = memory[i+11];
            mem_tmp[(32*13)-1:(32*12)] = memory[i+12];
            mem_tmp[(32*14)-1:(32*13)] = memory[i+13];
            mem_tmp[(32*15)-1:(32*14)] = memory[i+14];
            mem_tmp[(32*16)-1:(32*15)] = memory[i+15];
            mem_tmp[(32*17)-1:(32*16)] = memory[i+16];
            mem_tmp[(32*18)-1:(32*17)] = memory[i+17];
            mem_tmp[(32*19)-1:(32*18)] = memory[i+18];
            mem_tmp[(32*20)-1:(32*19)] = memory[i+19];
            mem_tmp[(32*21)-1:(32*20)] = memory[i+20];
            mem_tmp[(32*22)-1:(32*21)] = memory[i+21];
            mem_tmp[(32*23)-1:(32*22)] = memory[i+22];
            mem_tmp[(32*24)-1:(32*23)] = memory[i+23];
            mem_tmp[(32*25)-1:(32*24)] = memory[i+24];
            mem_tmp[(32*26)-1:(32*25)] = memory[i+25];
            mem_tmp[(32*27)-1:(32*26)] = memory[i+26];
            mem_tmp[(32*28)-1:(32*27)] = memory[i+27];
            mem_tmp[(32*29)-1:(32*28)] = memory[i+28];
            mem_tmp[(32*30)-1:(32*29)] = memory[i+29];
            mem_tmp[(32*31)-1:(32*30)] = memory[i+30];
            mem_tmp[(32*32)-1:(32*31)] = memory[i+31];
            `cm_imem.x_mem.mem[i/32] = {
                mem_tmp[(32*31)+31],mem_tmp[(32*30)+31],mem_tmp[(32*29)+31],mem_tmp[(32*28)+31],mem_tmp[(32*27)+31],mem_tmp[(32*26)+31],mem_tmp[(32*25)+31],mem_tmp[(32*24)+31],mem_tmp[(32*23)+31],mem_tmp[(32*22)+31],mem_tmp[(32*21)+31],mem_tmp[(32*20)+31],mem_tmp[(32*19)+31],mem_tmp[(32*18)+31],mem_tmp[(32*17)+31],mem_tmp[(32*16)+31],mem_tmp[(32*15)+31],mem_tmp[(32*14)+31],mem_tmp[(32*13)+31],mem_tmp[(32*12)+31],mem_tmp[(32*11)+31],mem_tmp[(32*10)+31],mem_tmp[(32*9)+31],mem_tmp[(32*8)+31],mem_tmp[(32*7)+31],mem_tmp[(32*6)+31],mem_tmp[(32*5)+31],mem_tmp[(32*4)+31],mem_tmp[(32*3)+31],mem_tmp[(32*2)+31],mem_tmp[(32*1)+31],mem_tmp[31],
                mem_tmp[(32*31)+30],mem_tmp[(32*30)+30],mem_tmp[(32*29)+30],mem_tmp[(32*28)+30],mem_tmp[(32*27)+30],mem_tmp[(32*26)+30],mem_tmp[(32*25)+30],mem_tmp[(32*24)+30],mem_tmp[(32*23)+30],mem_tmp[(32*22)+30],mem_tmp[(32*21)+30],mem_tmp[(32*20)+30],mem_tmp[(32*19)+30],mem_tmp[(32*18)+30],mem_tmp[(32*17)+30],mem_tmp[(32*16)+30],mem_tmp[(32*15)+30],mem_tmp[(32*14)+30],mem_tmp[(32*13)+30],mem_tmp[(32*12)+30],mem_tmp[(32*11)+30],mem_tmp[(32*10)+30],mem_tmp[(32*9)+30],mem_tmp[(32*8)+30],mem_tmp[(32*7)+30],mem_tmp[(32*6)+30],mem_tmp[(32*5)+30],mem_tmp[(32*4)+30],mem_tmp[(32*3)+30],mem_tmp[(32*2)+30],mem_tmp[(32*1)+30],mem_tmp[30],
                mem_tmp[(32*31)+29],mem_tmp[(32*30)+29],mem_tmp[(32*29)+29],mem_tmp[(32*28)+29],mem_tmp[(32*27)+29],mem_tmp[(32*26)+29],mem_tmp[(32*25)+29],mem_tmp[(32*24)+29],mem_tmp[(32*23)+29],mem_tmp[(32*22)+29],mem_tmp[(32*21)+29],mem_tmp[(32*20)+29],mem_tmp[(32*19)+29],mem_tmp[(32*18)+29],mem_tmp[(32*17)+29],mem_tmp[(32*16)+29],mem_tmp[(32*15)+29],mem_tmp[(32*14)+29],mem_tmp[(32*13)+29],mem_tmp[(32*12)+29],mem_tmp[(32*11)+29],mem_tmp[(32*10)+29],mem_tmp[(32*9)+29],mem_tmp[(32*8)+29],mem_tmp[(32*7)+29],mem_tmp[(32*6)+29],mem_tmp[(32*5)+29],mem_tmp[(32*4)+29],mem_tmp[(32*3)+29],mem_tmp[(32*2)+29],mem_tmp[(32*1)+29],mem_tmp[29],
                mem_tmp[(32*31)+28],mem_tmp[(32*30)+28],mem_tmp[(32*29)+28],mem_tmp[(32*28)+28],mem_tmp[(32*27)+28],mem_tmp[(32*26)+28],mem_tmp[(32*25)+28],mem_tmp[(32*24)+28],mem_tmp[(32*23)+28],mem_tmp[(32*22)+28],mem_tmp[(32*21)+28],mem_tmp[(32*20)+28],mem_tmp[(32*19)+28],mem_tmp[(32*18)+28],mem_tmp[(32*17)+28],mem_tmp[(32*16)+28],mem_tmp[(32*15)+28],mem_tmp[(32*14)+28],mem_tmp[(32*13)+28],mem_tmp[(32*12)+28],mem_tmp[(32*11)+28],mem_tmp[(32*10)+28],mem_tmp[(32*9)+28],mem_tmp[(32*8)+28],mem_tmp[(32*7)+28],mem_tmp[(32*6)+28],mem_tmp[(32*5)+28],mem_tmp[(32*4)+28],mem_tmp[(32*3)+28],mem_tmp[(32*2)+28],mem_tmp[(32*1)+28],mem_tmp[28],
                mem_tmp[(32*31)+27],mem_tmp[(32*30)+27],mem_tmp[(32*29)+27],mem_tmp[(32*28)+27],mem_tmp[(32*27)+27],mem_tmp[(32*26)+27],mem_tmp[(32*25)+27],mem_tmp[(32*24)+27],mem_tmp[(32*23)+27],mem_tmp[(32*22)+27],mem_tmp[(32*21)+27],mem_tmp[(32*20)+27],mem_tmp[(32*19)+27],mem_tmp[(32*18)+27],mem_tmp[(32*17)+27],mem_tmp[(32*16)+27],mem_tmp[(32*15)+27],mem_tmp[(32*14)+27],mem_tmp[(32*13)+27],mem_tmp[(32*12)+27],mem_tmp[(32*11)+27],mem_tmp[(32*10)+27],mem_tmp[(32*9)+27],mem_tmp[(32*8)+27],mem_tmp[(32*7)+27],mem_tmp[(32*6)+27],mem_tmp[(32*5)+27],mem_tmp[(32*4)+27],mem_tmp[(32*3)+27],mem_tmp[(32*2)+27],mem_tmp[(32*1)+27],mem_tmp[27],
                mem_tmp[(32*31)+26],mem_tmp[(32*30)+26],mem_tmp[(32*29)+26],mem_tmp[(32*28)+26],mem_tmp[(32*27)+26],mem_tmp[(32*26)+26],mem_tmp[(32*25)+26],mem_tmp[(32*24)+26],mem_tmp[(32*23)+26],mem_tmp[(32*22)+26],mem_tmp[(32*21)+26],mem_tmp[(32*20)+26],mem_tmp[(32*19)+26],mem_tmp[(32*18)+26],mem_tmp[(32*17)+26],mem_tmp[(32*16)+26],mem_tmp[(32*15)+26],mem_tmp[(32*14)+26],mem_tmp[(32*13)+26],mem_tmp[(32*12)+26],mem_tmp[(32*11)+26],mem_tmp[(32*10)+26],mem_tmp[(32*9)+26],mem_tmp[(32*8)+26],mem_tmp[(32*7)+26],mem_tmp[(32*6)+26],mem_tmp[(32*5)+26],mem_tmp[(32*4)+26],mem_tmp[(32*3)+26],mem_tmp[(32*2)+26],mem_tmp[(32*1)+26],mem_tmp[26],
                mem_tmp[(32*31)+25],mem_tmp[(32*30)+25],mem_tmp[(32*29)+25],mem_tmp[(32*28)+25],mem_tmp[(32*27)+25],mem_tmp[(32*26)+25],mem_tmp[(32*25)+25],mem_tmp[(32*24)+25],mem_tmp[(32*23)+25],mem_tmp[(32*22)+25],mem_tmp[(32*21)+25],mem_tmp[(32*20)+25],mem_tmp[(32*19)+25],mem_tmp[(32*18)+25],mem_tmp[(32*17)+25],mem_tmp[(32*16)+25],mem_tmp[(32*15)+25],mem_tmp[(32*14)+25],mem_tmp[(32*13)+25],mem_tmp[(32*12)+25],mem_tmp[(32*11)+25],mem_tmp[(32*10)+25],mem_tmp[(32*9)+25],mem_tmp[(32*8)+25],mem_tmp[(32*7)+25],mem_tmp[(32*6)+25],mem_tmp[(32*5)+25],mem_tmp[(32*4)+25],mem_tmp[(32*3)+25],mem_tmp[(32*2)+25],mem_tmp[(32*1)+25],mem_tmp[25],
                mem_tmp[(32*31)+24],mem_tmp[(32*30)+24],mem_tmp[(32*29)+24],mem_tmp[(32*28)+24],mem_tmp[(32*27)+24],mem_tmp[(32*26)+24],mem_tmp[(32*25)+24],mem_tmp[(32*24)+24],mem_tmp[(32*23)+24],mem_tmp[(32*22)+24],mem_tmp[(32*21)+24],mem_tmp[(32*20)+24],mem_tmp[(32*19)+24],mem_tmp[(32*18)+24],mem_tmp[(32*17)+24],mem_tmp[(32*16)+24],mem_tmp[(32*15)+24],mem_tmp[(32*14)+24],mem_tmp[(32*13)+24],mem_tmp[(32*12)+24],mem_tmp[(32*11)+24],mem_tmp[(32*10)+24],mem_tmp[(32*9)+24],mem_tmp[(32*8)+24],mem_tmp[(32*7)+24],mem_tmp[(32*6)+24],mem_tmp[(32*5)+24],mem_tmp[(32*4)+24],mem_tmp[(32*3)+24],mem_tmp[(32*2)+24],mem_tmp[(32*1)+24],mem_tmp[24],
                mem_tmp[(32*31)+23],mem_tmp[(32*30)+23],mem_tmp[(32*29)+23],mem_tmp[(32*28)+23],mem_tmp[(32*27)+23],mem_tmp[(32*26)+23],mem_tmp[(32*25)+23],mem_tmp[(32*24)+23],mem_tmp[(32*23)+23],mem_tmp[(32*22)+23],mem_tmp[(32*21)+23],mem_tmp[(32*20)+23],mem_tmp[(32*19)+23],mem_tmp[(32*18)+23],mem_tmp[(32*17)+23],mem_tmp[(32*16)+23],mem_tmp[(32*15)+23],mem_tmp[(32*14)+23],mem_tmp[(32*13)+23],mem_tmp[(32*12)+23],mem_tmp[(32*11)+23],mem_tmp[(32*10)+23],mem_tmp[(32*9)+23],mem_tmp[(32*8)+23],mem_tmp[(32*7)+23],mem_tmp[(32*6)+23],mem_tmp[(32*5)+23],mem_tmp[(32*4)+23],mem_tmp[(32*3)+23],mem_tmp[(32*2)+23],mem_tmp[(32*1)+23],mem_tmp[23],
                mem_tmp[(32*31)+22],mem_tmp[(32*30)+22],mem_tmp[(32*29)+22],mem_tmp[(32*28)+22],mem_tmp[(32*27)+22],mem_tmp[(32*26)+22],mem_tmp[(32*25)+22],mem_tmp[(32*24)+22],mem_tmp[(32*23)+22],mem_tmp[(32*22)+22],mem_tmp[(32*21)+22],mem_tmp[(32*20)+22],mem_tmp[(32*19)+22],mem_tmp[(32*18)+22],mem_tmp[(32*17)+22],mem_tmp[(32*16)+22],mem_tmp[(32*15)+22],mem_tmp[(32*14)+22],mem_tmp[(32*13)+22],mem_tmp[(32*12)+22],mem_tmp[(32*11)+22],mem_tmp[(32*10)+22],mem_tmp[(32*9)+22],mem_tmp[(32*8)+22],mem_tmp[(32*7)+22],mem_tmp[(32*6)+22],mem_tmp[(32*5)+22],mem_tmp[(32*4)+22],mem_tmp[(32*3)+22],mem_tmp[(32*2)+22],mem_tmp[(32*1)+22],mem_tmp[22],
                mem_tmp[(32*31)+21],mem_tmp[(32*30)+21],mem_tmp[(32*29)+21],mem_tmp[(32*28)+21],mem_tmp[(32*27)+21],mem_tmp[(32*26)+21],mem_tmp[(32*25)+21],mem_tmp[(32*24)+21],mem_tmp[(32*23)+21],mem_tmp[(32*22)+21],mem_tmp[(32*21)+21],mem_tmp[(32*20)+21],mem_tmp[(32*19)+21],mem_tmp[(32*18)+21],mem_tmp[(32*17)+21],mem_tmp[(32*16)+21],mem_tmp[(32*15)+21],mem_tmp[(32*14)+21],mem_tmp[(32*13)+21],mem_tmp[(32*12)+21],mem_tmp[(32*11)+21],mem_tmp[(32*10)+21],mem_tmp[(32*9)+21],mem_tmp[(32*8)+21],mem_tmp[(32*7)+21],mem_tmp[(32*6)+21],mem_tmp[(32*5)+21],mem_tmp[(32*4)+21],mem_tmp[(32*3)+21],mem_tmp[(32*2)+21],mem_tmp[(32*1)+21],mem_tmp[21],
                mem_tmp[(32*31)+20],mem_tmp[(32*30)+20],mem_tmp[(32*29)+20],mem_tmp[(32*28)+20],mem_tmp[(32*27)+20],mem_tmp[(32*26)+20],mem_tmp[(32*25)+20],mem_tmp[(32*24)+20],mem_tmp[(32*23)+20],mem_tmp[(32*22)+20],mem_tmp[(32*21)+20],mem_tmp[(32*20)+20],mem_tmp[(32*19)+20],mem_tmp[(32*18)+20],mem_tmp[(32*17)+20],mem_tmp[(32*16)+20],mem_tmp[(32*15)+20],mem_tmp[(32*14)+20],mem_tmp[(32*13)+20],mem_tmp[(32*12)+20],mem_tmp[(32*11)+20],mem_tmp[(32*10)+20],mem_tmp[(32*9)+20],mem_tmp[(32*8)+20],mem_tmp[(32*7)+20],mem_tmp[(32*6)+20],mem_tmp[(32*5)+20],mem_tmp[(32*4)+20],mem_tmp[(32*3)+20],mem_tmp[(32*2)+20],mem_tmp[(32*1)+20],mem_tmp[20],
                mem_tmp[(32*31)+19],mem_tmp[(32*30)+19],mem_tmp[(32*29)+19],mem_tmp[(32*28)+19],mem_tmp[(32*27)+19],mem_tmp[(32*26)+19],mem_tmp[(32*25)+19],mem_tmp[(32*24)+19],mem_tmp[(32*23)+19],mem_tmp[(32*22)+19],mem_tmp[(32*21)+19],mem_tmp[(32*20)+19],mem_tmp[(32*19)+19],mem_tmp[(32*18)+19],mem_tmp[(32*17)+19],mem_tmp[(32*16)+19],mem_tmp[(32*15)+19],mem_tmp[(32*14)+19],mem_tmp[(32*13)+19],mem_tmp[(32*12)+19],mem_tmp[(32*11)+19],mem_tmp[(32*10)+19],mem_tmp[(32*9)+19],mem_tmp[(32*8)+19],mem_tmp[(32*7)+19],mem_tmp[(32*6)+19],mem_tmp[(32*5)+19],mem_tmp[(32*4)+19],mem_tmp[(32*3)+19],mem_tmp[(32*2)+19],mem_tmp[(32*1)+19],mem_tmp[19],
                mem_tmp[(32*31)+18],mem_tmp[(32*30)+18],mem_tmp[(32*29)+18],mem_tmp[(32*28)+18],mem_tmp[(32*27)+18],mem_tmp[(32*26)+18],mem_tmp[(32*25)+18],mem_tmp[(32*24)+18],mem_tmp[(32*23)+18],mem_tmp[(32*22)+18],mem_tmp[(32*21)+18],mem_tmp[(32*20)+18],mem_tmp[(32*19)+18],mem_tmp[(32*18)+18],mem_tmp[(32*17)+18],mem_tmp[(32*16)+18],mem_tmp[(32*15)+18],mem_tmp[(32*14)+18],mem_tmp[(32*13)+18],mem_tmp[(32*12)+18],mem_tmp[(32*11)+18],mem_tmp[(32*10)+18],mem_tmp[(32*9)+18],mem_tmp[(32*8)+18],mem_tmp[(32*7)+18],mem_tmp[(32*6)+18],mem_tmp[(32*5)+18],mem_tmp[(32*4)+18],mem_tmp[(32*3)+18],mem_tmp[(32*2)+18],mem_tmp[(32*1)+18],mem_tmp[18],
                mem_tmp[(32*31)+17],mem_tmp[(32*30)+17],mem_tmp[(32*29)+17],mem_tmp[(32*28)+17],mem_tmp[(32*27)+17],mem_tmp[(32*26)+17],mem_tmp[(32*25)+17],mem_tmp[(32*24)+17],mem_tmp[(32*23)+17],mem_tmp[(32*22)+17],mem_tmp[(32*21)+17],mem_tmp[(32*20)+17],mem_tmp[(32*19)+17],mem_tmp[(32*18)+17],mem_tmp[(32*17)+17],mem_tmp[(32*16)+17],mem_tmp[(32*15)+17],mem_tmp[(32*14)+17],mem_tmp[(32*13)+17],mem_tmp[(32*12)+17],mem_tmp[(32*11)+17],mem_tmp[(32*10)+17],mem_tmp[(32*9)+17],mem_tmp[(32*8)+17],mem_tmp[(32*7)+17],mem_tmp[(32*6)+17],mem_tmp[(32*5)+17],mem_tmp[(32*4)+17],mem_tmp[(32*3)+17],mem_tmp[(32*2)+17],mem_tmp[(32*1)+17],mem_tmp[17],
                mem_tmp[(32*31)+16],mem_tmp[(32*30)+16],mem_tmp[(32*29)+16],mem_tmp[(32*28)+16],mem_tmp[(32*27)+16],mem_tmp[(32*26)+16],mem_tmp[(32*25)+16],mem_tmp[(32*24)+16],mem_tmp[(32*23)+16],mem_tmp[(32*22)+16],mem_tmp[(32*21)+16],mem_tmp[(32*20)+16],mem_tmp[(32*19)+16],mem_tmp[(32*18)+16],mem_tmp[(32*17)+16],mem_tmp[(32*16)+16],mem_tmp[(32*15)+16],mem_tmp[(32*14)+16],mem_tmp[(32*13)+16],mem_tmp[(32*12)+16],mem_tmp[(32*11)+16],mem_tmp[(32*10)+16],mem_tmp[(32*9)+16],mem_tmp[(32*8)+16],mem_tmp[(32*7)+16],mem_tmp[(32*6)+16],mem_tmp[(32*5)+16],mem_tmp[(32*4)+16],mem_tmp[(32*3)+16],mem_tmp[(32*2)+16],mem_tmp[(32*1)+16],mem_tmp[16],
                mem_tmp[(32*31)+15],mem_tmp[(32*30)+15],mem_tmp[(32*29)+15],mem_tmp[(32*28)+15],mem_tmp[(32*27)+15],mem_tmp[(32*26)+15],mem_tmp[(32*25)+15],mem_tmp[(32*24)+15],mem_tmp[(32*23)+15],mem_tmp[(32*22)+15],mem_tmp[(32*21)+15],mem_tmp[(32*20)+15],mem_tmp[(32*19)+15],mem_tmp[(32*18)+15],mem_tmp[(32*17)+15],mem_tmp[(32*16)+15],mem_tmp[(32*15)+15],mem_tmp[(32*14)+15],mem_tmp[(32*13)+15],mem_tmp[(32*12)+15],mem_tmp[(32*11)+15],mem_tmp[(32*10)+15],mem_tmp[(32*9)+15],mem_tmp[(32*8)+15],mem_tmp[(32*7)+15],mem_tmp[(32*6)+15],mem_tmp[(32*5)+15],mem_tmp[(32*4)+15],mem_tmp[(32*3)+15],mem_tmp[(32*2)+15],mem_tmp[(32*1)+15],mem_tmp[15],
                mem_tmp[(32*31)+14],mem_tmp[(32*30)+14],mem_tmp[(32*29)+14],mem_tmp[(32*28)+14],mem_tmp[(32*27)+14],mem_tmp[(32*26)+14],mem_tmp[(32*25)+14],mem_tmp[(32*24)+14],mem_tmp[(32*23)+14],mem_tmp[(32*22)+14],mem_tmp[(32*21)+14],mem_tmp[(32*20)+14],mem_tmp[(32*19)+14],mem_tmp[(32*18)+14],mem_tmp[(32*17)+14],mem_tmp[(32*16)+14],mem_tmp[(32*15)+14],mem_tmp[(32*14)+14],mem_tmp[(32*13)+14],mem_tmp[(32*12)+14],mem_tmp[(32*11)+14],mem_tmp[(32*10)+14],mem_tmp[(32*9)+14],mem_tmp[(32*8)+14],mem_tmp[(32*7)+14],mem_tmp[(32*6)+14],mem_tmp[(32*5)+14],mem_tmp[(32*4)+14],mem_tmp[(32*3)+14],mem_tmp[(32*2)+14],mem_tmp[(32*1)+14],mem_tmp[14],
                mem_tmp[(32*31)+13],mem_tmp[(32*30)+13],mem_tmp[(32*29)+13],mem_tmp[(32*28)+13],mem_tmp[(32*27)+13],mem_tmp[(32*26)+13],mem_tmp[(32*25)+13],mem_tmp[(32*24)+13],mem_tmp[(32*23)+13],mem_tmp[(32*22)+13],mem_tmp[(32*21)+13],mem_tmp[(32*20)+13],mem_tmp[(32*19)+13],mem_tmp[(32*18)+13],mem_tmp[(32*17)+13],mem_tmp[(32*16)+13],mem_tmp[(32*15)+13],mem_tmp[(32*14)+13],mem_tmp[(32*13)+13],mem_tmp[(32*12)+13],mem_tmp[(32*11)+13],mem_tmp[(32*10)+13],mem_tmp[(32*9)+13],mem_tmp[(32*8)+13],mem_tmp[(32*7)+13],mem_tmp[(32*6)+13],mem_tmp[(32*5)+13],mem_tmp[(32*4)+13],mem_tmp[(32*3)+13],mem_tmp[(32*2)+13],mem_tmp[(32*1)+13],mem_tmp[13],
                mem_tmp[(32*31)+12],mem_tmp[(32*30)+12],mem_tmp[(32*29)+12],mem_tmp[(32*28)+12],mem_tmp[(32*27)+12],mem_tmp[(32*26)+12],mem_tmp[(32*25)+12],mem_tmp[(32*24)+12],mem_tmp[(32*23)+12],mem_tmp[(32*22)+12],mem_tmp[(32*21)+12],mem_tmp[(32*20)+12],mem_tmp[(32*19)+12],mem_tmp[(32*18)+12],mem_tmp[(32*17)+12],mem_tmp[(32*16)+12],mem_tmp[(32*15)+12],mem_tmp[(32*14)+12],mem_tmp[(32*13)+12],mem_tmp[(32*12)+12],mem_tmp[(32*11)+12],mem_tmp[(32*10)+12],mem_tmp[(32*9)+12],mem_tmp[(32*8)+12],mem_tmp[(32*7)+12],mem_tmp[(32*6)+12],mem_tmp[(32*5)+12],mem_tmp[(32*4)+12],mem_tmp[(32*3)+12],mem_tmp[(32*2)+12],mem_tmp[(32*1)+12],mem_tmp[12],
                mem_tmp[(32*31)+11],mem_tmp[(32*30)+11],mem_tmp[(32*29)+11],mem_tmp[(32*28)+11],mem_tmp[(32*27)+11],mem_tmp[(32*26)+11],mem_tmp[(32*25)+11],mem_tmp[(32*24)+11],mem_tmp[(32*23)+11],mem_tmp[(32*22)+11],mem_tmp[(32*21)+11],mem_tmp[(32*20)+11],mem_tmp[(32*19)+11],mem_tmp[(32*18)+11],mem_tmp[(32*17)+11],mem_tmp[(32*16)+11],mem_tmp[(32*15)+11],mem_tmp[(32*14)+11],mem_tmp[(32*13)+11],mem_tmp[(32*12)+11],mem_tmp[(32*11)+11],mem_tmp[(32*10)+11],mem_tmp[(32*9)+11],mem_tmp[(32*8)+11],mem_tmp[(32*7)+11],mem_tmp[(32*6)+11],mem_tmp[(32*5)+11],mem_tmp[(32*4)+11],mem_tmp[(32*3)+11],mem_tmp[(32*2)+11],mem_tmp[(32*1)+11],mem_tmp[11],
                mem_tmp[(32*31)+10],mem_tmp[(32*30)+10],mem_tmp[(32*29)+10],mem_tmp[(32*28)+10],mem_tmp[(32*27)+10],mem_tmp[(32*26)+10],mem_tmp[(32*25)+10],mem_tmp[(32*24)+10],mem_tmp[(32*23)+10],mem_tmp[(32*22)+10],mem_tmp[(32*21)+10],mem_tmp[(32*20)+10],mem_tmp[(32*19)+10],mem_tmp[(32*18)+10],mem_tmp[(32*17)+10],mem_tmp[(32*16)+10],mem_tmp[(32*15)+10],mem_tmp[(32*14)+10],mem_tmp[(32*13)+10],mem_tmp[(32*12)+10],mem_tmp[(32*11)+10],mem_tmp[(32*10)+10],mem_tmp[(32*9)+10],mem_tmp[(32*8)+10],mem_tmp[(32*7)+10],mem_tmp[(32*6)+10],mem_tmp[(32*5)+10],mem_tmp[(32*4)+10],mem_tmp[(32*3)+10],mem_tmp[(32*2)+10],mem_tmp[(32*1)+10],mem_tmp[10],
                mem_tmp[(32*31)+ 9],mem_tmp[(32*30)+ 9],mem_tmp[(32*29)+ 9],mem_tmp[(32*28)+ 9],mem_tmp[(32*27)+ 9],mem_tmp[(32*26)+ 9],mem_tmp[(32*25)+ 9],mem_tmp[(32*24)+ 9],mem_tmp[(32*23)+ 9],mem_tmp[(32*22)+ 9],mem_tmp[(32*21)+ 9],mem_tmp[(32*20)+ 9],mem_tmp[(32*19)+ 9],mem_tmp[(32*18)+ 9],mem_tmp[(32*17)+ 9],mem_tmp[(32*16)+ 9],mem_tmp[(32*15)+ 9],mem_tmp[(32*14)+ 9],mem_tmp[(32*13)+ 9],mem_tmp[(32*12)+ 9],mem_tmp[(32*11)+ 9],mem_tmp[(32*10)+ 9],mem_tmp[(32*9)+ 9],mem_tmp[(32*8)+ 9],mem_tmp[(32*7)+ 9],mem_tmp[(32*6)+ 9],mem_tmp[(32*5)+ 9],mem_tmp[(32*4)+ 9],mem_tmp[(32*3)+ 9],mem_tmp[(32*2)+ 9],mem_tmp[(32*1)+ 9],mem_tmp[ 9],
                mem_tmp[(32*31)+ 8],mem_tmp[(32*30)+ 8],mem_tmp[(32*29)+ 8],mem_tmp[(32*28)+ 8],mem_tmp[(32*27)+ 8],mem_tmp[(32*26)+ 8],mem_tmp[(32*25)+ 8],mem_tmp[(32*24)+ 8],mem_tmp[(32*23)+ 8],mem_tmp[(32*22)+ 8],mem_tmp[(32*21)+ 8],mem_tmp[(32*20)+ 8],mem_tmp[(32*19)+ 8],mem_tmp[(32*18)+ 8],mem_tmp[(32*17)+ 8],mem_tmp[(32*16)+ 8],mem_tmp[(32*15)+ 8],mem_tmp[(32*14)+ 8],mem_tmp[(32*13)+ 8],mem_tmp[(32*12)+ 8],mem_tmp[(32*11)+ 8],mem_tmp[(32*10)+ 8],mem_tmp[(32*9)+ 8],mem_tmp[(32*8)+ 8],mem_tmp[(32*7)+ 8],mem_tmp[(32*6)+ 8],mem_tmp[(32*5)+ 8],mem_tmp[(32*4)+ 8],mem_tmp[(32*3)+ 8],mem_tmp[(32*2)+ 8],mem_tmp[(32*1)+ 8],mem_tmp[ 8],
                mem_tmp[(32*31)+ 7],mem_tmp[(32*30)+ 7],mem_tmp[(32*29)+ 7],mem_tmp[(32*28)+ 7],mem_tmp[(32*27)+ 7],mem_tmp[(32*26)+ 7],mem_tmp[(32*25)+ 7],mem_tmp[(32*24)+ 7],mem_tmp[(32*23)+ 7],mem_tmp[(32*22)+ 7],mem_tmp[(32*21)+ 7],mem_tmp[(32*20)+ 7],mem_tmp[(32*19)+ 7],mem_tmp[(32*18)+ 7],mem_tmp[(32*17)+ 7],mem_tmp[(32*16)+ 7],mem_tmp[(32*15)+ 7],mem_tmp[(32*14)+ 7],mem_tmp[(32*13)+ 7],mem_tmp[(32*12)+ 7],mem_tmp[(32*11)+ 7],mem_tmp[(32*10)+ 7],mem_tmp[(32*9)+ 7],mem_tmp[(32*8)+ 7],mem_tmp[(32*7)+ 7],mem_tmp[(32*6)+ 7],mem_tmp[(32*5)+ 7],mem_tmp[(32*4)+ 7],mem_tmp[(32*3)+ 7],mem_tmp[(32*2)+ 7],mem_tmp[(32*1)+ 7],mem_tmp[ 7],
                mem_tmp[(32*31)+ 6],mem_tmp[(32*30)+ 6],mem_tmp[(32*29)+ 6],mem_tmp[(32*28)+ 6],mem_tmp[(32*27)+ 6],mem_tmp[(32*26)+ 6],mem_tmp[(32*25)+ 6],mem_tmp[(32*24)+ 6],mem_tmp[(32*23)+ 6],mem_tmp[(32*22)+ 6],mem_tmp[(32*21)+ 6],mem_tmp[(32*20)+ 6],mem_tmp[(32*19)+ 6],mem_tmp[(32*18)+ 6],mem_tmp[(32*17)+ 6],mem_tmp[(32*16)+ 6],mem_tmp[(32*15)+ 6],mem_tmp[(32*14)+ 6],mem_tmp[(32*13)+ 6],mem_tmp[(32*12)+ 6],mem_tmp[(32*11)+ 6],mem_tmp[(32*10)+ 6],mem_tmp[(32*9)+ 6],mem_tmp[(32*8)+ 6],mem_tmp[(32*7)+ 6],mem_tmp[(32*6)+ 6],mem_tmp[(32*5)+ 6],mem_tmp[(32*4)+ 6],mem_tmp[(32*3)+ 6],mem_tmp[(32*2)+ 6],mem_tmp[(32*1)+ 6],mem_tmp[ 6],
                mem_tmp[(32*31)+ 5],mem_tmp[(32*30)+ 5],mem_tmp[(32*29)+ 5],mem_tmp[(32*28)+ 5],mem_tmp[(32*27)+ 5],mem_tmp[(32*26)+ 5],mem_tmp[(32*25)+ 5],mem_tmp[(32*24)+ 5],mem_tmp[(32*23)+ 5],mem_tmp[(32*22)+ 5],mem_tmp[(32*21)+ 5],mem_tmp[(32*20)+ 5],mem_tmp[(32*19)+ 5],mem_tmp[(32*18)+ 5],mem_tmp[(32*17)+ 5],mem_tmp[(32*16)+ 5],mem_tmp[(32*15)+ 5],mem_tmp[(32*14)+ 5],mem_tmp[(32*13)+ 5],mem_tmp[(32*12)+ 5],mem_tmp[(32*11)+ 5],mem_tmp[(32*10)+ 5],mem_tmp[(32*9)+ 5],mem_tmp[(32*8)+ 5],mem_tmp[(32*7)+ 5],mem_tmp[(32*6)+ 5],mem_tmp[(32*5)+ 5],mem_tmp[(32*4)+ 5],mem_tmp[(32*3)+ 5],mem_tmp[(32*2)+ 5],mem_tmp[(32*1)+ 5],mem_tmp[ 5],
                mem_tmp[(32*31)+ 4],mem_tmp[(32*30)+ 4],mem_tmp[(32*29)+ 4],mem_tmp[(32*28)+ 4],mem_tmp[(32*27)+ 4],mem_tmp[(32*26)+ 4],mem_tmp[(32*25)+ 4],mem_tmp[(32*24)+ 4],mem_tmp[(32*23)+ 4],mem_tmp[(32*22)+ 4],mem_tmp[(32*21)+ 4],mem_tmp[(32*20)+ 4],mem_tmp[(32*19)+ 4],mem_tmp[(32*18)+ 4],mem_tmp[(32*17)+ 4],mem_tmp[(32*16)+ 4],mem_tmp[(32*15)+ 4],mem_tmp[(32*14)+ 4],mem_tmp[(32*13)+ 4],mem_tmp[(32*12)+ 4],mem_tmp[(32*11)+ 4],mem_tmp[(32*10)+ 4],mem_tmp[(32*9)+ 4],mem_tmp[(32*8)+ 4],mem_tmp[(32*7)+ 4],mem_tmp[(32*6)+ 4],mem_tmp[(32*5)+ 4],mem_tmp[(32*4)+ 4],mem_tmp[(32*3)+ 4],mem_tmp[(32*2)+ 4],mem_tmp[(32*1)+ 4],mem_tmp[ 4],
                mem_tmp[(32*31)+ 3],mem_tmp[(32*30)+ 3],mem_tmp[(32*29)+ 3],mem_tmp[(32*28)+ 3],mem_tmp[(32*27)+ 3],mem_tmp[(32*26)+ 3],mem_tmp[(32*25)+ 3],mem_tmp[(32*24)+ 3],mem_tmp[(32*23)+ 3],mem_tmp[(32*22)+ 3],mem_tmp[(32*21)+ 3],mem_tmp[(32*20)+ 3],mem_tmp[(32*19)+ 3],mem_tmp[(32*18)+ 3],mem_tmp[(32*17)+ 3],mem_tmp[(32*16)+ 3],mem_tmp[(32*15)+ 3],mem_tmp[(32*14)+ 3],mem_tmp[(32*13)+ 3],mem_tmp[(32*12)+ 3],mem_tmp[(32*11)+ 3],mem_tmp[(32*10)+ 3],mem_tmp[(32*9)+ 3],mem_tmp[(32*8)+ 3],mem_tmp[(32*7)+ 3],mem_tmp[(32*6)+ 3],mem_tmp[(32*5)+ 3],mem_tmp[(32*4)+ 3],mem_tmp[(32*3)+ 3],mem_tmp[(32*2)+ 3],mem_tmp[(32*1)+ 3],mem_tmp[ 3],
                mem_tmp[(32*31)+ 2],mem_tmp[(32*30)+ 2],mem_tmp[(32*29)+ 2],mem_tmp[(32*28)+ 2],mem_tmp[(32*27)+ 2],mem_tmp[(32*26)+ 2],mem_tmp[(32*25)+ 2],mem_tmp[(32*24)+ 2],mem_tmp[(32*23)+ 2],mem_tmp[(32*22)+ 2],mem_tmp[(32*21)+ 2],mem_tmp[(32*20)+ 2],mem_tmp[(32*19)+ 2],mem_tmp[(32*18)+ 2],mem_tmp[(32*17)+ 2],mem_tmp[(32*16)+ 2],mem_tmp[(32*15)+ 2],mem_tmp[(32*14)+ 2],mem_tmp[(32*13)+ 2],mem_tmp[(32*12)+ 2],mem_tmp[(32*11)+ 2],mem_tmp[(32*10)+ 2],mem_tmp[(32*9)+ 2],mem_tmp[(32*8)+ 2],mem_tmp[(32*7)+ 2],mem_tmp[(32*6)+ 2],mem_tmp[(32*5)+ 2],mem_tmp[(32*4)+ 2],mem_tmp[(32*3)+ 2],mem_tmp[(32*2)+ 2],mem_tmp[(32*1)+ 2],mem_tmp[ 2],
                mem_tmp[(32*31)+ 1],mem_tmp[(32*30)+ 1],mem_tmp[(32*29)+ 1],mem_tmp[(32*28)+ 1],mem_tmp[(32*27)+ 1],mem_tmp[(32*26)+ 1],mem_tmp[(32*25)+ 1],mem_tmp[(32*24)+ 1],mem_tmp[(32*23)+ 1],mem_tmp[(32*22)+ 1],mem_tmp[(32*21)+ 1],mem_tmp[(32*20)+ 1],mem_tmp[(32*19)+ 1],mem_tmp[(32*18)+ 1],mem_tmp[(32*17)+ 1],mem_tmp[(32*16)+ 1],mem_tmp[(32*15)+ 1],mem_tmp[(32*14)+ 1],mem_tmp[(32*13)+ 1],mem_tmp[(32*12)+ 1],mem_tmp[(32*11)+ 1],mem_tmp[(32*10)+ 1],mem_tmp[(32*9)+ 1],mem_tmp[(32*8)+ 1],mem_tmp[(32*7)+ 1],mem_tmp[(32*6)+ 1],mem_tmp[(32*5)+ 1],mem_tmp[(32*4)+ 1],mem_tmp[(32*3)+ 1],mem_tmp[(32*2)+ 1],mem_tmp[(32*1)+ 1],mem_tmp[ 1],
                mem_tmp[(32*31)+ 0],mem_tmp[(32*30)+ 0],mem_tmp[(32*29)+ 0],mem_tmp[(32*28)+ 0],mem_tmp[(32*27)+ 0],mem_tmp[(32*26)+ 0],mem_tmp[(32*25)+ 0],mem_tmp[(32*24)+ 0],mem_tmp[(32*23)+ 0],mem_tmp[(32*22)+ 0],mem_tmp[(32*21)+ 0],mem_tmp[(32*20)+ 0],mem_tmp[(32*19)+ 0],mem_tmp[(32*18)+ 0],mem_tmp[(32*17)+ 0],mem_tmp[(32*16)+ 0],mem_tmp[(32*15)+ 0],mem_tmp[(32*14)+ 0],mem_tmp[(32*13)+ 0],mem_tmp[(32*12)+ 0],mem_tmp[(32*11)+ 0],mem_tmp[(32*10)+ 0],mem_tmp[(32*9)+ 0],mem_tmp[(32*8)+ 0],mem_tmp[(32*7)+ 0],mem_tmp[(32*6)+ 0],mem_tmp[(32*5)+ 0],mem_tmp[(32*4)+ 0],mem_tmp[(32*3)+ 0],mem_tmp[(32*2)+ 0],mem_tmp[(32*1)+ 0],mem_tmp[ 0]
            };
        end
        
        for ( i = 0 ; i < depth ; i = i + 32 ) begin
            mem_tmp[(32* 1)-1:(32* 0)] = memory[depth+i+ 0];
            mem_tmp[(32* 2)-1:(32* 1)] = memory[depth+i+ 1];
            mem_tmp[(32* 3)-1:(32* 2)] = memory[depth+i+ 2];
            mem_tmp[(32* 4)-1:(32* 3)] = memory[depth+i+ 3];
            mem_tmp[(32* 5)-1:(32* 4)] = memory[depth+i+ 4];
            mem_tmp[(32* 6)-1:(32* 5)] = memory[depth+i+ 5];
            mem_tmp[(32* 7)-1:(32* 6)] = memory[depth+i+ 6];
            mem_tmp[(32* 8)-1:(32* 7)] = memory[depth+i+ 7];
            mem_tmp[(32* 9)-1:(32* 8)] = memory[depth+i+ 8];
            mem_tmp[(32*10)-1:(32* 9)] = memory[depth+i+ 9];
            mem_tmp[(32*11)-1:(32*10)] = memory[depth+i+10];
            mem_tmp[(32*12)-1:(32*11)] = memory[depth+i+11];
            mem_tmp[(32*13)-1:(32*12)] = memory[depth+i+12];
            mem_tmp[(32*14)-1:(32*13)] = memory[depth+i+13];
            mem_tmp[(32*15)-1:(32*14)] = memory[depth+i+14];
            mem_tmp[(32*16)-1:(32*15)] = memory[depth+i+15];
            mem_tmp[(32*17)-1:(32*16)] = memory[depth+i+16];
            mem_tmp[(32*18)-1:(32*17)] = memory[depth+i+17];
            mem_tmp[(32*19)-1:(32*18)] = memory[depth+i+18];
            mem_tmp[(32*20)-1:(32*19)] = memory[depth+i+19];
            mem_tmp[(32*21)-1:(32*20)] = memory[depth+i+20];
            mem_tmp[(32*22)-1:(32*21)] = memory[depth+i+21];
            mem_tmp[(32*23)-1:(32*22)] = memory[depth+i+22];
            mem_tmp[(32*24)-1:(32*23)] = memory[depth+i+23];
            mem_tmp[(32*25)-1:(32*24)] = memory[depth+i+24];
            mem_tmp[(32*26)-1:(32*25)] = memory[depth+i+25];
            mem_tmp[(32*27)-1:(32*26)] = memory[depth+i+26];
            mem_tmp[(32*28)-1:(32*27)] = memory[depth+i+27];
            mem_tmp[(32*29)-1:(32*28)] = memory[depth+i+28];
            mem_tmp[(32*30)-1:(32*29)] = memory[depth+i+29];
            mem_tmp[(32*31)-1:(32*30)] = memory[depth+i+30];
            mem_tmp[(32*32)-1:(32*31)] = memory[depth+i+31];
            `cm_dmem.x_mem.mem[i/32] = {
                mem_tmp[(32*31)+31],mem_tmp[(32*30)+31],mem_tmp[(32*29)+31],mem_tmp[(32*28)+31],mem_tmp[(32*27)+31],mem_tmp[(32*26)+31],mem_tmp[(32*25)+31],mem_tmp[(32*24)+31],mem_tmp[(32*23)+31],mem_tmp[(32*22)+31],mem_tmp[(32*21)+31],mem_tmp[(32*20)+31],mem_tmp[(32*19)+31],mem_tmp[(32*18)+31],mem_tmp[(32*17)+31],mem_tmp[(32*16)+31],mem_tmp[(32*15)+31],mem_tmp[(32*14)+31],mem_tmp[(32*13)+31],mem_tmp[(32*12)+31],mem_tmp[(32*11)+31],mem_tmp[(32*10)+31],mem_tmp[(32*9)+31],mem_tmp[(32*8)+31],mem_tmp[(32*7)+31],mem_tmp[(32*6)+31],mem_tmp[(32*5)+31],mem_tmp[(32*4)+31],mem_tmp[(32*3)+31],mem_tmp[(32*2)+31],mem_tmp[(32*1)+31],mem_tmp[31],
                mem_tmp[(32*31)+30],mem_tmp[(32*30)+30],mem_tmp[(32*29)+30],mem_tmp[(32*28)+30],mem_tmp[(32*27)+30],mem_tmp[(32*26)+30],mem_tmp[(32*25)+30],mem_tmp[(32*24)+30],mem_tmp[(32*23)+30],mem_tmp[(32*22)+30],mem_tmp[(32*21)+30],mem_tmp[(32*20)+30],mem_tmp[(32*19)+30],mem_tmp[(32*18)+30],mem_tmp[(32*17)+30],mem_tmp[(32*16)+30],mem_tmp[(32*15)+30],mem_tmp[(32*14)+30],mem_tmp[(32*13)+30],mem_tmp[(32*12)+30],mem_tmp[(32*11)+30],mem_tmp[(32*10)+30],mem_tmp[(32*9)+30],mem_tmp[(32*8)+30],mem_tmp[(32*7)+30],mem_tmp[(32*6)+30],mem_tmp[(32*5)+30],mem_tmp[(32*4)+30],mem_tmp[(32*3)+30],mem_tmp[(32*2)+30],mem_tmp[(32*1)+30],mem_tmp[30],
                mem_tmp[(32*31)+29],mem_tmp[(32*30)+29],mem_tmp[(32*29)+29],mem_tmp[(32*28)+29],mem_tmp[(32*27)+29],mem_tmp[(32*26)+29],mem_tmp[(32*25)+29],mem_tmp[(32*24)+29],mem_tmp[(32*23)+29],mem_tmp[(32*22)+29],mem_tmp[(32*21)+29],mem_tmp[(32*20)+29],mem_tmp[(32*19)+29],mem_tmp[(32*18)+29],mem_tmp[(32*17)+29],mem_tmp[(32*16)+29],mem_tmp[(32*15)+29],mem_tmp[(32*14)+29],mem_tmp[(32*13)+29],mem_tmp[(32*12)+29],mem_tmp[(32*11)+29],mem_tmp[(32*10)+29],mem_tmp[(32*9)+29],mem_tmp[(32*8)+29],mem_tmp[(32*7)+29],mem_tmp[(32*6)+29],mem_tmp[(32*5)+29],mem_tmp[(32*4)+29],mem_tmp[(32*3)+29],mem_tmp[(32*2)+29],mem_tmp[(32*1)+29],mem_tmp[29],
                mem_tmp[(32*31)+28],mem_tmp[(32*30)+28],mem_tmp[(32*29)+28],mem_tmp[(32*28)+28],mem_tmp[(32*27)+28],mem_tmp[(32*26)+28],mem_tmp[(32*25)+28],mem_tmp[(32*24)+28],mem_tmp[(32*23)+28],mem_tmp[(32*22)+28],mem_tmp[(32*21)+28],mem_tmp[(32*20)+28],mem_tmp[(32*19)+28],mem_tmp[(32*18)+28],mem_tmp[(32*17)+28],mem_tmp[(32*16)+28],mem_tmp[(32*15)+28],mem_tmp[(32*14)+28],mem_tmp[(32*13)+28],mem_tmp[(32*12)+28],mem_tmp[(32*11)+28],mem_tmp[(32*10)+28],mem_tmp[(32*9)+28],mem_tmp[(32*8)+28],mem_tmp[(32*7)+28],mem_tmp[(32*6)+28],mem_tmp[(32*5)+28],mem_tmp[(32*4)+28],mem_tmp[(32*3)+28],mem_tmp[(32*2)+28],mem_tmp[(32*1)+28],mem_tmp[28],
                mem_tmp[(32*31)+27],mem_tmp[(32*30)+27],mem_tmp[(32*29)+27],mem_tmp[(32*28)+27],mem_tmp[(32*27)+27],mem_tmp[(32*26)+27],mem_tmp[(32*25)+27],mem_tmp[(32*24)+27],mem_tmp[(32*23)+27],mem_tmp[(32*22)+27],mem_tmp[(32*21)+27],mem_tmp[(32*20)+27],mem_tmp[(32*19)+27],mem_tmp[(32*18)+27],mem_tmp[(32*17)+27],mem_tmp[(32*16)+27],mem_tmp[(32*15)+27],mem_tmp[(32*14)+27],mem_tmp[(32*13)+27],mem_tmp[(32*12)+27],mem_tmp[(32*11)+27],mem_tmp[(32*10)+27],mem_tmp[(32*9)+27],mem_tmp[(32*8)+27],mem_tmp[(32*7)+27],mem_tmp[(32*6)+27],mem_tmp[(32*5)+27],mem_tmp[(32*4)+27],mem_tmp[(32*3)+27],mem_tmp[(32*2)+27],mem_tmp[(32*1)+27],mem_tmp[27],
                mem_tmp[(32*31)+26],mem_tmp[(32*30)+26],mem_tmp[(32*29)+26],mem_tmp[(32*28)+26],mem_tmp[(32*27)+26],mem_tmp[(32*26)+26],mem_tmp[(32*25)+26],mem_tmp[(32*24)+26],mem_tmp[(32*23)+26],mem_tmp[(32*22)+26],mem_tmp[(32*21)+26],mem_tmp[(32*20)+26],mem_tmp[(32*19)+26],mem_tmp[(32*18)+26],mem_tmp[(32*17)+26],mem_tmp[(32*16)+26],mem_tmp[(32*15)+26],mem_tmp[(32*14)+26],mem_tmp[(32*13)+26],mem_tmp[(32*12)+26],mem_tmp[(32*11)+26],mem_tmp[(32*10)+26],mem_tmp[(32*9)+26],mem_tmp[(32*8)+26],mem_tmp[(32*7)+26],mem_tmp[(32*6)+26],mem_tmp[(32*5)+26],mem_tmp[(32*4)+26],mem_tmp[(32*3)+26],mem_tmp[(32*2)+26],mem_tmp[(32*1)+26],mem_tmp[26],
                mem_tmp[(32*31)+25],mem_tmp[(32*30)+25],mem_tmp[(32*29)+25],mem_tmp[(32*28)+25],mem_tmp[(32*27)+25],mem_tmp[(32*26)+25],mem_tmp[(32*25)+25],mem_tmp[(32*24)+25],mem_tmp[(32*23)+25],mem_tmp[(32*22)+25],mem_tmp[(32*21)+25],mem_tmp[(32*20)+25],mem_tmp[(32*19)+25],mem_tmp[(32*18)+25],mem_tmp[(32*17)+25],mem_tmp[(32*16)+25],mem_tmp[(32*15)+25],mem_tmp[(32*14)+25],mem_tmp[(32*13)+25],mem_tmp[(32*12)+25],mem_tmp[(32*11)+25],mem_tmp[(32*10)+25],mem_tmp[(32*9)+25],mem_tmp[(32*8)+25],mem_tmp[(32*7)+25],mem_tmp[(32*6)+25],mem_tmp[(32*5)+25],mem_tmp[(32*4)+25],mem_tmp[(32*3)+25],mem_tmp[(32*2)+25],mem_tmp[(32*1)+25],mem_tmp[25],
                mem_tmp[(32*31)+24],mem_tmp[(32*30)+24],mem_tmp[(32*29)+24],mem_tmp[(32*28)+24],mem_tmp[(32*27)+24],mem_tmp[(32*26)+24],mem_tmp[(32*25)+24],mem_tmp[(32*24)+24],mem_tmp[(32*23)+24],mem_tmp[(32*22)+24],mem_tmp[(32*21)+24],mem_tmp[(32*20)+24],mem_tmp[(32*19)+24],mem_tmp[(32*18)+24],mem_tmp[(32*17)+24],mem_tmp[(32*16)+24],mem_tmp[(32*15)+24],mem_tmp[(32*14)+24],mem_tmp[(32*13)+24],mem_tmp[(32*12)+24],mem_tmp[(32*11)+24],mem_tmp[(32*10)+24],mem_tmp[(32*9)+24],mem_tmp[(32*8)+24],mem_tmp[(32*7)+24],mem_tmp[(32*6)+24],mem_tmp[(32*5)+24],mem_tmp[(32*4)+24],mem_tmp[(32*3)+24],mem_tmp[(32*2)+24],mem_tmp[(32*1)+24],mem_tmp[24],
                mem_tmp[(32*31)+23],mem_tmp[(32*30)+23],mem_tmp[(32*29)+23],mem_tmp[(32*28)+23],mem_tmp[(32*27)+23],mem_tmp[(32*26)+23],mem_tmp[(32*25)+23],mem_tmp[(32*24)+23],mem_tmp[(32*23)+23],mem_tmp[(32*22)+23],mem_tmp[(32*21)+23],mem_tmp[(32*20)+23],mem_tmp[(32*19)+23],mem_tmp[(32*18)+23],mem_tmp[(32*17)+23],mem_tmp[(32*16)+23],mem_tmp[(32*15)+23],mem_tmp[(32*14)+23],mem_tmp[(32*13)+23],mem_tmp[(32*12)+23],mem_tmp[(32*11)+23],mem_tmp[(32*10)+23],mem_tmp[(32*9)+23],mem_tmp[(32*8)+23],mem_tmp[(32*7)+23],mem_tmp[(32*6)+23],mem_tmp[(32*5)+23],mem_tmp[(32*4)+23],mem_tmp[(32*3)+23],mem_tmp[(32*2)+23],mem_tmp[(32*1)+23],mem_tmp[23],
                mem_tmp[(32*31)+22],mem_tmp[(32*30)+22],mem_tmp[(32*29)+22],mem_tmp[(32*28)+22],mem_tmp[(32*27)+22],mem_tmp[(32*26)+22],mem_tmp[(32*25)+22],mem_tmp[(32*24)+22],mem_tmp[(32*23)+22],mem_tmp[(32*22)+22],mem_tmp[(32*21)+22],mem_tmp[(32*20)+22],mem_tmp[(32*19)+22],mem_tmp[(32*18)+22],mem_tmp[(32*17)+22],mem_tmp[(32*16)+22],mem_tmp[(32*15)+22],mem_tmp[(32*14)+22],mem_tmp[(32*13)+22],mem_tmp[(32*12)+22],mem_tmp[(32*11)+22],mem_tmp[(32*10)+22],mem_tmp[(32*9)+22],mem_tmp[(32*8)+22],mem_tmp[(32*7)+22],mem_tmp[(32*6)+22],mem_tmp[(32*5)+22],mem_tmp[(32*4)+22],mem_tmp[(32*3)+22],mem_tmp[(32*2)+22],mem_tmp[(32*1)+22],mem_tmp[22],
                mem_tmp[(32*31)+21],mem_tmp[(32*30)+21],mem_tmp[(32*29)+21],mem_tmp[(32*28)+21],mem_tmp[(32*27)+21],mem_tmp[(32*26)+21],mem_tmp[(32*25)+21],mem_tmp[(32*24)+21],mem_tmp[(32*23)+21],mem_tmp[(32*22)+21],mem_tmp[(32*21)+21],mem_tmp[(32*20)+21],mem_tmp[(32*19)+21],mem_tmp[(32*18)+21],mem_tmp[(32*17)+21],mem_tmp[(32*16)+21],mem_tmp[(32*15)+21],mem_tmp[(32*14)+21],mem_tmp[(32*13)+21],mem_tmp[(32*12)+21],mem_tmp[(32*11)+21],mem_tmp[(32*10)+21],mem_tmp[(32*9)+21],mem_tmp[(32*8)+21],mem_tmp[(32*7)+21],mem_tmp[(32*6)+21],mem_tmp[(32*5)+21],mem_tmp[(32*4)+21],mem_tmp[(32*3)+21],mem_tmp[(32*2)+21],mem_tmp[(32*1)+21],mem_tmp[21],
                mem_tmp[(32*31)+20],mem_tmp[(32*30)+20],mem_tmp[(32*29)+20],mem_tmp[(32*28)+20],mem_tmp[(32*27)+20],mem_tmp[(32*26)+20],mem_tmp[(32*25)+20],mem_tmp[(32*24)+20],mem_tmp[(32*23)+20],mem_tmp[(32*22)+20],mem_tmp[(32*21)+20],mem_tmp[(32*20)+20],mem_tmp[(32*19)+20],mem_tmp[(32*18)+20],mem_tmp[(32*17)+20],mem_tmp[(32*16)+20],mem_tmp[(32*15)+20],mem_tmp[(32*14)+20],mem_tmp[(32*13)+20],mem_tmp[(32*12)+20],mem_tmp[(32*11)+20],mem_tmp[(32*10)+20],mem_tmp[(32*9)+20],mem_tmp[(32*8)+20],mem_tmp[(32*7)+20],mem_tmp[(32*6)+20],mem_tmp[(32*5)+20],mem_tmp[(32*4)+20],mem_tmp[(32*3)+20],mem_tmp[(32*2)+20],mem_tmp[(32*1)+20],mem_tmp[20],
                mem_tmp[(32*31)+19],mem_tmp[(32*30)+19],mem_tmp[(32*29)+19],mem_tmp[(32*28)+19],mem_tmp[(32*27)+19],mem_tmp[(32*26)+19],mem_tmp[(32*25)+19],mem_tmp[(32*24)+19],mem_tmp[(32*23)+19],mem_tmp[(32*22)+19],mem_tmp[(32*21)+19],mem_tmp[(32*20)+19],mem_tmp[(32*19)+19],mem_tmp[(32*18)+19],mem_tmp[(32*17)+19],mem_tmp[(32*16)+19],mem_tmp[(32*15)+19],mem_tmp[(32*14)+19],mem_tmp[(32*13)+19],mem_tmp[(32*12)+19],mem_tmp[(32*11)+19],mem_tmp[(32*10)+19],mem_tmp[(32*9)+19],mem_tmp[(32*8)+19],mem_tmp[(32*7)+19],mem_tmp[(32*6)+19],mem_tmp[(32*5)+19],mem_tmp[(32*4)+19],mem_tmp[(32*3)+19],mem_tmp[(32*2)+19],mem_tmp[(32*1)+19],mem_tmp[19],
                mem_tmp[(32*31)+18],mem_tmp[(32*30)+18],mem_tmp[(32*29)+18],mem_tmp[(32*28)+18],mem_tmp[(32*27)+18],mem_tmp[(32*26)+18],mem_tmp[(32*25)+18],mem_tmp[(32*24)+18],mem_tmp[(32*23)+18],mem_tmp[(32*22)+18],mem_tmp[(32*21)+18],mem_tmp[(32*20)+18],mem_tmp[(32*19)+18],mem_tmp[(32*18)+18],mem_tmp[(32*17)+18],mem_tmp[(32*16)+18],mem_tmp[(32*15)+18],mem_tmp[(32*14)+18],mem_tmp[(32*13)+18],mem_tmp[(32*12)+18],mem_tmp[(32*11)+18],mem_tmp[(32*10)+18],mem_tmp[(32*9)+18],mem_tmp[(32*8)+18],mem_tmp[(32*7)+18],mem_tmp[(32*6)+18],mem_tmp[(32*5)+18],mem_tmp[(32*4)+18],mem_tmp[(32*3)+18],mem_tmp[(32*2)+18],mem_tmp[(32*1)+18],mem_tmp[18],
                mem_tmp[(32*31)+17],mem_tmp[(32*30)+17],mem_tmp[(32*29)+17],mem_tmp[(32*28)+17],mem_tmp[(32*27)+17],mem_tmp[(32*26)+17],mem_tmp[(32*25)+17],mem_tmp[(32*24)+17],mem_tmp[(32*23)+17],mem_tmp[(32*22)+17],mem_tmp[(32*21)+17],mem_tmp[(32*20)+17],mem_tmp[(32*19)+17],mem_tmp[(32*18)+17],mem_tmp[(32*17)+17],mem_tmp[(32*16)+17],mem_tmp[(32*15)+17],mem_tmp[(32*14)+17],mem_tmp[(32*13)+17],mem_tmp[(32*12)+17],mem_tmp[(32*11)+17],mem_tmp[(32*10)+17],mem_tmp[(32*9)+17],mem_tmp[(32*8)+17],mem_tmp[(32*7)+17],mem_tmp[(32*6)+17],mem_tmp[(32*5)+17],mem_tmp[(32*4)+17],mem_tmp[(32*3)+17],mem_tmp[(32*2)+17],mem_tmp[(32*1)+17],mem_tmp[17],
                mem_tmp[(32*31)+16],mem_tmp[(32*30)+16],mem_tmp[(32*29)+16],mem_tmp[(32*28)+16],mem_tmp[(32*27)+16],mem_tmp[(32*26)+16],mem_tmp[(32*25)+16],mem_tmp[(32*24)+16],mem_tmp[(32*23)+16],mem_tmp[(32*22)+16],mem_tmp[(32*21)+16],mem_tmp[(32*20)+16],mem_tmp[(32*19)+16],mem_tmp[(32*18)+16],mem_tmp[(32*17)+16],mem_tmp[(32*16)+16],mem_tmp[(32*15)+16],mem_tmp[(32*14)+16],mem_tmp[(32*13)+16],mem_tmp[(32*12)+16],mem_tmp[(32*11)+16],mem_tmp[(32*10)+16],mem_tmp[(32*9)+16],mem_tmp[(32*8)+16],mem_tmp[(32*7)+16],mem_tmp[(32*6)+16],mem_tmp[(32*5)+16],mem_tmp[(32*4)+16],mem_tmp[(32*3)+16],mem_tmp[(32*2)+16],mem_tmp[(32*1)+16],mem_tmp[16],
                mem_tmp[(32*31)+15],mem_tmp[(32*30)+15],mem_tmp[(32*29)+15],mem_tmp[(32*28)+15],mem_tmp[(32*27)+15],mem_tmp[(32*26)+15],mem_tmp[(32*25)+15],mem_tmp[(32*24)+15],mem_tmp[(32*23)+15],mem_tmp[(32*22)+15],mem_tmp[(32*21)+15],mem_tmp[(32*20)+15],mem_tmp[(32*19)+15],mem_tmp[(32*18)+15],mem_tmp[(32*17)+15],mem_tmp[(32*16)+15],mem_tmp[(32*15)+15],mem_tmp[(32*14)+15],mem_tmp[(32*13)+15],mem_tmp[(32*12)+15],mem_tmp[(32*11)+15],mem_tmp[(32*10)+15],mem_tmp[(32*9)+15],mem_tmp[(32*8)+15],mem_tmp[(32*7)+15],mem_tmp[(32*6)+15],mem_tmp[(32*5)+15],mem_tmp[(32*4)+15],mem_tmp[(32*3)+15],mem_tmp[(32*2)+15],mem_tmp[(32*1)+15],mem_tmp[15],
                mem_tmp[(32*31)+14],mem_tmp[(32*30)+14],mem_tmp[(32*29)+14],mem_tmp[(32*28)+14],mem_tmp[(32*27)+14],mem_tmp[(32*26)+14],mem_tmp[(32*25)+14],mem_tmp[(32*24)+14],mem_tmp[(32*23)+14],mem_tmp[(32*22)+14],mem_tmp[(32*21)+14],mem_tmp[(32*20)+14],mem_tmp[(32*19)+14],mem_tmp[(32*18)+14],mem_tmp[(32*17)+14],mem_tmp[(32*16)+14],mem_tmp[(32*15)+14],mem_tmp[(32*14)+14],mem_tmp[(32*13)+14],mem_tmp[(32*12)+14],mem_tmp[(32*11)+14],mem_tmp[(32*10)+14],mem_tmp[(32*9)+14],mem_tmp[(32*8)+14],mem_tmp[(32*7)+14],mem_tmp[(32*6)+14],mem_tmp[(32*5)+14],mem_tmp[(32*4)+14],mem_tmp[(32*3)+14],mem_tmp[(32*2)+14],mem_tmp[(32*1)+14],mem_tmp[14],
                mem_tmp[(32*31)+13],mem_tmp[(32*30)+13],mem_tmp[(32*29)+13],mem_tmp[(32*28)+13],mem_tmp[(32*27)+13],mem_tmp[(32*26)+13],mem_tmp[(32*25)+13],mem_tmp[(32*24)+13],mem_tmp[(32*23)+13],mem_tmp[(32*22)+13],mem_tmp[(32*21)+13],mem_tmp[(32*20)+13],mem_tmp[(32*19)+13],mem_tmp[(32*18)+13],mem_tmp[(32*17)+13],mem_tmp[(32*16)+13],mem_tmp[(32*15)+13],mem_tmp[(32*14)+13],mem_tmp[(32*13)+13],mem_tmp[(32*12)+13],mem_tmp[(32*11)+13],mem_tmp[(32*10)+13],mem_tmp[(32*9)+13],mem_tmp[(32*8)+13],mem_tmp[(32*7)+13],mem_tmp[(32*6)+13],mem_tmp[(32*5)+13],mem_tmp[(32*4)+13],mem_tmp[(32*3)+13],mem_tmp[(32*2)+13],mem_tmp[(32*1)+13],mem_tmp[13],
                mem_tmp[(32*31)+12],mem_tmp[(32*30)+12],mem_tmp[(32*29)+12],mem_tmp[(32*28)+12],mem_tmp[(32*27)+12],mem_tmp[(32*26)+12],mem_tmp[(32*25)+12],mem_tmp[(32*24)+12],mem_tmp[(32*23)+12],mem_tmp[(32*22)+12],mem_tmp[(32*21)+12],mem_tmp[(32*20)+12],mem_tmp[(32*19)+12],mem_tmp[(32*18)+12],mem_tmp[(32*17)+12],mem_tmp[(32*16)+12],mem_tmp[(32*15)+12],mem_tmp[(32*14)+12],mem_tmp[(32*13)+12],mem_tmp[(32*12)+12],mem_tmp[(32*11)+12],mem_tmp[(32*10)+12],mem_tmp[(32*9)+12],mem_tmp[(32*8)+12],mem_tmp[(32*7)+12],mem_tmp[(32*6)+12],mem_tmp[(32*5)+12],mem_tmp[(32*4)+12],mem_tmp[(32*3)+12],mem_tmp[(32*2)+12],mem_tmp[(32*1)+12],mem_tmp[12],
                mem_tmp[(32*31)+11],mem_tmp[(32*30)+11],mem_tmp[(32*29)+11],mem_tmp[(32*28)+11],mem_tmp[(32*27)+11],mem_tmp[(32*26)+11],mem_tmp[(32*25)+11],mem_tmp[(32*24)+11],mem_tmp[(32*23)+11],mem_tmp[(32*22)+11],mem_tmp[(32*21)+11],mem_tmp[(32*20)+11],mem_tmp[(32*19)+11],mem_tmp[(32*18)+11],mem_tmp[(32*17)+11],mem_tmp[(32*16)+11],mem_tmp[(32*15)+11],mem_tmp[(32*14)+11],mem_tmp[(32*13)+11],mem_tmp[(32*12)+11],mem_tmp[(32*11)+11],mem_tmp[(32*10)+11],mem_tmp[(32*9)+11],mem_tmp[(32*8)+11],mem_tmp[(32*7)+11],mem_tmp[(32*6)+11],mem_tmp[(32*5)+11],mem_tmp[(32*4)+11],mem_tmp[(32*3)+11],mem_tmp[(32*2)+11],mem_tmp[(32*1)+11],mem_tmp[11],
                mem_tmp[(32*31)+10],mem_tmp[(32*30)+10],mem_tmp[(32*29)+10],mem_tmp[(32*28)+10],mem_tmp[(32*27)+10],mem_tmp[(32*26)+10],mem_tmp[(32*25)+10],mem_tmp[(32*24)+10],mem_tmp[(32*23)+10],mem_tmp[(32*22)+10],mem_tmp[(32*21)+10],mem_tmp[(32*20)+10],mem_tmp[(32*19)+10],mem_tmp[(32*18)+10],mem_tmp[(32*17)+10],mem_tmp[(32*16)+10],mem_tmp[(32*15)+10],mem_tmp[(32*14)+10],mem_tmp[(32*13)+10],mem_tmp[(32*12)+10],mem_tmp[(32*11)+10],mem_tmp[(32*10)+10],mem_tmp[(32*9)+10],mem_tmp[(32*8)+10],mem_tmp[(32*7)+10],mem_tmp[(32*6)+10],mem_tmp[(32*5)+10],mem_tmp[(32*4)+10],mem_tmp[(32*3)+10],mem_tmp[(32*2)+10],mem_tmp[(32*1)+10],mem_tmp[10],
                mem_tmp[(32*31)+ 9],mem_tmp[(32*30)+ 9],mem_tmp[(32*29)+ 9],mem_tmp[(32*28)+ 9],mem_tmp[(32*27)+ 9],mem_tmp[(32*26)+ 9],mem_tmp[(32*25)+ 9],mem_tmp[(32*24)+ 9],mem_tmp[(32*23)+ 9],mem_tmp[(32*22)+ 9],mem_tmp[(32*21)+ 9],mem_tmp[(32*20)+ 9],mem_tmp[(32*19)+ 9],mem_tmp[(32*18)+ 9],mem_tmp[(32*17)+ 9],mem_tmp[(32*16)+ 9],mem_tmp[(32*15)+ 9],mem_tmp[(32*14)+ 9],mem_tmp[(32*13)+ 9],mem_tmp[(32*12)+ 9],mem_tmp[(32*11)+ 9],mem_tmp[(32*10)+ 9],mem_tmp[(32*9)+ 9],mem_tmp[(32*8)+ 9],mem_tmp[(32*7)+ 9],mem_tmp[(32*6)+ 9],mem_tmp[(32*5)+ 9],mem_tmp[(32*4)+ 9],mem_tmp[(32*3)+ 9],mem_tmp[(32*2)+ 9],mem_tmp[(32*1)+ 9],mem_tmp[ 9],
                mem_tmp[(32*31)+ 8],mem_tmp[(32*30)+ 8],mem_tmp[(32*29)+ 8],mem_tmp[(32*28)+ 8],mem_tmp[(32*27)+ 8],mem_tmp[(32*26)+ 8],mem_tmp[(32*25)+ 8],mem_tmp[(32*24)+ 8],mem_tmp[(32*23)+ 8],mem_tmp[(32*22)+ 8],mem_tmp[(32*21)+ 8],mem_tmp[(32*20)+ 8],mem_tmp[(32*19)+ 8],mem_tmp[(32*18)+ 8],mem_tmp[(32*17)+ 8],mem_tmp[(32*16)+ 8],mem_tmp[(32*15)+ 8],mem_tmp[(32*14)+ 8],mem_tmp[(32*13)+ 8],mem_tmp[(32*12)+ 8],mem_tmp[(32*11)+ 8],mem_tmp[(32*10)+ 8],mem_tmp[(32*9)+ 8],mem_tmp[(32*8)+ 8],mem_tmp[(32*7)+ 8],mem_tmp[(32*6)+ 8],mem_tmp[(32*5)+ 8],mem_tmp[(32*4)+ 8],mem_tmp[(32*3)+ 8],mem_tmp[(32*2)+ 8],mem_tmp[(32*1)+ 8],mem_tmp[ 8],
                mem_tmp[(32*31)+ 7],mem_tmp[(32*30)+ 7],mem_tmp[(32*29)+ 7],mem_tmp[(32*28)+ 7],mem_tmp[(32*27)+ 7],mem_tmp[(32*26)+ 7],mem_tmp[(32*25)+ 7],mem_tmp[(32*24)+ 7],mem_tmp[(32*23)+ 7],mem_tmp[(32*22)+ 7],mem_tmp[(32*21)+ 7],mem_tmp[(32*20)+ 7],mem_tmp[(32*19)+ 7],mem_tmp[(32*18)+ 7],mem_tmp[(32*17)+ 7],mem_tmp[(32*16)+ 7],mem_tmp[(32*15)+ 7],mem_tmp[(32*14)+ 7],mem_tmp[(32*13)+ 7],mem_tmp[(32*12)+ 7],mem_tmp[(32*11)+ 7],mem_tmp[(32*10)+ 7],mem_tmp[(32*9)+ 7],mem_tmp[(32*8)+ 7],mem_tmp[(32*7)+ 7],mem_tmp[(32*6)+ 7],mem_tmp[(32*5)+ 7],mem_tmp[(32*4)+ 7],mem_tmp[(32*3)+ 7],mem_tmp[(32*2)+ 7],mem_tmp[(32*1)+ 7],mem_tmp[ 7],
                mem_tmp[(32*31)+ 6],mem_tmp[(32*30)+ 6],mem_tmp[(32*29)+ 6],mem_tmp[(32*28)+ 6],mem_tmp[(32*27)+ 6],mem_tmp[(32*26)+ 6],mem_tmp[(32*25)+ 6],mem_tmp[(32*24)+ 6],mem_tmp[(32*23)+ 6],mem_tmp[(32*22)+ 6],mem_tmp[(32*21)+ 6],mem_tmp[(32*20)+ 6],mem_tmp[(32*19)+ 6],mem_tmp[(32*18)+ 6],mem_tmp[(32*17)+ 6],mem_tmp[(32*16)+ 6],mem_tmp[(32*15)+ 6],mem_tmp[(32*14)+ 6],mem_tmp[(32*13)+ 6],mem_tmp[(32*12)+ 6],mem_tmp[(32*11)+ 6],mem_tmp[(32*10)+ 6],mem_tmp[(32*9)+ 6],mem_tmp[(32*8)+ 6],mem_tmp[(32*7)+ 6],mem_tmp[(32*6)+ 6],mem_tmp[(32*5)+ 6],mem_tmp[(32*4)+ 6],mem_tmp[(32*3)+ 6],mem_tmp[(32*2)+ 6],mem_tmp[(32*1)+ 6],mem_tmp[ 6],
                mem_tmp[(32*31)+ 5],mem_tmp[(32*30)+ 5],mem_tmp[(32*29)+ 5],mem_tmp[(32*28)+ 5],mem_tmp[(32*27)+ 5],mem_tmp[(32*26)+ 5],mem_tmp[(32*25)+ 5],mem_tmp[(32*24)+ 5],mem_tmp[(32*23)+ 5],mem_tmp[(32*22)+ 5],mem_tmp[(32*21)+ 5],mem_tmp[(32*20)+ 5],mem_tmp[(32*19)+ 5],mem_tmp[(32*18)+ 5],mem_tmp[(32*17)+ 5],mem_tmp[(32*16)+ 5],mem_tmp[(32*15)+ 5],mem_tmp[(32*14)+ 5],mem_tmp[(32*13)+ 5],mem_tmp[(32*12)+ 5],mem_tmp[(32*11)+ 5],mem_tmp[(32*10)+ 5],mem_tmp[(32*9)+ 5],mem_tmp[(32*8)+ 5],mem_tmp[(32*7)+ 5],mem_tmp[(32*6)+ 5],mem_tmp[(32*5)+ 5],mem_tmp[(32*4)+ 5],mem_tmp[(32*3)+ 5],mem_tmp[(32*2)+ 5],mem_tmp[(32*1)+ 5],mem_tmp[ 5],
                mem_tmp[(32*31)+ 4],mem_tmp[(32*30)+ 4],mem_tmp[(32*29)+ 4],mem_tmp[(32*28)+ 4],mem_tmp[(32*27)+ 4],mem_tmp[(32*26)+ 4],mem_tmp[(32*25)+ 4],mem_tmp[(32*24)+ 4],mem_tmp[(32*23)+ 4],mem_tmp[(32*22)+ 4],mem_tmp[(32*21)+ 4],mem_tmp[(32*20)+ 4],mem_tmp[(32*19)+ 4],mem_tmp[(32*18)+ 4],mem_tmp[(32*17)+ 4],mem_tmp[(32*16)+ 4],mem_tmp[(32*15)+ 4],mem_tmp[(32*14)+ 4],mem_tmp[(32*13)+ 4],mem_tmp[(32*12)+ 4],mem_tmp[(32*11)+ 4],mem_tmp[(32*10)+ 4],mem_tmp[(32*9)+ 4],mem_tmp[(32*8)+ 4],mem_tmp[(32*7)+ 4],mem_tmp[(32*6)+ 4],mem_tmp[(32*5)+ 4],mem_tmp[(32*4)+ 4],mem_tmp[(32*3)+ 4],mem_tmp[(32*2)+ 4],mem_tmp[(32*1)+ 4],mem_tmp[ 4],
                mem_tmp[(32*31)+ 3],mem_tmp[(32*30)+ 3],mem_tmp[(32*29)+ 3],mem_tmp[(32*28)+ 3],mem_tmp[(32*27)+ 3],mem_tmp[(32*26)+ 3],mem_tmp[(32*25)+ 3],mem_tmp[(32*24)+ 3],mem_tmp[(32*23)+ 3],mem_tmp[(32*22)+ 3],mem_tmp[(32*21)+ 3],mem_tmp[(32*20)+ 3],mem_tmp[(32*19)+ 3],mem_tmp[(32*18)+ 3],mem_tmp[(32*17)+ 3],mem_tmp[(32*16)+ 3],mem_tmp[(32*15)+ 3],mem_tmp[(32*14)+ 3],mem_tmp[(32*13)+ 3],mem_tmp[(32*12)+ 3],mem_tmp[(32*11)+ 3],mem_tmp[(32*10)+ 3],mem_tmp[(32*9)+ 3],mem_tmp[(32*8)+ 3],mem_tmp[(32*7)+ 3],mem_tmp[(32*6)+ 3],mem_tmp[(32*5)+ 3],mem_tmp[(32*4)+ 3],mem_tmp[(32*3)+ 3],mem_tmp[(32*2)+ 3],mem_tmp[(32*1)+ 3],mem_tmp[ 3],
                mem_tmp[(32*31)+ 2],mem_tmp[(32*30)+ 2],mem_tmp[(32*29)+ 2],mem_tmp[(32*28)+ 2],mem_tmp[(32*27)+ 2],mem_tmp[(32*26)+ 2],mem_tmp[(32*25)+ 2],mem_tmp[(32*24)+ 2],mem_tmp[(32*23)+ 2],mem_tmp[(32*22)+ 2],mem_tmp[(32*21)+ 2],mem_tmp[(32*20)+ 2],mem_tmp[(32*19)+ 2],mem_tmp[(32*18)+ 2],mem_tmp[(32*17)+ 2],mem_tmp[(32*16)+ 2],mem_tmp[(32*15)+ 2],mem_tmp[(32*14)+ 2],mem_tmp[(32*13)+ 2],mem_tmp[(32*12)+ 2],mem_tmp[(32*11)+ 2],mem_tmp[(32*10)+ 2],mem_tmp[(32*9)+ 2],mem_tmp[(32*8)+ 2],mem_tmp[(32*7)+ 2],mem_tmp[(32*6)+ 2],mem_tmp[(32*5)+ 2],mem_tmp[(32*4)+ 2],mem_tmp[(32*3)+ 2],mem_tmp[(32*2)+ 2],mem_tmp[(32*1)+ 2],mem_tmp[ 2],
                mem_tmp[(32*31)+ 1],mem_tmp[(32*30)+ 1],mem_tmp[(32*29)+ 1],mem_tmp[(32*28)+ 1],mem_tmp[(32*27)+ 1],mem_tmp[(32*26)+ 1],mem_tmp[(32*25)+ 1],mem_tmp[(32*24)+ 1],mem_tmp[(32*23)+ 1],mem_tmp[(32*22)+ 1],mem_tmp[(32*21)+ 1],mem_tmp[(32*20)+ 1],mem_tmp[(32*19)+ 1],mem_tmp[(32*18)+ 1],mem_tmp[(32*17)+ 1],mem_tmp[(32*16)+ 1],mem_tmp[(32*15)+ 1],mem_tmp[(32*14)+ 1],mem_tmp[(32*13)+ 1],mem_tmp[(32*12)+ 1],mem_tmp[(32*11)+ 1],mem_tmp[(32*10)+ 1],mem_tmp[(32*9)+ 1],mem_tmp[(32*8)+ 1],mem_tmp[(32*7)+ 1],mem_tmp[(32*6)+ 1],mem_tmp[(32*5)+ 1],mem_tmp[(32*4)+ 1],mem_tmp[(32*3)+ 1],mem_tmp[(32*2)+ 1],mem_tmp[(32*1)+ 1],mem_tmp[ 1],
                mem_tmp[(32*31)+ 0],mem_tmp[(32*30)+ 0],mem_tmp[(32*29)+ 0],mem_tmp[(32*28)+ 0],mem_tmp[(32*27)+ 0],mem_tmp[(32*26)+ 0],mem_tmp[(32*25)+ 0],mem_tmp[(32*24)+ 0],mem_tmp[(32*23)+ 0],mem_tmp[(32*22)+ 0],mem_tmp[(32*21)+ 0],mem_tmp[(32*20)+ 0],mem_tmp[(32*19)+ 0],mem_tmp[(32*18)+ 0],mem_tmp[(32*17)+ 0],mem_tmp[(32*16)+ 0],mem_tmp[(32*15)+ 0],mem_tmp[(32*14)+ 0],mem_tmp[(32*13)+ 0],mem_tmp[(32*12)+ 0],mem_tmp[(32*11)+ 0],mem_tmp[(32*10)+ 0],mem_tmp[(32*9)+ 0],mem_tmp[(32*8)+ 0],mem_tmp[(32*7)+ 0],mem_tmp[(32*6)+ 0],mem_tmp[(32*5)+ 0],mem_tmp[(32*4)+ 0],mem_tmp[(32*3)+ 0],mem_tmp[(32*2)+ 0],mem_tmp[(32*1)+ 0],mem_tmp[ 0]
            };
        end

        $display("%t : rom_end !!",$time);
        wait (`CMBUS_TOP.ARESETn_CMB == 1'b1);
        #1000;
        $display("%t : release cm4 reset !!",$time);
        wait (TEST_TOP.xCMBUS.x_otp_wrap.x_otp_cmbinitif.oINITDONE);
        force `TSDEMUX_TOP.x_tsdemux_core.x_cfg.SWRESETN[2:1] = 0;
    end
endtask
//-------------------------------------------------

wire    dHCLK;
wire    dFCLK;

assign #0.01 dHCLK = `CORTEX_M4.HCLK;
assign #0.01 dFCLK = `CORTEX_M4.FCLK;

initial begin
    $display ("%t : CMBUS RTL-SIM START",$time);
    //force `CMBUS_TOP.w_OtpUseIntOsc = 1'b0;
    // for CFG_EMAS_CMOSRA1
    `ifdef POST
        force TEST_TOP.duv.xCORE.VPIC_IRQO[127:0] = 128'h0; 
    `endif
    //`ifdef RTL //>> FAIL !!!!! IRQ shouled be matched with FCLK edge
    //    force `CORTEX_M4.FCLK =  dHCLK;
    //`endif
    //`ifdef RTL //>> FAIL !!!!! FCLK HCLK shouled be matched 
    //    force `CORTEX_M4.HCLK =  dFCLK;
    //`endif
    `ifdef FORCE_FCLK
        force `CORTEX_M4.FCLK =  `CORTEX_M4.HCLK;
    `endif
    //`ifdef PW_BYPASS
    //    force `CORTEX_M4.FCLK =  dHCLK;
    //    //force TEST_TOP.duv.xCORE.xCMBUS.TESTMODE_PW_VALID = 1'b1;
    //`endif

    force `CORTEX_M4.INTISR[239:16] = 0;
    //force `CMBUS_TOP.x_cmb_core.xTSDEMUX_TOP.x_tsdemux_core.CM_BOOT_RESETn = 1'b0;

    force `cm4.DAPABORT = 0;
    force `cm4.DAPADDR = 0;
    force `cm4.DAPCLKEN = 0;
    force `cm4.DAPEN = 1;
    force `cm4.DAPENABLE = 0;
    force `cm4.DAPRESETn = `CMBUS_TOP.x_cmb_core.xTSDEMUX_TOP.x_tsdemux_core.HRESETn;
    force `cm4.DAPSEL = 0;
    force `cm4.DAPWDATA = 0;
    force `cm4.DAPWRITE = 0;
    force `cm4.DNOTITRANS = 0;
    force `cm4.FIXMASTERTYPE = 0;
    force `cm4.PRDATA = 0;
    force `cm4.PREADY = 1;
    force `cm4.PSLVERR = 0;
    force `cm4.STKALIGNINIT = 0;

    force `cm4.RSTBYPASS = 1; // temp
    #1000;
    `ifndef NO_CM_ROM
        `ifdef DIRECT
            CM_ROM_INIT_CELL;
        `else // AHB TASK
            CM_ROM_INIT;
        `endif
    `endif
    //force `CMBUS_TOP.ACLK = Clock; // for speed!
       
    #100;
    //wait (TEST_TOP.xCMBUS.x_otp_wrap.x_otp_cmbinitif.oINITDONE);
    #50000000;
    $display ("%t : TIME OVER !!!!!!!!!!!!!!!!!!",$time);
    $finish;
end

`include    "./tasks.h"
//--------------------------------------------------

//`endif // RTL }}}

endmodule

// vim:ts=4:et:sw=4:sts=4
