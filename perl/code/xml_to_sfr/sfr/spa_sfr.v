//----------------------------------------------------------------------------------
//		Module Name : SPA_SFR.v
//
//		Project Name: GigaTron
//
//		Author		: Lee Eul-Hwan (eulhwan.lee@hp.com)
//----------------------------------------------------------------------------------
//	Date		Author					Remarks
//----------------------------------------------------------------------------------
//	2018-01-11	Lee Eul-Hwan    ACS_HISTO_EN default value changed (0->1)		
//----------------------------------------------------------------------------------
//	Notice
//	v:wA.B.C  C: code clean up (function no change)
//		  B: function change
//		  A: largen change
//----------------------------------------------------------------------------------
`include "SPA_BS.v"
`include  "spa_define.v"

module SPA_SFR
(

	i_TM,

	//  APB Interface
	i_HRESETn								,	// HW reset 
	i_PCLK									,	// APB signal
	i_PSEL									,	// APB signal
	i_PENABLE								,	// APB signal
	i_PADDR									,	// APB signal
	i_PWDATA								,	// APB signal
	i_PWRITE								,	// APB signal
	o_PRDATA								,	// APB signal
	
	// TZPC
	i_TZPC								,

	// Common SFR
	o_GRESETn					,
	o_DMA_RESETn						,
	o_CORE_START						,
	o_RX_DPI_MODE						,
	o_TX_COLOR_MODE						,
	o_RX_COLOR_MODE						,		
	o_SEG2_COLOR_MODE						,		
	o_ACS_COLOR_MODE						,		
	o_BLANK_COLOR_MODE						,		
	o_ACBD_COLOR_MODE						,		
	o_CLA_COLOR_MODE,
	o_NEWABSD_COLOR_MODE,
	o_ABSD_COLOR_MODE,
	o_MAGD_COLOR_MODE,
	o_RX_XD									,
	o_RX_YD									,	
	o_TX_XD									,
	o_TX_YD									,	
	o_ACS_XD,
	o_BLANK_XD,
	o_ACS_LAST_BAND_HEIGHT					,
	o_BLANK_LAST_BAND_HEIGHT					,
	i_CORE_BAND_END,
	i_CORE_PAGE_END,

	// Enable signal
	o_RC1_EN							,
	o_S1D_EN							,
	o_SCC_EN							,
	o_BLANK_EN							,
	o_ADAPT_EN							,
	o_SMAP_EN							,
	o_BDS_EN							,
	o_TX_CH_EN							,
	o_ACS_EN							,
	o_MAGD_EN							,

	// Padding
	o_CH2_PADDING_VAL					,		
	o_CH1_PADDING_VAL					,
	o_CH0_PADDING_VAL					,
	
	// VSD
	o_VSD_EN                           ,
	o_VSD_DEBUG                        ,
	o_VSD_TOP_BAND			   ,     
	o_VSD_K_DEPTH_MIN		   ,     	
	o_VSD_K_DEPTH_MID		   ,     	
	o_VSD_K_DEPTH_MAX		   ,     	
	o_VSD_K_DEPTH_MIN_TOP		   ,     
	o_VSD_K_DEPTH_MAX_TOP		   ,     
	o_VSD_K_DEPTH_COND		   ,     
	o_VSD_W_DEPTH_MIN		   ,     	
	o_VSD_W_DEPTH_MID		   ,     	
	o_VSD_W_DEPTH_MAX		   ,     	
	o_VSD_W_DEPTH_MIN_TOP		   ,     
	o_VSD_W_DEPTH_MAX_TOP		   ,     
	o_VSD_W_DEPTH_COND		   ,     
	o_VSD_THICKNESS_TH		   ,     
	o_VSD_CHROMA_TH1		   ,     	
	o_VSD_CHROMA_TH2		   ,     	
	o_VSD_CHROMA_TH1_TOP		   ,     
	o_VSD_CHROMA_TH2_TOP		   ,     
	o_VSD_CONTINUITY_TH		   ,     
	o_VSD_FREQUENCY_TH		   ,     
	o_VSD_REFINE_EN			   ,     	
	o_VSD_REFINE_TH			   ,     	
	o_VSD_CUR_MEM_INIT		   ,     	
	i_VSD_DONE_sp	                   ,



	// CIS_INTP
	o_CIS_SUB_EN,
	o_CIS_SUB_COEF_R2,
	o_CIS_SUB_COEF_R1,
	o_CIS_SUB_COEF_G2,
	o_CIS_SUB_COEF_G1,
	o_CIS_SUB_COEF_G0,
	o_CIS_SUB_COEF_B1,
	o_CIS_SUB_COEF_B0,
	i_CIS_CRC_0,
	i_CIS_CRC_1,
	i_CIS_CRC_2,
	i_VSD_CRC_0,
	i_VSD_CRC_1,
	i_VSD_CRC_2,
	// RC1
	o_RC1_SHIFT_VAL							,
	o_RC1_SHIFT_OFST						,
	o_RC1_LOOP_X							,
	o_RC1_LOOP_Y							,
	o_RC1_X_COF_00							,
	o_RC1_X_COF_03							,
	o_RC1_X_COF_10							,
	o_RC1_X_COF_13							,
	o_RC1_X_COF_20							,
	o_RC1_X_COF_23							,
	o_RC1_X_COF_30							,
	o_RC1_X_COF_33							,
	o_RC1_X_COF_01							,
	o_RC1_X_COF_02							,
	o_RC1_X_COF_11							,
	o_RC1_X_COF_12 							,
	o_RC1_X_COF_21							,
	o_RC1_X_COF_22 							,
	o_RC1_X_COF_31							,
	o_RC1_X_COF_32 							,
	o_RC1_Y_COF_00							,
	o_RC1_Y_COF_03							,
	o_RC1_Y_COF_10							,
	o_RC1_Y_COF_13							,
	o_RC1_Y_COF_20							,
	o_RC1_Y_COF_23							,
	o_RC1_Y_COF_30							,
	o_RC1_Y_COF_33							,
	o_RC1_Y_COF_01							,
	o_RC1_Y_COF_02							,
	o_RC1_Y_COF_11							,
	o_RC1_Y_COF_12 							,
	o_RC1_Y_COF_21							,
	o_RC1_Y_COF_22 							,
	o_RC1_Y_COF_31							,
	o_RC1_Y_COF_32 							,

	// RC2
	o_RC2_OUTIMG_WIDTH						,		 	
	o_RC2_OUTIMG_HEIGHT						,		
	o_RC2_MASK_IMG_BD						,			
	o_RC2_OVERLAP							,
	o_RC2_H_FRAC							,
	o_RC2_V_FRAC							,
						
	// ADAPT
	o_ASB_BLK_WIDTH					,
	o_ASB_BLK_HEIGHT					,
	o_ASB_BLK_X_NUM					,

	//SMAP
	i_SMAP_TX_CUR_ADDR						,
	i_SMAP_TX_SVC_CNT						,
	i_SMAP_OUT_LINES						,
	i_SMAP_DMA_TX_BUSY						,
	o_SMAP_R_RANGE1							,
	o_SMAP_R_RANGE2 						,
	o_SMAP_G_RANGE1 						,
	o_SMAP_G_RANGE2 						,
	o_SMAP_B_RANGE1							,
	o_SMAP_B_RANGE2							,
	o_SMAP_BINTH1							,
	o_SMAP_BINTH2        					,
	o_SMAP_BINTH3        					,
	o_SMAP_REFINE_ENABLE 					,
	o_SMAP_OUT_BANDS						,
	o_SMAP_DMA_ADDR							,
	o_SMAP_DMA_ADDR_INCR					,
	o_SMAP_TX_ADDR_MAX						,
	o_SMAP_TX_ADDR_MIN						,
	o_SMAP_DMA_TX_START						,

	//SEG1
	o_SEG1_EN					   ,
	o_SEG1_HVline_diff_th          ,
	o_SEG1_HVline_minmaxdiff_th1   ,
	o_SEG1_HVline_minmaxdiff_th2   ,
	o_SEG1_HVline_level_th         ,
	o_SEG1_Lowfreq_th              ,
	o_SEG1_Lowfreq_th2             ,
	o_SEG1_Highfreq_th             ,
	o_SEG1_Uni_lowfreq_th          ,
	o_SEG1_Uni_highfreq_th         ,
	o_SEG1_Uni_edge_th             ,
	o_SEG1_Uni_edge_th2            ,
	o_SEG1_ZC_edge_th              ,
	o_SEG1_ZC_scaling_shift        ,
	o_SEG1_White_th                ,
	o_SEG1_Enable_Y_text           ,

	//SEG2
	o_SEG2_EN						  ,
	o_SEG2_Enable_uniformtext         ,
	o_SEG2_Enable_FAR_9x9             ,
	o_SEG2_Enable_contoneImage        ,
	o_SEG2_FG_level_th                ,
	o_SEG2_text_index                 ,
	o_SEG2_edgecnt_th                 ,
	o_SEG2_halftonecnt_th             ,
	o_SEG2_uniformlinecnt_th          ,
	o_SEG2_zccnt_th                   ,
	o_SEG2_bgcnt_th                   ,
	o_SEG2_Neut_chroma_th             ,
	o_SEG2_Neut_chroma_th2_shiftcoef  ,
	o_SEG2_FAR_chroma_th              ,
	o_SEG2_FAR_chroma_th2_shiftcoef   ,
	o_SEG2_FAR_Y_th                   ,
	o_SEG2_FAR_Y_th2_shiftcoef1       ,
	o_SEG2_FAR_Y_th3_shiftcoef2       ,

	// SCC
	o_SCC_LATTICE_STEP						,
	o_SCC_FLOATING_MODE						,

		 //ACS_v2
		o_ACSv2_EN,
		o_ACSv2_BLOCK_SIZE_X,
		o_ACSv2_BLOCK_SIZE_Y,
		o_ACSv2_WHITE_TH,
		o_ACSv2_SATURATION_PXL_TH,
		o_ACSv2_SATURATION_PXL_CNT_TH,
		o_ACSv2_SATURATION_BLOCK_TH,
		o_ACSv2_VALUE_PXL_TH,
		o_ACSv2_VALUE_BLOCK_TH,
		o_ACSv2_HALFTONE_CNT,
		o_ACSv2_PUREHALFTONE_CNT,

		// ACSv2
		i_ACSv2_TBLK_PAGE,
		i_ACSv2_TBLK_NPAGE,
		i_ACSv2_CBLK,		 
		i_ACSv2_SBLK_PAGE, 
		i_ACSv2_SPXL_BLK_PAGE,
		i_ACSv2_SPXL_PAGE,

	// ACS
	o_ACS_WHITE_TH							,
	o_ACS_RANGE_REAL_IMAGE					,
	o_ACS_BLOCK_SIZE_Y						,
	o_ACS_BLOCK_SIZE_X						,
	o_ACS_DPI_Y								,
	o_ACS_DPI_X								,
	o_ACS_HISTO_EN							,
	o_ACS_MARK_ON							,
	o_ACS_BLOCK_SIZE_AUTO					,
	o_ACS_HALF_CNT_AUTO						,
	o_ACS_SATURATION_PXL_CNT_AUTO			,
	o_ACS_MARK_TOP		 					,
	o_ACS_MARK_BOTTOM						,
	o_ACS_MARK_LEFT		 					,
	o_ACS_MARK_RIGHT						,
	o_ACS_SATURATION_PXL_TH					,
	o_ACS_SATURATION_PXL_CNT_TH				,
	o_ACS_SATURATION_BLOCK_TH	 	 	 	,
	o_ACS_HALFTONE_CNT						,
	o_ACS_PUREHALFTONE_CNT					,
	o_ACS_CB_MAX_00							,
	o_ACS_CB_MAX_01							,
	o_ACS_CB_MAX_02							,
	o_ACS_CB_MAX_03							,
	o_ACS_CB_MAX_04							,
	o_ACS_CB_MAX_05							,
	o_ACS_CB_MAX_06							,
	o_ACS_CB_MAX_07							,
	o_ACS_CB_MAX_08							,
	o_ACS_CB_MAX_09							,
	o_ACS_CB_MAX_10							,
	o_ACS_CB_MAX_11							,
	o_ACS_CB_MAX_12							,
	o_ACS_CB_MAX_13							,
	o_ACS_CB_MAX_14							,
	o_ACS_CB_MAX_15							,
	o_ACS_CB_MIN_00							,
	o_ACS_CB_MIN_01							,
	o_ACS_CB_MIN_02							,
	o_ACS_CB_MIN_03							,
	o_ACS_CB_MIN_04							,
	o_ACS_CB_MIN_05							,
	o_ACS_CB_MIN_06							,
	o_ACS_CB_MIN_07							,
	o_ACS_CB_MIN_08							,
	o_ACS_CB_MIN_09							,
	o_ACS_CB_MIN_10							,
	o_ACS_CB_MIN_11							,
	o_ACS_CB_MIN_12							,
	o_ACS_CB_MIN_13							,
	o_ACS_CB_MIN_14							,
	o_ACS_CB_MIN_15							,
	o_ACS_CR_MAX_00							,
	o_ACS_CR_MAX_01							,
	o_ACS_CR_MAX_02							,
	o_ACS_CR_MAX_03							,
	o_ACS_CR_MAX_04							,
	o_ACS_CR_MAX_05							,
	o_ACS_CR_MAX_06							,
	o_ACS_CR_MAX_07							,
	o_ACS_CR_MAX_08							,
	o_ACS_CR_MAX_09							,
	o_ACS_CR_MAX_10							,
	o_ACS_CR_MAX_11							,
	o_ACS_CR_MAX_12							,
	o_ACS_CR_MAX_13							,
	o_ACS_CR_MAX_14							,
	o_ACS_CR_MAX_15							,
	o_ACS_CR_MIN_00							,
	o_ACS_CR_MIN_01							,
	o_ACS_CR_MIN_02							,
	o_ACS_CR_MIN_03							,
	o_ACS_CR_MIN_04							,
	o_ACS_CR_MIN_05							,
	o_ACS_CR_MIN_06							,
	o_ACS_CR_MIN_07							,
	o_ACS_CR_MIN_08							,
	o_ACS_CR_MIN_09							,
	o_ACS_CR_MIN_10							,
	o_ACS_CR_MIN_11							,
	o_ACS_CR_MIN_12							,
	o_ACS_CR_MIN_13							,
	o_ACS_CR_MIN_14							,
	o_ACS_CR_MIN_15							,
	o_ACS_CB_MAXh_00						,
	o_ACS_CB_MAXh_01						,
	o_ACS_CB_MAXh_02 						,
	o_ACS_CB_MAXh_03 						,
	o_ACS_CB_MAXh_04						,
	o_ACS_CB_MAXh_05						,
	o_ACS_CB_MAXh_06 						,
	o_ACS_CB_MAXh_07 						,
	o_ACS_CB_MAXh_08						,
	o_ACS_CB_MAXh_09						,
	o_ACS_CB_MAXh_10 						,
	o_ACS_CB_MAXh_11 						,
	o_ACS_CB_MAXh_12						,
	o_ACS_CB_MAXh_13						,
	o_ACS_CB_MAXh_14 						,
	o_ACS_CB_MAXh_15 						,
	o_ACS_CB_MINh_00						,
	o_ACS_CB_MINh_01						,
	o_ACS_CB_MINh_02 						,
	o_ACS_CB_MINh_03 						,
	o_ACS_CB_MINh_04						,
	o_ACS_CB_MINh_05						,
	o_ACS_CB_MINh_06 						,
	o_ACS_CB_MINh_07 						,
	o_ACS_CB_MINh_08						,
	o_ACS_CB_MINh_09						,
	o_ACS_CB_MINh_10 						,
	o_ACS_CB_MINh_11 						,
	o_ACS_CB_MINh_12						,
	o_ACS_CB_MINh_13						,
	o_ACS_CB_MINh_14 						,
	o_ACS_CB_MINh_15 						,
	o_ACS_CR_MAXh_00						,
	o_ACS_CR_MAXh_01						,
	o_ACS_CR_MAXh_02 						,
	o_ACS_CR_MAXh_03 						,
	o_ACS_CR_MAXh_04						,
	o_ACS_CR_MAXh_05						,
	o_ACS_CR_MAXh_06 						,
	o_ACS_CR_MAXh_07 						,
	o_ACS_CR_MAXh_08						,
	o_ACS_CR_MAXh_09						,
	o_ACS_CR_MAXh_10 						,
	o_ACS_CR_MAXh_11 						,
	o_ACS_CR_MAXh_12						,
	o_ACS_CR_MAXh_13						,
	o_ACS_CR_MAXh_14 						,
	o_ACS_CR_MAXh_15 						,
	o_ACS_CR_MINh_00						,
	o_ACS_CR_MINh_01						,
	o_ACS_CR_MINh_02 						,
	o_ACS_CR_MINh_03 						,
	o_ACS_CR_MINh_04						,
	o_ACS_CR_MINh_05						,
	o_ACS_CR_MINh_06 						,
	o_ACS_CR_MINh_07 						,
	o_ACS_CR_MINh_08						,
	o_ACS_CR_MINh_09						,
	o_ACS_CR_MINh_10 						,
	o_ACS_CR_MINh_11 						,
	o_ACS_CR_MINh_12						,
	o_ACS_CR_MINh_13						,
	o_ACS_CR_MINh_14 						,
	o_ACS_CR_MINh_15 						,

	// Blank
	o_BLANK_RANGE_REAL_IMAGE			,
	o_BLANK_BLOCK_SIZE_V				,
	o_BLANK_BLOCK_SIZE_H				,
	o_BLANK_DPI_V					,
	o_BLANK_DPI_H					,
	o_BLANK_MARK_EN						,
	o_BLANK_AUTO_EN						,
	o_BLANK_CONTENTBLOCK_PCT			,
	o_BLANK_DARKBLK_TH				,
	o_BLANK_MARK_POS_TOP			,
	o_BLANK_MARK_POS_BOTTOM			,
	o_BLANK_MARK_POS_LEFT			,
	o_BLANK_MARK_POS_RIGHT			,
	o_BLANK_COLORBLOCK_CB_THL		,
	o_BLANK_COLORBLOCK_CB_THU		,
	o_BLANK_COLORBLOCK_CR_THL		,
	o_BLANK_COLORBLOCK_CR_THU		,
	i_BLANK_TBLK_PAGE		,
	i_BLANK_ContBLK_PAGE	,
	i_BLANK_BlankBLK_PAGE	,
	i_BLANK_DarkBLK		    ,
	i_BLANK_CBLK			,
	i_BLANK_Y_MIN		,
	i_BLANK_Y_MAX		,
	i_BLANK_CB_MIN		,
	i_BLANK_CB_MAX		,
	i_BLANK_CR_MIN		,
	i_BLANK_CR_MAX		,


	// ACS
	o_ACS_VALUE_PXL_TH						,
	o_ACS_VALUE_BLOCK_TH					,
	i_ACS_TBLK_PAGE							,
	i_ACS_TBLK_NPAGE						,
	i_ACS_CBLK								,
	i_ACS_SBLK_PAGE							,
	i_ACS_SPXL_PAGE							,
	i_ACS_SPXL_BLK_PAGE						,
	i_ACS_TEXT_PAGE							,
	i_ACS_HT_PAGE							,
	i_ACS_EDGE_PAGE							,
	i_ACS_AVG_HT00							,
	i_ACS_AVG_HT01							,
	i_ACS_AVG_HT02							,
	i_ACS_AVG_HT03							,
	i_ACS_AVG_HT04							,
	i_ACS_AVG_HT05							,
	i_ACS_AVG_HT06							,
	i_ACS_AVG_HT07							,
	i_ACS_AVG_HT08							,
	i_ACS_AVG_HT09							,
	i_ACS_AVG_HT10							,
	i_ACS_AVG_HT11							,
	i_ACS_AVG_HT12							,
	i_ACS_AVG_HT13							,
	i_ACS_AVG_HT14							,
	i_ACS_AVG_HT15							,
	i_ACS_AVG_NHT00							,
	i_ACS_AVG_NHT01							,
	i_ACS_AVG_NHT02							,
	i_ACS_AVG_NHT03							,
	i_ACS_AVG_NHT04							,
	i_ACS_AVG_NHT05							,
	i_ACS_AVG_NHT06							,
	i_ACS_AVG_NHT07							,
	i_ACS_AVG_NHT08							,
	i_ACS_AVG_NHT09							,
	i_ACS_AVG_NHT10							,
	i_ACS_AVG_NHT11							,
	i_ACS_AVG_NHT12							,
	i_ACS_AVG_NHT13							,
	i_ACS_AVG_NHT14							,
	i_ACS_AVG_NHT15							,
	i_ACS_DONE_sp,
 	i_ACS_VALID_TOP		,
 	i_ACS_VALID_BOTTOM	,
 	i_ACS_VALID_LEFT	,
 	i_ACS_VALID_RIGHT	,
	// ABSD
	o_ABSD_EN							,
	i_ABSD_DETECT_DONE_sp,
	o_ABSD_PRE_SCAN_LINE					,
	o_ABSD_IWIN_START						,
	o_ABSD_IWIN_END							,
	o_ABSD_WHITE_TH							,
	o_ABSD_BLACK_TH							,
	o_ABSD_NOISE_REM						,
	o_ABSD_VALID_PERCENTAGE					,
	o_ABSD_BK_STD_TH						,
	o_ABSD_CONFID_SIGMA						,
	o_ABSD_DETECT_SIGMA						,
	o_ABSD_PERCENTAGE						,
	o_ABSD_BG_BACKUP_EN						,
	o_ABSD_BG_BACKUP_TH						,
	o_ABSD_COLOR_EXCEPTION_EN				,
	o_ABSD_COLOR_TH1						,
	o_ABSD_COLOR_TH2						,
	o_ABSD_PRE_SCAN_START					,	
	i_ABSD_TOP_BG_LEVEL						,
	i_ABSD_MAX_CB							,
	i_ABSD_MAX_CR							,
	i_ABSD_TOP_PEAK_CONFIDENCE				,
	i_ABSD_RESULT_SUCCESS				,

	// NEWABSD
	o_NEWABSD_EN				,
	o_NEWABSD_CHROMA_TH			,
	o_NEWABSD_PRE_SCAN_START	,
	o_NEWABSD_PRE_SCAN_LINE_NUM	,
	o_NEWABSD_IWIN_START		,
	o_NEWABSD_IWIN_END			,
	o_NEWABSD_LEFT_LIMIT		,
	o_NEWABSD_RIGHT_LIMIT		,
	o_NEWABSD_GRAY_RIDGE_TH		,
	o_NEWABSD_COLOR_RIDGE_TH	,
	i_NEWABSD_DETECT_DONE	,
	i_NEWABSD_HISTO_GRAY_PEAK  	,
	i_NEWABSD_HISTO_COLOR_PEAK 	,
	i_NEWABSD_HISTO_GRAY_LEFT  	,
	i_NEWABSD_HISTO_COLOR_LEFT 	,
	i_NEWABSD_HISTO_GRAY_RIGHT 	,
	i_NEWABSD_HISTO_COLOR_RIGHT	,
	i_NEWABSD_MEM_READ_STAT		,
	i_NEWABSD_PAPER_COLOR_FLAG	,

	// ACBD
	o_ACBD_EN 					,
	o_ACBD_TOP_MARGIN				,
	o_ACBD_BOTTOM_MARGIN			,
	o_ACBD_LEFT_MARGIN			,
	o_ACBD_RIGHT_MARGIN			,
	o_ACBD_LOW_THRESHOLD_MIN1		,
	o_ACBD_HIGH_THRESHOLD_MAX1	,
	o_ACBD_LOW_THRESHOLD_MIN2		,
	o_ACBD_HIGH_THRESHOLD_MAX2	,
	o_ACBD_HIGHLIGHT_SELECT_EN	,
	o_ACBD_AVG_THRESHOLD			,
	o_ACBD_HISTCB_VAL_LOW			,
	o_ACBD_HISTCB_VAL_HIGH		,
	o_ACBD_HISTCR_VAL_LOW			,
	o_ACBD_HISTCR_VAL_HIGH		,
	o_ACBD_CB_RATION_THRESHOLD	,
	o_ACBD_CR_RATION_THRESHOLD	,
	o_ACBD_MIN_LIMIT_THRESHOLD	,
	o_ACBD_MAX_LIMIT_THRESHOLD	,
	o_ACBD_BRIGHTNESS_EN			,
	o_ACBD_BRIGHTNESS_THRESHOLD	,
	o_ACBD_STRETCHING_OFFSET		,
	o_ACBD_ACB_GRAY_RIDGE_TH		,
	o_ACBD_ACB_LEFT_LIMIT			,
	o_ACBD_ACB_RIGHT_LIMIT		,
	o_ACBD_ACB_PEAK_RATIO_TH		,
	o_ACBD_OBJ_INDEX_TH			,
	o_ACBD_OBJ_AREA_TH			,
	i_ACBD_FINAL_MIN				,
	i_ACBD_FINAL_MAX				,
	i_ACBD_BRIGHT_OFFSET			,
i_ACBD_ANKER_POINT		,
i_ACBD_PEAK_ID			,
i_ACBD_MEM_READ_STAT		,
i_ACBD_DETECT_DONE		,
o_ACBD_ACS_REF_ON		,

	// MAGD
	i_MAGD_DETECT_DONE_sp,
	o_MAGD_PRE_SCAN_LINE					,
	o_MAGD_IWIN_START						,
	o_MAGD_IWIN_END							,
	o_MAGD_WHITE_TH							,
	o_MAGD_BLACK_TH							,
	o_MAGD_NOISE_REM						,
	o_MAGD_VALID_PERCENTAGE					,
	o_MAGD_BK_STD_TH						,
	o_MAGD_CONFID_SIGMA						,
	o_MAGD_DETECT_SIGMA						,
	o_MAGD_PERCENTAGE						,
	o_MAGD_BG_BACKUP_EN						,
	o_MAGD_BG_BACKUP_TH						,
	o_MAGD_COLOR_EXCEPTION_EN				,
	o_MAGD_COLOR_TH1						,
	o_MAGD_COLOR_TH2						,
	o_MAGD_PRE_SCAN_START					,	
	i_MAGD_TOP_BG_LEVEL						,
	i_MAGD_MAX_CB							,
	i_MAGD_MAX_CR							,
	i_MAGD_TOP_PEAK_CONFIDENCE				,
	i_MAGD_RESULT_SUCCESS				,

	// CLA
	o_CLA_EN,
	o_CLA_HLcount_maxth1,
	o_CLA_HLcount_maxth2,
	o_CLA_HLcount_diffth1,
	o_CLA_HLcount_diffth2,
	o_CLA_HLgray_diffth,
	o_CLA_WIDTH,
	o_CLA_HEIGHT,
	o_CLA_ContentsSizeTh,


	i_CLA_DONE,
	i_CLA_TOTAL_BIN_CNT,
	i_CLA_HL_range2,
	i_CLA_HL_color2,
	i_CLA_BTEXT_CNT,
	i_CLA_TEXT_CNT,
	i_CLA_HT_CNT,
	i_CLA_EDGE_CNT,
	i_CLA_WHITE_CNT,
	i_CLA_CONTONE_CNT,
	i_CLA_WHITE_WO_TEXT_CNT,
	i_CLA_WHITE_WO_HT_TEXT_CNT,
	i_CLA_ContentSizeW,
	i_CLA_ContentSizeH,

// ORI
	o_ORI_EN			          ,
	o_ORI_PAGE_EN               ,
	o_ORI_WIDTH                 ,
	o_ORI_HEIGHT                ,
	o_ORI_BLOCK_SIZE_W          ,
	o_ORI_BLOCK_SIZE_H          ,
	o_ORI_AREA_SIZE_W           ,
	o_ORI_AREA_SIZE_H           ,
	o_ORI_CHAR_LENGTH_MIN_V     ,
	o_ORI_CHAR_THICK_MIN_V      ,
	o_ORI_CHAR_THICK_MAX_V      ,
	o_ORI_CHAR_LENGTH_MIN_H     ,
	o_ORI_CHAR_THICK_MIN_H      ,
	o_ORI_CHAR_THICK_MAX_H      ,
	o_ORI_DIFF_SHIFT1_V         ,
	o_ORI_DIFF_SHIFT2_V         ,
	o_ORI_CHANGE_RATIO_TH_V     ,
	o_ORI_CHANGE_CNT_TH_V       ,
	o_ORI_DIFF_SHIFT1_H         ,
	o_ORI_DIFF_SHIFT2_H         ,
	o_ORI_CHANGE_RATIO_TH_H     ,
	o_ORI_CHANGE_CNT_TH_H       ,
	o_ORI_DIR_MIN_TH            ,
	o_ORI_DIR_MAX_TH            ,
	o_ORI_DIR_TH                ,
	o_ORI_DIR_MAX_LOW_TH        ,
	o_ORI_DIR_MAX_HIGH_TH       ,
	o_ORI_DIR_DIFF_TH1          ,
	o_ORI_DIR_DIFF_TH2          ,
	o_ORI_DIR_DIFF_TH3          ,
	o_ORI_AREA_OFFSET_H        ,
	o_ORI_AREA_OFFSET_W        ,
	o_ORI_AREA_OFFSET	        ,
	o_ORI_LINE_SPACE_H          ,
	o_ORI_LINE_SPACE_V          ,

	i_ORI_DONE					 ,
	i_ORI_TEXT_FLAG1            ,
	i_ORI_TEXT_FLAG2            ,
	i_ORI_TEXT_FLAG3            ,
	i_ORI_TEXT_AREA1_ST_W       ,
	i_ORI_TEXT_AREA1_EN_W       ,
	i_ORI_TEXT_AREA1_ST_H       ,
	i_ORI_TEXT_AREA1_EN_H       ,
	i_ORI_TEXT_AREA2_ST_W       ,
	i_ORI_TEXT_AREA2_EN_W       ,
	i_ORI_TEXT_AREA2_ST_H       ,
	i_ORI_TEXT_AREA2_EN_H       ,
	i_ORI_TEXT_AREA3_ST_W       ,
	i_ORI_TEXT_AREA3_EN_W       ,
	i_ORI_TEXT_AREA3_ST_H       ,
	i_ORI_TEXT_AREA3_EN_H       ,

	// BDS
	o_BDS_MIRROR,
	o_BDS_EDGE_CNT_TH  ,
	o_BDS_EDGE_Y_HIGH  ,
	o_BDS_EDGE_Y_LOW   ,
	o_BDS_EDGE_CB_HIGH ,
	o_BDS_EDGE_CB_LOW  ,
	o_BDS_EDGE_CR_HIGH ,
	o_BDS_EDGE_CR_LOW  ,
	o_BDS_EURion_Y_HIGH  ,
	o_BDS_EURion_Y_LOW   ,
	o_BDS_EURion_CB_HIGH ,
	o_BDS_EURion_CB_LOW  ,
	o_BDS_EURion_CR_HIGH ,
	o_BDS_EURion_CR_LOW  ,
	o_BDS_OFFSET_LEFT,
	o_BDS_OFFSET_RIGHT,
	o_BDS_OFFSET_TOP,
	o_BDS_OFFSET_BOTTOM,
	o_BDS_EDGE_TH,
	i_BDS_CONTENTS_START,
	i_BDS_CONTENTS_END,
	o_BDS_PAGE_WIDTH	,
	o_BDS_PAGE_HEIGHT	,
	
	// TBL
	i_TBL_ENDsp,
	o_TBL_ADDR				,
	o_TBL_STARTsp			,
	o_TBL_CNT				,
	o_TBL_END_M_sp			,
	o_TBL_RW				,

	// RX DMA
	o_RX_START							,
	o_RX_INCR							,
	o_RX_SWAP_EN,
	o_RX_ARCACHE,
	o_RX_ARPROT,
	o_RX_ISSUE_CAP,
	o_RX_BLK_SIZE_X,
	o_RX_BLK_SIZE_Y,
	o_RX_DWL,
	o_RX_DHU,
o_RX_CH0_CURR_ADDR					,
o_RX_CH1_CURR_ADDR					,
o_RX_CH2_CURR_ADDR					,

o_RX_CH0_NEXT_ADDR					,
o_RX_CH1_NEXT_ADDR					,
o_RX_CH2_NEXT_ADDR					,
//o_RX_CH0_START_ADDR					,
//o_RX_CH1_START_ADDR					,
//o_RX_CH2_START_ADDR					,
//o_RX_CH0_TOP_ADDR					,
//o_RX_CH1_TOP_ADDR					,
//o_RX_CH2_TOP_ADDR					,
//o_RX_CH0_BOT_ADDR					,
//o_RX_CH1_BOT_ADDR					,
//o_RX_CH2_BOT_ADDR					,
	i_RX_BLK_CNT						,
	i_RX_BAND_CNT						,
	i_RX_CUR_ADDR_CH0					,
	i_RX_CUR_ADDR_CH1					,
	i_RX_CUR_ADDR_CH2					,
	i_RX_SVC_CNT_CH0					,
	i_RX_SVC_CNT_CH1					,
	i_RX_SVC_CNT_CH2					,

	// TX DMA
	o_TX_AWCACHE,
	o_TX_AWPROT,		//SECURE
	o_TX_MAX_WISSUE,
	o_TX_INT_CHECK,
	o_TX_SWAP_EN,
	i_YD_ERR,
	i_TX_ERR,
	i_TX_ERR_RESP,
	i_TX_ERR_ID,
	i_ADAPT_START_ERR,
	i_SMAP_START_ERR,
	i_BDS_START_ERR,
	i_TX_CH_START_ERR,
	o_TX_ARB_MODE							,
	o_TX_START								,
	o_TX_DATA_INCR							,
	o_TX_CH0_START_ADDR						,
	o_TX_CH1_START_ADDR						,
	o_TX_CH2_START_ADDR						,
	i_TX_BLK_CNT							,
	i_TX_BAND_CNT							,
	o_TX_ADDR_CH0_MAX						,
	o_TX_ADDR_CH0_MIN						,
	o_TX_ADDR_CH1_MAX						,
	o_TX_ADDR_CH1_MIN						,
	o_TX_ADDR_CH2_MAX						,
	o_TX_ADDR_CH2_MIN						,

	// ADAPT DMA
	o_ADAPT_DMA_TX_START					,
	i_ADAPT_DMA_TX_BUSY						,	//Busy Signal
	i_ADAPT_OUT_LINES						,
	i_ADAPT_TX_SVC_CNT						,
	i_ADAPT_TX_CUR_ADDR						,

	o_ADAPT_DMA_ADDR						,
	o_ADAPT_DMA_ADDR_INCR					,
	o_ADAPT_OUT_BANDS						,
	o_ASB_INT_CHECK					,

	o_ADAPT_TX_ADDR_MAX						,
	o_ADAPT_TX_ADDR_MIN						,

	i_ADAPT_TX_ADDR_ERR						,
	i_ADAPT_DMA_TX_END						,
//	i_ADAPT_DMA_OUTPUT_BAND_END				,
	
	// BDS
	i_BDS_DMA_TX_BUSY			,	
	i_BDS_OUT_LINES				,
	i_BDS_TX_SVC_CNT			,		
	i_BDS_TX_CUR_ADDR			,
	
	o_BDS_DMA_TX_START			,
	o_BDS_DMA_ADDR				,
	o_BDS_DMA_ADDR_INCR			,
	o_BDS_OUT_BANDS				,
	o_BDS_TX_ADDR_MAX			,
	o_BDS_TX_ADDR_MIN			,

	i_BDS_TX_ADDR_ERR,		
	i_BDS_DMA_TX_END,
//	i_BDS_DMA_OUTPUT_BAND_END,

	// IRQ
	i_DMA_RESET_DONE_sp,

	i_SMAP_TX_ADDR_ERR					,		
	i_SMAP_DMA_TX_END					,
//	i_SMAP_DMA_OUTPUT_BAND_END				,

	o_SMAP_AVGDIVPARAM,
	o_SMAP_ADAPTIVE_ENABLE,
	o_SMAP_ADAP_R_MAXRANGE,
	o_SMAP_ADAP_R_MINRANGE,
	o_SMAP_ADAP_G_MAXRANGE,
	o_SMAP_ADAP_G_MINRANGE,
	o_SMAP_ADAP_B_MAXRANGE,
	o_SMAP_ADAP_B_MINRANGE,

	i_RX_BAND_DONE							, 
	i_RRESP_ERR_INT,
	i_RRESP_ERR_RID,
	i_RRESP_ERR_RRESP,

	i_RX_START_INT							, 
	i_TX_PAGE_DONE							, 
	i_TX_BAND_DONE							, 
	i_TX_START_INT							, 
	i_DMA_TX_ADDR_ERR_CH0					, 
	i_DMA_TX_ADDR_ERR_CH1					, 
	i_DMA_TX_ADDR_ERR_CH2					, 

	i_TX_CH0_SVC_CNT						,
	i_TX_CH1_SVC_CNT						,
	i_TX_CH2_SVC_CNT						,

	i_TX_CH0_CUR_ADDR						,
	i_TX_CH1_CUR_ADDR						,
	i_TX_CH2_CUR_ADDR						,

	o_IRQ								,
	
//	o_TX_BAND_DONE_M,
//	o_TX_PAGE_DONE_M,

	// CRC
	i_DRX_CH0_CRC							,
	i_DRX_CH1_CRC							,
	i_DRX_CH2_CRC							,

	i_RC1_CH0_CRC						,
	i_RC1_CH1_CRC						,
	i_RC1_CH2_CRC						,

	i_BSC1_CH0_CRC						,
	i_BSC1_CH1_CRC						,
	i_BSC1_CH2_CRC						,

	i_RC2_CH0_CRC						,
	i_RC2_CH1_CRC						,
	i_RC2_CH2_CRC						,

	i_S1D_CH0_CRC								,
	i_S1D_CH1_CRC								,
	i_S1D_CH2_CRC								,

	i_ADAPT_CRC								,	
	i_SMAP_CRC								,	
	i_BDS_CRC								,

	i_SEG1_CH0_CRC							,
	i_SEG1_CH1_CRC							,
	i_SEG1_CH2_CRC							,
	i_SEG1_ATT_CRC							,

	i_SCC_CH0_CRC							,
	i_SCC_CH1_CRC							,
	i_SCC_CH2_CRC							,
	i_SCC_ATT_CRC							,

	i_SEG2_CH0_CRC							,
	i_SEG2_CH1_CRC							,
	i_SEG2_CH2_CRC							,
	i_SEG2_ATT_CRC							,

	i_BSSA_CH0_CRC							,	
	i_BSSA_CH1_CRC							,	
	i_BSSA_CH2_CRC							,	

	i_BSSB_CH0_CRC							,	
	i_BSSB_CH1_CRC							,	
	i_BSSB_CH2_CRC							,	
	i_DTX_CH0_CRC							,	
	i_DTX_CH1_CRC							,	
	i_DTX_CH2_CRC							,	


// DEBUG
	i_S1D_DEBUG_FLAG		,
	i_SCC_DEBUG_FLAG		,
	i_BDS_DEBUG_FLAG		,
	i_BSSA_DEBUG_FLAG		,
	i_BSSB_DEBUG_FLAG		,

	o_RAM_SW_MODE,
	o_RAM_CSN,
	o_RAM_WEN,
	o_RAM_ADDR,
	o_RAM_DATA,
	i_RAM_RD_DATA
	
);

//--------------------------------------------------------------------
// Color definition
//--------------------------------------------------------------------
parameter		p_COLOR_Y	 = 0;
parameter		p_COLOR_RGB  = 1;
parameter		p_COLOR_YCC  = 2;

//--------------------------------------------------------------------
parameter  p_RBD_IDLE	= 0;
parameter  p_RBD_WAIT	= 1;
parameter  p_RBD_DONE	= 2;

parameter  p_ABS_ST_IDLE	= 0;
parameter  p_ABS_ST_DET		= 1;
parameter  p_ABS_ST_COR		= 2;

parameter  p_600x600 = 0;
parameter  p_600x450 = 1;
//parameter  p_600x400 = 2;
parameter  p_600x300 = 3;
parameter  p_300x600 = 4;
parameter  p_300x450 = 5;
//parameter  p_300x400 = 6;
parameter  p_300x300 = 7;

parameter	p_BW_600 = 256;
parameter	p_BW_300 = 128;

parameter	p_BH_600	= 128; // Block Size 256x128
parameter	p_BH_450	= 96;
parameter	p_BH_300	= 64;

parameter	p_BW_600_m1 = p_BW_600 -1;
parameter	p_BH_600_m1 = p_BH_600 -1; // Block Size 256x128
parameter	p_BH_300_m1 = p_BH_300 -1;


input	[39:0]		i_SMAP_TX_CUR_ADDR;
input	[31:0]		i_SMAP_TX_SVC_CNT;
input	[15:0]		i_SMAP_OUT_LINES;
input			i_SMAP_DMA_TX_BUSY;


output	[7:0]		o_SMAP_R_RANGE1			;
output	[7:0]		o_SMAP_R_RANGE2 		;
output	[7:0]		o_SMAP_G_RANGE1 		;
output	[7:0]		o_SMAP_G_RANGE2 		;
output	[7:0]		o_SMAP_B_RANGE1			;
output	[7:0]		o_SMAP_B_RANGE2			;
output	[3:0]		o_SMAP_BINTH1			;
output	[3:0]		o_SMAP_BINTH2        	;
output	[3:0]		o_SMAP_BINTH3        	;
output				o_SMAP_REFINE_ENABLE 	;

output	[ 7:0]		o_SMAP_OUT_BANDS		;
output	[39:0]		o_SMAP_DMA_ADDR			;
output	[31:0]		o_SMAP_DMA_ADDR_INCR	;
output	[39:0]		o_SMAP_TX_ADDR_MAX		;
output	[39:0]		o_SMAP_TX_ADDR_MIN		;
output			o_SMAP_DMA_TX_START		;
input				i_DMA_RESET_DONE_sp;
output		[ 7:0]		o_ACS_LAST_BAND_HEIGHT;
output		[ 7:0]		o_BLANK_LAST_BAND_HEIGHT;

input		[8:0]		i_CORE_BAND_END;
input		[8:0]		i_CORE_PAGE_END;



output		[3:0]			o_TX_AWCACHE;
output		[1:0]			o_TX_AWPROT;		//SECURE
output		[4:0]			o_TX_MAX_WISSUE;
output						o_TX_INT_CHECK;
output		[1:0]			o_TX_SWAP_EN;
input						i_YD_ERR;
input						i_TX_ERR;
input		[1:0]			i_TX_ERR_RESP;
input		[3:0]			i_TX_ERR_ID;
input						i_ADAPT_START_ERR;
input						i_SMAP_START_ERR;
input						i_BDS_START_ERR;
input						i_TX_CH_START_ERR;

output			o_TX_ARB_MODE;

input			i_TM;
input			i_HRESETn							;
input			i_PCLK								;
input			i_PSEL								;
input			i_PENABLE							;
input	[10:0]	i_PADDR								;
input	[31:0]	i_PWDATA							;
input			i_PWRITE							;

output	[31:0]	o_PRDATA							;

input			i_TZPC								;

output			o_DMA_RESETn						;
output			o_GRESETn					;
output			o_CORE_START						;
output	[ 2:0]	o_RX_DPI_MODE						;

output	[ 1:0]	o_TX_COLOR_MODE						;
output	[ 1:0]	o_RX_COLOR_MODE						;	
output	[ 1:0]	o_SEG2_COLOR_MODE						;	
output	[ 1:0]	o_ACS_COLOR_MODE						;	
output	[ 1:0]	o_BLANK_COLOR_MODE						;	
output	[ 1:0]	o_ACBD_COLOR_MODE						;	
output	[1:0]	o_CLA_COLOR_MODE;
output	[1:0]	o_NEWABSD_COLOR_MODE;
output	[1:0]	o_ABSD_COLOR_MODE;
output	[1:0]	o_MAGD_COLOR_MODE;
output			o_RC1_EN						    ;
output			o_S1D_EN							;
output			o_SCC_EN							;
output			o_BLANK_EN							;
output			o_ADAPT_EN							;
output			o_SMAP_EN							;
output			o_BDS_EN							;
output			o_TX_CH_EN							;
output			o_ACS_EN							;
output			o_ABSD_EN							;
output			o_MAGD_EN							;

output	[15:0]	o_RX_XD				;
output	[15:0]	o_RX_YD				;		// by ehlee, 2012Jan02
output	[15:0]	o_TX_XD				;
output	[15:0]	o_TX_YD				;
output	[15:0]	o_ACS_XD				;
output	[15:0]	o_BLANK_XD				;
output	[ 7:0]	o_CH2_PADDING_VAL					;		
output	[ 7:0]	o_CH1_PADDING_VAL					;
output	[ 7:0]	o_CH0_PADDING_VAL					;

output		o_VSD_EN;
output	[1:0]	o_VSD_DEBUG	;
output	[3:0]	o_VSD_TOP_BAND				;
output	[7:0]	o_VSD_K_DEPTH_MIN			; 
output	[7:0]	o_VSD_K_DEPTH_MID			; 
output	[7:0]	o_VSD_K_DEPTH_MAX			; 
output	[7:0]	o_VSD_K_DEPTH_MIN_TOP		; 
output	[7:0]	o_VSD_K_DEPTH_MAX_TOP		; 
output	[6:0]	o_VSD_K_DEPTH_COND			; 
output	[7:0]	o_VSD_W_DEPTH_MIN			; 
output	[7:0]	o_VSD_W_DEPTH_MID			; 
output	[7:0]	o_VSD_W_DEPTH_MAX			; 
output	[7:0]	o_VSD_W_DEPTH_MIN_TOP		; 
output	[7:0]	o_VSD_W_DEPTH_MAX_TOP		; 
output	[7:0]	o_VSD_W_DEPTH_COND			;
output	[7:0]	o_VSD_THICKNESS_TH			;
output	[6:0]	o_VSD_CHROMA_TH1			; 
output	[6:0]	o_VSD_CHROMA_TH2			; 
output	[6:0]	o_VSD_CHROMA_TH1_TOP		; 
output	[6:0]	o_VSD_CHROMA_TH2_TOP		; 
output	[7:0]	o_VSD_CONTINUITY_TH;
output	[7:0]	o_VSD_FREQUENCY_TH;
output		o_VSD_REFINE_EN;				//(new)
output	[12:0]	o_VSD_REFINE_TH;				//(new)(range: 0~6300)(nFreq: max100)(nDepth:max63)(nStrength: max6300)	
output		o_VSD_CUR_MEM_INIT;
input		i_VSD_DONE_sp;
// CIS_INTP
output		o_CIS_SUB_EN;
output	[ 8:0]	o_CIS_SUB_COEF_R2					;
output	[ 8:0]	o_CIS_SUB_COEF_R1					;
output	[ 8:0]	o_CIS_SUB_COEF_G2					;
output	[ 8:0]	o_CIS_SUB_COEF_G1					;
output	[ 8:0]	o_CIS_SUB_COEF_G0					;
output	[ 8:0]	o_CIS_SUB_COEF_B1					;
output	[ 8:0]	o_CIS_SUB_COEF_B0					;
input	[31:0]	i_CIS_CRC_0;
input	[31:0]	i_CIS_CRC_1;
input	[31:0]	i_CIS_CRC_2;

input	[31:0]	i_VSD_CRC_0;
input	[31:0]	i_VSD_CRC_1;
input	[31:0]	i_VSD_CRC_2;
// RC1
output	[31:0]	o_RC1_SHIFT_VAL						;
output	[31:0]	o_RC1_SHIFT_OFST					;
output	[ 2:0]	o_RC1_LOOP_X	,o_RC1_LOOP_Y		;
output	[11:0]	o_RC1_X_COF_00	,o_RC1_X_COF_03		;
output	[11:0]	o_RC1_X_COF_10	,o_RC1_X_COF_13		;
output	[11:0]	o_RC1_X_COF_20	,o_RC1_X_COF_23		;
output	[11:0]	o_RC1_X_COF_30	,o_RC1_X_COF_33		;
output	[11:0]	o_RC1_X_COF_01	,o_RC1_X_COF_02		;
output	[11:0]	o_RC1_X_COF_11	,o_RC1_X_COF_12		;
output	[11:0]	o_RC1_X_COF_21	,o_RC1_X_COF_22		;
output	[11:0]	o_RC1_X_COF_31	,o_RC1_X_COF_32		;
output	[11:0]	o_RC1_Y_COF_00	,o_RC1_Y_COF_03		;
output	[11:0]	o_RC1_Y_COF_10	,o_RC1_Y_COF_13		;
output	[11:0]	o_RC1_Y_COF_20	,o_RC1_Y_COF_23		;
output	[11:0]	o_RC1_Y_COF_30	,o_RC1_Y_COF_33		;
output	[11:0]	o_RC1_Y_COF_01	,o_RC1_Y_COF_02		;
output	[11:0]	o_RC1_Y_COF_11	,o_RC1_Y_COF_12		;
output	[11:0]	o_RC1_Y_COF_21	,o_RC1_Y_COF_22		;
output	[11:0]	o_RC1_Y_COF_31	,o_RC1_Y_COF_32		;

// RC2
output		[ 8:0] o_RC2_OUTIMG_WIDTH;		 	
output		[ 7:0] o_RC2_OUTIMG_HEIGHT;		
output				o_RC2_MASK_IMG_BD;			
output		[ 5: 0] o_RC2_OVERLAP;				
output		[11: 0] o_RC2_H_FRAC;
output		[11: 0] o_RC2_V_FRAC;				


// ADAPT
output		[ 8:0]	o_ASB_BLK_WIDTH;
output		[ 7:0]	o_ASB_BLK_HEIGHT;
output		[ 7:0]	o_ASB_BLK_X_NUM;


// SCC
output			o_SCC_LATTICE_STEP					;
output	[ 1:0]	o_SCC_FLOATING_MODE					;

//SEG1
output			o_SEG1_EN;
output	[7:0]	o_SEG1_HVline_diff_th;
output	[7:0]	o_SEG1_HVline_minmaxdiff_th1;
output	[7:0]	o_SEG1_HVline_minmaxdiff_th2; 
output	[7:0]	o_SEG1_HVline_level_th;
output	[7:0]	o_SEG1_Lowfreq_th; 
output	[7:0]	o_SEG1_Lowfreq_th2; 
output	[7:0]	o_SEG1_Highfreq_th; 
output	[7:0]	o_SEG1_Uni_highfreq_th; 
output	[7:0]	o_SEG1_Uni_lowfreq_th;
output	[7:0]	o_SEG1_Uni_edge_th2;
output	[7:0]	o_SEG1_Uni_edge_th;
output	[7:0]	o_SEG1_White_th;
output	[7:0]	o_SEG1_ZC_edge_th;
output	[2:0]	o_SEG1_ZC_scaling_shift;
output			o_SEG1_Enable_Y_text; 

//SEG2
output			o_SEG2_EN;
output			o_SEG2_Enable_contoneImage;
output			o_SEG2_Enable_uniformtext; 
output			o_SEG2_Enable_FAR_9x9;
output	[7:0]	o_SEG2_FG_level_th;
output	[1:0]	o_SEG2_text_index;
output	[6:0]	o_SEG2_edgecnt_th;
output	[6:0]	o_SEG2_bgcnt_th;
output	[6:0]	o_SEG2_halftonecnt_th;
output	[6:0]	o_SEG2_uniformlinecnt_th;
output	[6:0]	o_SEG2_zccnt_th;
output	[7:0]	o_SEG2_FAR_chroma_th;
output	[3:0]	o_SEG2_FAR_chroma_th2_shiftcoef;
output	[7:0]	o_SEG2_FAR_Y_th;
output	[3:0]	o_SEG2_FAR_Y_th2_shiftcoef1;
output	[3:0]	o_SEG2_FAR_Y_th3_shiftcoef2;
output	[7:0]	o_SEG2_Neut_chroma_th;
output	[3:0]	o_SEG2_Neut_chroma_th2_shiftcoef;

// ACS
output	[ 7:0]	o_ACS_WHITE_TH					;
output			o_ACS_RANGE_REAL_IMAGE			;
output	[ 7:0]	o_ACS_BLOCK_SIZE_Y				;
output	[ 7:0]	o_ACS_BLOCK_SIZE_X				;
output	[ 1:0]	o_ACS_DPI_Y						;
output		    o_ACS_DPI_X						;
output			o_ACS_HISTO_EN					;
output		    o_ACS_MARK_ON					;
output		    o_ACS_BLOCK_SIZE_AUTO			;
output		    o_ACS_HALF_CNT_AUTO				;
output		    o_ACS_SATURATION_PXL_CNT_AUTO	;
output	[16:0]	o_ACS_MARK_TOP		 			;
output	[16:0]	o_ACS_MARK_BOTTOM				;
output	[16:0]	o_ACS_MARK_LEFT		 			;
output	[16:0]	o_ACS_MARK_RIGHT				;
output	[ 7:0]	o_ACS_SATURATION_PXL_TH			;
output	[14:0]	o_ACS_SATURATION_PXL_CNT_TH		;
output	[ 7:0]	o_ACS_SATURATION_BLOCK_TH	 	;
output	[14:0]	o_ACS_HALFTONE_CNT				;
output	[14:0]	o_ACS_PUREHALFTONE_CNT			;
output	[ 7:0]	o_ACS_CB_MAX_00					;
output	[ 7:0]	o_ACS_CB_MAX_01					;
output	[ 7:0]	o_ACS_CB_MAX_02					;
output	[ 7:0]	o_ACS_CB_MAX_03					;
output	[ 7:0]	o_ACS_CB_MAX_04					;
output	[ 7:0]	o_ACS_CB_MAX_05					;
output	[ 7:0]	o_ACS_CB_MAX_06					;
output	[ 7:0]	o_ACS_CB_MAX_07					;
output	[ 7:0]	o_ACS_CB_MAX_08					;
output	[ 7:0]	o_ACS_CB_MAX_09					;
output	[ 7:0]	o_ACS_CB_MAX_10					;
output	[ 7:0]	o_ACS_CB_MAX_11					;
output	[ 7:0]	o_ACS_CB_MAX_12					;
output	[ 7:0]	o_ACS_CB_MAX_13					;
output	[ 7:0]	o_ACS_CB_MAX_14					;
output	[ 7:0]	o_ACS_CB_MAX_15					;
output	[ 7:0]	o_ACS_CB_MIN_00					;
output	[ 7:0]	o_ACS_CB_MIN_01					;
output	[ 7:0]	o_ACS_CB_MIN_02					;
output	[ 7:0]	o_ACS_CB_MIN_03					;
output	[ 7:0]	o_ACS_CB_MIN_04					;
output	[ 7:0]	o_ACS_CB_MIN_05					;
output	[ 7:0]	o_ACS_CB_MIN_06					;
output	[ 7:0]	o_ACS_CB_MIN_07					;
output	[ 7:0]	o_ACS_CB_MIN_08					;
output	[ 7:0]	o_ACS_CB_MIN_09					;
output	[ 7:0]	o_ACS_CB_MIN_10					;
output	[ 7:0]	o_ACS_CB_MIN_11					;
output	[ 7:0]	o_ACS_CB_MIN_12					;
output	[ 7:0]	o_ACS_CB_MIN_13					;
output	[ 7:0]	o_ACS_CB_MIN_14					;
output	[ 7:0]	o_ACS_CB_MIN_15					;
output	[ 7:0]	o_ACS_CR_MAX_00					;
output	[ 7:0]	o_ACS_CR_MAX_01					;
output	[ 7:0]	o_ACS_CR_MAX_02					;
output	[ 7:0]	o_ACS_CR_MAX_03					;
output	[ 7:0]	o_ACS_CR_MAX_04					;
output	[ 7:0]	o_ACS_CR_MAX_05					;
output	[ 7:0]	o_ACS_CR_MAX_06					;
output	[ 7:0]	o_ACS_CR_MAX_07					;
output	[ 7:0]	o_ACS_CR_MAX_08					;
output	[ 7:0]	o_ACS_CR_MAX_09					;
output	[ 7:0]	o_ACS_CR_MAX_10					;
output	[ 7:0]	o_ACS_CR_MAX_11					;
output	[ 7:0]	o_ACS_CR_MAX_12					;
output	[ 7:0]	o_ACS_CR_MAX_13					;
output	[ 7:0]	o_ACS_CR_MAX_14					;
output	[ 7:0]	o_ACS_CR_MAX_15					;
output	[ 7:0]	o_ACS_CR_MIN_00					;
output	[ 7:0]	o_ACS_CR_MIN_01					;
output	[ 7:0]	o_ACS_CR_MIN_02					;
output	[ 7:0]	o_ACS_CR_MIN_03					;
output	[ 7:0]	o_ACS_CR_MIN_04					;
output	[ 7:0]	o_ACS_CR_MIN_05					;
output	[ 7:0]	o_ACS_CR_MIN_06					;
output	[ 7:0]	o_ACS_CR_MIN_07					;
output	[ 7:0]	o_ACS_CR_MIN_08					;
output	[ 7:0]	o_ACS_CR_MIN_09					;
output	[ 7:0]	o_ACS_CR_MIN_10					;
output	[ 7:0]	o_ACS_CR_MIN_11					;
output	[ 7:0]	o_ACS_CR_MIN_12					;
output	[ 7:0]	o_ACS_CR_MIN_13					;
output	[ 7:0]	o_ACS_CR_MIN_14					;
output	[ 7:0]	o_ACS_CR_MIN_15					;
output	[ 7:0]	o_ACS_CB_MAXh_00				;
output	[ 7:0]	o_ACS_CB_MAXh_01				;
output	[ 7:0]	o_ACS_CB_MAXh_02 				;
output	[ 7:0]	o_ACS_CB_MAXh_03 				;
output	[ 7:0]	o_ACS_CB_MAXh_04				;
output	[ 7:0]	o_ACS_CB_MAXh_05				;
output	[ 7:0]	o_ACS_CB_MAXh_06 				;
output	[ 7:0]	o_ACS_CB_MAXh_07 				;
output	[ 7:0]	o_ACS_CB_MAXh_08				;
output	[ 7:0]	o_ACS_CB_MAXh_09				;
output	[ 7:0]	o_ACS_CB_MAXh_10 				;
output	[ 7:0]	o_ACS_CB_MAXh_11 				;
output	[ 7:0]	o_ACS_CB_MAXh_12				;
output	[ 7:0]	o_ACS_CB_MAXh_13				;
output	[ 7:0]	o_ACS_CB_MAXh_14 				;
output	[ 7:0]	o_ACS_CB_MAXh_15 				;
output	[ 7:0]	o_ACS_CB_MINh_00				;
output	[ 7:0]	o_ACS_CB_MINh_01				;
output	[ 7:0]	o_ACS_CB_MINh_02 				;
output	[ 7:0]	o_ACS_CB_MINh_03 				;
output	[ 7:0]	o_ACS_CB_MINh_04				;
output	[ 7:0]	o_ACS_CB_MINh_05				;
output	[ 7:0]	o_ACS_CB_MINh_06 				;
output	[ 7:0]	o_ACS_CB_MINh_07 				;
output	[ 7:0]	o_ACS_CB_MINh_08				;
output	[ 7:0]	o_ACS_CB_MINh_09				;
output	[ 7:0]	o_ACS_CB_MINh_10 				;
output	[ 7:0]	o_ACS_CB_MINh_11 				;
output	[ 7:0]	o_ACS_CB_MINh_12				;
output	[ 7:0]	o_ACS_CB_MINh_13				;
output	[ 7:0]	o_ACS_CB_MINh_14 				;
output	[ 7:0]	o_ACS_CB_MINh_15 				;
output	[ 7:0]	o_ACS_CR_MAXh_00				;
output	[ 7:0]	o_ACS_CR_MAXh_01				;
output	[ 7:0]	o_ACS_CR_MAXh_02 				;
output	[ 7:0]	o_ACS_CR_MAXh_03 				;
output	[ 7:0]	o_ACS_CR_MAXh_04				;
output	[ 7:0]	o_ACS_CR_MAXh_05				;
output	[ 7:0]	o_ACS_CR_MAXh_06 				;
output	[ 7:0]	o_ACS_CR_MAXh_07 				;
output	[ 7:0]	o_ACS_CR_MAXh_08				;
output	[ 7:0]	o_ACS_CR_MAXh_09				;
output	[ 7:0]	o_ACS_CR_MAXh_10 				;
output	[ 7:0]	o_ACS_CR_MAXh_11 				;
output	[ 7:0]	o_ACS_CR_MAXh_12				;
output	[ 7:0]	o_ACS_CR_MAXh_13				;
output	[ 7:0]	o_ACS_CR_MAXh_14 				;
output	[ 7:0]	o_ACS_CR_MAXh_15 				;
output	[ 7:0]	o_ACS_CR_MINh_00				;
output	[ 7:0]	o_ACS_CR_MINh_01				;
output	[ 7:0]	o_ACS_CR_MINh_02 				;
output	[ 7:0]	o_ACS_CR_MINh_03 				;
output	[ 7:0]	o_ACS_CR_MINh_04				;
output	[ 7:0]	o_ACS_CR_MINh_05				;
output	[ 7:0]	o_ACS_CR_MINh_06 				;
output	[ 7:0]	o_ACS_CR_MINh_07 				;
output	[ 7:0]	o_ACS_CR_MINh_08				;
output	[ 7:0]	o_ACS_CR_MINh_09				;
output	[ 7:0]	o_ACS_CR_MINh_10 				;
output	[ 7:0]	o_ACS_CR_MINh_11 				;
output	[ 7:0]	o_ACS_CR_MINh_12				;
output	[ 7:0]	o_ACS_CR_MINh_13				;
output	[ 7:0]	o_ACS_CR_MINh_14 				;
output	[ 7:0]	o_ACS_CR_MINh_15 				;

output					o_BLANK_RANGE_REAL_IMAGE;
output		[7:0]		o_BLANK_BLOCK_SIZE_V	;
output		[7:0]		o_BLANK_BLOCK_SIZE_H	;
output		[1:0]		o_BLANK_DPI_V		;
output					o_BLANK_DPI_H		;
output					o_BLANK_MARK_EN			;
output					o_BLANK_AUTO_EN			;
output		[7:0]		o_BLANK_CONTENTBLOCK_PCT				;
output		[7:0]		o_BLANK_DARKBLK_TH				;
output		[16: 0]	o_BLANK_MARK_POS_TOP			;
output		[16: 0]	o_BLANK_MARK_POS_BOTTOM			;
output		[16: 0]	o_BLANK_MARK_POS_LEFT			;
output		[16: 0]	o_BLANK_MARK_POS_RIGHT			;
output		[ 7: 0]	o_BLANK_COLORBLOCK_CB_THL		;
output		[ 7: 0]	o_BLANK_COLORBLOCK_CB_THU		;
output		[ 7: 0]	o_BLANK_COLORBLOCK_CR_THL		;
output		[ 7: 0]	o_BLANK_COLORBLOCK_CR_THU		;

input		[31: 0]	i_BLANK_TBLK_PAGE		;
input		[31: 0]	i_BLANK_ContBLK_PAGE	;
input		[31: 0]	i_BLANK_BlankBLK_PAGE	;
input		[31: 0]	i_BLANK_DarkBLK		    ;
input		[31: 0]	i_BLANK_CBLK			;
input		[ 7: 0]	i_BLANK_Y_MIN		;
input		[ 7: 0]	i_BLANK_Y_MAX		;
input		[ 7: 0]	i_BLANK_CB_MIN		;
input		[ 7: 0]	i_BLANK_CB_MAX		;
input		[ 7: 0]	i_BLANK_CR_MIN		;
input		[ 7: 0]	i_BLANK_CR_MAX		;


output	[ 7:0]      o_ACS_VALUE_PXL_TH			;
output	[ 7:0]      o_ACS_VALUE_BLOCK_TH		;
input	[31:0]		i_ACS_TBLK_PAGE				;
input	[31:0]		i_ACS_TBLK_NPAGE			;
input	[31:0]		i_ACS_CBLK					;
input	[31:0]		i_ACS_SBLK_PAGE				;
input	[31:0]		i_ACS_SPXL_BLK_PAGE			;

input	[31:0]		i_ACS_SPXL_PAGE				;
input	[31:0]		i_ACS_TEXT_PAGE				;
input	[31:0]		i_ACS_HT_PAGE				;
input	[31:0]		i_ACS_EDGE_PAGE				;

		// ACS_v2
output		o_ACSv2_EN;
output	[7:0]	o_ACSv2_BLOCK_SIZE_X;
output	[7:0]	o_ACSv2_BLOCK_SIZE_Y;
output	[7:0]	o_ACSv2_WHITE_TH;
output	[7:0]	o_ACSv2_SATURATION_PXL_TH;
output	[14:0]	o_ACSv2_SATURATION_PXL_CNT_TH;
output	[7:0]	o_ACSv2_SATURATION_BLOCK_TH;
output	[7:0]	o_ACSv2_VALUE_PXL_TH;
output	[7:0]	o_ACSv2_VALUE_BLOCK_TH;
output	[14:0]	o_ACSv2_HALFTONE_CNT;
output	[14:0]	o_ACSv2_PUREHALFTONE_CNT;

// ACSv2
input	[31:0]	i_ACSv2_TBLK_PAGE;
input	[31:0]	i_ACSv2_TBLK_NPAGE;
input	[31:0]	i_ACSv2_CBLK;
input   [31:0]  i_ACSv2_SBLK_PAGE; 
input   [31:0]  i_ACSv2_SPXL_BLK_PAGE; 
input   [31:0]  i_ACSv2_SPXL_PAGE; 

input	[31:0]		i_ACS_AVG_HT00				;
input	[31:0]		i_ACS_AVG_HT01				;
input	[31:0]		i_ACS_AVG_HT02				;
input	[31:0]		i_ACS_AVG_HT03				;
input	[31:0]		i_ACS_AVG_HT04				;
input	[31:0]		i_ACS_AVG_HT05				;
input	[31:0]		i_ACS_AVG_HT06				;
input	[31:0]		i_ACS_AVG_HT07				;
input	[31:0]		i_ACS_AVG_HT08				;
input	[31:0]		i_ACS_AVG_HT09				;
input	[31:0]		i_ACS_AVG_HT10				;
input	[31:0]		i_ACS_AVG_HT11				;
input	[31:0]		i_ACS_AVG_HT12				;
input	[31:0]		i_ACS_AVG_HT13				;
input	[31:0]		i_ACS_AVG_HT14				;
input	[31:0]		i_ACS_AVG_HT15				;
input	[31:0]		i_ACS_AVG_NHT00				;
input	[31:0]		i_ACS_AVG_NHT01				;
input	[31:0]		i_ACS_AVG_NHT02				;
input	[31:0]		i_ACS_AVG_NHT03				;
input	[31:0]		i_ACS_AVG_NHT04				;
input	[31:0]		i_ACS_AVG_NHT05				;
input	[31:0]		i_ACS_AVG_NHT06				;
input	[31:0]		i_ACS_AVG_NHT07				;
input	[31:0]		i_ACS_AVG_NHT08				;
input	[31:0]		i_ACS_AVG_NHT09				;
input	[31:0]		i_ACS_AVG_NHT10				;
input	[31:0]		i_ACS_AVG_NHT11				;
input	[31:0]		i_ACS_AVG_NHT12				;
input	[31:0]		i_ACS_AVG_NHT13				;
input	[31:0]		i_ACS_AVG_NHT14				;
input	[31:0]		i_ACS_AVG_NHT15				;
input		i_ACS_DONE_sp;
 input	[13:0]	i_ACS_VALID_TOP		;
 input	[13:0]	i_ACS_VALID_BOTTOM	;
 input	[13:0]	i_ACS_VALID_LEFT	;
 input	[13:0]	i_ACS_VALID_RIGHT	;

input			i_MAGD_DETECT_DONE_sp;
output	[13:0]	o_MAGD_PRE_SCAN_START;
output	[13:0]	o_MAGD_PRE_SCAN_LINE						;
output	[13:0]	o_MAGD_IWIN_START						;
output	[13:0]	o_MAGD_IWIN_END							;

output	[ 7:0]	o_MAGD_WHITE_TH						;
output	[ 7:0]	o_MAGD_BLACK_TH						;
output			o_MAGD_NOISE_REM							;

output	[ 6:0]	o_MAGD_VALID_PERCENTAGE					;
output	[ 7:0]	o_MAGD_BK_STD_TH							;

output	[ 5:0]	o_MAGD_CONFID_SIGMA					;
output	[ 5:0]	o_MAGD_DETECT_SIGMA					;
output	[ 6:0]	o_MAGD_PERCENTAGE					;
output			o_MAGD_BG_BACKUP_EN					;
output	[ 7:0]	o_MAGD_BG_BACKUP_TH					;
output			o_MAGD_COLOR_EXCEPTION_EN			;
output	[ 7:0]	o_MAGD_COLOR_TH1						;
output	[ 7:0]	o_MAGD_COLOR_TH2						;

input	[ 7:0]	i_MAGD_TOP_BG_LEVEL						;
input	[ 7:0]	i_MAGD_MAX_CB						;
input	[ 7:0]	i_MAGD_MAX_CR						;
input	[ 6:0]	i_MAGD_TOP_PEAK_CONFIDENCE				;
input			i_MAGD_RESULT_SUCCESS				;

//

output				o_ACBD_EN 					;
output	[15:0]		o_ACBD_TOP_MARGIN				;
output	[15:0]		o_ACBD_BOTTOM_MARGIN			;
output	[15:0]		o_ACBD_LEFT_MARGIN			;
output	[15:0]		o_ACBD_RIGHT_MARGIN			;
output	[ 9:0] 		o_ACBD_LOW_THRESHOLD_MIN1		;
output	[ 9:0]		o_ACBD_HIGH_THRESHOLD_MAX1	;
output	[ 9:0] 		o_ACBD_LOW_THRESHOLD_MIN2		;
output	[ 9:0]		o_ACBD_HIGH_THRESHOLD_MAX2	;
output				o_ACBD_HIGHLIGHT_SELECT_EN	;
output	[ 7:0]		o_ACBD_AVG_THRESHOLD			;
output	[ 7:0]		o_ACBD_HISTCB_VAL_LOW			;
output	[ 7:0]		o_ACBD_HISTCB_VAL_HIGH		;
output	[ 7:0]		o_ACBD_HISTCR_VAL_LOW			;
output	[ 7:0]		o_ACBD_HISTCR_VAL_HIGH		;
output	[ 9:0]		o_ACBD_CB_RATION_THRESHOLD	;
output	[ 9:0]		o_ACBD_CR_RATION_THRESHOLD	;
output	[ 7:0]		o_ACBD_MIN_LIMIT_THRESHOLD	;
output	[ 7:0]		o_ACBD_MAX_LIMIT_THRESHOLD	;
output				o_ACBD_BRIGHTNESS_EN			;
output	[ 7:0]		o_ACBD_BRIGHTNESS_THRESHOLD	;
output	[ 7:0]		o_ACBD_STRETCHING_OFFSET		;
output	[ 5:0]		o_ACBD_ACB_GRAY_RIDGE_TH			;		//add 17.08.18
output	[ 7:0]		o_ACBD_ACB_LEFT_LIMIT			;		//add 17.08.18
output	[ 7:0]		o_ACBD_ACB_RIGHT_LIMIT			;		//add 17.08.18
output	[ 9:0]		o_ACBD_ACB_PEAK_RATIO_TH			;		//add 17.08.18
output	[ 7:0]		o_ACBD_OBJ_INDEX_TH				;		//add 17.08.18
output	[ 3:0]		o_ACBD_OBJ_AREA_TH				;		//add 17.08.18
input	[ 7:0]		i_ACBD_FINAL_MIN				;
input	[ 7:0]		i_ACBD_FINAL_MAX				;
input	[ 7:0]		i_ACBD_BRIGHT_OFFSET			;
input	[ 7:0]		i_ACBD_ANKER_POINT				;
input	[ 7:0]		i_ACBD_PEAK_ID					;
input  [ 3:0]		i_ACBD_MEM_READ_STAT				;
input  			i_ACBD_DETECT_DONE			;
output 			o_ACBD_ACS_REF_ON			;
//
output			o_CLA_EN;
output	[7:0]	o_CLA_HLcount_maxth1;
output	[7:0]	o_CLA_HLcount_maxth2;
output	[7:0]	o_CLA_HLcount_diffth1;
output	[7:0]	o_CLA_HLcount_diffth2;
output	[7:0]	o_CLA_HLgray_diffth;
output	[13:0] o_CLA_WIDTH;
output	[13:0] o_CLA_HEIGHT;
output	[10:0] o_CLA_ContentsSizeTh;

input			i_CLA_DONE;
input	[31:0]	i_CLA_TOTAL_BIN_CNT;
input	[31:0]	i_CLA_HL_range2;
input	[31:0]	i_CLA_HL_color2;
input	[31:0]	i_CLA_BTEXT_CNT;
input	[31:0]	i_CLA_TEXT_CNT;
input	[31:0]	i_CLA_HT_CNT;
input	[31:0]	i_CLA_EDGE_CNT;
input	[31:0]	i_CLA_WHITE_CNT;
input	[31:0]	i_CLA_CONTONE_CNT;
input	[31:0]	i_CLA_WHITE_WO_TEXT_CNT;
input	[31:0]	i_CLA_WHITE_WO_HT_TEXT_CNT;
input	[13:0]	i_CLA_ContentSizeW;
input	[13:0]	i_CLA_ContentSizeH;
// ORI
output			o_ORI_EN;
output			o_ORI_PAGE_EN;
output	[13:0]	o_ORI_WIDTH;
output	[13:0]  o_ORI_HEIGHT;
output	[5:0]	o_ORI_BLOCK_SIZE_W;
output	[6:0]	o_ORI_BLOCK_SIZE_H;
output	[13:0]	o_ORI_AREA_SIZE_W;
output	[13:0]	o_ORI_AREA_SIZE_H;
output	[7:0]	o_ORI_CHAR_LENGTH_MIN_V; 
output	[7:0]	o_ORI_CHAR_THICK_MIN_V; 
output	[7:0]	o_ORI_CHAR_THICK_MAX_V;
output	[7:0]	o_ORI_CHAR_LENGTH_MIN_H; 
output	[7:0]	o_ORI_CHAR_THICK_MIN_H;
output	[7:0]	o_ORI_CHAR_THICK_MAX_H;
output	[3:0]	o_ORI_DIFF_SHIFT1_V;
output	[3:0]	o_ORI_DIFF_SHIFT2_V;
output	[6:0]	o_ORI_CHANGE_RATIO_TH_V;
output	[6:0]	o_ORI_CHANGE_CNT_TH_V;
output	[3:0]	o_ORI_DIFF_SHIFT1_H;
output	[3:0]	o_ORI_DIFF_SHIFT2_H;
output	[6:0]	o_ORI_CHANGE_RATIO_TH_H;
output	[6:0]	o_ORI_CHANGE_CNT_TH_H;
output	[7:0]	o_ORI_DIR_MIN_TH;
output	[7:0]	o_ORI_DIR_MAX_TH;
output	[7:0]	o_ORI_DIR_TH;
output	[7:0]	o_ORI_DIR_MAX_LOW_TH;
output	[7:0]	o_ORI_DIR_MAX_HIGH_TH;
output	[7:0]	o_ORI_DIR_DIFF_TH1;
output	[7:0]   o_ORI_DIR_DIFF_TH2;
output	[7:0]	o_ORI_DIR_DIFF_TH3;
output	[10:0]	o_ORI_AREA_OFFSET_H;
output	[10:0]	o_ORI_AREA_OFFSET_W;
output	[10:0]	o_ORI_AREA_OFFSET;
output	[7:0]	o_ORI_LINE_SPACE_H;
output	[7:0]	o_ORI_LINE_SPACE_V;

input			i_ORI_DONE;
input			i_ORI_TEXT_FLAG1; 
input			i_ORI_TEXT_FLAG2; 
input			i_ORI_TEXT_FLAG3;
input	[13:0]	i_ORI_TEXT_AREA1_ST_W;
input	[13:0]	i_ORI_TEXT_AREA1_EN_W;
input	[13:0]	i_ORI_TEXT_AREA1_ST_H;
input	[13:0]	i_ORI_TEXT_AREA1_EN_H;
input	[13:0]	i_ORI_TEXT_AREA2_ST_W;
input	[13:0]	i_ORI_TEXT_AREA2_EN_W;
input	[13:0]	i_ORI_TEXT_AREA2_ST_H; 
input	[13:0]	i_ORI_TEXT_AREA2_EN_H;
input	[13:0]	i_ORI_TEXT_AREA3_ST_W;
input	[13:0]	i_ORI_TEXT_AREA3_EN_W;
input	[13:0]	i_ORI_TEXT_AREA3_ST_H;
input	[13:0]	i_ORI_TEXT_AREA3_EN_H;

// ABSD
input		i_ABSD_DETECT_DONE_sp;
output	[13:0]	o_ABSD_PRE_SCAN_START;
output	[13:0]	o_ABSD_PRE_SCAN_LINE						;
output	[13:0]	o_ABSD_IWIN_START						;
output	[13:0]	o_ABSD_IWIN_END							;
output	[ 7:0]	o_ABSD_WHITE_TH						;
output	[ 7:0]	o_ABSD_BLACK_TH						;
output			o_ABSD_NOISE_REM							;
output	[ 6:0]	o_ABSD_VALID_PERCENTAGE					;
output	[ 7:0]	o_ABSD_BK_STD_TH							;
output	[ 5:0]	o_ABSD_CONFID_SIGMA					;
output	[ 5:0]	o_ABSD_DETECT_SIGMA					;
output	[ 6:0]	o_ABSD_PERCENTAGE					;
output			o_ABSD_BG_BACKUP_EN					;
output	[ 7:0]	o_ABSD_BG_BACKUP_TH					;
output			o_ABSD_COLOR_EXCEPTION_EN			;
output	[ 7:0]	o_ABSD_COLOR_TH1						;
output	[ 7:0]	o_ABSD_COLOR_TH2						;
input	[ 7:0]	i_ABSD_TOP_BG_LEVEL						;
input	[ 7:0]	i_ABSD_MAX_CB						;
input	[ 7:0]	i_ABSD_MAX_CR						;
input	[ 6:0]	i_ABSD_TOP_PEAK_CONFIDENCE				;
input			i_ABSD_RESULT_SUCCESS				;


output				o_NEWABSD_EN					;
output	[13:0]		o_NEWABSD_PRE_SCAN_START			;
output	[13:0]		o_NEWABSD_PRE_SCAN_LINE_NUM			;
output	[13:0]		o_NEWABSD_IWIN_START				;
output	[13:0]		o_NEWABSD_IWIN_END					;
output	[ 7:0]		o_NEWABSD_LEFT_LIMIT				;
output	[ 7:0]		o_NEWABSD_RIGHT_LIMIT				;

output	[ 7:0]		o_NEWABSD_GRAY_RIDGE_TH				;
output	[ 7:0]		o_NEWABSD_COLOR_RIDGE_TH			;
output	[ 7:0]		o_NEWABSD_CHROMA_TH					;

input				i_NEWABSD_DETECT_DONE			;
input	[ 7:0]		i_NEWABSD_HISTO_GRAY_PEAK  		;
input	[ 7:0]      i_NEWABSD_HISTO_COLOR_PEAK 		;
input	[ 7:0]      i_NEWABSD_HISTO_GRAY_LEFT  		;
input	[ 7:0]      i_NEWABSD_HISTO_COLOR_LEFT 		;
input	[ 7:0]      i_NEWABSD_HISTO_GRAY_RIGHT 		;
input	[ 7:0]      i_NEWABSD_HISTO_COLOR_RIGHT		;
input    [ 3:0]		i_NEWABSD_MEM_READ_STAT			;
input				i_NEWABSD_PAPER_COLOR_FLAG		;

output			o_BDS_MIRROR;

output	[7:0]	o_BDS_EDGE_CNT_TH  ;
output	[7:0]	o_BDS_EDGE_Y_HIGH  ;
output	[7:0]	o_BDS_EDGE_Y_LOW   ;
output	[7:0]	o_BDS_EDGE_CB_HIGH ;
output	[7:0]	o_BDS_EDGE_CB_LOW  ;
output	[7:0]	o_BDS_EDGE_CR_HIGH ;
output	[7:0]	o_BDS_EDGE_CR_LOW  ;

output	[7:0]	o_BDS_EURion_Y_HIGH  ;
output	[7:0]	o_BDS_EURion_Y_LOW   ;
output	[7:0]	o_BDS_EURion_CB_HIGH ;
output	[7:0]	o_BDS_EURion_CB_LOW  ;
output	[7:0]	o_BDS_EURion_CR_HIGH ;
output	[7:0]	o_BDS_EURion_CR_LOW  ;

output	[7:0]	o_BDS_OFFSET_LEFT;
output	[7:0]	o_BDS_OFFSET_RIGHT;
output	[7:0]	o_BDS_OFFSET_TOP;
output	[7:0]	o_BDS_OFFSET_BOTTOM;
output	[7:0]	o_BDS_EDGE_TH;

input	[15:0]	i_BDS_CONTENTS_START;
input	[15:0]	i_BDS_CONTENTS_END;

output	[15:0]	o_BDS_PAGE_WIDTH	;
output	[15:0]	o_BDS_PAGE_HEIGHT	;


input			i_TBL_ENDsp;
output	[ 5:0]	o_TBL_CNT;
output	[39:0]	o_TBL_ADDR;
output			o_TBL_STARTsp;	
output			o_TBL_END_M_sp;
output			o_TBL_RW;

// RX DMA
//output	[ 7:0]	o_BNY;

input	[ 7:0]	i_RX_BLK_CNT						;
input	[ 7:0]	i_RX_BAND_CNT						;
input	[39:0]	i_RX_CUR_ADDR_CH0;
input	[39:0]	i_RX_CUR_ADDR_CH1;
input	[39:0]	i_RX_CUR_ADDR_CH2;
input	[31:0]	i_RX_SVC_CNT_CH0;
input	[31:0]	i_RX_SVC_CNT_CH1;
input	[31:0]	i_RX_SVC_CNT_CH2;

output			o_RX_START							;
output	[15:0]	o_RX_INCR							;
output	[1:0]	o_RX_SWAP_EN;
output	[3:0]	o_RX_ARCACHE;
output	[2:0]	o_RX_ARPROT;
output	[2:0]	o_RX_ISSUE_CAP;
output	[8:0]	o_RX_BLK_SIZE_X;
output	[7:0]	o_RX_BLK_SIZE_Y;
output	[5:0]	o_RX_DWL;
output	[5:0]	o_RX_DHU;
output	[39:0]	o_RX_CH0_CURR_ADDR					;
output	[39:0]	o_RX_CH1_CURR_ADDR					;
output	[39:0]	o_RX_CH2_CURR_ADDR					;
output	[39:0]	o_RX_CH0_NEXT_ADDR					;
output	[39:0]	o_RX_CH1_NEXT_ADDR					;
output	[39:0]	o_RX_CH2_NEXT_ADDR					;
//output	[39:0]	o_RX_CH0_START_ADDR					;
//output	[39:0]	o_RX_CH1_START_ADDR					;
//output	[39:0]	o_RX_CH2_START_ADDR					;
//output	[39:0]	o_RX_CH0_TOP_ADDR					;
//output	[39:0]	o_RX_CH1_TOP_ADDR					;
//output	[39:0]	o_RX_CH2_TOP_ADDR					;
//output	[39:0]	o_RX_CH0_BOT_ADDR				;
//output	[39:0]	o_RX_CH1_BOT_ADDR				;
//output	[39:0]	o_RX_CH2_BOT_ADDR				;
//o

// TX DMA
input	[ 7:0]	i_TX_BLK_CNT						;
input	[ 7:0]	i_TX_BAND_CNT						;

output			o_TX_START							;

output	[15:0]	o_TX_DATA_INCR						;
output	[39:0]	o_TX_CH0_START_ADDR					;
output	[39:0]	o_TX_CH1_START_ADDR					;
output	[39:0]	o_TX_CH2_START_ADDR					;
output	[39:0]	o_TX_ADDR_CH0_MAX					;
output	[39:0]	o_TX_ADDR_CH0_MIN					;
output	[39:0]	o_TX_ADDR_CH1_MAX					;
output	[39:0]	o_TX_ADDR_CH1_MIN					;
output	[39:0]	o_TX_ADDR_CH2_MAX					;
output	[39:0]	o_TX_ADDR_CH2_MIN					;

// ADAPT DMA
output	[ 1:0]	o_ASB_INT_CHECK;	

input		i_ADAPT_TX_ADDR_ERR					;

input		i_ADAPT_DMA_TX_BUSY					;	//Busy Signal
input	[15:0]	i_ADAPT_OUT_LINES					;
input	[31:0]	i_ADAPT_TX_SVC_CNT					;		
input	[39:0]	i_ADAPT_TX_CUR_ADDR					;

output			o_ADAPT_DMA_TX_START				;
output	[39:0]	o_ADAPT_DMA_ADDR					;
output	[31:0]	o_ADAPT_DMA_ADDR_INCR				;
output	[ 7:0]	o_ADAPT_OUT_BANDS					;
output	[39:0]	o_ADAPT_TX_ADDR_MAX					;
output	[39:0]	o_ADAPT_TX_ADDR_MIN					;

// ADAPT DMA
input			i_BDS_DMA_TX_BUSY					;	//Busy Signal
input	[15:0]	i_BDS_OUT_LINES					;
input	[31:0]	i_BDS_TX_SVC_CNT					;		
input	[39:0]	i_BDS_TX_CUR_ADDR					;

output			o_BDS_DMA_TX_START				;
output	[39:0]	o_BDS_DMA_ADDR					;
output	[31:0]	o_BDS_DMA_ADDR_INCR				;
output	[ 7:0]	o_BDS_OUT_BANDS					;
output	[39:0]	o_BDS_TX_ADDR_MAX					;
output	[39:0]	o_BDS_TX_ADDR_MIN					;

// IRQ
input			i_RX_BAND_DONE						;
input			i_RRESP_ERR_INT;
input	[3:0]	i_RRESP_ERR_RID;
input	[1:0]	i_RRESP_ERR_RRESP;
input			i_RX_START_INT						;

input			i_TX_PAGE_DONE						;
input			i_TX_BAND_DONE						;
input			i_TX_START_INT						;
input			i_DMA_TX_ADDR_ERR_CH0				;
input			i_DMA_TX_ADDR_ERR_CH1				;
input			i_DMA_TX_ADDR_ERR_CH2				;


input	[31:0]	i_TX_CH0_SVC_CNT;
input	[31:0]	i_TX_CH1_SVC_CNT;
input	[31:0]	i_TX_CH2_SVC_CNT;

input	[39:0]	i_TX_CH0_CUR_ADDR;
input	[39:0]	i_TX_CH1_CUR_ADDR;
input	[39:0]	i_TX_CH2_CUR_ADDR;


input			i_ADAPT_DMA_TX_END;	
//input			i_ADAPT_DMA_OUTPUT_BAND_END;

input			i_SMAP_TX_ADDR_ERR;		
input			i_SMAP_DMA_TX_END;
//input			i_SMAP_DMA_OUTPUT_BAND_END;

input			i_BDS_TX_ADDR_ERR;		
input			i_BDS_DMA_TX_END;
//input			i_BDS_DMA_OUTPUT_BAND_END;

output			[5:0]	o_SMAP_AVGDIVPARAM;
output				o_SMAP_ADAPTIVE_ENABLE;
output			[255:0]	o_SMAP_ADAP_R_MAXRANGE;
output			[255:0]	o_SMAP_ADAP_R_MINRANGE ;
output			[255:0]	o_SMAP_ADAP_G_MAXRANGE ;
output			[255:0]	o_SMAP_ADAP_G_MINRANGE ;
output			[255:0]	o_SMAP_ADAP_B_MAXRANGE ;
output			[255:0]	o_SMAP_ADAP_B_MINRANGE ;

output			o_IRQ							;

// CRC
input	[31:0]	i_DRX_CH0_CRC						;
input	[31:0]	i_DRX_CH1_CRC						;
input	[31:0]	i_DRX_CH2_CRC						;

input	[31:0]	i_BSSA_CH0_CRC						;
input	[31:0]	i_BSSA_CH1_CRC						;
input	[31:0]	i_BSSA_CH2_CRC						;
input	[31:0]	i_BSSB_CH0_CRC						;
input	[31:0]	i_BSSB_CH1_CRC						;
input	[31:0]	i_BSSB_CH2_CRC						;

input	[31:0]	i_RC1_CH0_CRC						;
input	[31:0]	i_RC1_CH1_CRC						;
input	[31:0]	i_RC1_CH2_CRC						;

input	[31:0]	i_BSC1_CH0_CRC						;
input	[31:0]	i_BSC1_CH1_CRC						;
input	[31:0]	i_BSC1_CH2_CRC						;

input	[31:0]	i_RC2_CH0_CRC						;
input	[31:0]	i_RC2_CH1_CRC						;
input	[31:0]	i_RC2_CH2_CRC						;

input	[31:0]	i_S1D_CH0_CRC							;
input	[31:0]	i_S1D_CH1_CRC							;
input	[31:0]	i_S1D_CH2_CRC							;

input	[31:0]	i_ADAPT_CRC							; 
input	[31:0]	i_SMAP_CRC							; 
input	[31:0]	i_BDS_CRC							; 


input	[31:0]	i_SEG1_CH0_CRC						;
input	[31:0]	i_SEG1_CH1_CRC						;
input	[31:0]	i_SEG1_CH2_CRC						;
input	[31:0]	i_SEG1_ATT_CRC						;

input	[31:0]	i_SCC_CH0_CRC						;
input	[31:0]	i_SCC_CH1_CRC						;
input	[31:0]	i_SCC_CH2_CRC						;
input	[31:0]	i_SCC_ATT_CRC						;

input	[31:0]	i_SEG2_CH0_CRC						;
input	[31:0]	i_SEG2_CH1_CRC						;
input	[31:0]	i_SEG2_CH2_CRC						;
input	[31:0]	i_SEG2_ATT_CRC						;

input	[31:0]	i_DTX_CH0_CRC				;
input	[31:0]	i_DTX_CH1_CRC				;
input	[31:0]	i_DTX_CH2_CRC				;
//input	[31:0]	i_DTX_ATT0_CRC				;
//input	[31:0]	i_DTX_ATT1_CRC				;
//input	[31:0]	i_DTX_ATT2_CRC				;
// DEBUG
input	[7:0]	i_S1D_DEBUG_FLAG		;
input	[7:0]	i_SCC_DEBUG_FLAG		;
input	[7:0]	i_BDS_DEBUG_FLAG		;
input	[7:0]	i_BSSA_DEBUG_FLAG		;
input	[7:0]	i_BSSB_DEBUG_FLAG		;

output			o_RAM_SW_MODE;
output	[29:0]	o_RAM_CSN;
output			o_RAM_WEN;
output	[31:0]	o_RAM_ADDR;
output	[31:0]	o_RAM_DATA;
input	[31:0]	i_RAM_RD_DATA;

//-------------------------------------------------------------
// CONFIG
//-------------------------------------------------------------
// MODE 
parameter		SPA_SW_RESET					=	13'h000>>2;		
parameter		SPA_CORE_START				=	13'h004>>2; 		
parameter		SPA_MODE						=	13'h008>>2; 		
parameter		SPA_EN						=	13'h00C>>2; 		
parameter		SPA_RX_XD						=	13'h010>>2; 		
parameter		SPA_RX_YD						=	13'h014>>2; 		
parameter		SPA_TX_IMG_SIZE				=	13'h018>>2; 		
parameter		SPA_PADDING_VAL				=	13'h01C>>2; 		
//Reeserved 
parameter		SPA_VERSION					=	13'h024>>2; 		
//parameter		SPA_RX_YD_OUT					=	13'h028>>2; 		
//Reserved											13'h02C>>2; 		
parameter		IRQ_ENABLE						=	13'h030>>2; 		
parameter		IRQ_PEND						=	13'h034>>2; 		
parameter		IRQ_SVC_CNT						=	13'h038>>2; 		
parameter		SRAM_SW_MODE					=	13'h03C>>2; 		
parameter		SRAM_CSN						=	13'h040>>2; 		
parameter		SRAM_DATA						=	13'h048>>2; 		
parameter		SRAM_ADDR						=	13'h04C>>2; 		
//Reserved											13'h050>>2; 		
parameter		SPA_CORE_BAND_END				=   13'h054>>2; 		
parameter		SPA_CORE_PAGE_END				=   13'h058>>2; 		
//Reserved										=   13'h060>>2; 		
//Reserved										=   13'h064>>2;
parameter		COLOR_MODE						=   13'h068>>2;
parameter		TBL_RX_CNT						=   13'h06C>>2;
parameter		TBL_TX_CNT						=   13'h070>>2;
parameter		TBL_END_STATUS1					=   13'h074>>2;
//parameter		TBL_END_STATUS2					=   13'h078>>2;
//Reserved										=   13'h07C>>2;
parameter		TBL_START						=	13'h080>>2 ;	  
parameter		TBL_ENABLE						=	13'h084>>2 ;	  
//parameter		Reserved						=	13'h088>>2 ;	  
parameter		TBL_ADDR_00						=	13'h08C>>2 ;      
parameter		TBL_ADDR_01						=	13'h090>>2 ;      
parameter		TBL_ADDR_02						=	13'h094>>2 ;      
parameter		TBL_ADDR_03						=	13'h098>>2 ;      
parameter		TBL_ADDR_04						=	13'h09C>>2 ;      
parameter		TBL_ADDR_05						=	13'h0A0>>2 ;      
parameter		TBL_ADDR_06						=	13'h0A4>>2 ;      
parameter		TBL_ADDR_07						=	13'h0A8>>2 ;      
parameter		TBL_ADDR_08						=	13'h0AC>>2 ;
parameter		TBL_ADDR_09						=	13'h0B0>>2 ;
parameter		TBL_ADDR_10						=	13'h0B4>>2 ;
parameter		TBL_ADDR_11						=	13'h0B8>>2 ;
parameter		TBL_ADDR_12						=	13'h0BC>>2 ;
parameter		TBL_ADDR_13						=	13'h0C0>>2 ;
parameter		TBL_ADDR_14						=	13'h0C4>>2 ;
parameter		TBL_ADDR_15						=	13'h0C8>>2 ;      
parameter		TBL_ADDR_16						=	13'h0CC>>2 ;      
parameter		TBL_ADDR_17						=	13'h0D0>>2 ;      
parameter		TBL_ADDR_18						=	13'h0D4>>2 ;      
parameter		TBL_ADDR_19						=	13'h0D8>>2 ;      
parameter		TBL_ADDR_20						=	13'h0DC>>2 ;      
parameter		TBL_ADDR_21						=	13'h0E0>>2 ;      
parameter		TBL_ADDR_22						=	13'h0E4>>2 ;      
parameter		TBL_ADDR_23						=	13'h0E8>>2 ;      
parameter		TBL_ADDR_24						=	13'h0EC>>2 ;      
//parameter		TBL_ADDR_25						=	13'h0F0>>2 ;      
//parameter		TBL_ADDR_26						=	13'h0F4>>2 ;      
//parameter		TBL_ADDR_27						=	13'h0F8>>2 ;      
//parameter		TBL_ADDR_28						=	13'h0FC>>2 ;      
//parameter		TBL_ADDR_29						=	13'h100>>2 ;      
//p/parameter		TBL_ADDR_30						=	13'h104>>2 ;      
//p/parameter		TBL_ADDR_31						=	13'h108>>2 ;      
//parameter		TBL_ADDR_32						=	13'h10C>>2 ;      
//parameter		TBL_ADDR_33						=	13'h110>>2 ;      
//parameter		TBL_ADDR_34						=	13'h114>>2 ;      
//parameter		TBL_ADDR_35						=	13'h118>>2 ;      
//parameter		TBL_ADDR_36						=	13'h11C>>2 ;      
//parameter		TBL_ADDR_37						=	13'h120>>2 ;      
//parameter		TBL_ADDR_38						=	13'h124>>2 ;      
//parameter		TBL_ADDR_39						=	13'h128>>2 ;      
//parameter		TBL_ADDR_40						=	13'h12C>>2 ;      
//parameter		TBL_ADDR_41						=	13'h130>>2 ;      
//parameter		TBL_ADDR_42						=	13'h134>>2 ;      
//-------------------------------------------------------------
// RX DMA                                                            
//-------------------------------------------------------------
parameter		p_RX_START						=	13'h140>>2 ;      
//parameter		p_RX_BAND_NUM					=	13'h144>>2 ;      
parameter		RX_INCR							=	13'h148>>2 ;      
parameter		RX_CH0_PREV_ADDR				=	13'h14C>>2 ;      
parameter		RX_CH1_PREV_ADDR				=	13'h150>>2 ;      
parameter		RX_CH2_PREV_ADDR				=	13'h154>>2 ;      
parameter		RX_CH0_CURR_ADDR					=	13'h158>>2 ;      
parameter		RX_CH1_CURR_ADDR					=	13'h15C>>2 ;      
parameter		RX_CH2_CURR_ADDR					=	13'h160>>2 ;      
parameter		RX_CH0_START_ADDR					=	13'h164>>2 ;      
parameter		RX_CH1_START_ADDR					=	13'h168>>2 ;      
parameter		RX_CH2_START_ADDR					=	13'h16C>>2 ;      
parameter		RX_BLK_CNT						=	13'h170>>2 ;      
parameter		RX_STATUS						=	13'h174>>2 ;      
parameter		RX_CUR_ADDR_CH0					=	13'h178>>2 ;      
parameter		RX_CUR_ADDR_CH1					=	13'h17C>>2 ;      
parameter		RX_CUR_ADDR_CH2					=	13'h180>>2 ;      
parameter		RX_SVC_CNT_CH0 					=	13'h184>>2 ;      
parameter		RX_SVC_CNT_CH1 					=	13'h188>>2 ;      
parameter		RX_SVC_CNT_CH2 					=	13'h18C>>2 ;      
parameter		RX_DMA_CON	 					=	13'h190>>2 ;      
parameter		RX_ERR_STATUS 					=	13'h194>>2 ;      
parameter		RX_ERR_CNT	 					=	13'h198>>2 ;      
parameter		RX_ERR_ARADDR 					=	13'h19C>>2 ;      
parameter		RX_ERR_POS	 					=	13'h1A0>>2 ;      
//Reserved										=   13'h1A4>>2;
// .....
//Reserved										=   13'h1BC>>2;
//-------------------------------------------------------------
// TX DMA                                                            
//-------------------------------------------------------------
parameter		TX_START						=	13'h1C0>>2;      
parameter		TX_DMA_CON						=	13'h1C4>>2;      
parameter		p_TX_BAND_NUM					=	13'h1C8>>2;      
parameter		TX_DATA_INCR					=	13'h1CC>>2;      
//Reserved										=	13'h1D0>>2;      
parameter		TX_CH0_START_ADDR				=	13'h1D4>>2;      
parameter		TX_CH1_START_ADDR				=	13'h1D8>>2;     
parameter		TX_CH2_START_ADDR				=	13'h1DC>>2;      
//Reserved										=	13'h1E0>>2;      
//Reserved										=	13'h1E4>>2;      
parameter		TX_BLK_CNT						=	13'h1E8>>2;      
parameter		TX_STATUS						=	13'h1EC>>2;  
parameter		TX_ADDR_CH0_MAX					=	13'h1F0>>2;      
parameter		TX_ADDR_CH0_MIN					=	13'h1F4>>2;      
parameter		TX_ADDR_CH1_MAX					=	13'h1F8>>2;      
parameter		TX_ADDR_CH1_MIN					=	13'h1FC>>2;      
parameter		TX_ADDR_CH2_MAX					=	13'h200>>2;      
parameter		TX_ADDR_CH2_MIN					=	13'h204>>2;      
//				=	13'h208>>2;      
//				=	13'h20C>>2;      
//				=	13'h210>>2;      
//				=	13'h214>>2; 
//				=	13'h218>>2;      
//				=	13'h21C>>2; 
parameter		TX_CH0_CUR_ADDR					=	13'h218>>2;     
parameter		TX_CH1_CUR_ADDR					=	13'h21C>>2;     
parameter		TX_CH2_CUR_ADDR					=	13'h220>>2;     
//Reserved
parameter		TX_CH0_SVC_CNT					=	13'h22C>>2 ;     
parameter		TX_CH1_SVC_CNT					=	13'h230>>2 ;      
parameter		TX_CH2_SVC_CNT					=	13'h234>>2 ;      
//Reserved
parameter		TX_ERR_STATUS					=	13'h240>>2 ;      
//parameter		TX_ADDR_ERR_STATUS				=	13'h244>>2 ;      
//-------------------------------------------------------------
// ADAPT DMA                                                         
//-------------------------------------------------------------
parameter		ADAPT_DMA_CON					=	13'h280>>2 ;      
parameter		ADAPT_DMA_ADDR					=	13'h284>>2 ;      
parameter		ADAPT_DMA_ADDR_INCR				=	13'h288>>2 ;      
parameter		ADAPT_DMA_STATUS				=	13'h28C>>2 ;      
parameter		ADAPT_DMA_TX_ADDR_MAX			=	13'h290>>2 ;      
parameter		ADAPT_DMA_TX_ADDR_MIN			=	13'h294>>2 ;      
parameter		ADAPT_TX_CUR_ADDR				=	13'h298>>2 ;      
parameter		ADAPT_TX_SVC_CNT				=	13'h29C>>2 ; 
parameter		ADAPT_TX_START					=	13'h2A0>>2 ; 
parameter		ADAPT_BAND_CNT					=	13'h2A4>>2 ; 
//SMAP DMA                                                           
parameter		SMAP_DMA_CON					=	13'h2C0>>2 ;      
parameter		SMAP_DMA_ADDR					=	13'h2C4>>2 ;      
parameter		SMAP_DMA_ADDR_INCR				=	13'h2C8>>2 ;      
parameter		SMAP_DMA_STATUS					=	13'h2CC>>2 ;      
parameter		SMAP_DMA_TX_ADDR_MAX				=	13'h2D0>>2 ;      
parameter		SMAP_DMA_TX_ADDR_MIN				=	13'h2D4>>2 ;  
parameter		SMAP_TX_CUR_ADDR				=	13'h2D8>>2 ;      
parameter		SMAP_TX_SVC_CNT					=	13'h2DC>>2 ;
parameter		SMAP_TX_START					=	13'h2E0>>2 ; 
parameter		SMAP_BAND_CNT					=	13'h2E4>>2 ; 
//BDS DMA                                                           
parameter		BDS_DMA_CON					=	13'h300>>2 ;      
parameter		BDS_DMA_ADDR					=	13'h304>>2 ;      
parameter		BDS_DMA_ADDR_INCR				=	13'h308>>2 ;      
parameter		BDS_DMA_STATUS					=	13'h30C>>2 ;      
parameter		BDS_DMA_TX_ADDR_MAX				=	13'h310>>2 ;      
parameter		BDS_DMA_TX_ADDR_MIN				=	13'h314>>2 ;  
parameter		BDS_TX_CUR_ADDR					=	13'h318>>2 ;      
parameter		BDS_TX_SVC_CNT					=	13'h31C>>2 ;
parameter		BDS_TX_START					=	13'h320>>2 ; 
parameter		BDS_BAND_CNT					=	13'h324>>2 ; 
//--------------------------------------------------------------
// CRC
//--------------------------------------------------------------
// RXDMA
parameter		RX_CH0_CRC						=	13'h340>>2 ;
parameter		RX_CH1_CRC						=	13'h344>>2 ;
parameter		RX_CH2_CRC						=	13'h348>>2 ;

// RC1
parameter		RC1_CH0_CRC						=	13'h350>>2 ;
parameter		RC1_CH1_CRC						=	13'h354>>2 ;
parameter		RC1_CH2_CRC						=	13'h358>>2 ;

// BSC1
parameter		DEBUG_RC1_CH0_CRC				=	13'h360>>2 ;
parameter		DEBUG_RC1_CH1_CRC				=	13'h364>>2 ;
parameter		DEBUG_RC1_CH2_CRC				=	13'h368>>2 ;

// S1D
parameter		S1D_CH0_CRC						=	13'h370>>2 ;
parameter		S1D_CH1_CRC						=	13'h374>>2 ;
parameter		S1D_CH2_CRC						=	13'h378>>2 ;

// SEG1
parameter		SEG1_CH0_CRC					=	13'h380>>2 ;
parameter		SEG1_CH1_CRC					=	13'h384>>2 ;
parameter		SEG1_CH2_CRC					=	13'h388>>2 ;
parameter		SEG1_ATT0_CRC					=	13'h38C>>2 ; 

// SCC
parameter		SCC_CH0_CRC						=	13'h390>>2 ;
parameter		SCC_CH1_CRC						=	13'h394>>2 ;
parameter		SCC_CH2_CRC						=	13'h398>>2 ;
parameter		SCC_ATT_CRC						=	13'h39C>>2 ;

// SEG2
parameter		SEG2_CH0_CRC					=	13'h3A0>>2 ;
parameter		SEG2_CH1_CRC					=	13'h3A4>>2 ;
parameter		SEG2_CH2_CRC					=	13'h3A8>>2 ;
parameter		SEG2_ATT_CRC					=	13'h3AC>>2 ;

// BSSA
parameter		BSSA_CH0_CRC						=	13'h3B0>>2 ;
parameter		BSSA_CH1_CRC						=	13'h3B4>>2 ;
parameter		BSSA_CH2_CRC						=	13'h3B8>>2 ;

// TX DMA
parameter		DTX_CH0_CRC						=	13'h3C0>>2 ;
parameter		DTX_CH1_CRC						=	13'h3C4>>2 ;
parameter		DTX_CH2_CRC						=	13'h3C8>>2 ;

// RC2
parameter		RC2_CH0_CRC						=	13'h3D0>>2 ;
parameter		RC2_CH1_CRC						=	13'h3D4>>2 ;
parameter		RC2_CH2_CRC						=	13'h3D8>>2 ;

// ADAPT_SMAP 
parameter		ADAPT_CRC						=	13'h3E0>>2 ;
parameter		SMAP_CRC						=	13'h3E4>>2 ;
parameter		BDS_CRC							=	13'h3E8>>2 ;

//VSD 
parameter		VSD_CH0_CRC						=	13'h3F0>>2 ;
parameter		VSD_CH1_CRC						=	13'h3F4>>2 ;
parameter		VSD_CH2_CRC						=	13'h3F8>>2 ;

//CIS 
parameter		CIS_CH0_CRC						=	13'h400>>2 ;
parameter		CIS_CH1_CRC						=	13'h404>>2 ;
parameter		CIS_CH2_CRC						=	13'h408>>2 ;

// BSSB
parameter		BSSB_CH0_CRC						=	13'h410>>2 ;
parameter		BSSB_CH1_CRC						=	13'h414>>2 ;
parameter		BSSB_CH2_CRC						=	13'h418>>2 ;
//---------------------------------------------------------------
// DEBUG FIFO
//---------------------------------------------------------------
parameter		S1D_DEBUG_FLAG					=	13'h440>>2;
parameter		SCC_DEBUG_FLAG					=	13'h444>>2;
parameter		BDS_DEBUG_FLAG					=	13'h448>>2;
parameter		BSSA_DEBUG_FLAG					=	13'h44C>>2;
parameter		BSSB_DEBUG_FLAG					=	13'h450>>2;
//-------------------------------------------------------------------------
//VSD                                               
//-------------------------------------------------------------------------
parameter		VSD_REG_A						=	13'h480>>2 ;		
parameter		VSD_REG_B						=	13'h484>>2 ;		
parameter		VSD_REG_C						=	13'h488>>2 ;		
parameter		VSD_REG_D						=	13'h48C>>2 ;		
parameter		VSD_REG_E						=	13'h490>>2 ;		
parameter		VSD_REG_F						=	13'h494>>2 ;		
parameter		VSD_REG_G						=	13'h498>>2 ;	
parameter		VSD_REG_H						=	13'h49C>>2 ;	
             
//---------------------------------------------------------------
// RC1
//---------------------------------------------------------------
parameter		CIS_SUB_COEF_R				=	13'h4C0>>2;    
parameter		CIS_SUB_COEF_G				=	13'h4C4>>2;    
parameter		CIS_SUB_COEF_B				=	13'h4C8>>2;    

//---------------------------------------------------------------
// RC1
//---------------------------------------------------------------
parameter		RC1_SHIFT_VAL					=	13'h500>>2;    
parameter		RC1_SHIFT_OFST					=	13'h504>>2;    
parameter		RC1_LOOP						=	13'h508>>2;    
//Reserved
parameter		RC1_X_COF_00_01					=	13'h510>>2;    
parameter		RC1_X_COF_02_03					=	13'h514>>2;    
parameter		RC1_X_COF_10_11					=	13'h518>>2;    
parameter		RC1_X_COF_12_13					=	13'h51C>>2;    
parameter		RC1_X_COF_20_21					=	13'h520>>2;    
parameter		RC1_X_COF_22_23					=	13'h524>>2;    
parameter		RC1_X_COF_30_31					=	13'h528>>2;    
parameter		RC1_X_COF_32_33					=	13'h52C>>2;      
parameter		RC1_Y_COF_00_01					=	13'h530>>2;      
parameter		RC1_Y_COF_02_03					=	13'h534>>2;      
parameter		RC1_Y_COF_10_11					=	13'h538>>2;      
parameter		RC1_Y_COF_12_13					=	13'h53C>>2;      
parameter		RC1_Y_COF_20_21					=	13'h540>>2;      
parameter		RC1_Y_COF_22_23					=	13'h544>>2;      
parameter		RC1_Y_COF_30_31					=	13'h548>>2;      
parameter		RC1_Y_COF_32_33					=	13'h54C>>2;      
//---------------------------------------------------------------
// S1D
//---------------------------------------------------------------
// None

//---------------------------------------------------------------
// SEG1
//---------------------------------------------------------------
parameter		SEG1_CON						=	13'h580>>2 ;      
parameter		SEG1_HVLINE_TH					=	13'h584>>2 ;      
parameter		SEG1_EDGE_TH					=	13'h588>>2 ;      
parameter		SEG1_LINE_TH					=	13'h58C>>2 ;      
parameter		SEG1_ZC_TH						=	13'h590>>2 ;      
//---------------------------------------------------------------
// SCC
//---------------------------------------------------------------
parameter		SCC_CON							=	13'h5C0>>2 ;   
//---------------------------------------------------------------
// SEG2
//---------------------------------------------------------------
parameter		SEG2_CON						=	13'h600>>2 ;      
parameter		SEG2_PARAM1						=	13'h604>>2 ;      
parameter		SEG2_PARAM2						=	13'h608>>2 ;      
parameter		SEG2_FAR_CHROMA_PARAM 			=	13'h60C>>2 ;      
parameter		SEG2_FAR_Y_PARAM	  			=	13'h610>>2 ;      
parameter		SEG2_NEUT_CHROMA_PARAM			=	13'h614>>2 ;    
//---------------------------------------------------------------
// ORIENTATION
//---------------------------------------------------------------
parameter		ORI_PAGE_EN						=	13'h7C0>>2 ;      
parameter		ORI_BLOCK_SIZE					=	13'h7C4>>2 ;      
parameter		ORI_AREA_SIZE					=	13'h7C8>>2 ;      
parameter		ORI_CHAR_LENGTH_THICK_V			=	13'h7CC>>2 ;      
parameter		ORI_CHAR_LENGTH_THICK_H			=	13'h7D0>>2 ;      
parameter		ORI_DIFF_CHANGE_V				=	13'h7D4>>2 ;      
parameter		ORI_DIFF_CHANGE_H				=	13'h7D8>>2 ;      
parameter		ORI_DIR_TH1					=	13'h7DC>>2 ;      
parameter		ORI_DIR_TH2					=	13'h7E0>>2 ;      
parameter		ORI_AREA_OFFSET1				=	13'h7E4>>2 ;      
parameter		ORI_AREA_OFFSET2				=	13'h7E8>>2 ;      
parameter		ORI_LINE_SPACE					=	13'h7EC>>2 ;      
parameter		ORI_TEX_FLAG					=	13'h7F0>>2 ; // Read Only    
parameter		ORI_TEXT_AREA1_W				=	13'h7F4>>2 ; // Read Only    
parameter		ORI_TEXT_AREA1_H				=	13'h7F8>>2 ; // Read Only    
parameter		ORI_TEXT_AREA2_W				=	13'h7FC>>2 ; // Read Only    
parameter		ORI_TEXT_AREA2_H				=	13'h800>>2 ; // Read Only   
parameter		ORI_TEXT_AREA3_W				=	13'h804>>2 ; // Read Only    
parameter		ORI_TEXT_AREA3_H				=	13'h808>>2 ; // Read Only    

//---------------------------------------------------------------
// ABSD                                                       
//---------------------------------------------------------------
parameter		ABSD_PRE_SCAN_LINE				=	13'h840>>2 ;      
parameter		ABSD_PRESCAN_IWIN				=	13'h844>>2 ;      
parameter		ABSD_TH							=	13'h848>>2 ;      
parameter		ABSD_VALID_PERCENTAGE			=	13'h84C>>2 ;      
parameter		ABSD_BK_STD_TH					=	13'h850>>2 ;      
parameter		ABSD_SIGMA						=	13'h854>>2 ;      
parameter		ABSD_BG_BACKUP					=	13'h858>>2 ;      
parameter		ABSD_COLOR_EXCEPTION			=	13'h85C>>2 ;      
parameter		ABSD_TOP_BG_LEVEL				=	13'h860>>2 ;      
parameter		ABSD_TOP_PEAK_CONFIDENCE		=	13'h864>>2 ;      
parameter		ABSD_PRE_SCAN_START				=	13'h868>>2 ;   
//---------------------------------------------------------------
// MAGD
//---------------------------------------------------------------
parameter		MAGD_PRE_SCAN_LINE				=	13'h880>>2 ;      
parameter		MAGD_PRESCAN_IWIN				=	13'h884>>2 ;      
parameter		MAGD_TH							=	13'h888>>2 ;      
parameter		MAGD_VALID_PERCENTAGE			=	13'h88C>>2 ;      
parameter		MAGD_BK_STD_TH					=	13'h890>>2 ;      
parameter		MAGD_SIGMA						=	13'h894>>2 ;      
parameter		MAGD_BG_BACKUP					=	13'h898>>2 ;      
parameter		MAGD_COLOR_EXCEPTION			=	13'h89C>>2 ;      
parameter		MAGD_TOP_BG_LEVEL				=	13'h8A0>>2 ;      
parameter		MAGD_TOP_PEAK_CONFIDENCE		=	13'h8A4>>2 ;      
parameter		MAGD_PRE_SCAN_START				=	13'h8A8>>2 ;

//---------------------------------------------------------------
// NEWABSD
//---------------------------------------------------------------
parameter		NEWABSD_SCAN_RANGE				=	13'h8C0>>2 ;      
parameter		NEWABSD_PRESCAN_IWIN			=	13'h8C4>>2 ;      
parameter		NEWABSD_CHROMA_TH				=	13'h8C8>>2 ;      
parameter		NEWABSD_LIMIT					=	13'h8CC>>2 ;  
parameter		NEWABSD_HISTO_PEAK				=	13'h8D0>>2 ;  
parameter		NEWABSD_HISTO_LEFT				=	13'h8D4>>2 ;  
parameter		NEWABSD_HISTO_RIGHT				=	13'h8D8>>2 ;  
parameter		NEWABSD_RESULT					=	13'h8DC>>2 ;  
//---------------------------------------------------------------
// CLA
//---------------------------------------------------------------
parameter		CLA_CON1						=	13'h900>>2 ;      
parameter		CLA_CON2						=	13'h904>>2 ;      
parameter		CLA_TOTAL_BIN_CNT				=	13'h908>>2 ;      
parameter		CLA_HL_range2	  				=	13'h90C>>2 ;      
parameter		CLA_HL_color2	  				=	13'h910>>2 ;      
parameter		CLA_BTEXT_CNT	  				=	13'h914>>2 ;      
parameter		CLA_TEXT_CNT	  				=	13'h918>>2 ;      
parameter		CLA_HT_CNT						=	13'h91C>>2 ;      
parameter		CLA_EDGE_CNT	  				=	13'h920>>2 ;      
parameter		CLA_WHITE_CNT	  				=	13'h924>>2 ;      
parameter		CLA_CONTONE_CNT	  				=	13'h928>>2 ;
parameter		CLA_WHITE_WO_TEXT_CNT  				=	13'h92C>>2 ;
parameter		CLA_WHITE_WO_HT_TEXT_CNT  			=	13'h930>>2 ;
parameter		CLA_CONTENT_SIZE	  			=	13'h934>>2 ;

//---------------------------------------------------------------
// ACBD
//---------------------------------------------------------------
parameter		ACBD_MARGIN1					=	13'h980>>2 ;      
parameter		ACBD_MARGIN2					=	13'h984>>2 ;      
parameter		ACBD_TH1						=	13'h988>>2 ;      
parameter		ACBD_TH2						=	13'h98C>>2 ;      
parameter		ACBD_HLIGHT_SEL_EN				=	13'h990>>2 ;      
parameter		ACBD_AVG_TH						=	13'h994>>2 ;      
parameter		ACBD_HISTO_WIN_VAL				=	13'h998>>2 ;      
parameter		ACBD_RATIO_TH					=	13'h99C>>2 ;      
parameter		ACBD_LIMIT_TH				 	=	13'h9A0>>2 ;      
parameter		ACBD_BRIGHT_STRETCH_OFFSET		=	13'h9A4>>2 ;
parameter		ACBD_ACB_TH1					=	13'h9A8>>2 ;
parameter		ACBD_ACB_TH2					=	13'h9AC>>2 ;
parameter		ACBD_OBJ						=	13'h9B0>>2 ;
parameter		ACBD_RESULT1						=	13'h9B4>>2 ; // Read Only
parameter		ACBD_RESULT2						=	13'h9B8>>2 ; // Read Only
parameter		ACBD_ACS_REF_ON						=	13'h9BC>>2 ;
//---------------------------------------------------------------
// ACS
//---------------------------------------------------------------
parameter		ACS_CON 						=	13'h9C0>>2 ;      
parameter		ACS_MARK_POS_TOP				=   13'h9C4>>2 ;      
parameter		ACS_MARK_POS_BOTTOM				=   13'h9C8>>2 ;      
parameter		ACS_MARK_POS_LEFT 				=	13'h9CC>>2 ;      
parameter		ACS_MARK_POS_RIGHT				=	13'h9D0>>2 ;      
parameter		ACS_SATURATION_TH 				=	13'h9D4>>2 ;      
parameter		ACS_HT_TH 						=	13'h9D8>>2 ;      
parameter		ACS_CBMAX1 						=	13'h9DC>>2 ;      
parameter		ACS_CBMAX2 						=	13'h9E0>>2 ;      
parameter		ACS_CBMAX3 						=	13'h9E4>>2 ;      
parameter		ACS_CBMAX4 						=	13'h9E8>>2 ;      
parameter		ACS_CBMIN1 						=	13'h9EC>>2 ;      
parameter		ACS_CBMIN2 						=	13'h9F0>>2 ;      
parameter		ACS_CBMIN3 						=	13'h9F4>>2 ;      
parameter		ACS_CBMIN4 						=	13'h9F8>>2 ;      
parameter		ACS_CRMAX1 						=	13'h9FC>>2 ;      
parameter		ACS_CRMAX2 						=	13'hA00>>2 ;      
parameter		ACS_CRMAX3 						=	13'hA04>>2 ;      
parameter		ACS_CRMAX4 						=	13'hA08>>2 ;      
parameter		ACS_CRMIN1 						=	13'hA0C>>2 ;      
parameter		ACS_CRMIN2 						=	13'hA10>>2 ;      
parameter		ACS_CRMIN3 						=	13'hA14>>2 ;      
parameter		ACS_CRMIN4 						=	13'hA18>>2 ;      
parameter		ACS_CBMAXH1 					=	13'hA1C>>2 ;      
parameter		ACS_CBMAXH2 					=	13'hA20>>2 ;      
parameter		ACS_CBMAXH3 					=	13'hA24>>2 ;      
parameter		ACS_CBMAXH4 					=	13'hA28>>2 ;      
parameter		ACS_CBMINH1 					=	13'hA2C>>2 ;      
parameter		ACS_CBMINH2 					=	13'hA30>>2 ;      
parameter		ACS_CBMINH3 					=	13'hA34>>2 ;      
parameter		ACS_CBMINH4 					=	13'hA38>>2 ;      
parameter		ACS_CRMAXH1 					=	13'hA3C>>2 ;      
parameter		ACS_CRMAXH2 					=	13'hA40>>2 ;      
parameter		ACS_CRMAXH3 					=	13'hA44>>2 ;      
parameter		ACS_CRMAXH4 					=	13'hA48>>2 ;      
parameter		ACS_CRMINH1 					=	13'hA4C>>2 ;      
parameter		ACS_CRMINH2 					=	13'hA50>>2 ;      
parameter		ACS_CRMINH3 					=	13'hA54>>2 ;      
parameter		ACS_CRMINH4 					=	13'hA58>>2 ;      
parameter		ACS_VALUE_TH 					=	13'hA5C>>2 ;      
parameter		ACS_TBLK_PAGE 					=	13'hA60>>2 ;      
parameter		ACS_TBLK_NPAGE	 				=	13'hA64>>2 ;      
parameter		ACS_CBLK 					=	13'hA68>>2 ;      
parameter		ACS_SBLK_PAGE 					=	13'hA6C>>2 ;      
parameter		ACS_SPXL_BLK_PAGE				=	13'hA70>>2 ;      
parameter		ACS_SPXL_PAGE	  				=	13'hA74>>2 ;      
parameter		ACS_TEXT_PAGE	  				=	13'hA78>>2 ;      
parameter		ACS_HT_PAGE	    				=	13'hA7C>>2 ;      
parameter		ACS_EDGE_PAGE	  				=	13'hA80>>2 ;      
//Reserved						  				=	13'hA84>>2 ;      
parameter		ACS_AVG_HT_ACS00 				=	13'hA88>>2 ;      
parameter		ACS_AVG_HT_ACS01 				=	13'hA8C>>2 ;      
parameter		ACS_AVG_HT_ACS02 				=	13'hA90>>2 ;      
parameter		ACS_AVG_HT_ACS03 				=	13'hA94>>2 ;      
parameter		ACS_AVG_HT_ACS04 				=	13'hA98>>2 ;      
parameter		ACS_AVG_HT_ACS05 				=	13'hA9C>>2 ;      
parameter		ACS_AVG_HT_ACS06 				=	13'hAA0>>2 ;      
parameter		ACS_AVG_HT_ACS07 				=	13'hAA4>>2 ;      
parameter		ACS_AVG_HT_ACS08 				=	13'hAA8>>2 ;      
parameter		ACS_AVG_HT_ACS09 				=	13'hAAC>>2 ;      
parameter		ACS_AVG_HT_ACS10 				=	13'hAB0>>2 ;      
parameter		ACS_AVG_HT_ACS11 				=	13'hAB4>>2 ;      
parameter		ACS_AVG_HT_ACS12 				=	13'hAB8>>2 ;      
parameter		ACS_AVG_HT_ACS13 				=	13'hABC>>2 ;      
parameter		ACS_AVG_HT_ACS14 				=	13'hAC0>>2 ;      
parameter		ACS_AVG_HT_ACS15 				=	13'hAC4>>2 ;      
parameter		ACS_AVG_NHT_ACS00 				=	13'hAC8>>2 ;      
parameter		ACS_AVG_NHT_ACS01 				=	13'hACC>>2 ;      
parameter		ACS_AVG_NHT_ACS02 				=	13'hAD0>>2 ;      
parameter		ACS_AVG_NHT_ACS03 				=	13'hAD4>>2 ;      
parameter		ACS_AVG_NHT_ACS04 				=	13'hAD8>>2 ;      
parameter		ACS_AVG_NHT_ACS05 				=	13'hADC>>2 ;      
parameter		ACS_AVG_NHT_ACS06 				=	13'hAE0>>2 ;      
parameter		ACS_AVG_NHT_ACS07 				=	13'hAE4>>2 ;      
parameter		ACS_AVG_NHT_ACS08 				=	13'hAE8>>2 ;      
parameter		ACS_AVG_NHT_ACS09 				=	13'hAEC>>2 ;      
parameter		ACS_AVG_NHT_ACS10 				=	13'hAF0>>2 ;      
parameter		ACS_AVG_NHT_ACS11 				=	13'hAF4>>2 ;      
parameter		ACS_AVG_NHT_ACS12 				=	13'hAF8>>2 ;      
parameter		ACS_AVG_NHT_ACS13 				=	13'hAFC>>2 ;      
parameter		ACS_AVG_NHT_ACS14 				=	13'hB00>>2 ;      
parameter		ACS_AVG_NHT_ACS15 				=	13'hB04>>2 ;      
parameter		ACS_SATURATION_TH2 				=	13'hB08>>2 ;    
parameter		ACS_VALID_RANGE_H 				=	13'hB0C>>2 ;    
parameter		ACS_VALID_RANGE_W 				=	13'hB10>>2 ;    
  
parameter		ACSv2_CON	 				=	13'hB14>>2 ;    
parameter		ACSv2_SATURATION_TH				=	13'hB18>>2 ;    
parameter		ACSv2_SATURATION_TH2				=	13'hB1C>>2 ;    
parameter		ACSv2_HT_TH	 				=	13'hB20>>2 ;    
parameter		ACSv2_VALUE_TH 					=	13'hB24>>2 ;      
parameter		ACSv2_TBLK_PAGE 				=	13'hB28>>2 ;      
parameter		ACSv2_TBLK_NPAGE	 			=	13'hB2C>>2 ;      
parameter		ACSv2_CBLK 					=	13'hB30>>2 ;      
parameter		ACSv2_SBLK_PAGE 				=	13'hB34>>2 ;      
parameter		ACSv2_SPXL_BLK_PAGE				=	13'hB38>>2 ;      
parameter		ACSv2_SPXL_PAGE	  				=	13'hB3C>>2 ;      
//---------------------------------------------------------------
// BLANK                                                      
//---------------------------------------------------------------
parameter		BLANK_CON0 						=	13'hB40>>2 ;      
parameter		BLANK_CON1						=	13'hB44>>2 ;      
parameter		BLANK_MARK_POS_TOP  			=	13'hB48>>2 ;      
parameter		BLANK_MARK_POS_BOTTOM 			=	13'hB4C>>2 ;      
parameter		BLANK_MARK_POS_LEFT  			=	13'hB50>>2 ;      
parameter		BLANK_MARK_POS_RIGHT 			=	13'hB54>>2 ;      
parameter		BLANK_COLOR_BLK  				=	13'hB58>>2 ;      
parameter		BLANK_TotalBLK  				=	13'hB5C>>2 ;      
parameter		BLANK_ContBLK					=	13'hB60>>2 ;      
parameter		BLANK_BlankBLK  				=	13'hB64>>2 ;      
parameter		BLANK_DarkBLK					=	13'hB68>>2 ;      
parameter		BLANK_ColorBLK  				=	13'hB6C>>2 ;      
parameter		BLANK_Y_MIN_MAX  				=	13'hB70>>2 ;      
parameter		BLANK_CB_MIN_MAX  				=	13'hB74>>2 ;      
parameter		BLANK_CR_MIN_MAX  				=	13'hB78>>2 ;      
//---------------------------------------------------------------
// RC2
//---------------------------------------------------------------
parameter		RC2_OUTIMG_WIDTH_HEIGHT			=	13'hB80>>2;      
parameter		RC2_OVERLAP						=	13'hB84>>2;      
parameter		RC2_FRAC						=	13'hB88>>2;
//---------------------------------------------------------------
// BDS
//---------------------------------------------------------------
parameter		BDS_CON							=	13'hBC0>>2;
parameter		BDS_EDGE1						=	13'hBC4>>2;
parameter		BDS_EDGE2						=	13'hBC8>>2;
parameter		BDS_EURion1						=	13'hBCC>>2;
parameter		BDS_EURion2						=	13'hBD0>>2;
parameter		BDS_OFFSET						=	13'hBD4>>2;
parameter		BDS_CONTENTS					=	13'hBD8>>2;
//---------------------------------------------------------------
// SMAP
//---------------------------------------------------------------
//parameter		SMAP_PARAM_A					=	13'hC80>>2;      
parameter		SMAP_PARAM_B					=	13'hC84>>2;      
parameter		SMAP_PARAM_C					=	13'hC88>>2;      
parameter		SMAP_CON						=	13'hC8C>>2;	  
parameter 		SMAP_R_MAX0						= 	13'hC90>>2;      
parameter 		SMAP_R_MAX1						= 	13'hC94>>2;      
parameter 		SMAP_R_MAX2						= 	13'hC98>>2;      
parameter 		SMAP_R_MAX3						= 	13'hC9C>>2;      
parameter 		SMAP_R_MAX4						= 	13'hCA0>>2;      
parameter 		SMAP_R_MAX5						= 	13'hCA4>>2;      
parameter 		SMAP_R_MAX6						= 	13'hCA8>>2;      
parameter 		SMAP_R_MAX7 					= 	13'hCAC>>2;      
parameter 		SMAP_R_MIN0 					= 	13'hCB0>>2;      
parameter 		SMAP_R_MIN1 					= 	13'hCB4>>2;      
parameter 		SMAP_R_MIN2 					= 	13'hCB8>>2;      
parameter 		SMAP_R_MIN3 					= 	13'hCBC>>2;      
parameter 		SMAP_R_MIN4 					= 	13'hCC0>>2;      
parameter 		SMAP_R_MIN5 					= 	13'hCC4>>2;      
parameter 		SMAP_R_MIN6 					= 	13'hCC8>>2;      
parameter 		SMAP_R_MIN7 					= 	13'hCCC>>2;      
parameter 		SMAP_G_MAX0 					= 	13'hCD0>>2;      
parameter 		SMAP_G_MAX1 					= 	13'hCD4>>2;      
parameter 		SMAP_G_MAX2 					= 	13'hCD8>>2;      
parameter 		SMAP_G_MAX3 					= 	13'hCDC>>2;      
parameter 		SMAP_G_MAX4 					= 	13'hCE0>>2;      
parameter 		SMAP_G_MAX5 					= 	13'hCE4>>2;      
parameter 		SMAP_G_MAX6 					= 	13'hCE8>>2;      
parameter 		SMAP_G_MAX7 					= 	13'hCEC>>2;      
parameter 		SMAP_G_MIN0 					= 	13'hCF0>>2;      
parameter 		SMAP_G_MIN1 					= 	13'hCF4>>2;      
parameter 		SMAP_G_MIN2 					= 	13'hCF8>>2;      
parameter 		SMAP_G_MIN3 					= 	13'hCFC>>2;
parameter 		SMAP_G_MIN4 					= 	13'hD00>>2;      
parameter 		SMAP_G_MIN5 					= 	13'hD04>>2;      
parameter 		SMAP_G_MIN6 					= 	13'hD08>>2;      
parameter 		SMAP_G_MIN7 					= 	13'hD0C>>2;      
parameter 		SMAP_B_MAX0 					= 	13'hD10>>2;      
parameter 		SMAP_B_MAX1 					= 	13'hD14>>2;      
parameter 		SMAP_B_MAX2 					= 	13'hD18>>2;      
parameter 		SMAP_B_MAX3 					= 	13'hD1C>>2;      
parameter 		SMAP_B_MAX4 					= 	13'hD20>>2;      
parameter 		SMAP_B_MAX5 					= 	13'hD24>>2;      
parameter 		SMAP_B_MAX6 					= 	13'hD28>>2;      
parameter 		SMAP_B_MAX7 					= 	13'hD2C>>2;      
parameter 		SMAP_B_MIN0 					= 	13'hD30>>2;      
parameter 		SMAP_B_MIN1 					= 	13'hD34>>2;      
parameter 		SMAP_B_MIN2 					= 	13'hD38>>2;      
parameter 		SMAP_B_MIN3 					= 	13'hD3C>>2;      
parameter 		SMAP_B_MIN4 					= 	13'hD40>>2;      
parameter 		SMAP_B_MIN5 					= 	13'hD44>>2;      
parameter 		SMAP_B_MIN6 					= 	13'hD48>>2;      
parameter 		SMAP_B_MIN7 					= 	13'hD4C>>2;      
//---------------------------------------------------------------
// TBL
//---------------------------------------------------------------
parameter		TBL_ADDR_00_UP					=	13'h108C>>2;	  
parameter		TBL_ADDR_01_UP					=	13'h1090>>2;	  
parameter		TBL_ADDR_02_UP					=	13'h1094>>2;     
parameter		TBL_ADDR_03_UP					=	13'h1098>>2;     
parameter		TBL_ADDR_04_UP					=	13'h109C>>2;     
parameter		TBL_ADDR_05_UP					=	13'h10A0>>2;     
parameter		TBL_ADDR_06_UP					=	13'h10A4>>2;     
parameter		TBL_ADDR_07_UP					=	13'h10A8>>2;     
parameter		TBL_ADDR_08_UP					=	13'h10AC>>2;     
parameter		TBL_ADDR_09_UP					=	13'h10B0>>2;     
parameter		TBL_ADDR_10_UP					=	13'h10B4>>2;     
parameter		TBL_ADDR_11_UP					=	13'h10B8>>2;     
parameter		TBL_ADDR_12_UP					=	13'h10BC>>2;     
parameter		TBL_ADDR_13_UP					=	13'h10C0>>2;     
parameter		TBL_ADDR_14_UP					=	13'h10C4>>2;     
parameter		TBL_ADDR_15_UP					=	13'h10C8>>2;     
parameter		TBL_ADDR_16_UP					=	13'h10CC>>2;     
parameter		TBL_ADDR_17_UP					=	13'h10D0>>2;     
parameter		TBL_ADDR_18_UP					=	13'h10D4>>2;     
parameter		TBL_ADDR_19_UP					=	13'h10D8>>2;     
parameter		TBL_ADDR_20_UP					=	13'h10DC>>2;     
parameter		TBL_ADDR_21_UP					=	13'h10E0>>2;     
parameter		TBL_ADDR_22_UP					=	13'h10E4>>2;     
parameter		TBL_ADDR_23_UP					=	13'h10E8>>2;     
parameter		TBL_ADDR_24_UP					=	13'h10EC>>2;     
//parameter		TBL_ADDR_25_UP					=	13'h10F0>>2;     
//parameter		TBL_ADDR_26_UP					=	13'h10F4>>2;     
//parameter		TBL_ADDR_27_UP					=	13'h10F8>>2;     
//parameter		TBL_ADDR_28_UP					=	13'h10FC>>2;     
//parameter		TBL_ADDR_29_UP					=	13'h1100>>2;     
//parameter		TBL_ADDR_30_UP					=	13'h1104>>2;     
//parameter		TBL_ADDR_31_UP					=	13'h1108>>2;     
//parameter		TBL_ADDR_32_UP					=	13'h110C>>2;     
//parameter		TBL_ADDR_33_UP					=	13'h1110>>2;     
//parameter		TBL_ADDR_34_UP					=	13'h1114>>2;     
//parameter		TBL_ADDR_35_UP					=	13'h1118>>2;     
//parameter		TBL_ADDR_36_UP					=	13'h111C>>2;     
//parameter		TBL_ADDR_37_UP					=	13'h1120>>2;     
//parameter		TBL_ADDR_38_UP					=	13'h1124>>2;     
//parameter		TBL_ADDR_39_UP					=	13'h1128>>2;     
//parameter		TBL_ADDR_40_UP					=	13'h112C>>2;     
//parameter		TBL_ADDR_41_UP					=	13'h1130>>2;     
//parameter		TBL_ADDR_42_UP					=	13'h1134>>2;     
//---------------------------------------------------------------
// RX DMA
//---------------------------------------------------------------
parameter		RX_CH0_PREV_ADDR_UP			=	13'h114C>>2;      
parameter		RX_CH1_PREV_ADDR_UP			=	13'h1150>>2;      
parameter		RX_CH2_PREV_ADDR_UP			=	13'h1154>>2;      
parameter		RX_CH0_CURR_ADDR_UP			=	13'h1158>>2;      
parameter		RX_CH1_CURR_ADDR_UP			=	13'h115C>>2;      
parameter		RX_CH2_CURR_ADDR_UP			=	13'h1160>>2;      
parameter		RX_CH0_START_ADDR_UP			=	13'h1164>>2;      
parameter		RX_CH1_START_ADDR_UP			=	13'h1168>>2;      
parameter		RX_CH2_START_ADDR_UP			=	13'h116C>>2;      
// Reserved                                               
parameter		RX_CUR_ADDR_CH0_UP			=	13'h1178>>2;      
parameter		RX_CUR_ADDR_CH1_UP			=	13'h117C>>2;      
parameter		RX_CUR_ADDR_CH2_UP			=	13'h1180>>2;      
// Reserved                            
parameter		TX_CH0_START_ADDR_UP			=	13'h11D4>>2;      
parameter		TX_CH1_START_ADDR_UP			=	13'h11D8>>2;      
parameter		TX_CH2_START_ADDR_UP			=	13'h11DC>>2;      
// Reserved
parameter		TX_ADDR_CH0_MAX_UP				=	13'h11F0>>2;     
parameter		TX_ADDR_CH0_MIN_UP				=	13'h11F4>>2;     
parameter		TX_ADDR_CH1_MAX_UP				=	13'h11F8>>2;     
parameter		TX_ADDR_CH1_MIN_UP				=	13'h11FC>>2;     
parameter		TX_ADDR_CH2_MAX_UP				=	13'h1200>>2;     
parameter		TX_ADDR_CH2_MIN_UP				=	13'h1204>>2;     
// Reserved                            
parameter		TX_CH0_CUR_ADDR_UP				=	13'h1218>>2;     
parameter		TX_CH1_CUR_ADDR_UP				=	13'h121C>>2;     
parameter		TX_CH2_CUR_ADDR_UP				=	13'h1220>>2;     
// Reserved                            
parameter		ADAPT_DMA_ADDR_UP				=	13'h1284>>2;	  
// Reserved                            
parameter		ADAPT_DMA_TX_ADDR_MAX_UP		=	13'h1290>>2;      
parameter		ADAPT_DMA_TX_ADDR_MIN_UP		=	13'h1294>>2;      
parameter		ADAPT_TX_CUR_ADDR_UP			=	13'h1298>>2;      
// Reserved                            
parameter		SMAP_DMA_ADDR_UP				=	13'h12C4>>2;      
// Reserved                            
parameter		SMAP_DMA_TX_ADDR_MAX_UP			=	13'h12D0>>2;      
parameter		SMAP_DMA_TX_ADDR_MIN_UP			=	13'h12D4>>2;      
parameter		SMAP_TX_CUR_ADDR_UP			=	13'h12D8>>2;      
// Reserved                            
parameter		BDS_DMA_ADDR_UP				=	13'h1304>>2;      
// Reserved                            
parameter		BDS_DMA_TX_ADDR_MAX_UP			=	13'h1310>>2;      
parameter		BDS_DMA_TX_ADDR_MIN_UP			=	13'h1314>>2;      
parameter		BDS_TX_CUR_ADDR_UP			=	13'h1318>>2; 
wire	[39:0]	w_RX_CH0_PREV_ADDR;
wire	[39:0]	w_RX_CH1_PREV_ADDR;
wire	[39:0]	w_RX_CH2_PREV_ADDR;
//wire			w_SMAP_BAND_END_M_sp;
//wire			w_SMAP_TX_START_ORG;
wire	[ 7:0]	w_SMAP_OUT_BANDS		;
//wire	[ 7:0]	w_SMAP_OUT_BANDS_m1		;
//wire			w_SMAP_BAND_DONE;
//reg		[7:0]	r_SMAP_TX_BAND_CNT;
reg				r_SMAP_DMA_TX_END;

//wire			w_BDS_BAND_END_M_sp;
//wire			w_BDS_TX_START_ORG;
wire	[ 7:0]	w_BDS_OUT_BANDS		;
//wire	[ 7:0]	w_BDS_OUT_BANDS_m1		;
//wire			w_BDS_BAND_DONE;
//reg		[7:0]	r_BDS_TX_BAND_CNT;
reg				r_BDS_DMA_TX_END;
reg				r_DMA_STOP		;
reg				r_SW_RESET;
reg				r_SW_RESETn;
//wire			w_ADAPT_BAND_END_M_sp;
//wire			w_ADAPT_TX_START_ORG;
wire	[7:0]	w_ADAPT_OUT_BANDS;
//wire	[7:0]	w_ADAPT_OUT_BANDS_m1;
//wire			w_ADAPT_BAND_DONE;
//reg		[7:0]	r_ADAPT_TX_BAND_CNT;
//reg		[7:0]	r_rx_band_num;
reg				r_ADAPT_DMA_TX_END;
reg				w_PAGE_DONE_M_1d;
reg				r_TX_BAND_DONE;
reg				r_TX_BAND_DONE_1d;
reg	[15:0]	r_RX_XD_ALIGNED;
reg	[15:0]	r_RX_YD_ALIGNED;

wire			w_PAGE_DONE_M;
wire			w_PAGE_DONE_sp;
wire			w_TX_BAND_DONE_sp;
wire	[15:0]	w_RX_YD_ALIGNED_450;

reg				r_TX_START				;
reg		[25:0]		r_tx_dma_con				;
reg		[15:0]		r_tx_data_incr				;
reg		[39:0]		r_tx_ch0_start_addr			;
reg		[39:0]		r_tx_ch1_start_addr			;
reg		[39:0]		r_tx_ch2_start_addr			;
reg		[39:0]		r_tx_addr_ch0_max			;
reg		[39:0]		r_tx_addr_ch0_min			;
reg		[39:0]		r_tx_addr_ch1_max			;
reg		[39:0]		r_tx_addr_ch1_min			;
reg		[39:0]		r_tx_addr_ch2_max			;
reg		[39:0]		r_tx_addr_ch2_min			;

reg				r_RX_START				;
reg		[31:0]		r_rx_incr				;
reg		[25:0]		r_rx_dma_con				;
reg		[39:0]		r_rx_ch0_start_addr		;
reg		[39:0]		r_rx_ch1_start_addr		;
reg		[39:0]		r_rx_ch2_start_addr		;
reg		[13:0]		r_abs_pre_scan_line				;
reg		[29:0]		r_abs_prescan_iwin				;
reg		[16:0]		r_abs_th						;
reg		[ 6:0]		r_abs_valid_percentage			;
reg		[ 7:0]		r_abs_bk_std_th					;
reg		[21:0]		r_abs_sigma						;
reg		[11:0]		r_abs_bg_backup					;
reg		[23:0]		r_abs_color_exception			;

reg		[13:0]		r_magd_pre_scan_line				;
reg		[29:0]		r_magd_prescan_iwin				;
reg		[16:0]		r_magd_th						;
reg		[ 6:0]		r_magd_valid_percentage			;
reg		[ 7:0]		r_magd_bk_std_th					;
reg		[21:0]		r_magd_sigma						;
reg		[11:0]		r_magd_bg_backup					;
reg		[23:0]		r_magd_color_exception			;
reg		[ 7:0]		r_RC1_LAST_BAND_HEIGHT;
reg		[15:0]		r_RC1_YD_ALIGNED;
reg		[15:0]		r_RC1_YD;
reg		[15:0]		r_RC1_XD_ALIGNED;
wire	[ 7:0]		w_RC1_LAST_BAND_HEIGHT;


reg			r_CORE_START;
reg		[31:0]	r_SPA_MODE			;	// 151207 seugnmo.moon
reg		[31:0]	r_SPA_EN				;
reg		[15:0]	r_RX_XD	;
reg		[15:0]	r_RX_YD	;		
reg		[23:0]	r_RX_PADDING_VAL		;
reg		[13:0]	r_ABSD_PRE_SCAN_START;	
reg		[13:0]	r_MAGD_PRE_SCAN_START;	

reg		[ 7:0]	r_tx_band_num;
//wire	[ 7:0]	w_RX_BAND_NUM;
wire	[15:0]	w_BNY;
//reg	[15:0]	r_BNY;
reg	[ 7:0] r_BNX;
reg	[ 7:0]	r_BNY;	//(kjm20130222)
reg		[31:0]	r_TBL_END_STATUS1;
//reg		[10:0]	r_TBL_END_STATUS2;

reg		[15:0]	r_TBL_RX_START_CNT;
reg		[15:0]	r_TBL_TX_START_CNT;
reg		[15:0]	r_TBL_RX_END_CNT;
reg		[15:0]	r_TBL_TX_END_CNT;
// ===================================================================================
//	WRITE FLAG
// ===================================================================================
reg		[31:0]	r_prdata;

wire			w_wr_en,
				w_rd_en;

assign w_wr_en			= i_PSEL & i_PENABLE & i_PWRITE;
assign w_rd_en			= i_PSEL & ~i_PWRITE;


//-------------------------------------------------------------------------------------------
// CONFIG
//-------------------------------------------------------------------------------------------
wire			 w_addr000_wr		= w_wr_en & (i_PADDR == SPA_SW_RESET				);
wire			 w_addr004_wr		= w_wr_en & (i_PADDR == SPA_CORE_START			);
wire			 w_addr008_wr		= w_wr_en & (i_PADDR == SPA_MODE					);
wire			 w_addr00C_wr		= w_wr_en & (i_PADDR == SPA_EN					);
wire			 w_addr010_wr		= w_wr_en & (i_PADDR == SPA_RX_XD					);
wire			 w_addr014_wr		= w_wr_en & (i_PADDR == SPA_RX_YD					);
wire			 w_addr01C_wr		= w_wr_en & (i_PADDR == SPA_PADDING_VAL			);
//Reserved wire			 w_addr020_wr		=
//+------------+---------------+------------------------------------------------------------+
//				 024				Read only
//				 028				Read only
//+------------+---------------+------------------------------------------------------------+
//				 02C				reserved
//+------------+---------------+------------------------------------------------------------+
// IRQ                                                                                    
wire			 w_addr030_wr		= w_wr_en & (i_PADDR == IRQ_ENABLE					);
wire			 w_addr034_wr		= w_wr_en & (i_PADDR == IRQ_PEND					);
wire			 w_addr038_wr		= w_wr_en & (i_PADDR == IRQ_SVC_CNT					);

// SRAM
wire			 w_addr03C_wr		= w_wr_en & (i_PADDR == SRAM_SW_MODE				);
wire			 w_addr040_wr		= w_wr_en & (i_PADDR == SRAM_CSN					);
wire			 w_addr048_wr		= w_wr_en & (i_PADDR == SRAM_DATA					);
wire			 w_addr04C_wr		= w_wr_en & (i_PADDR == SRAM_ADDR					);

wire			 w_addr068_wr		= w_wr_en & (i_PADDR == COLOR_MODE				); 

//TBL_DRX
wire			w_addr080_wr		= w_wr_en & (i_PADDR ==	TBL_START					);
wire			w_addr084_wr		= w_wr_en & (i_PADDR ==	TBL_ENABLE					);

// 0 unused
wire			w_addr08C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_00					);
wire			w_addr090_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_01					);
wire			w_addr094_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_02					);
wire			w_addr098_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_03					);
wire			w_addr09C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_04					);
wire			w_addr0A0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_05					);
wire			w_addr0A4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_06					);
wire			w_addr0A8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_07					);
wire			w_addr0AC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_08					);
wire			w_addr0B0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_09					);
wire			w_addr0B4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_10					);
wire			w_addr0B8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_11					);
wire			w_addr0BC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_12					);
wire			w_addr0C0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_13					);
wire			w_addr0C4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_14					);
wire			w_addr0C8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_15					);
wire			w_addr0CC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_16					);
wire			w_addr0D0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_17					);
wire			w_addr0D4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_18					);
wire			w_addr0D8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_19					);
wire			w_addr0DC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_20					);
wire			w_addr0E0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_21					);
wire			w_addr0E4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_22					);
wire			w_addr0E8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_23					);
wire			w_addr0EC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_24					);
//wire			w_addr0F0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_25					);
//wire			w_addr0F4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_26					);
//wire			w_addr0F8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_27					);
//wire			w_addr0FC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_28					);
//wire			w_addr100_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_29					);
//+------------+---------------+------------------------------------------------------------+
//				 104				reserved
//				 108				reserved
//+------------+---------------+------------------------------------------------------------+
// 30, 31 unused
//wire			w_addr10C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_32					);
//wire			w_addr110_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_33					);
//wire			w_addr114_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_34					);
//wire			w_addr118_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_35					);
//wire			w_addr11C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_36					);
//wire			w_addr120_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_37					);
//wire			w_addr124_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_38					);
//wire			w_addr128_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_39					);
//wire			w_addr12C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_40					);
//wire			w_addr130_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_41					);
//wire			w_addr134_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_42					);

// RX DMA 
wire			w_addr140_wr		= w_wr_en & (i_PADDR == p_RX_START					);
//wire			w_addr144_wr		= w_wr_en & (i_PADDR == p_RX_BAND_NUM				);
wire			w_addr148_wr		= w_wr_en & (i_PADDR == RX_INCR						);
/*
wire			w_addr14C_wr		= w_wr_en & (i_PADDR == RX_CH0_START_ADDR			);
wire			w_addr150_wr		= w_wr_en & (i_PADDR == RX_CH1_START_ADDR			);
wire			w_addr154_wr		= w_wr_en & (i_PADDR == RX_CH2_START_ADDR			);
wire			w_addr158_wr		= w_wr_en & (i_PADDR == RX_CH0_TOP_ADDR				);
wire			w_addr15C_wr		= w_wr_en & (i_PADDR == RX_CH1_TOP_ADDR				);
wire			w_addr160_wr		= w_wr_en & (i_PADDR == RX_CH2_TOP_ADDR				);
*/
wire			w_addr164_wr		= w_wr_en & (i_PADDR == RX_CH0_START_ADDR				);
wire			w_addr168_wr		= w_wr_en & (i_PADDR == RX_CH1_START_ADDR				);
wire			w_addr16C_wr		= w_wr_en & (i_PADDR == RX_CH2_START_ADDR				);
//Reserved
wire			w_addr190_wr		= w_wr_en & (i_PADDR == RX_DMA_CON					);

// 29)	TXDMA
wire			w_addr1C0_wr		= w_wr_en & (i_PADDR == TX_START					);
wire			w_addr1C4_wr		= w_wr_en & (i_PADDR == TX_DMA_CON					);
wire			w_addr1C8_wr		= w_wr_en & (i_PADDR == p_TX_BAND_NUM				);
wire			w_addr1CC_wr		= w_wr_en & (i_PADDR == TX_DATA_INCR				);
//Reserved		w_addr1D0_wr		
wire			w_addr1D4_wr		= w_wr_en & (i_PADDR == TX_CH0_START_ADDR			);
wire			w_addr1D8_wr		= w_wr_en & (i_PADDR == TX_CH1_START_ADDR			);
wire			w_addr1DC_wr		= w_wr_en & (i_PADDR == TX_CH2_START_ADDR			);



wire			w_addr1F0_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH0_MAX				);
wire			w_addr1F4_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH0_MIN				);
wire			w_addr1F8_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH1_MAX				);
wire			w_addr1FC_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH1_MIN				);
wire			w_addr200_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH2_MAX				);
wire			w_addr204_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH2_MIN				);


// 30)	DMA_ADAPT_SMAP
// ADAPT DMA
wire			 w_addr280_wr		= w_wr_en & (i_PADDR == ADAPT_DMA_CON	   			); 
wire			 w_addr284_wr		= w_wr_en & (i_PADDR == ADAPT_DMA_ADDR	   			); 
wire			 w_addr288_wr		= w_wr_en & (i_PADDR == ADAPT_DMA_ADDR_INCR			);
//wire			 w_addr28C_wr		= w_wr_en & (i_PADDR == ADAPT_DMA_STATUS			);		//  Read Only
wire			 w_addr290_wr		= w_wr_en & (i_PADDR == ADAPT_DMA_TX_ADDR_MAX		);
wire			 w_addr294_wr		= w_wr_en & (i_PADDR == ADAPT_DMA_TX_ADDR_MIN		);
wire			 w_addr2A0_wr		= w_wr_en & (i_PADDR == ADAPT_TX_START	   			); 

// SMAP
wire			 w_addr2C0_wr		= w_wr_en & (i_PADDR == SMAP_DMA_CON	   			);
wire			 w_addr2C4_wr		= w_wr_en & (i_PADDR == SMAP_DMA_ADDR	   			);
wire			 w_addr2C8_wr		= w_wr_en & (i_PADDR == SMAP_DMA_ADDR_INCR			);
//wire			 w_addr2CC_wr		= w_wr_en & (i_PADDR == SMAP_DMA_STATUS				);  	// Read Only
wire			 w_addr2D0_wr		= w_wr_en & (i_PADDR == SMAP_DMA_TX_ADDR_MAX		);
wire			 w_addr2D4_wr		= w_wr_en & (i_PADDR == SMAP_DMA_TX_ADDR_MIN		);

wire			 w_addr2E0_wr		= w_wr_en & (i_PADDR == SMAP_TX_START	   			); 
// BDS
wire			 w_addr300_wr		= w_wr_en & (i_PADDR == BDS_DMA_CON	   			);
wire			 w_addr304_wr		= w_wr_en & (i_PADDR == BDS_DMA_ADDR	   			);
wire			 w_addr308_wr		= w_wr_en & (i_PADDR == BDS_DMA_ADDR_INCR			);
//wire			 w_addr30C_wr		= w_wr_en & (i_PADDR == BDS_DMA_STATUS				);  	// Read Only
wire			 w_addr310_wr		= w_wr_en & (i_PADDR == BDS_DMA_TX_ADDR_MAX		);
wire			 w_addr314_wr		= w_wr_en & (i_PADDR == BDS_DMA_TX_ADDR_MIN		);
wire			 w_addr320_wr		= w_wr_en & (i_PADDR == BDS_TX_START	   			); 

// 2 )  VSC
wire			 w_addr480_wr		= w_wr_en & (i_PADDR == VSD_REG_A					); 
wire			 w_addr484_wr		= w_wr_en & (i_PADDR == VSD_REG_B					); 
wire			 w_addr488_wr		= w_wr_en & (i_PADDR == VSD_REG_C					); 
wire			 w_addr48C_wr		= w_wr_en & (i_PADDR == VSD_REG_D					); 
wire			 w_addr490_wr		= w_wr_en & (i_PADDR == VSD_REG_E					); 
wire			 w_addr494_wr		= w_wr_en & (i_PADDR == VSD_REG_F					); 
wire			 w_addr498_wr		= w_wr_en & (i_PADDR == VSD_REG_G					); 
wire			 w_addr49C_wr		= w_wr_en & (i_PADDR == VSD_REG_H					); 

// 4 )  CISSI
wire			 w_addr4C0_wr		= w_wr_en & (i_PADDR == CIS_SUB_COEF_R				);
wire			 w_addr4C4_wr		= w_wr_en & (i_PADDR == CIS_SUB_COEF_G				);
wire			 w_addr4C8_wr		= w_wr_en & (i_PADDR == CIS_SUB_COEF_B				);


// 5 )  RC1
wire			 w_addr500_wr		= w_wr_en & (i_PADDR == RC1_SHIFT_VAL				);
wire			 w_addr504_wr		= w_wr_en & (i_PADDR == RC1_SHIFT_OFST				);
wire			 w_addr508_wr		= w_wr_en & (i_PADDR == RC1_LOOP					);
//Reserved                       
wire			 w_addr510_wr		= w_wr_en & (i_PADDR == RC1_X_COF_00_01				);
wire			 w_addr514_wr		= w_wr_en & (i_PADDR == RC1_X_COF_02_03				);
wire			 w_addr518_wr		= w_wr_en & (i_PADDR == RC1_X_COF_10_11				);
wire			 w_addr51C_wr		= w_wr_en & (i_PADDR == RC1_X_COF_12_13				);
wire			 w_addr520_wr		= w_wr_en & (i_PADDR == RC1_X_COF_20_21				);
wire			 w_addr524_wr		= w_wr_en & (i_PADDR == RC1_X_COF_22_23				);
wire			 w_addr528_wr		= w_wr_en & (i_PADDR == RC1_X_COF_30_31				);
wire			 w_addr52C_wr		= w_wr_en & (i_PADDR == RC1_X_COF_32_33				);
wire			 w_addr530_wr		= w_wr_en & (i_PADDR == RC1_Y_COF_00_01				);
wire			 w_addr534_wr		= w_wr_en & (i_PADDR == RC1_Y_COF_02_03				);
wire			 w_addr538_wr		= w_wr_en & (i_PADDR == RC1_Y_COF_10_11				);
wire			 w_addr53C_wr		= w_wr_en & (i_PADDR == RC1_Y_COF_12_13				);
wire			 w_addr540_wr		= w_wr_en & (i_PADDR == RC1_Y_COF_20_21				);
wire			 w_addr544_wr		= w_wr_en & (i_PADDR == RC1_Y_COF_22_23				);
wire			 w_addr548_wr		= w_wr_en & (i_PADDR == RC1_Y_COF_30_31				);
wire			 w_addr54C_wr		= w_wr_en & (i_PADDR == RC1_Y_COF_32_33				);

//---------------------------------------------------------------------------------------------------
// S1D
//---------------------------------------------------------------------------------------------------
// None

//---------------------------------------------------------------------------------------------------
// SEG1
//---------------------------------------------------------------------------------------------------
wire			 w_addr580_wr		= w_wr_en & (i_PADDR ==SEG1_CON			 ); 
wire			 w_addr584_wr		= w_wr_en & (i_PADDR ==SEG1_HVLINE_TH		 ); 
wire			 w_addr588_wr		= w_wr_en & (i_PADDR ==SEG1_EDGE_TH			 ); 
wire			 w_addr58C_wr		= w_wr_en & (i_PADDR ==SEG1_LINE_TH			 ); 
wire			 w_addr590_wr		= w_wr_en & (i_PADDR ==SEG1_ZC_TH			 ); 

//---------------------------------------------------------------------------------------------------
// SCC
//---------------------------------------------------------------------------------------------------
wire			 w_addr5C0_wr		= w_wr_en & (i_PADDR == SCC_CON						);

//---------------------------------------------------------------------------------------------------
// SEG2
//---------------------------------------------------------------------------------------------------
wire			 w_addr600_wr		= w_wr_en & (i_PADDR == SEG2_CON					);
wire			 w_addr604_wr		= w_wr_en & (i_PADDR == SEG2_PARAM1					);
wire			 w_addr608_wr		= w_wr_en & (i_PADDR == SEG2_PARAM2					);
wire			 w_addr60C_wr		= w_wr_en & (i_PADDR == SEG2_FAR_CHROMA_PARAM		);
wire			 w_addr610_wr		= w_wr_en & (i_PADDR == SEG2_FAR_Y_PARAM			);
wire			 w_addr614_wr		= w_wr_en & (i_PADDR == SEG2_NEUT_CHROMA_PARAM		);

//---------------------------------------------------------------------------------------------------
// ORIENTATION
//---------------------------------------------------------------------------------------------------
wire			w_addr7C0_wr       = w_wr_en & ( i_PADDR == ORI_PAGE_EN					);	
wire			w_addr7C4_wr       = w_wr_en & ( i_PADDR == ORI_BLOCK_SIZE				);	
wire			w_addr7C8_wr       = w_wr_en & ( i_PADDR == ORI_AREA_SIZE				);	
wire			w_addr7CC_wr       = w_wr_en & ( i_PADDR == ORI_CHAR_LENGTH_THICK_V		);	
wire			w_addr7D0_wr       = w_wr_en & ( i_PADDR == ORI_CHAR_LENGTH_THICK_H		);	
wire			w_addr7D4_wr       = w_wr_en & ( i_PADDR == ORI_DIFF_CHANGE_V			);	
wire			w_addr7D8_wr       = w_wr_en & ( i_PADDR == ORI_DIFF_CHANGE_H			);	
wire			w_addr7DC_wr       = w_wr_en & ( i_PADDR == ORI_DIR_TH1					);	
wire			w_addr7E0_wr       = w_wr_en & ( i_PADDR == ORI_DIR_TH2					);	
wire			w_addr7E4_wr       = w_wr_en & ( i_PADDR == ORI_AREA_OFFSET1		);	
wire			w_addr7E8_wr       = w_wr_en & ( i_PADDR == ORI_AREA_OFFSET2		);	
wire			w_addr7EC_wr       = w_wr_en & ( i_PADDR == ORI_LINE_SPACE				);	
//wire			w_addr7F0_wr       = w_wr_en & ( i_PADDR == ORI_TEX_FLAG				);	// Read Only
//wire			w_addr7F4_wr       = w_wr_en & ( i_PADDR == ORI_TEXT_AREA1_W			);	// Read Only
//wire			w_addr7F8_wr       = w_wr_en & ( i_PADDR == ORI_TEXT_AREA1_H			);	// Read Only
//wire			w_addr7FC_wr       = w_wr_en & ( i_PADDR == ORI_TEXT_AREA2_W			);	// Read Only
//wire			w_addr800_wr       = w_wr_en & ( i_PADDR == ORI_TEXT_AREA2_H			);	// Read Only
//wire			w_addr804_wr       = w_wr_en & ( i_PADDR == ORI_TEXT_AREA3_W			);	// Read Only
//wire			w_addr808_wr       = w_wr_en & ( i_PADDR == ORI_TEXT_AREA3_H			);	// Read Only

//---------------------------------------------------------------------------------------------------
// Classifier
//---------------------------------------------------------------------------------------------------
wire			 w_addr900_wr		= w_wr_en & (i_PADDR == CLA_CON1		  );
wire			 w_addr904_wr		= w_wr_en & (i_PADDR == CLA_CON2		  );
//---------------------------------------------------------------------------------------------------
// ACBD
//---------------------------------------------------------------------------------------------------
wire			 w_addr980_wr		= w_wr_en & (i_PADDR == ACBD_MARGIN1				  );
wire			 w_addr984_wr		= w_wr_en & (i_PADDR == ACBD_MARGIN2				  );
wire			 w_addr988_wr		= w_wr_en & (i_PADDR == ACBD_TH1					  );
wire			 w_addr98C_wr		= w_wr_en & (i_PADDR == ACBD_TH2					  );
wire			 w_addr990_wr		= w_wr_en & (i_PADDR == ACBD_HLIGHT_SEL_EN			  );
wire			 w_addr994_wr		= w_wr_en & (i_PADDR == ACBD_AVG_TH					  );
wire			 w_addr998_wr		= w_wr_en & (i_PADDR == ACBD_HISTO_WIN_VAL			  );
wire			 w_addr99C_wr		= w_wr_en & (i_PADDR == ACBD_RATIO_TH				  );
wire			 w_addr9A0_wr		= w_wr_en & (i_PADDR == ACBD_LIMIT_TH				  );
wire			 w_addr9A4_wr		= w_wr_en & (i_PADDR == ACBD_BRIGHT_STRETCH_OFFSET );
wire			 w_addr9A8_wr		= w_wr_en & (i_PADDR == ACBD_ACB_TH1 );
wire			 w_addr9AC_wr		= w_wr_en & (i_PADDR == ACBD_ACB_TH2 );
wire			 w_addr9B0_wr		= w_wr_en & (i_PADDR == ACBD_OBJ );
// Reserved
//// Reserved
wire			 w_addr9BC_wr		= w_wr_en & (i_PADDR == ACBD_ACS_REF_ON );

//---------------------------------------------------------------------------------------------------
// ABSD
//---------------------------------------------------------------------------------------------------
wire			 w_addr840_wr		= w_wr_en & (i_PADDR == ABSD_PRE_SCAN_LINE	   		); 
wire			 w_addr844_wr		= w_wr_en & (i_PADDR == ABSD_PRESCAN_IWIN	   		); 
wire			 w_addr848_wr		= w_wr_en & (i_PADDR == ABSD_TH				   		); 
wire			 w_addr84C_wr		= w_wr_en & (i_PADDR == ABSD_VALID_PERCENTAGE   	); 
wire			 w_addr850_wr		= w_wr_en & (i_PADDR == ABSD_BK_STD_TH		   		); 
wire			 w_addr854_wr		= w_wr_en & (i_PADDR == ABSD_SIGMA			   		); 
wire			 w_addr858_wr		= w_wr_en & (i_PADDR == ABSD_BG_BACKUP		   		); 
wire			 w_addr85C_wr		= w_wr_en & (i_PADDR == ABSD_COLOR_EXCEPTION	   	); 
//wire			 w_addr860_wr		= w_wr_en & (i_PADDR == ABSD_TOP_BG_LEVEL	   		); 	// Read Only
//wire			 w_addr864_wr		= w_wr_en & (i_PADDR == ABSD_TOP_PEAK_CONFIDENCE	); 	// Read Only
wire			 w_addr868_wr		= w_wr_en & (i_PADDR == ABSD_PRE_SCAN_START			); 

//---------------------------------------------------------------------------------------------------
// MAGD
//---------------------------------------------------------------------------------------------------
wire			 w_addr880_wr		= w_wr_en & (i_PADDR == MAGD_PRE_SCAN_LINE	   		); 
wire			 w_addr884_wr		= w_wr_en & (i_PADDR == MAGD_PRESCAN_IWIN	   		); 
wire			 w_addr888_wr		= w_wr_en & (i_PADDR == MAGD_TH				   		); 
wire			 w_addr88C_wr		= w_wr_en & (i_PADDR == MAGD_VALID_PERCENTAGE   	); 
wire			 w_addr890_wr		= w_wr_en & (i_PADDR == MAGD_BK_STD_TH		   		); 
wire			 w_addr894_wr		= w_wr_en & (i_PADDR == MAGD_SIGMA			   		); 
wire			 w_addr898_wr		= w_wr_en & (i_PADDR == MAGD_BG_BACKUP		   		); 
wire			 w_addr89C_wr		= w_wr_en & (i_PADDR == MAGD_COLOR_EXCEPTION	   	); 
//wire			 w_addr8A0_wr		= w_wr_en & (i_PADDR == MAGD_TOP_BG_LEVEL	   		); 	// Read Only
//wire			 w_addr8A4_wr		= w_wr_en & (i_PADDR == MAGD_TOP_PEAK_CONFIDENCE	); 	// Read Only
wire			 w_addr8A8_wr		= w_wr_en & (i_PADDR == MAGD_PRE_SCAN_START			); 	

//---------------------------------------------------------------------------------------------------
//NEABSD
//---------------------------------------------------------------------------------------------------
wire			 w_addr8C0_wr		= w_wr_en & (i_PADDR == NEWABSD_SCAN_RANGE	); 
wire			 w_addr8C4_wr		= w_wr_en & (i_PADDR == NEWABSD_PRESCAN_IWIN); 
wire			 w_addr8C8_wr		= w_wr_en & (i_PADDR == NEWABSD_CHROMA_TH	); 
wire			 w_addr8CC_wr		= w_wr_en & (i_PADDR == NEWABSD_LIMIT		);

//---------------------------------------------------------------------------------------------------
// ACS
//---------------------------------------------------------------------------------------------------
wire			 w_addr9C0_wr		= w_wr_en & (i_PADDR == ACS_CON						);
wire			 w_addr9C4_wr		= w_wr_en & (i_PADDR == ACS_MARK_POS_TOP			);
wire			 w_addr9C8_wr		= w_wr_en & (i_PADDR == ACS_MARK_POS_BOTTOM			);
wire			 w_addr9CC_wr		= w_wr_en & (i_PADDR == ACS_MARK_POS_LEFT			);
wire			 w_addr9D0_wr		= w_wr_en & (i_PADDR == ACS_MARK_POS_RIGHT			);
wire			 w_addr9D4_wr		= w_wr_en & (i_PADDR == ACS_SATURATION_TH 			);
wire			 w_addr9D8_wr		= w_wr_en & (i_PADDR == ACS_HT_TH 					);
wire			 w_addr9DC_wr		= w_wr_en & (i_PADDR == ACS_CBMAX1 					);
wire			 w_addr9E0_wr		= w_wr_en & (i_PADDR == ACS_CBMAX2 					);
wire			 w_addr9E4_wr		= w_wr_en & (i_PADDR == ACS_CBMAX3 					);
wire			 w_addr9E8_wr		= w_wr_en & (i_PADDR == ACS_CBMAX4 					);
wire			 w_addr9EC_wr		= w_wr_en & (i_PADDR == ACS_CBMIN1 					);
wire			 w_addr9F0_wr		= w_wr_en & (i_PADDR == ACS_CBMIN2 					);
wire			 w_addr9F4_wr		= w_wr_en & (i_PADDR == ACS_CBMIN3 					);
wire			 w_addr9F8_wr		= w_wr_en & (i_PADDR == ACS_CBMIN4 					);
wire			 w_addr9FC_wr		= w_wr_en & (i_PADDR == ACS_CRMAX1 					);
wire			 w_addrA00_wr		= w_wr_en & (i_PADDR == ACS_CRMAX2 					);
wire			 w_addrA04_wr		= w_wr_en & (i_PADDR == ACS_CRMAX3 					);
wire			 w_addrA08_wr		= w_wr_en & (i_PADDR == ACS_CRMAX4 					);
wire			 w_addrA0C_wr		= w_wr_en & (i_PADDR == ACS_CRMIN1 					);
wire			 w_addrA10_wr		= w_wr_en & (i_PADDR == ACS_CRMIN2 					);
wire			 w_addrA14_wr		= w_wr_en & (i_PADDR == ACS_CRMIN3 					);
wire			 w_addrA18_wr		= w_wr_en & (i_PADDR == ACS_CRMIN4 					);
wire			 w_addrA1C_wr		= w_wr_en & (i_PADDR == ACS_CBMAXH1 				);
wire			 w_addrA20_wr		= w_wr_en & (i_PADDR == ACS_CBMAXH2 				);
wire			 w_addrA24_wr		= w_wr_en & (i_PADDR == ACS_CBMAXH3 				);
wire			 w_addrA28_wr		= w_wr_en & (i_PADDR == ACS_CBMAXH4 				);
wire			 w_addrA2C_wr		= w_wr_en & (i_PADDR == ACS_CBMINH1 				);
wire			 w_addrA30_wr		= w_wr_en & (i_PADDR == ACS_CBMINH2 				);
wire			 w_addrA34_wr		= w_wr_en & (i_PADDR == ACS_CBMINH3 				);
wire			 w_addrA38_wr		= w_wr_en & (i_PADDR == ACS_CBMINH4 				);
wire			 w_addrA3C_wr		= w_wr_en & (i_PADDR == ACS_CRMAXH1 				);
wire			 w_addrA40_wr		= w_wr_en & (i_PADDR == ACS_CRMAXH2 				);
wire			 w_addrA44_wr		= w_wr_en & (i_PADDR == ACS_CRMAXH3 				);
wire			 w_addrA48_wr		= w_wr_en & (i_PADDR == ACS_CRMAXH4 				);
wire			 w_addrA4C_wr		= w_wr_en & (i_PADDR == ACS_CRMINH1 				);
wire			 w_addrA50_wr		= w_wr_en & (i_PADDR == ACS_CRMINH2 				);
wire			 w_addrA54_wr		= w_wr_en & (i_PADDR == ACS_CRMINH3 				);
wire			 w_addrA58_wr		= w_wr_en & (i_PADDR == ACS_CRMINH4 				);
wire			 w_addrA5C_wr		= w_wr_en & (i_PADDR == ACS_VALUE_TH 				);

wire			 w_addrB08_wr		= w_wr_en & (i_PADDR == ACS_SATURATION_TH2 			);

wire			 w_addrB14_wr		= w_wr_en & (i_PADDR == ACSv2_CON						);
wire			 w_addrB18_wr		= w_wr_en & (i_PADDR == ACSv2_SATURATION_TH 			);
wire			 w_addrB1C_wr		= w_wr_en & (i_PADDR == ACSv2_SATURATION_TH2 			);
wire			 w_addrB20_wr		= w_wr_en & (i_PADDR == ACSv2_HT_TH 					);
wire			 w_addrB24_wr		= w_wr_en & (i_PADDR == ACSv2_VALUE_TH 				);
//---------------------------------------------------------------------------------------------------
// BLANK
//---------------------------------------------------------------------------------------------------
wire			 w_addrB40_wr		= w_wr_en & (i_PADDR == BLANK_CON0 					);
wire			 w_addrB44_wr		= w_wr_en & (i_PADDR == BLANK_CON1					);
wire			 w_addrB48_wr		= w_wr_en & (i_PADDR == BLANK_MARK_POS_TOP 			);
wire			 w_addrB4C_wr		= w_wr_en & (i_PADDR == BLANK_MARK_POS_BOTTOM 		);
wire			 w_addrB50_wr		= w_wr_en & (i_PADDR == BLANK_MARK_POS_LEFT 		);
wire			 w_addrB54_wr		= w_wr_en & (i_PADDR == BLANK_MARK_POS_RIGHT 		);
wire			 w_addrB58_wr		= w_wr_en & (i_PADDR == BLANK_COLOR_BLK 			);

//---------------------------------------------------------------------------------------------------
// RC2
//---------------------------------------------------------------------------------------------------
wire			 w_addrB80_wr		= w_wr_en & (i_PADDR == RC2_OUTIMG_WIDTH_HEIGHT		);
wire			 w_addrB84_wr		= w_wr_en & (i_PADDR == RC2_OVERLAP					);
wire			 w_addrB88_wr		= w_wr_en & (i_PADDR == RC2_FRAC					);
//				 w_addrB8C_wr		Reserved

//---------------------------------------------------------------------------------------------------
// BDS
//---------------------------------------------------------------------------------------------------
wire			 w_addrBC0_wr		= w_wr_en & (i_PADDR == BDS_CON				);
wire			 w_addrBC4_wr		= w_wr_en & (i_PADDR == BDS_EDGE1				);
wire			 w_addrBC8_wr		= w_wr_en & (i_PADDR == BDS_EDGE2				);
wire			 w_addrBCC_wr		= w_wr_en & (i_PADDR == BDS_EURion1				);
wire			 w_addrBD0_wr		= w_wr_en & (i_PADDR == BDS_EURion2				);
wire			 w_addrBD4_wr		= w_wr_en & (i_PADDR == BDS_OFFSET				);
//wire			 w_addrBD8_wr		= w_wr_en & (i_PADDR == BDS_CONTENTS			); // readonly
                         
//---------------------------------------------------------------------------------------------------
//SMAP
//---------------------------------------------------------------------------------------------------
//				 w_addrC80_wr   // reserved
wire			 w_addrC84_wr		= w_wr_en & (i_PADDR == SMAP_PARAM_B				);
wire			 w_addrC88_wr		= w_wr_en & (i_PADDR == SMAP_PARAM_C				);
wire			 w_addrC8C_wr		= w_wr_en & (i_PADDR ==	SMAP_CON					);
wire			 w_addrC90_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MAX0					);
wire			 w_addrC94_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MAX1					);
wire			 w_addrC98_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MAX2					);
wire			 w_addrC9C_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MAX3					);
wire			 w_addrCA0_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MAX4					);
wire			 w_addrCA4_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MAX5					);
wire			 w_addrCA8_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MAX6 				);
wire			 w_addrCAC_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MAX7 				);
wire			 w_addrCB0_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MIN0 				);
wire			 w_addrCB4_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MIN1 				);
wire			 w_addrCB8_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MIN2 				);
wire			 w_addrCBC_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MIN3 				);
wire			 w_addrCC0_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MIN4 				);
wire			 w_addrCC4_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MIN5 				);
wire			 w_addrCC8_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MIN6 				);
wire			 w_addrCCC_wr		= w_wr_en & (i_PADDR ==	SMAP_R_MIN7 				);
wire			 w_addrCD0_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MAX0 				);
wire			 w_addrCD4_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MAX1 				);
wire			 w_addrCD8_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MAX2 				);
wire			 w_addrCDC_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MAX3 				);
wire			 w_addrCE0_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MAX4 				);
wire			 w_addrCE4_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MAX5 				);
wire			 w_addrCE8_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MAX6 				);
wire			 w_addrCEC_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MAX7 				);
wire			 w_addrCF0_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MIN0 				);
wire			 w_addrCF4_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MIN1 				);
wire			 w_addrCF8_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MIN2 				);
wire			 w_addrCFC_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MIN3 				);
wire			 w_addrD00_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MIN4 				);
wire			 w_addrD04_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MIN5 				);
wire			 w_addrD08_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MIN6 				);
wire			 w_addrD0C_wr		= w_wr_en & (i_PADDR ==	SMAP_G_MIN7 				);
wire			 w_addrD10_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MAX0 				);
wire			 w_addrD14_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MAX1 				);
wire			 w_addrD18_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MAX2 				);
wire			 w_addrD1C_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MAX3 				);
wire			 w_addrD20_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MAX4 				);
wire			 w_addrD24_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MAX5 				);
wire			 w_addrD28_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MAX6 				);
wire			 w_addrD2C_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MAX7 				);
wire			 w_addrD30_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MIN0 				);
wire			 w_addrD34_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MIN1 				);
wire			 w_addrD38_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MIN2 				);
wire			 w_addrD3C_wr		= w_wr_en & (i_PADDR == SMAP_B_MIN3					);
wire			 w_addrD40_wr		= w_wr_en & (i_PADDR == SMAP_B_MIN4 				);
wire			 w_addrD44_wr		= w_wr_en & (i_PADDR ==	SMAP_B_MIN5 				);
wire			 w_addrD48_wr		= w_wr_en & (i_PADDR == SMAP_B_MIN6 				);
wire			 w_addrD4C_wr		= w_wr_en & (i_PADDR == SMAP_B_MIN7 				);

wire			w_addr108C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_00_UP				);
wire			w_addr1090_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_01_UP				);
wire			w_addr1094_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_02_UP				);
wire			w_addr1098_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_03_UP				);
wire			w_addr109C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_04_UP				);
wire			w_addr10A0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_05_UP				);
wire			w_addr10A4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_06_UP				);
wire			w_addr10A8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_07_UP				);
wire			w_addr10AC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_08_UP				);
wire			w_addr10B0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_09_UP				);
wire			w_addr10B4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_10_UP				);
wire			w_addr10B8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_11_UP				);
wire			w_addr10BC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_12_UP				);
wire			w_addr10C0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_13_UP				);
wire			w_addr10C4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_14_UP				);
wire			w_addr10C8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_15_UP				);
wire			w_addr10CC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_16_UP				);
wire			w_addr10D0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_17_UP				);
wire			w_addr10D4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_18_UP				);
wire			w_addr10D8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_19_UP				);
wire			w_addr10DC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_20_UP				);
wire			w_addr10E0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_21_UP				);
wire			w_addr10E4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_22_UP				);
wire			w_addr10E8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_23_UP				);
wire			w_addr10EC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_24_UP				);
//wire			w_addr10F0_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_25_UP				);
//wire			w_addr10F4_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_26_UP				);
//wire			w_addr10F8_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_27_UP				);
//wire			w_addr10FC_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_28_UP				);
//wire			w_addr1100_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_29_UP				);
//wire			w_addr1104_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_30_UP				);  // reserved
//wire			w_addr1108_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_31_UP				);  // reserved
//wire			w_addr110C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_32_UP				);
//wire			w_addr1110_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_33_UP				);
//wire			w_addr1114_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_34_UP				);
//wire			w_addr1118_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_35_UP				);
//wire			w_addr111C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_36_UP				);
//wire			w_addr1120_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_37_UP				);
//wire			w_addr1124_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_38_UP				);
//wire			w_addr1128_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_39_UP				);
//wire			w_addr112C_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_40_UP				);
//wire			w_addr1130_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_41_UP				);
//wire			w_addr1134_wr		= w_wr_en & (i_PADDR ==	TBL_ADDR_42_UP				);
/*
wire			w_addr114C_wr		= w_wr_en & (i_PADDR == RX_CH0_START_ADDR_UP		);
wire			w_addr1150_wr		= w_wr_en & (i_PADDR == RX_CH1_START_ADDR_UP		);
wire			w_addr1154_wr		= w_wr_en & (i_PADDR == RX_CH2_START_ADDR_UP		);
wire			w_addr1158_wr		= w_wr_en & (i_PADDR == RX_CH0_TOP_ADDR_UP			);
wire			w_addr115C_wr		= w_wr_en & (i_PADDR == RX_CH1_TOP_ADDR_UP			);
wire			w_addr1160_wr		= w_wr_en & (i_PADDR == RX_CH2_TOP_ADDR_UP			);
*/
wire			w_addr1164_wr		= w_wr_en & (i_PADDR == RX_CH0_START_ADDR_UP			);
wire			w_addr1168_wr		= w_wr_en & (i_PADDR == RX_CH1_START_ADDR_UP			);
wire			w_addr116C_wr		= w_wr_en & (i_PADDR == RX_CH2_START_ADDR_UP			);

wire			w_addr11D4_wr		= w_wr_en & (i_PADDR == TX_CH0_START_ADDR_UP		);
wire			w_addr11D8_wr		= w_wr_en & (i_PADDR == TX_CH1_START_ADDR_UP		);
wire			w_addr11DC_wr		= w_wr_en & (i_PADDR == TX_CH2_START_ADDR_UP		);

wire			w_addr11F0_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH0_MAX_UP			);
wire			w_addr11F4_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH0_MIN_UP			);
wire			w_addr11F8_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH1_MAX_UP			);
wire			w_addr11FC_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH1_MIN_UP			);
wire			w_addr1200_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH2_MAX_UP			);
wire			w_addr1204_wr		= w_wr_en & (i_PADDR == TX_ADDR_CH2_MIN_UP			);

wire			 w_addr1284_wr		= w_wr_en & (i_PADDR == ADAPT_DMA_ADDR_UP			);
                           
wire			 w_addr1290_wr		= w_wr_en & (i_PADDR == ADAPT_DMA_TX_ADDR_MAX_UP	);
wire			 w_addr1294_wr		= w_wr_en & (i_PADDR == ADAPT_DMA_TX_ADDR_MIN_UP	);
                           
wire			 w_addr12C4_wr		= w_wr_en & (i_PADDR == SMAP_DMA_ADDR_UP			);
                           
wire			 w_addr12D0_wr		= w_wr_en & (i_PADDR == SMAP_DMA_TX_ADDR_MAX_UP		);
wire			 w_addr12D4_wr		= w_wr_en & (i_PADDR == SMAP_DMA_TX_ADDR_MIN_UP		);

wire			 w_addr1304_wr		= w_wr_en & (i_PADDR == BDS_DMA_ADDR_UP				);
                           
wire			 w_addr1310_wr		= w_wr_en & (i_PADDR == BDS_DMA_TX_ADDR_MAX_UP		);
wire			 w_addr1314_wr		= w_wr_en & (i_PADDR == BDS_DMA_TX_ADDR_MIN_UP		);

// ===================================================================================
//	READ FLAG
// ===================================================================================
// 1 )  CONFIG
wire			 w_addr000_rd		= w_rd_en & (i_PADDR == SPA_SW_RESET				);
wire			 w_addr004_rd		= w_rd_en & (i_PADDR == SPA_CORE_START			);
wire			 w_addr008_rd		= w_rd_en & (i_PADDR == SPA_MODE					);
wire			 w_addr00C_rd		= w_rd_en & (i_PADDR == SPA_EN					);
wire			 w_addr010_rd		= w_rd_en & (i_PADDR == SPA_RX_XD					);
wire			 w_addr014_rd		= w_rd_en & (i_PADDR == SPA_RX_YD					);
wire			 w_addr018_rd		= w_rd_en & (i_PADDR == SPA_TX_IMG_SIZE			);
wire			 w_addr01C_rd		= w_rd_en & (i_PADDR == SPA_PADDING_VAL			);	
//wire			 w_addr020_rd		
wire			 w_addr024_rd		= w_rd_en & (i_PADDR == SPA_VERSION				);
//wire			 w_addr028_rd		= w_rd_en & (i_PADDR == SPA_RX_YD_OUT				);
//+------------+---------------+------------------------------------------------------------+
//				 02C				reserved
//+------------+---------------+------------------------------------------------------------+
// IRQ
wire			 w_addr030_rd		= w_rd_en & (i_PADDR == IRQ_ENABLE					);
wire			 w_addr034_rd		= w_rd_en & (i_PADDR == IRQ_PEND					);
wire			 w_addr038_rd		= w_rd_en & (i_PADDR == IRQ_SVC_CNT					);
// SRAM
wire			 w_addr03C_rd		= w_rd_en & (i_PADDR == SRAM_SW_MODE				);
wire			 w_addr040_rd		= w_rd_en & (i_PADDR == SRAM_CSN					);
wire			 w_addr048_rd		= w_rd_en & (i_PADDR == SRAM_DATA					);
wire			 w_addr04C_rd		= w_rd_en & (i_PADDR == SRAM_ADDR					);

wire			 w_addr054_rd		= w_rd_en & (i_PADDR == SPA_CORE_BAND_END				); 
wire			 w_addr058_rd		= w_rd_en & (i_PADDR == SPA_CORE_PAGE_END				); 
// Reserved
wire			 w_addr068_rd		= w_rd_en & (i_PADDR == COLOR_MODE				); 
wire			 w_addr06C_rd		= w_rd_en & (i_PADDR == TBL_RX_CNT				); 
wire			 w_addr070_rd		= w_rd_en & (i_PADDR == TBL_TX_CNT				); 
wire			 w_addr074_rd		= w_rd_en & (i_PADDR == TBL_END_STATUS1			); 
//wire			 w_addr078_rd		= w_rd_en & (i_PADDR == TBL_END_STATUS2			); 

// TBL_DRX
wire			 w_addr080_rd		= w_rd_en & (i_PADDR ==	TBL_START					);
wire			 w_addr084_rd		= w_rd_en & (i_PADDR ==	TBL_ENABLE					);
wire			 w_addr08C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_00					);
wire			 w_addr090_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_01					);
wire			 w_addr094_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_02					);
wire			 w_addr098_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_03					);
wire			 w_addr09C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_04					);
wire			 w_addr0A0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_05					);
wire			 w_addr0A4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_06					);
wire			 w_addr0A8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_07					);
wire			 w_addr0AC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_08					);
wire			 w_addr0B0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_09					);
wire			 w_addr0B4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_10					);
wire			 w_addr0B8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_11					);
wire			 w_addr0BC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_12					);
wire			 w_addr0C0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_13					);
wire			 w_addr0C4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_14					);
wire			 w_addr0C8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_15					);
wire			 w_addr0CC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_16					);
wire			 w_addr0D0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_17					);
wire			 w_addr0D4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_18					);
wire			 w_addr0D8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_19					);
wire			 w_addr0DC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_20					);
wire			 w_addr0E0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_21					);
wire			 w_addr0E4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_22					);
wire			 w_addr0E8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_23					);
wire			 w_addr0EC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_24					);
//wire			 w_addr0F0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_25					);
//wire			 w_addr0F4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_26					);
//wire			 w_addr0F8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_27					);
//wire			 w_addr0FC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_28					);
//wire			 w_addr100_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_29					);
//wire			 w_addr104_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_30					);
//wire			 w_addr108_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_31					);
//wire			 w_addr10C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_32					);
//wire			 w_addr110_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_33					);
//wire			 w_addr114_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_34					);
//wire			 w_addr118_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_35					);
//wire			 w_addr11C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_36					);
//wire			 w_addr120_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_37					);
//wire			 w_addr124_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_38					);
//wire			 w_addr128_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_39					);
//wire			 w_addr12C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_40					);
//wire			 w_addr130_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_41					);
//wire			 w_addr134_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_42					);


// RX DMA 
wire			 w_addr140_rd		= w_rd_en & (i_PADDR == p_RX_START					);
//wire			 w_addr144_rd		= w_rd_en & (i_PADDR == p_RX_BAND_NUM				);
wire			 w_addr148_rd		= w_rd_en & (i_PADDR == RX_INCR						);
wire			 w_addr14C_rd		= w_rd_en & (i_PADDR == RX_CH0_PREV_ADDR			);
wire			 w_addr150_rd		= w_rd_en & (i_PADDR == RX_CH1_PREV_ADDR			);
wire			 w_addr154_rd		= w_rd_en & (i_PADDR == RX_CH2_PREV_ADDR			);
wire			 w_addr158_rd		= w_rd_en & (i_PADDR == RX_CH0_CURR_ADDR				);
wire			 w_addr15C_rd		= w_rd_en & (i_PADDR == RX_CH1_CURR_ADDR				);
wire			 w_addr160_rd		= w_rd_en & (i_PADDR == RX_CH2_CURR_ADDR				);
wire			 w_addr164_rd		= w_rd_en & (i_PADDR == RX_CH0_START_ADDR				);
wire			 w_addr168_rd		= w_rd_en & (i_PADDR == RX_CH1_START_ADDR				);
wire			 w_addr16C_rd		= w_rd_en & (i_PADDR == RX_CH2_START_ADDR				);
wire			 w_addr170_rd		= w_rd_en & (i_PADDR == RX_BLK_CNT					);	 // Read Only
wire			 w_addr174_rd		= w_rd_en & (i_PADDR == RX_STATUS					);	 // Read Only
wire			 w_addr178_rd		= w_rd_en & (i_PADDR == RX_CUR_ADDR_CH0				);	 // Read Only
wire			 w_addr17C_rd		= w_rd_en & (i_PADDR == RX_CUR_ADDR_CH1				);	 // Read Only
wire			 w_addr180_rd		= w_rd_en & (i_PADDR == RX_CUR_ADDR_CH2				);	 // Read Only
wire			 w_addr184_rd		= w_rd_en & (i_PADDR == RX_SVC_CNT_CH0				);	 // Read Only
wire			 w_addr188_rd		= w_rd_en & (i_PADDR == RX_SVC_CNT_CH1				);	 // Read Only
wire			 w_addr18C_rd		= w_rd_en & (i_PADDR == RX_SVC_CNT_CH2				);	 // Read Only
wire			 w_addr190_rd		= w_rd_en & (i_PADDR == RX_DMA_CON					);
wire			 w_addr194_rd		= w_rd_en & (i_PADDR == RX_ERR_STATUS				);
wire			 w_addr198_rd		= w_rd_en & (i_PADDR == RX_ERR_CNT					);
wire			 w_addr19C_rd		= w_rd_en & (i_PADDR == RX_ERR_ARADDR				);
wire			 w_addr1A0_rd		= w_rd_en & (i_PADDR == RX_ERR_POS					);

// 29)	TXDMA
wire			 w_addr1C0_rd		= w_rd_en & (i_PADDR == TX_START					);
wire			 w_addr1C4_rd		= w_rd_en & (i_PADDR == TX_DMA_CON					);
wire			 w_addr1C8_rd		= w_rd_en & (i_PADDR == p_TX_BAND_NUM				);	
wire			 w_addr1CC_rd		= w_rd_en & (i_PADDR == TX_DATA_INCR				);
//Reserved
wire			 w_addr1D4_rd		= w_rd_en & (i_PADDR == TX_CH0_START_ADDR			);
wire			 w_addr1D8_rd		= w_rd_en & (i_PADDR == TX_CH1_START_ADDR			);
wire			 w_addr1DC_rd		= w_rd_en & (i_PADDR == TX_CH2_START_ADDR			);

wire			 w_addr1E8_rd		= w_rd_en & (i_PADDR == TX_BLK_CNT					);		// Read Only
wire			 w_addr1EC_rd		= w_rd_en & (i_PADDR == TX_STATUS					);		// Read Only

wire			 w_addr1F0_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH0_MAX				);
wire			 w_addr1F4_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH0_MIN				);
wire			 w_addr1F8_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH1_MAX				);
wire			 w_addr1FC_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH1_MIN				);
wire			 w_addr200_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH2_MAX				);
wire			 w_addr204_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH2_MIN				);

wire			 w_addr218_rd		= w_rd_en & (i_PADDR == TX_CH0_CUR_ADDR				);  
wire			 w_addr21C_rd		= w_rd_en & (i_PADDR == TX_CH1_CUR_ADDR				);  
wire			 w_addr220_rd		= w_rd_en & (i_PADDR == TX_CH2_CUR_ADDR				);  

wire			 w_addr22C_rd		= w_rd_en & (i_PADDR == TX_CH0_SVC_CNT				);
wire			 w_addr230_rd		= w_rd_en & (i_PADDR == TX_CH1_SVC_CNT				);
wire			 w_addr234_rd		= w_rd_en & (i_PADDR == TX_CH2_SVC_CNT				);

wire			 w_addr240_rd		= w_rd_en & (i_PADDR == TX_ERR_STATUS				);
//wire			 w_addr244_rd		= w_rd_en & (i_PADDR == TX_ADDR_ERR_STATUS				);


// ADAPT DMA
wire			 w_addr280_rd		= w_rd_en & (i_PADDR == ADAPT_DMA_CON				);
wire			 w_addr284_rd		= w_rd_en & (i_PADDR == ADAPT_DMA_ADDR	   			);
wire			 w_addr288_rd		= w_rd_en & (i_PADDR == ADAPT_DMA_ADDR_INCR			);
wire			 w_addr28C_rd		= w_rd_en & (i_PADDR == ADAPT_DMA_STATUS			);
wire			 w_addr290_rd		= w_rd_en & (i_PADDR == ADAPT_DMA_TX_ADDR_MAX		);
wire			 w_addr294_rd		= w_rd_en & (i_PADDR == ADAPT_DMA_TX_ADDR_MIN		);
wire			 w_addr298_rd		= w_rd_en & (i_PADDR == ADAPT_TX_CUR_ADDR			);
wire			 w_addr29C_rd		= w_rd_en & (i_PADDR == ADAPT_TX_SVC_CNT			);
wire			 w_addr2A0_rd		= w_rd_en & (i_PADDR == ADAPT_TX_START			);
wire			 w_addr2A4_rd		= w_rd_en & (i_PADDR == ADAPT_BAND_CNT			);


//SMAP
wire			 w_addr2C0_rd		= w_rd_en & (i_PADDR == SMAP_DMA_CON				);
wire			 w_addr2C4_rd		= w_rd_en & (i_PADDR == SMAP_DMA_ADDR	   			);
wire			 w_addr2C8_rd		= w_rd_en & (i_PADDR == SMAP_DMA_ADDR_INCR			);
wire			 w_addr2CC_rd		= w_rd_en & (i_PADDR == SMAP_DMA_STATUS				);
wire			 w_addr2D0_rd		= w_rd_en & (i_PADDR == SMAP_DMA_TX_ADDR_MAX		);
wire			 w_addr2D4_rd		= w_rd_en & (i_PADDR == SMAP_DMA_TX_ADDR_MIN		);
wire			 w_addr2D8_rd		= w_rd_en & (i_PADDR == SMAP_TX_CUR_ADDR			);
wire			 w_addr2DC_rd		= w_rd_en & (i_PADDR == SMAP_TX_SVC_CNT				);
wire			 w_addr2E0_rd		= w_rd_en & (i_PADDR == SMAP_TX_START				);
wire			 w_addr2E4_rd		= w_rd_en & (i_PADDR == SMAP_BAND_CNT				);

//SMAP
wire			 w_addr300_rd		= w_rd_en & (i_PADDR == BDS_DMA_CON				);
wire			 w_addr304_rd		= w_rd_en & (i_PADDR == BDS_DMA_ADDR	   		);
wire			 w_addr308_rd		= w_rd_en & (i_PADDR == BDS_DMA_ADDR_INCR		);
wire			 w_addr30C_rd		= w_rd_en & (i_PADDR == BDS_DMA_STATUS			);
wire			 w_addr310_rd		= w_rd_en & (i_PADDR == BDS_DMA_TX_ADDR_MAX		);
wire			 w_addr314_rd		= w_rd_en & (i_PADDR == BDS_DMA_TX_ADDR_MIN		);
wire			 w_addr318_rd		= w_rd_en & (i_PADDR == BDS_TX_CUR_ADDR			);
wire			 w_addr31C_rd		= w_rd_en & (i_PADDR == BDS_TX_SVC_CNT			);
wire			 w_addr320_rd		= w_rd_en & (i_PADDR == BDS_TX_START			);
wire			 w_addr324_rd		= w_rd_en & (i_PADDR == BDS_BAND_CNT			);

wire			 w_addr340_rd		= w_rd_en & (i_PADDR == RX_CH0_CRC				);
wire			 w_addr344_rd		= w_rd_en & (i_PADDR == RX_CH1_CRC				);
wire			 w_addr348_rd		= w_rd_en & (i_PADDR == RX_CH2_CRC				);
                          
wire			 w_addr350_rd		= w_rd_en & (i_PADDR == RC1_CH0_CRC				);
wire			 w_addr354_rd		= w_rd_en & (i_PADDR == RC1_CH1_CRC				);
wire			 w_addr358_rd		= w_rd_en & (i_PADDR == RC1_CH2_CRC				);
                          
wire			 w_addr360_rd		= w_rd_en & (i_PADDR == DEBUG_RC1_CH0_CRC		);
wire			 w_addr364_rd		= w_rd_en & (i_PADDR == DEBUG_RC1_CH1_CRC		);
wire			 w_addr368_rd		= w_rd_en & (i_PADDR == DEBUG_RC1_CH2_CRC		);

wire			 w_addr370_rd		= w_rd_en & (i_PADDR == S1D_CH0_CRC				);
wire			 w_addr374_rd		= w_rd_en & (i_PADDR == S1D_CH1_CRC				);
wire			 w_addr378_rd		= w_rd_en & (i_PADDR == S1D_CH2_CRC				);
                          
wire			 w_addr380_rd		= w_rd_en & (i_PADDR == SEG1_CH0_CRC			);
wire			 w_addr384_rd		= w_rd_en & (i_PADDR == SEG1_CH1_CRC			);
wire			 w_addr388_rd		= w_rd_en & (i_PADDR == SEG1_CH2_CRC			);
wire			 w_addr38C_rd		= w_rd_en & (i_PADDR == SEG1_ATT0_CRC			);

wire			 w_addr390_rd		= w_rd_en & (i_PADDR == SCC_CH0_CRC				);
wire			 w_addr394_rd		= w_rd_en & (i_PADDR == SCC_CH1_CRC				);
wire			 w_addr398_rd		= w_rd_en & (i_PADDR == SCC_CH2_CRC				);
wire			 w_addr39C_rd		= w_rd_en & (i_PADDR == SCC_ATT_CRC				);

wire			 w_addr3A0_rd		= w_rd_en & (i_PADDR == SEG2_CH0_CRC			);
wire			 w_addr3A4_rd		= w_rd_en & (i_PADDR == SEG2_CH1_CRC			);
wire			 w_addr3A8_rd		= w_rd_en & (i_PADDR == SEG2_CH2_CRC			);
wire			 w_addr3AC_rd		= w_rd_en & (i_PADDR == SEG2_ATT_CRC			);
                          
wire			 w_addr3B0_rd		= w_rd_en & (i_PADDR == BSSA_CH0_CRC			);
wire			 w_addr3B4_rd		= w_rd_en & (i_PADDR == BSSA_CH1_CRC			);
wire			 w_addr3B8_rd		= w_rd_en & (i_PADDR == BSSA_CH2_CRC			);

wire			 w_addr3C0_rd		= w_rd_en & (i_PADDR == DTX_CH0_CRC			);
wire			 w_addr3C4_rd		= w_rd_en & (i_PADDR == DTX_CH1_CRC			);
wire			 w_addr3C8_rd		= w_rd_en & (i_PADDR == DTX_CH2_CRC			);

wire			 w_addr3D0_rd		= w_rd_en & (i_PADDR == RC2_CH0_CRC				);
wire			 w_addr3D4_rd		= w_rd_en & (i_PADDR == RC2_CH1_CRC				);
wire			 w_addr3D8_rd		= w_rd_en & (i_PADDR == RC2_CH2_CRC				);
 
wire			 w_addr3E0_rd		= w_rd_en & (i_PADDR == ADAPT_CRC				);
wire			 w_addr3E4_rd		= w_rd_en & (i_PADDR == SMAP_CRC				);
wire			 w_addr3E8_rd		= w_rd_en & (i_PADDR == BDS_CRC					);
                          
wire			 w_addr3F0_rd		= w_rd_en & (i_PADDR == VSD_CH0_CRC				);
wire			 w_addr3F4_rd		= w_rd_en & (i_PADDR == VSD_CH1_CRC				);
wire			 w_addr3F8_rd		= w_rd_en & (i_PADDR == VSD_CH2_CRC				);
 
wire			 w_addr400_rd		= w_rd_en & (i_PADDR == CIS_CH0_CRC				);
wire			 w_addr404_rd		= w_rd_en & (i_PADDR == CIS_CH1_CRC				);
wire			 w_addr408_rd		= w_rd_en & (i_PADDR == CIS_CH2_CRC				);
 
wire			 w_addr410_rd		= w_rd_en & (i_PADDR == BSSB_CH0_CRC			);
wire			 w_addr414_rd		= w_rd_en & (i_PADDR == BSSB_CH1_CRC			);
wire			 w_addr418_rd		= w_rd_en & (i_PADDR == BSSB_CH2_CRC			);


wire		 w_addr440_rd		= w_rd_en & (i_PADDR == S1D_DEBUG_FLAG				);
wire		 w_addr444_rd		= w_rd_en & (i_PADDR == SCC_DEBUG_FLAG				);
wire		 w_addr448_rd		= w_rd_en & (i_PADDR == BDS_DEBUG_FLAG				);
wire		 w_addr44C_rd		= w_rd_en & (i_PADDR == BSSA_DEBUG_FLAG				);
wire		 w_addr450_rd		= w_rd_en & (i_PADDR == BSSB_DEBUG_FLAG				);

// 11)	ABSD
wire			 w_addr880_rd		= w_rd_en & (i_PADDR == MAGD_PRE_SCAN_LINE	   		);
wire			 w_addr884_rd		= w_rd_en & (i_PADDR == MAGD_PRESCAN_IWIN	   		);
wire			 w_addr888_rd		= w_rd_en & (i_PADDR == MAGD_TH				   		);
wire			 w_addr88C_rd		= w_rd_en & (i_PADDR == MAGD_VALID_PERCENTAGE   	);
wire			 w_addr890_rd		= w_rd_en & (i_PADDR == MAGD_BK_STD_TH		   		);
wire			 w_addr894_rd		= w_rd_en & (i_PADDR == MAGD_SIGMA			   		);
wire			 w_addr898_rd		= w_rd_en & (i_PADDR == MAGD_BG_BACKUP		   		);
wire			 w_addr89C_rd		= w_rd_en & (i_PADDR == MAGD_COLOR_EXCEPTION	   	);
wire			 w_addr8A0_rd		= w_rd_en & (i_PADDR == MAGD_TOP_BG_LEVEL	   		);	// Read Only
wire			 w_addr8A4_rd		= w_rd_en & (i_PADDR == MAGD_TOP_PEAK_CONFIDENCE	);	// Read Only
wire			 w_addr8A8_rd		= w_rd_en & (i_PADDR == MAGD_PRE_SCAN_START			);
//NEABSD
wire			 w_addr8C0_rd		= w_rd_en & (i_PADDR == NEWABSD_SCAN_RANGE	); 
wire			 w_addr8C4_rd		= w_rd_en & (i_PADDR == NEWABSD_PRESCAN_IWIN); 
wire			 w_addr8C8_rd		= w_rd_en & (i_PADDR == NEWABSD_CHROMA_TH	); 
wire			 w_addr8CC_rd		= w_rd_en & (i_PADDR == NEWABSD_LIMIT		);
wire			 w_addr8D0_rd		= w_rd_en & (i_PADDR == NEWABSD_HISTO_PEAK		);
wire			 w_addr8D4_rd		= w_rd_en & (i_PADDR == NEWABSD_HISTO_LEFT		);
wire			 w_addr8D8_rd		= w_rd_en & (i_PADDR == NEWABSD_HISTO_RIGHT		);
wire			 w_addr8DC_rd		= w_rd_en & (i_PADDR == NEWABSD_RESULT		);
 
// 2 )  VSC
wire			 w_addr480_rd		= w_rd_en & (i_PADDR == VSD_REG_A					); 
wire			 w_addr484_rd		= w_rd_en & (i_PADDR == VSD_REG_B					); 
wire			 w_addr488_rd		= w_rd_en & (i_PADDR == VSD_REG_C					); 
wire			 w_addr48C_rd		= w_rd_en & (i_PADDR == VSD_REG_D					); 
wire			 w_addr490_rd		= w_rd_en & (i_PADDR == VSD_REG_E					); 
wire			 w_addr494_rd		= w_rd_en & (i_PADDR == VSD_REG_F					); 
wire			 w_addr498_rd		= w_rd_en & (i_PADDR == VSD_REG_G					); 
wire			 w_addr49C_rd		= w_rd_en & (i_PADDR == VSD_REG_H					); 

// 4 )  CISSI
wire			 w_addr4C0_rd		= w_rd_en & (i_PADDR == CIS_SUB_COEF_R				);
wire			 w_addr4C4_rd		= w_rd_en & (i_PADDR == CIS_SUB_COEF_G				);
wire			 w_addr4C8_rd		= w_rd_en & (i_PADDR == CIS_SUB_COEF_B				);

     
// 5 )  RC1
wire			 w_addr500_rd		= w_rd_en & (i_PADDR == RC1_SHIFT_VAL				);
wire			 w_addr504_rd		= w_rd_en & (i_PADDR == RC1_SHIFT_OFST				);
wire			 w_addr508_rd		= w_rd_en & (i_PADDR == RC1_LOOP					);
//Reserved             5  
wire			 w_addr510_rd		= w_rd_en & (i_PADDR == RC1_X_COF_00_01				);
wire			 w_addr514_rd		= w_rd_en & (i_PADDR == RC1_X_COF_02_03				);
wire			 w_addr518_rd		= w_rd_en & (i_PADDR == RC1_X_COF_10_11				);
wire			 w_addr51C_rd		= w_rd_en & (i_PADDR == RC1_X_COF_12_13				);
wire			 w_addr520_rd		= w_rd_en & (i_PADDR == RC1_X_COF_20_21				);
wire			 w_addr524_rd		= w_rd_en & (i_PADDR == RC1_X_COF_22_23				);
wire			 w_addr528_rd		= w_rd_en & (i_PADDR == RC1_X_COF_30_31				);
wire			 w_addr52C_rd		= w_rd_en & (i_PADDR == RC1_X_COF_32_33				);
wire			 w_addr530_rd		= w_rd_en & (i_PADDR == RC1_Y_COF_00_01				);
wire			 w_addr534_rd		= w_rd_en & (i_PADDR == RC1_Y_COF_02_03				);
wire			 w_addr538_rd		= w_rd_en & (i_PADDR == RC1_Y_COF_10_11				);
wire			 w_addr53C_rd		= w_rd_en & (i_PADDR == RC1_Y_COF_12_13				);
wire			 w_addr540_rd		= w_rd_en & (i_PADDR == RC1_Y_COF_20_21				);
wire			 w_addr544_rd		= w_rd_en & (i_PADDR == RC1_Y_COF_22_23				);
wire			 w_addr548_rd		= w_rd_en & (i_PADDR == RC1_Y_COF_30_31				);
wire			 w_addr54C_rd		= w_rd_en & (i_PADDR == RC1_Y_COF_32_33				);

// 6 )  S1D


// 8 )  SEG1
wire			 w_addr580_rd		= w_rd_en & (i_PADDR ==SEG1_CON			 ); 
wire			 w_addr584_rd		= w_rd_en & (i_PADDR ==SEG1_HVLINE_TH		 ); 
wire			 w_addr588_rd		= w_rd_en & (i_PADDR ==SEG1_EDGE_TH			 ); 
wire			 w_addr58C_rd		= w_rd_en & (i_PADDR ==SEG1_LINE_TH			 ); 
wire			 w_addr590_rd		= w_rd_en & (i_PADDR ==SEG1_ZC_TH			 );

// 7 )  SCC
wire			 w_addr5C0_rd		= w_rd_en & (i_PADDR == SCC_CON						);
// 10)	SEG2
wire			 w_addr600_rd		= w_rd_en & (i_PADDR == SEG2_CON					);
wire			 w_addr604_rd		= w_rd_en & (i_PADDR == SEG2_PARAM1				);
wire			 w_addr608_rd		= w_rd_en & (i_PADDR == SEG2_PARAM2				);
wire			 w_addr60C_rd		= w_rd_en & (i_PADDR == SEG2_FAR_CHROMA_PARAM				);
wire			 w_addr610_rd		= w_rd_en & (i_PADDR == SEG2_FAR_Y_PARAM				);
wire			 w_addr614_rd		= w_rd_en & (i_PADDR == SEG2_NEUT_CHROMA_PARAM					);
//---------------------------------------------------------------
// ORIENTATION
//---------------------------------------------------------------
wire			w_addr7C0_rd       = w_rd_en & ( i_PADDR == ORI_PAGE_EN					);	
wire			w_addr7C4_rd       = w_rd_en & ( i_PADDR == ORI_BLOCK_SIZE				);	
wire			w_addr7C8_rd       = w_rd_en & ( i_PADDR == ORI_AREA_SIZE				);	
wire			w_addr7CC_rd       = w_rd_en & ( i_PADDR == ORI_CHAR_LENGTH_THICK_V		);	
wire			w_addr7D0_rd       = w_rd_en & ( i_PADDR == ORI_CHAR_LENGTH_THICK_H		);	
wire			w_addr7D4_rd       = w_rd_en & ( i_PADDR == ORI_DIFF_CHANGE_V			);	
wire			w_addr7D8_rd       = w_rd_en & ( i_PADDR == ORI_DIFF_CHANGE_H			);	
wire			w_addr7DC_rd       = w_rd_en & ( i_PADDR == ORI_DIR_TH1					);	
wire			w_addr7E0_rd       = w_rd_en & ( i_PADDR == ORI_DIR_TH2					);	
wire			w_addr7E4_rd       = w_rd_en & ( i_PADDR == ORI_AREA_OFFSET1		);	
wire			w_addr7E8_rd       = w_rd_en & ( i_PADDR == ORI_AREA_OFFSET2		);	
wire			w_addr7EC_rd       = w_rd_en & ( i_PADDR == ORI_LINE_SPACE				);	
wire			w_addr7F0_rd       = w_rd_en & ( i_PADDR == ORI_TEX_FLAG				);	// Read Only
wire			w_addr7F4_rd       = w_rd_en & ( i_PADDR == ORI_TEXT_AREA1_W			);	// Read Only
wire			w_addr7F8_rd       = w_rd_en & ( i_PADDR == ORI_TEXT_AREA1_H			);	// Read Only
wire			w_addr7FC_rd       = w_rd_en & ( i_PADDR == ORI_TEXT_AREA2_W			);	// Read Only
wire			w_addr800_rd       = w_rd_en & ( i_PADDR == ORI_TEXT_AREA2_H			);	// Read Only
wire			w_addr804_rd       = w_rd_en & ( i_PADDR == ORI_TEXT_AREA3_W			);	// Read Only
wire			w_addr808_rd       = w_rd_en & ( i_PADDR == ORI_TEXT_AREA3_H			);	// Read Only

// CLA
wire			 w_addr900_rd		= w_rd_en & (i_PADDR == CLA_CON1		  );
wire			 w_addr904_rd		= w_rd_en & (i_PADDR == CLA_CON2		  );
wire			 w_addr908_rd		= w_rd_en & (i_PADDR == CLA_TOTAL_BIN_CNT ); // Read Only
wire			 w_addr90C_rd		= w_rd_en & (i_PADDR == CLA_HL_range2	  ); // Read Only
wire			 w_addr910_rd		= w_rd_en & (i_PADDR == CLA_HL_color2	  ); // Read Only
wire			 w_addr914_rd		= w_rd_en & (i_PADDR == CLA_BTEXT_CNT	  ); // Read Only
wire			 w_addr918_rd		= w_rd_en & (i_PADDR == CLA_TEXT_CNT	  ); // Read Only
wire			 w_addr91C_rd		= w_rd_en & (i_PADDR == CLA_HT_CNT		  ); // Read Only
wire			 w_addr920_rd		= w_rd_en & (i_PADDR == CLA_EDGE_CNT	  ); // Read Only
wire			 w_addr924_rd		= w_rd_en & (i_PADDR == CLA_WHITE_CNT	  ); // Read Only
wire			 w_addr928_rd		= w_rd_en & (i_PADDR == CLA_CONTONE_CNT	  ); // Read Only
wire			 w_addr92C_rd		= w_rd_en & (i_PADDR == CLA_WHITE_WO_TEXT_CNT	  ); // Read Only
wire			 w_addr930_rd		= w_rd_en & (i_PADDR == CLA_WHITE_WO_HT_TEXT_CNT	  ); // Read Only
wire			 w_addr934_rd		= w_rd_en & (i_PADDR == CLA_CONTENT_SIZE	  ); // Read Only
//ACBD

wire			 w_addr980_rd		= w_rd_en & (i_PADDR == ACBD_MARGIN1				  );
wire			 w_addr984_rd		= w_rd_en & (i_PADDR == ACBD_MARGIN2				  );
wire			 w_addr988_rd		= w_rd_en & (i_PADDR == ACBD_TH1					  );
wire			 w_addr98C_rd		= w_rd_en & (i_PADDR == ACBD_TH2					  );
wire			 w_addr990_rd		= w_rd_en & (i_PADDR == ACBD_HLIGHT_SEL_EN			  );
wire			 w_addr994_rd		= w_rd_en & (i_PADDR == ACBD_AVG_TH					  );
wire			 w_addr998_rd		= w_rd_en & (i_PADDR == ACBD_HISTO_WIN_VAL			  );
wire			 w_addr99C_rd		= w_rd_en & (i_PADDR == ACBD_RATIO_TH				  );
wire			 w_addr9A0_rd		= w_rd_en & (i_PADDR == ACBD_LIMIT_TH				  );
wire			 w_addr9A4_rd		= w_rd_en & (i_PADDR == ACBD_BRIGHT_STRETCH_OFFSET );
wire			 w_addr9A8_rd		= w_rd_en & (i_PADDR == ACBD_ACB_TH1 );
wire			 w_addr9AC_rd		= w_rd_en & (i_PADDR == ACBD_ACB_TH2 );
wire			 w_addr9B0_rd		= w_rd_en & (i_PADDR == ACBD_OBJ );
wire			 w_addr9B4_rd		= w_rd_en & (i_PADDR == ACBD_RESULT1					 );
wire			 w_addr9B8_rd		= w_rd_en & (i_PADDR == ACBD_RESULT2					 );
wire			 w_addr9BC_rd		= w_rd_en & (i_PADDR == ACBD_ACS_REF_ON					 );

// 11)	ABSD

wire			 w_addr840_rd		= w_rd_en & (i_PADDR == ABSD_PRE_SCAN_LINE	   		);
wire			 w_addr844_rd		= w_rd_en & (i_PADDR == ABSD_PRESCAN_IWIN	   		);
wire			 w_addr848_rd		= w_rd_en & (i_PADDR == ABSD_TH				   		);
wire			 w_addr84C_rd		= w_rd_en & (i_PADDR == ABSD_VALID_PERCENTAGE   	);
wire			 w_addr850_rd		= w_rd_en & (i_PADDR == ABSD_BK_STD_TH		   		);
wire			 w_addr854_rd		= w_rd_en & (i_PADDR == ABSD_SIGMA			   		);
wire			 w_addr858_rd		= w_rd_en & (i_PADDR == ABSD_BG_BACKUP		   		);
wire			 w_addr85C_rd		= w_rd_en & (i_PADDR == ABSD_COLOR_EXCEPTION	   	);
wire			 w_addr860_rd		= w_rd_en & (i_PADDR == ABSD_TOP_BG_LEVEL	   		);	// Read Only
wire			 w_addr864_rd		= w_rd_en & (i_PADDR == ABSD_TOP_PEAK_CONFIDENCE	);	// Read Only
wire			 w_addr868_rd		= w_rd_en & (i_PADDR == ABSD_PRE_SCAN_START			);	

// 13)	ACS
wire			 w_addr9C0_rd		= w_rd_en & (i_PADDR == ACS_CON						);
wire			 w_addr9C4_rd		= w_rd_en & (i_PADDR == ACS_MARK_POS_TOP			);
wire			 w_addr9C8_rd		= w_rd_en & (i_PADDR == ACS_MARK_POS_BOTTOM			);
wire			 w_addr9CC_rd		= w_rd_en & (i_PADDR == ACS_MARK_POS_LEFT			);
wire			 w_addr9D0_rd		= w_rd_en & (i_PADDR == ACS_MARK_POS_RIGHT			);
wire			 w_addr9D4_rd		= w_rd_en & (i_PADDR == ACS_SATURATION_TH 			);
wire			 w_addr9D8_rd		= w_rd_en & (i_PADDR == ACS_HT_TH 					);
wire			 w_addr9DC_rd		= w_rd_en & (i_PADDR == ACS_CBMAX1 					);
wire			 w_addr9E0_rd		= w_rd_en & (i_PADDR == ACS_CBMAX2 					);
wire			 w_addr9E4_rd		= w_rd_en & (i_PADDR == ACS_CBMAX3 					);
wire			 w_addr9E8_rd		= w_rd_en & (i_PADDR == ACS_CBMAX4 					);
wire			 w_addr9EC_rd		= w_rd_en & (i_PADDR == ACS_CBMIN1 					);
wire			 w_addr9F0_rd		= w_rd_en & (i_PADDR == ACS_CBMIN2 					);
wire			 w_addr9F4_rd		= w_rd_en & (i_PADDR == ACS_CBMIN3 					);
wire			 w_addr9F8_rd		= w_rd_en & (i_PADDR == ACS_CBMIN4 					);
wire			 w_addr9FC_rd		= w_rd_en & (i_PADDR == ACS_CRMAX1 					);
wire			 w_addrA00_rd		= w_rd_en & (i_PADDR == ACS_CRMAX2 					);
wire			 w_addrA04_rd		= w_rd_en & (i_PADDR == ACS_CRMAX3 					);
wire			 w_addrA08_rd		= w_rd_en & (i_PADDR == ACS_CRMAX4 					);
wire			 w_addrA0C_rd		= w_rd_en & (i_PADDR == ACS_CRMIN1 					);
wire			 w_addrA10_rd		= w_rd_en & (i_PADDR == ACS_CRMIN2 					);
wire			 w_addrA14_rd		= w_rd_en & (i_PADDR == ACS_CRMIN3 					);
wire			 w_addrA18_rd		= w_rd_en & (i_PADDR == ACS_CRMIN4 					);
wire			 w_addrA1C_rd		= w_rd_en & (i_PADDR == ACS_CBMAXH1 				);
wire			 w_addrA20_rd		= w_rd_en & (i_PADDR == ACS_CBMAXH2 				);
wire			 w_addrA24_rd		= w_rd_en & (i_PADDR == ACS_CBMAXH3 				);
wire			 w_addrA28_rd		= w_rd_en & (i_PADDR == ACS_CBMAXH4 				);
wire			 w_addrA2C_rd		= w_rd_en & (i_PADDR == ACS_CBMINH1 				);
wire			 w_addrA30_rd		= w_rd_en & (i_PADDR == ACS_CBMINH2 				);
wire			 w_addrA34_rd		= w_rd_en & (i_PADDR == ACS_CBMINH3 				);
wire			 w_addrA38_rd		= w_rd_en & (i_PADDR == ACS_CBMINH4 				);
wire			 w_addrA3C_rd		= w_rd_en & (i_PADDR == ACS_CRMAXH1 				);
wire			 w_addrA40_rd		= w_rd_en & (i_PADDR == ACS_CRMAXH2 				);
wire			 w_addrA44_rd		= w_rd_en & (i_PADDR == ACS_CRMAXH3 				);
wire			 w_addrA48_rd		= w_rd_en & (i_PADDR == ACS_CRMAXH4 				);
wire			 w_addrA4C_rd		= w_rd_en & (i_PADDR == ACS_CRMINH1 				);
wire			 w_addrA50_rd		= w_rd_en & (i_PADDR == ACS_CRMINH2 				);
wire			 w_addrA54_rd		= w_rd_en & (i_PADDR == ACS_CRMINH3 				);
wire			 w_addrA58_rd		= w_rd_en & (i_PADDR == ACS_CRMINH4 				);
wire			 w_addrA5C_rd		= w_rd_en & (i_PADDR == ACS_VALUE_TH				);
wire			 w_addrA60_rd		= w_rd_en & (i_PADDR == ACS_TBLK_PAGE 				);
wire			 w_addrA64_rd		= w_rd_en & (i_PADDR == ACS_TBLK_NPAGE	 			);
wire			 w_addrA68_rd		= w_rd_en & (i_PADDR == ACS_CBLK 					);
wire			 w_addrA6C_rd		= w_rd_en & (i_PADDR == ACS_SBLK_PAGE 				);
wire			 w_addrA70_rd		= w_rd_en & (i_PADDR == ACS_SPXL_BLK_PAGE			);
wire			 w_addrA74_rd		= w_rd_en & (i_PADDR == ACS_SPXL_PAGE	  			);
wire			 w_addrA78_rd		= w_rd_en & (i_PADDR == ACS_TEXT_PAGE	  			);
wire			 w_addrA7C_rd		= w_rd_en & (i_PADDR == ACS_HT_PAGE	    			);
wire			 w_addrA80_rd		= w_rd_en & (i_PADDR == ACS_EDGE_PAGE	  			);
//Reserved		 w_addrA84_rd	
wire			 w_addrA88_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS00 			);
wire			 w_addrA8C_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS01 			);
wire			 w_addrA90_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS02 			);
wire			 w_addrA94_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS03 			);
wire			 w_addrA98_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS04 			);
wire			 w_addrA9C_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS05 			);
wire			 w_addrAA0_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS06 			);
wire			 w_addrAA4_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS07 			);
wire			 w_addrAA8_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS08 			);
wire			 w_addrAAC_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS09 			);
wire			 w_addrAB0_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS10 			);
wire			 w_addrAB4_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS11 			);
wire			 w_addrAB8_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS12 			);
wire			 w_addrABC_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS13 			);
wire			 w_addrAC0_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS14 			);
wire			 w_addrAC4_rd		= w_rd_en & (i_PADDR == ACS_AVG_HT_ACS15 			);
wire			 w_addrAC8_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS00 			);
wire			 w_addrACC_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS01 			);
wire			 w_addrAD0_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS02 			);
wire			 w_addrAD4_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS03 			);
wire			 w_addrAD8_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS04 			);
wire			 w_addrADC_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS05 			);
wire			 w_addrAE0_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS06 			);
wire			 w_addrAE4_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS07 			);
wire			 w_addrAE8_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS08 			);
wire			 w_addrAEC_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS09 			);
wire			 w_addrAF0_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS10 			);
wire			 w_addrAF4_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS11 			);
wire			 w_addrAF8_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS12 			);
wire			 w_addrAFC_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS13 			);
wire			 w_addrB00_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS14 			);
wire			 w_addrB04_rd		= w_rd_en & (i_PADDR == ACS_AVG_NHT_ACS15 			);
wire			 w_addrB08_rd		= w_rd_en & (i_PADDR == ACS_SATURATION_TH2 			);
wire			 w_addrB0C_rd		= w_rd_en & (i_PADDR == ACS_VALID_RANGE_H 			);
wire			 w_addrB10_rd		= w_rd_en & (i_PADDR == ACS_VALID_RANGE_W 			);

wire			 w_addrB14_rd		= w_rd_en & (i_PADDR == ACSv2_CON						);
wire			 w_addrB18_rd		= w_rd_en & (i_PADDR == ACSv2_SATURATION_TH 			);
wire			 w_addrB1C_rd		= w_rd_en & (i_PADDR == ACSv2_SATURATION_TH2 			);
wire			 w_addrB20_rd		= w_rd_en & (i_PADDR == ACSv2_HT_TH 					);
wire			 w_addrB24_rd		= w_rd_en & (i_PADDR == ACSv2_VALUE_TH				);
wire			 w_addrB28_rd		= w_rd_en & (i_PADDR == ACSv2_TBLK_PAGE 				);
wire			 w_addrB2C_rd		= w_rd_en & (i_PADDR == ACSv2_TBLK_NPAGE	 			);
wire			 w_addrB30_rd		= w_rd_en & (i_PADDR == ACSv2_CBLK 					);
wire			 w_addrB34_rd		= w_rd_en & (i_PADDR == ACSv2_SBLK_PAGE 				);
wire			 w_addrB38_rd		= w_rd_en & (i_PADDR == ACSv2_SPXL_BLK_PAGE			);
wire			 w_addrB3C_rd		= w_rd_en & (i_PADDR == ACSv2_SPXL_PAGE	  			);

// 14)	BLANK
wire			 w_addrB40_rd		= w_rd_en & (i_PADDR == BLANK_CON0 					);
wire			 w_addrB44_rd		= w_rd_en & (i_PADDR == BLANK_CON1					);
wire			 w_addrB48_rd		= w_rd_en & (i_PADDR == BLANK_MARK_POS_TOP  		);
wire			 w_addrB4C_rd		= w_rd_en & (i_PADDR == BLANK_MARK_POS_BOTTOM 		);
wire			 w_addrB50_rd		= w_rd_en & (i_PADDR == BLANK_MARK_POS_LEFT  		);
wire			 w_addrB54_rd		= w_rd_en & (i_PADDR == BLANK_MARK_POS_RIGHT 		);
wire			 w_addrB58_rd		= w_rd_en & (i_PADDR == BLANK_COLOR_BLK  			);
wire			 w_addrB5C_rd		= w_rd_en & (i_PADDR == BLANK_TotalBLK  			);
wire			 w_addrB60_rd		= w_rd_en & (i_PADDR == BLANK_ContBLK  				);
wire			 w_addrB64_rd		= w_rd_en & (i_PADDR == BLANK_BlankBLK  			);
wire			 w_addrB68_rd		= w_rd_en & (i_PADDR == BLANK_DarkBLK  				);
wire			 w_addrB6C_rd		= w_rd_en & (i_PADDR == BLANK_ColorBLK  			);
wire			 w_addrB70_rd		= w_rd_en & (i_PADDR == BLANK_Y_MIN_MAX  			);
wire			 w_addrB74_rd		= w_rd_en & (i_PADDR == BLANK_CB_MIN_MAX  			);
wire			 w_addrB78_rd		= w_rd_en & (i_PADDR == BLANK_CR_MIN_MAX  			);

// 26)	RC2
wire			 w_addrB80_rd		= w_rd_en & (i_PADDR == RC2_OUTIMG_WIDTH_HEIGHT		);
wire			 w_addrB84_rd		= w_rd_en & (i_PADDR == RC2_OVERLAP					);
wire			 w_addrB88_rd		= w_rd_en & (i_PADDR == RC2_FRAC					);

wire			 w_addrBC0_rd		= w_rd_en & (i_PADDR == BDS_CON				);
wire			 w_addrBC4_rd		= w_rd_en & (i_PADDR == BDS_EDGE1				);
wire			 w_addrBC8_rd		= w_rd_en & (i_PADDR == BDS_EDGE2				);
wire			 w_addrBCC_rd		= w_rd_en & (i_PADDR == BDS_EURion1				);
wire			 w_addrBD0_rd		= w_rd_en & (i_PADDR == BDS_EURion2				);
wire			 w_addrBD4_rd		= w_rd_en & (i_PADDR == BDS_OFFSET				);
wire			 w_addrBD8_rd		= w_rd_en & (i_PADDR == BDS_CONTENTS			);
                         

//SMAP
wire			 w_addrC84_rd		= w_rd_en & (i_PADDR == SMAP_PARAM_B		);
wire			 w_addrC88_rd		= w_rd_en & (i_PADDR == SMAP_PARAM_C		);
wire			 w_addrC8C_rd		= w_rd_en & (i_PADDR ==	SMAP_CON			);
wire			 w_addrC90_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MAX0			);
wire			 w_addrC94_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MAX1			);
wire			 w_addrC98_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MAX2			);
wire			 w_addrC9C_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MAX3			);
wire			 w_addrCA0_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MAX4			);
wire			 w_addrCA4_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MAX5			);
wire			 w_addrCA8_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MAX6			);
wire			 w_addrCAC_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MAX7			);
wire			 w_addrCB0_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MIN0			);
wire			 w_addrCB4_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MIN1			);
wire			 w_addrCB8_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MIN2			);
wire			 w_addrCBC_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MIN3			);
wire			 w_addrCC0_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MIN4			);
wire			 w_addrCC4_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MIN5			);
wire			 w_addrCC8_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MIN6			);
wire			 w_addrCCC_rd		= w_rd_en & (i_PADDR ==	SMAP_R_MIN7			);
wire			 w_addrCD0_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MAX0			);
wire			 w_addrCD4_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MAX1			);
wire			 w_addrCD8_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MAX2			);
wire			 w_addrCDC_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MAX3			);
wire			 w_addrCE0_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MAX4			);
wire			 w_addrCE4_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MAX5			);
wire			 w_addrCE8_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MAX6			);
wire			 w_addrCEC_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MAX7			);
wire			 w_addrCF0_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MIN0			);
wire			 w_addrCF4_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MIN1			);
wire			 w_addrCF8_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MIN2			);
wire			 w_addrCFC_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MIN3			);
wire			 w_addrD00_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MIN4			);
wire			 w_addrD04_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MIN5			);
wire			 w_addrD08_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MIN6			);
wire			 w_addrD0C_rd		= w_rd_en & (i_PADDR ==	SMAP_G_MIN7			);
wire			 w_addrD10_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MAX0			);
wire			 w_addrD14_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MAX1			);
wire			 w_addrD18_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MAX2			);
wire			 w_addrD1C_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MAX3			);
wire			 w_addrD20_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MAX4			);
wire			 w_addrD24_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MAX5			);
wire			 w_addrD28_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MAX6			);
wire			 w_addrD2C_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MAX7			);
wire			 w_addrD30_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MIN0			);
wire			 w_addrD34_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MIN1			);
wire			 w_addrD38_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MIN2			);
wire			 w_addrD3C_rd		= w_rd_en & (i_PADDR == SMAP_B_MIN3			);
wire			 w_addrD40_rd		= w_rd_en & (i_PADDR == SMAP_B_MIN4			);
wire			 w_addrD44_rd		= w_rd_en & (i_PADDR ==	SMAP_B_MIN5			);
wire			 w_addrD48_rd		= w_rd_en & (i_PADDR == SMAP_B_MIN6			);
wire			 w_addrD4C_rd		= w_rd_en & (i_PADDR == SMAP_B_MIN7			);

// 28)	RXDMA
wire			 w_addr108C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_00_UP				);
wire			 w_addr1090_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_01_UP				);
wire			 w_addr1094_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_02_UP				);
wire			 w_addr1098_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_03_UP				);
wire			 w_addr109C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_04_UP				);
wire			 w_addr10A0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_05_UP				);
wire			 w_addr10A4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_06_UP				);
wire			 w_addr10A8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_07_UP				);
wire			 w_addr10AC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_08_UP				);
wire			 w_addr10B0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_09_UP				);
wire			 w_addr10B4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_10_UP				);
wire			 w_addr10B8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_11_UP				);
wire			 w_addr10BC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_12_UP				);
wire			 w_addr10C0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_13_UP				);
wire			 w_addr10C4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_14_UP				);
wire			 w_addr10C8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_15_UP				);
wire			 w_addr10CC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_16_UP				);
wire			 w_addr10D0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_17_UP				);
wire			 w_addr10D4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_18_UP				);
wire			 w_addr10D8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_19_UP				);
wire			 w_addr10DC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_20_UP				);
wire			 w_addr10E0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_21_UP				);
wire			 w_addr10E4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_22_UP				);
wire			 w_addr10E8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_23_UP				);
wire			 w_addr10EC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_24_UP				);
//wire			 w_addr10F0_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_25_UP				);
//wire			 w_addr10F4_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_26_UP				);
//wire			 w_addr10F8_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_27_UP				);
//wire			 w_addr10FC_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_28_UP				);
//wire			 w_addr1100_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_29_UP				);
//wire			 w_addr1104_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_30_UP				);
//wire			 w_addr1108_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_31_UP				);
//wire			 w_addr110C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_32_UP				);
//wire			 w_addr1110_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_33_UP				);
//wire			 w_addr1114_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_34_UP				);
//wire			 w_addr1118_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_35_UP				);
//wire			 w_addr111C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_36_UP				);
//wire			 w_addr1120_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_37_UP				);
//wire			 w_addr1124_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_38_UP				);
//wire			 w_addr1128_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_39_UP				);
//wire			 w_addr112C_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_40_UP				);
//wire			 w_addr1130_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_41_UP				);
//wire			 w_addr1134_rd		= w_rd_en & (i_PADDR ==	TBL_ADDR_42_UP				);


wire			 w_addr114C_rd		= w_rd_en & (i_PADDR == RX_CH0_PREV_ADDR_UP		);
wire			 w_addr1150_rd		= w_rd_en & (i_PADDR == RX_CH1_PREV_ADDR_UP		);
wire			 w_addr1154_rd		= w_rd_en & (i_PADDR == RX_CH2_PREV_ADDR_UP		);
wire			 w_addr1158_rd		= w_rd_en & (i_PADDR == RX_CH0_CURR_ADDR_UP			);
wire			 w_addr115C_rd		= w_rd_en & (i_PADDR == RX_CH1_CURR_ADDR_UP			);
wire			 w_addr1160_rd		= w_rd_en & (i_PADDR == RX_CH2_CURR_ADDR_UP			);
wire			 w_addr1164_rd		= w_rd_en & (i_PADDR == RX_CH0_START_ADDR_UP			);
wire			 w_addr1168_rd		= w_rd_en & (i_PADDR == RX_CH1_START_ADDR_UP			);
wire			 w_addr116C_rd		= w_rd_en & (i_PADDR == RX_CH2_START_ADDR_UP			);
// Reserved                
wire			 w_addr1178_rd		= w_rd_en & (i_PADDR == RX_CUR_ADDR_CH0_UP			);
wire			 w_addr117C_rd		= w_rd_en & (i_PADDR == RX_CUR_ADDR_CH1_UP			);
wire			 w_addr1180_rd		= w_rd_en & (i_PADDR == RX_CUR_ADDR_CH2_UP			);

wire			 w_addr11D4_rd		= w_rd_en & (i_PADDR == TX_CH0_START_ADDR_UP		);
wire			 w_addr11D8_rd		= w_rd_en & (i_PADDR == TX_CH1_START_ADDR_UP		);
wire			 w_addr11DC_rd		= w_rd_en & (i_PADDR == TX_CH2_START_ADDR_UP		);

wire			 w_addr11F0_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH0_MAX_UP			);
wire			 w_addr11F4_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH0_MIN_UP			);
wire			 w_addr11F8_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH1_MAX_UP			);
wire			 w_addr11FC_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH1_MIN_UP			);
wire			 w_addr1200_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH2_MAX_UP			);
wire			 w_addr1204_rd		= w_rd_en & (i_PADDR == TX_ADDR_CH2_MIN_UP			);

wire			 w_addr1218_rd		= w_rd_en & (i_PADDR == TX_CH0_CUR_ADDR_UP			);
wire			 w_addr121C_rd		= w_rd_en & (i_PADDR == TX_CH1_CUR_ADDR_UP			);
wire			 w_addr1220_rd		= w_rd_en & (i_PADDR == TX_CH2_CUR_ADDR_UP			);

// 30)	DMA_ADAPT_SMAP
wire			 w_addr1284_rd		= w_rd_en & (i_PADDR == ADAPT_DMA_ADDR_UP			);
                           
wire			 w_addr1290_rd		= w_rd_en & (i_PADDR == ADAPT_DMA_TX_ADDR_MAX_UP	);
wire			 w_addr1294_rd		= w_rd_en & (i_PADDR == ADAPT_DMA_TX_ADDR_MIN_UP	);
wire			 w_addr1298_rd		= w_rd_en & (i_PADDR == ADAPT_TX_CUR_ADDR_UP		);
                           
wire			 w_addr12C4_rd		= w_rd_en & (i_PADDR == SMAP_DMA_ADDR_UP			);
                           
wire			 w_addr12D0_rd		= w_rd_en & (i_PADDR == SMAP_DMA_TX_ADDR_MAX_UP		);
wire			 w_addr12D4_rd		= w_rd_en & (i_PADDR == SMAP_DMA_TX_ADDR_MIN_UP		);
wire			 w_addr12D8_rd		= w_rd_en & (i_PADDR == SMAP_TX_CUR_ADDR_UP			);

wire			 w_addr1304_rd		= w_rd_en & (i_PADDR == BDS_DMA_ADDR_UP			);
                           
wire			 w_addr1310_rd		= w_rd_en & (i_PADDR == BDS_DMA_TX_ADDR_MAX_UP		);
wire			 w_addr1314_rd		= w_rd_en & (i_PADDR == BDS_DMA_TX_ADDR_MIN_UP		);
wire			 w_addr1318_rd		= w_rd_en & (i_PADDR == BDS_TX_CUR_ADDR_UP		);

//---------------------------------------------------------------------------------------
// i_ADAPT_DMA_TX_END: short pulse
//---------------------------------------------------------------------------------------
reg	r_ADAPT_TX_START;
reg	r_SMAP_TX_START;
reg	r_BDS_TX_START;

	always @ (negedge i_HRESETn or posedge i_PCLK)  
		if(!i_HRESETn)					r_ADAPT_DMA_TX_END <= #1 0;	
		else if(r_CORE_START)				r_ADAPT_DMA_TX_END <= #1 0;
		else if(r_ADAPT_TX_START)			r_ADAPT_DMA_TX_END <= #1 0;
		else if(i_ADAPT_DMA_TX_END)			r_ADAPT_DMA_TX_END <= #1 1; // level


	always @ (negedge i_HRESETn or posedge i_PCLK)  
		if(!i_HRESETn)					r_SMAP_DMA_TX_END <= #1 0;	
		else if(r_CORE_START)				r_SMAP_DMA_TX_END <= #1 0;
		else if(r_SMAP_TX_START)			r_SMAP_DMA_TX_END <= #1 0;
		else if(i_SMAP_DMA_TX_END)			r_SMAP_DMA_TX_END <= #1 1; // level

	always @ (negedge i_HRESETn or posedge i_PCLK)  
		if(!i_HRESETn)					r_BDS_DMA_TX_END <= #1 0;	
		else if(r_CORE_START)				r_BDS_DMA_TX_END <= #1 0;
		else if(r_BDS_TX_START)				r_BDS_DMA_TX_END <= #1 0;
		else if(i_BDS_DMA_TX_END)			r_BDS_DMA_TX_END <= #1 1; // level


	always @ (negedge i_HRESETn or posedge i_PCLK)  
		if(!i_HRESETn)					r_TX_BAND_DONE <= #1 0;	
		else if(r_CORE_START)				r_TX_BAND_DONE <= #1 0;
		else if(o_TX_START)				r_TX_BAND_DONE <= #1 0;
		else if(i_TX_BAND_DONE)				r_TX_BAND_DONE <= #1 1;  // level


	`IPR_REG( r_TX_BAND_DONE_1d, r_TX_BAND_DONE	)  
	assign  w_TX_BAND_DONE_sp = r_TX_BAND_DONE & (~r_TX_BAND_DONE_1d); 


	wire	w_CORE_BAND_END_TOTAL;
	wire	w_CORE_BAND_DONE_TOTAL_sp ;
	reg	r_CORE_BAND_END_TOTAL_1d;
	
	assign	w_CORE_BAND_END_TOTAL =    i_CORE_BAND_END[0];
	`IPR_REG( r_CORE_BAND_END_TOTAL_1d, w_CORE_BAND_END_TOTAL)  
	assign	w_CORE_BAND_DONE_TOTAL_sp = w_CORE_BAND_END_TOTAL & (~r_CORE_BAND_END_TOTAL_1d);


	wire   w_BAND_DONE_sp;
	assign w_BAND_DONE_sp = (o_TX_CH_EN) ?    w_TX_BAND_DONE_sp      :  	w_CORE_BAND_DONE_TOTAL_sp;
//---------------------------------------------------------------------------------------------
// Save ABSD result 
// To SFR
//---------------------------------------------------------------------------------------------
reg	[ 7:0]	r_MAGD_TOP_BG_LEVEL						;
reg	[ 7:0]	r_MAGD_MAX_CB						;
reg	[ 7:0]	r_MAGD_MAX_CR						;
reg	[ 6:0]	r_MAGD_TOP_PEAK_CONFIDENCE				;
reg		r_MAGD_RESULT_SUCCESS				;

always @ (negedge i_HRESETn or posedge i_PCLK)  begin

	if(!i_HRESETn)  begin
				r_MAGD_MAX_CB			<= #1 8'h80;	
				r_MAGD_MAX_CR 			<= #1 8'h80;	
				r_MAGD_TOP_BG_LEVEL 		<= #1 8'hFF; 
				r_MAGD_TOP_PEAK_CONFIDENCE	<= #1 0;
				r_MAGD_RESULT_SUCCESS		<= #1 1;
	end						
	else if(r_CORE_START)  begin	     
				r_MAGD_MAX_CB			<= #1 8'h80;
				r_MAGD_MAX_CR 			<= #1 8'h80;	
				r_MAGD_TOP_BG_LEVEL 		<= #1 8'hFF; 
				r_MAGD_TOP_PEAK_CONFIDENCE	<= #1 0;
				r_MAGD_RESULT_SUCCESS		<= #1 1;
	end
	else if(i_MAGD_DETECT_DONE_sp)  begin
				r_MAGD_MAX_CB			<= #1 i_MAGD_MAX_CB;
				r_MAGD_MAX_CR 			<= #1 i_MAGD_MAX_CR;	
				r_MAGD_TOP_BG_LEVEL 		<= #1 i_MAGD_TOP_BG_LEVEL;
				r_MAGD_TOP_PEAK_CONFIDENCE	<= #1 i_MAGD_TOP_PEAK_CONFIDENCE;
				r_MAGD_RESULT_SUCCESS		<= #1 i_MAGD_RESULT_SUCCESS;
	end										
end

//---------------------------------------------------------------------------------------------
// Save ABSD result 
// To SFR
//---------------------------------------------------------------------------------------------
reg	[ 7:0]	r_ABSD_TOP_BG_LEVEL						;
reg	[ 7:0]	r_ABSD_MAX_CB						;
reg	[ 7:0]	r_ABSD_MAX_CR						;
reg	[ 6:0]	r_ABSD_TOP_PEAK_CONFIDENCE				;
reg			r_ABSD_RESULT_SUCCESS				;

always @ (negedge i_HRESETn or posedge i_PCLK)  begin

	if(!i_HRESETn)  begin
				r_ABSD_MAX_CB			<= #1 8'h80;	
				r_ABSD_MAX_CR 			<= #1 8'h80;	
				r_ABSD_TOP_BG_LEVEL 		<= #1 8'hFF; 
				r_ABSD_TOP_PEAK_CONFIDENCE	<= #1 0;
				r_ABSD_RESULT_SUCCESS		<= #1 1;
	end						
	else if(r_CORE_START)  begin	     
				r_ABSD_MAX_CB			<= #1 8'h80;
				r_ABSD_MAX_CR 			<= #1 8'h80;	
				r_ABSD_TOP_BG_LEVEL 		<= #1 8'hFF; 
				r_ABSD_TOP_PEAK_CONFIDENCE	<= #1 0;
				r_ABSD_RESULT_SUCCESS		<= #1 1;
	end
	else if(i_ABSD_DETECT_DONE_sp)  begin
				r_ABSD_MAX_CB			<= #1 i_ABSD_MAX_CB;
				r_ABSD_MAX_CR 			<= #1 i_ABSD_MAX_CR;	
				r_ABSD_TOP_BG_LEVEL 		<= #1 i_ABSD_TOP_BG_LEVEL;
				r_ABSD_TOP_PEAK_CONFIDENCE	<= #1 i_ABSD_TOP_PEAK_CONFIDENCE;
				r_ABSD_RESULT_SUCCESS		<= #1 i_ABSD_RESULT_SUCCESS;
	end										
end


//---------------------------------------------------------------------------------------------------
// ABSD
//---------------------------------------------------------------------------------------------------
wire	w_ABSD_DETECT_DONE;
reg	r_ABSD_DETECT_DONE;

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_ABSD_DETECT_DONE		<= #1 1'h0;	
	else if(r_CORE_START)			r_ABSD_DETECT_DONE		<= #1 1'h0;
	else if(i_ABSD_DETECT_DONE_sp)		r_ABSD_DETECT_DONE		<= #1 1'h1;
end

assign	w_ABSD_DETECT_DONE = (o_ABSD_EN) ? r_ABSD_DETECT_DONE : 1'h1;


//---------------------------------------------------------------------------------------------------
// MAGD
//---------------------------------------------------------------------------------------------------
wire	w_MAGD_DETECT_DONE;
reg	r_MAGD_DETECT_DONE;

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_MAGD_DETECT_DONE		<= #1 1'h0;	
	else if(r_CORE_START)			r_MAGD_DETECT_DONE		<= #1 1'h0;
	else if(i_MAGD_DETECT_DONE_sp)		r_MAGD_DETECT_DONE		<= #1 1'h1;
end

//assign	w_MAGD_DETECT_DONE = (o_ABSD_EN) ? r_MAGD_DETECT_DONE : 1'h1;
assign	w_MAGD_DETECT_DONE = (o_MAGD_EN) ? r_MAGD_DETECT_DONE : 1'h1;

//---------------------------------------------------------------------------------------------------
// VSD
//---------------------------------------------------------------------------------------------------
wire	w_VSD_DONE;
reg	r_VSD_DONE;

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_VSD_DONE		<= #1 1'h0;	
	else if(r_CORE_START)			r_VSD_DONE		<= #1 1'h0;
	else if(i_VSD_DONE_sp)			r_VSD_DONE		<= #1 1'h1;
end

assign	w_VSD_DONE = (o_VSD_EN) ? r_VSD_DONE : 1'h1;

//---------------------------------------------------------------------------------------------------
// ACS
//---------------------------------------------------------------------------------------------------
wire	w_ACS_DONE;
reg	r_ACS_DONE;

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_ACS_DONE		<= #1 1'h0;	
	else if(r_CORE_START)			r_ACS_DONE		<= #1 1'h0;
	else if(i_ACS_DONE_sp)			r_ACS_DONE		<= #1 1'h1;
end

assign	w_ACS_DONE = (o_ACS_EN) ? r_ACS_DONE : 1'h1;
//---------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------
// ORI_DONE 
//---------------------------------------------------------------------------------------------------
reg	    r_ORI_DONE_1d;
wire	w_ORI_DONE_sp;
wire	w_ORI_DONE;

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_ORI_DONE_1d	 	<= #1 	1'h0;
	else if(r_SW_RESET | r_DMA_STOP )	r_ORI_DONE_1d	 	<= #1 	1'h0;
	else if(r_CORE_START)			r_ORI_DONE_1d	 	<= #1 	1'h0;
	else					r_ORI_DONE_1d	 	<= #1 	i_ORI_DONE; // level
end
assign	w_ORI_DONE_sp =  i_ORI_DONE & ~r_ORI_DONE_1d;
assign	w_ORI_DONE	= (o_ORI_EN) ? i_ORI_DONE : 1;

//---------------------------------------------------------------------------------------------------
// NEWABSD_DETECT_DONE 
//---------------------------------------------------------------------------------------------------
reg	    r_NEWABSD_DETECT_DONE_1d;
wire	w_NEWABSD_DETECT_DONE_sp;
wire	w_NEWABSD_DETECT_DONE; 

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_NEWABSD_DETECT_DONE_1d	 	<= #1 	1'h0;
	else if(r_SW_RESET | r_DMA_STOP )	r_NEWABSD_DETECT_DONE_1d	 	<= #1 	1'h0;
	else if(r_CORE_START)			r_NEWABSD_DETECT_DONE_1d	 	<= #1 	1'h0;
	else					r_NEWABSD_DETECT_DONE_1d	 	<= #1 	i_NEWABSD_DETECT_DONE;	// level
end

assign	w_NEWABSD_DETECT_DONE_sp =  i_NEWABSD_DETECT_DONE & ~r_NEWABSD_DETECT_DONE_1d;
assign	w_NEWABSD_DETECT_DONE = (o_NEWABSD_EN) ? i_NEWABSD_DETECT_DONE : 1;

//---------------------------------------------------------------------------------------------------
// ACBD_DETECT_DONE 
//---------------------------------------------------------------------------------------------------
reg	r_ACBD_DETECT_DONE_1d;
wire	w_ACBD_DETECT_DONE_sp;
wire    w_ACBD_DETECT_DONE;

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_ACBD_DETECT_DONE_1d	 	<= #1 	1'h0;
	else if(r_SW_RESET | r_DMA_STOP )	r_ACBD_DETECT_DONE_1d	 	<= #1 	1'h0;
	else if(r_CORE_START)			r_ACBD_DETECT_DONE_1d	 	<= #1 	1'h0;
	else					r_ACBD_DETECT_DONE_1d	 	<= #1 	i_ACBD_DETECT_DONE;
end

assign	w_ACBD_DETECT_DONE_sp =  i_ACBD_DETECT_DONE & ~r_ACBD_DETECT_DONE_1d;
assign	w_ACBD_DETECT_DONE    =  (o_ACBD_EN) ? i_ACBD_DETECT_DONE : 1;
//-------------------------------------------------------------------------------------
// CLA
//-------------------------------------------------------------------------------------
reg     r_CLA_DONE_1d;
wire	w_CLA_DONE_sp;
wire	w_CLA_DONE;

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_CLA_DONE_1d	 	<= #1 	1'h0;
	else if(r_SW_RESET | r_DMA_STOP )	r_CLA_DONE_1d	 	<= #1 	1'h0;
	else if(r_CORE_START)			r_CLA_DONE_1d	 	<= #1 	1'h0;
	else					r_CLA_DONE_1d	 	<= #1 	i_CLA_DONE;
end

assign	w_CLA_DONE_sp =  i_CLA_DONE & ~r_CLA_DONE_1d;
assign	w_CLA_DONE	= (o_CLA_EN) ? i_CLA_DONE : 1;
//-----------------------------------------------------------------------------------------------

reg	[7:0]	r_ADAPT_BAND_CNT;
reg	[7:0]	r_SMAP_BAND_CNT;
reg	[7:0]	r_BDS_BAND_CNT;

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_ADAPT_BAND_CNT <= #1 0;	
	else if(r_CORE_START)			r_ADAPT_BAND_CNT <= #1 0;
	else if(r_ADAPT_TX_START)		r_ADAPT_BAND_CNT <= #1 (r_ADAPT_BAND_CNT + w_ADAPT_OUT_BANDS );
end

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_SMAP_BAND_CNT <= #1 0;	
	else if(r_CORE_START)			r_SMAP_BAND_CNT <= #1 0;
	else if(r_SMAP_TX_START)		r_SMAP_BAND_CNT <= #1 (r_SMAP_BAND_CNT + w_SMAP_OUT_BANDS );
end

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_BDS_BAND_CNT <= #1 0;	
	else if(r_CORE_START)			r_BDS_BAND_CNT <= #1 0;
	else if(r_BDS_TX_START)			r_BDS_BAND_CNT <= #1 (r_BDS_BAND_CNT + w_BDS_OUT_BANDS );
end

//---------------------------------------------------------------------------------------
//PAGE_DONE
// i_ADAPT_DMA_TX_END : short pulse
// i_BDS_DMA_TX_END : short pulse
// i_SMAP_DMA_TX_END : short pulse
//---------------------------------------------------------------------------------------
reg	r_ADAPT_PAGE_DONE;  // level
reg	r_BDS_PAGE_DONE;  // level
reg	r_SMAP_PAGE_DONE;  // level
reg	r_RX_PAGE_DONE;  // level

	always @ (negedge i_HRESETn or posedge i_PCLK)  begin
		if(!i_HRESETn)							r_ADAPT_PAGE_DONE <= #1 0;	
		else if(r_CORE_START)						r_ADAPT_PAGE_DONE <= #1 0;
		else if(i_ADAPT_DMA_TX_END && (r_ADAPT_BAND_CNT >= r_BNY ))	r_ADAPT_PAGE_DONE <= #1 1;
	end

	always @ (negedge i_HRESETn or posedge i_PCLK)  begin
		if(!i_HRESETn)						r_BDS_PAGE_DONE <= #1 0;	
		else if(r_CORE_START)					r_BDS_PAGE_DONE <= #1 0;
		else if(i_BDS_DMA_TX_END && (r_BDS_BAND_CNT >= r_BNY) )	r_BDS_PAGE_DONE <= #1 1;
	end

	always @ (negedge i_HRESETn or posedge i_PCLK)  begin
		if(!i_HRESETn)							r_SMAP_PAGE_DONE <= #1 0;	
		else if(r_CORE_START)						r_SMAP_PAGE_DONE <= #1 0;
		else if(i_SMAP_DMA_TX_END && (r_SMAP_BAND_CNT >= r_BNY) )	r_SMAP_PAGE_DONE <= #1 1;
	end

	
	wire	w_TX_PAGE_DONE_sp;
	reg	r_TX_PAGE_DONE;
	reg	r_TX_PAGE_DONE_1d;
	
	always @ (negedge i_HRESETn or posedge i_PCLK)  
		if(!i_HRESETn)				r_TX_PAGE_DONE <= #1 0;	
		else if(r_CORE_START)			r_TX_PAGE_DONE <= #1 0;
		else if(i_TX_PAGE_DONE)			r_TX_PAGE_DONE <= #1 1;

	`IPR_REG( r_TX_PAGE_DONE_1d, r_TX_PAGE_DONE	)  
	assign  w_TX_PAGE_DONE_sp = r_TX_PAGE_DONE & (~r_TX_PAGE_DONE_1d); 

	always @ (negedge i_HRESETn or posedge i_PCLK)  
		if(!i_HRESETn)				r_RX_PAGE_DONE <= #1 0;	
		else if(r_CORE_START)			r_RX_PAGE_DONE <= #1 0;
		else if(i_RX_BAND_DONE && (i_RX_BAND_CNT >= (r_BNY -1) ) )			r_RX_PAGE_DONE <= #1 1;

	wire w_ADAPT_PAGE_DONE;
	wire w_SMAP_PAGE_DONE;
	wire w_BDS_PAGE_DONE;
	wire w_PAGE_DONE;

	assign  w_ADAPT_PAGE_DONE	= (o_ADAPT_EN) ? r_ADAPT_PAGE_DONE : 1 ;
	assign  w_SMAP_PAGE_DONE	= (o_SMAP_EN) ? r_SMAP_PAGE_DONE : 1 ;
	assign  w_BDS_PAGE_DONE  	= (o_BDS_EN) ? r_BDS_PAGE_DONE : 1 ;
	assign  w_PAGE_DONE  		= (o_TX_CH_EN) ? r_TX_PAGE_DONE : 1 ;


	assign   w_PAGE_DONE_M = r_RX_PAGE_DONE & w_PAGE_DONE & w_ADAPT_PAGE_DONE & w_SMAP_PAGE_DONE &  w_BDS_PAGE_DONE  & 
				 i_CORE_PAGE_END[0] & 
				 w_ABSD_DETECT_DONE & w_MAGD_DETECT_DONE & w_NEWABSD_DETECT_DONE & w_ACBD_DETECT_DONE &
				 w_ORI_DONE & w_CLA_DONE & w_VSD_DONE & w_ACS_DONE;  

	`IPR_REG( w_PAGE_DONE_M_1d, w_PAGE_DONE_M	)  
	assign  w_PAGE_DONE_sp = w_PAGE_DONE_M & (~w_PAGE_DONE_M_1d); 

//-------------------------------------------------------------------------------------	
// DMA Status
// - To SFR
//-------------------------------------------------------------------------------------	
reg				r_RX_BUSY,
				r_TX_BUSY;

	always @ (negedge i_HRESETn or posedge i_PCLK)  begin
		if(!i_HRESETn)				r_RX_BUSY <= #1 0;	
		else if(r_CORE_START)			r_RX_BUSY <= #1 0;
		else if(o_RX_START)			r_RX_BUSY <= #1 1;
		else if(i_RX_BAND_DONE)			r_RX_BUSY <= #1 0;
	end

	always @ (negedge i_HRESETn or posedge i_PCLK)  begin
		if(!i_HRESETn)				r_TX_BUSY <= #1 0;	
		else if(r_CORE_START)			r_TX_BUSY <= #1 0;
		else if(o_TX_START)			r_TX_BUSY <= #1 1;
		else if(i_TX_BAND_DONE)			r_TX_BUSY <= #1 0;
	end

//-------------------------------------------------------------------------------------	
// TZPC
//-------------------------------------------------------------------------------------	
reg	r_tzpc;

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)					r_tzpc <= #1 0;
	else						r_tzpc <= #1 i_TZPC;
end

//-------------------------------------------------------------------------------------	
// START
//-------------------------------------------------------------------------------------
reg   r_CORE_START_1d;
reg   r_CORE_START_2d;
reg   r_CORE_START_3d;
reg   r_CORE_START_4d;
reg   r_CORE_START_5d;

`IPR_REG( r_CORE_START_1d, r_CORE_START)  
`IPR_REG( r_CORE_START_2d, r_CORE_START_1d	)  
`IPR_REG( r_CORE_START_3d, r_CORE_START_2d	)  
`IPR_REG( r_CORE_START_4d, r_CORE_START_3d	)  
`IPR_REG( r_CORE_START_5d, r_CORE_START_4d	)  

assign  o_CORE_START	= r_CORE_START_5d;

// TX START
reg	r_TX_START_1d;
reg	r_TX_START_2d;
reg	r_TX_START_3d;
reg	r_TX_START_4d;
reg	r_TX_START_5d;
	
`IPR_REG( r_TX_START_1d, r_TX_START   )  
`IPR_REG( r_TX_START_2d, r_TX_START_1d	)  
`IPR_REG( r_TX_START_3d, r_TX_START_2d	)  
`IPR_REG( r_TX_START_4d, r_TX_START_3d	)  
`IPR_REG( r_TX_START_5d, r_TX_START_4d	)  

assign o_TX_START = (o_TX_CH_EN) ? r_TX_START_5d : 0;

// RX
wire	w_RX_START_SCATTERD;

reg     r_RX_START_1d;
reg     r_RX_START_2d;
reg     r_RX_START_3d;
reg     r_RX_START_4d;
reg     r_RX_START_5d;

`IPR_REG( r_RX_START_1d, w_RX_START_SCATTERD   )  
`IPR_REG( r_RX_START_2d, r_RX_START_1d	)  
`IPR_REG( r_RX_START_3d, r_RX_START_2d	)  
`IPR_REG( r_RX_START_4d, r_RX_START_3d	)  
`IPR_REG( r_RX_START_5d, r_RX_START_4d	) 
assign o_RX_START = r_RX_START_5d;
// ===================================================================================
//	WRITE
// ===================================================================================
reg		[15:0]		r_RC1_XD;

wire	[2:0]	RX_DPI_MODE_RC  = (o_RX_DPI_MODE * o_RC1_EN);

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_RC1_XD	<= #1	16'hFFFF;
	else if( RX_DPI_MODE_RC >= 4)		r_RC1_XD	<= #1 	{o_RX_XD, 1'b0 }	;	
	else					r_RC1_XD	<= #1 	o_RX_XD				;


//H450: r_RX_YD*4/3
wire	[17:0] w_RC1_YD_ZOOM_450_c1; 
wire	[15:0] w_RC1_YD_ZOOM_450; 
assign	w_RC1_YD_ZOOM_450_c1 =  {r_RX_YD, 2'h0} / 3; 
assign	w_RC1_YD_ZOOM_450    =  (w_RC1_YD_ZOOM_450_c1[17:16] !=0 ) ? 16'hffff : w_RC1_YD_ZOOM_450_c1[15:0];

//H300 : r_RX_YD*2
wire	[15:0]	w_RC1_YD_ZOOM_300;

assign	w_RC1_YD_ZOOM_300  = (r_RX_YD[15] ) ? 16'hffff: {r_RX_YD[14:0], 1'h0};

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)					r_RC1_YD <= #1  16'hffff; 
	else if(RX_DPI_MODE_RC == p_600x600)		r_RC1_YD <= #1  r_RX_YD;
	else if(RX_DPI_MODE_RC == p_600x450)		r_RC1_YD <= #1  w_RC1_YD_ZOOM_450;
	else if(RX_DPI_MODE_RC == p_600x300)		r_RC1_YD <= #1  w_RC1_YD_ZOOM_300;
	else if(RX_DPI_MODE_RC == p_300x600)		r_RC1_YD <= #1  r_RX_YD;
	else if(RX_DPI_MODE_RC == p_300x450)		r_RC1_YD <= #1  w_RC1_YD_ZOOM_450;
	else 						r_RC1_YD <= #1  w_RC1_YD_ZOOM_300; //300x300
end

assign	o_TX_XD	=  r_RX_XD; 
assign	o_TX_YD	=  r_RX_YD;

assign	o_ACS_XD	=  r_RC1_XD; 
assign	o_BLANK_XD	=  r_RC1_XD; 
//-----------------------------------------------------------------------------------
// SW RESET
//-----------------------------------------------------------------------------------


// DMA Reset
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)		r_DMA_STOP		<= #1	1'h0			;
	else if(w_addr000_wr)	r_DMA_STOP		<= #1 	i_PWDATA[0]		;
	else if(r_DMA_STOP)	r_DMA_STOP		<= #1 	1'h0			;		// Notice: short pluse

assign  o_DMA_RESETn  =		(~r_DMA_STOP);		// DMA Reset

// Global Reset
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_SW_RESET <= #1 0;
	else if(w_addr000_wr)		r_SW_RESET <= #1 i_PWDATA[8];
	else				r_SW_RESET <= #1 0;				// Notice: short pluse

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_SW_RESETn <= #1 1;
	else if(r_SW_RESET)		r_SW_RESETn <= #1 0;
	else if(i_DMA_RESET_DONE_sp)	r_SW_RESETn <= #1 0;	
	else				r_SW_RESETn <= #1 1;		

assign  o_GRESETn = (i_TM) ? i_HRESETn : (i_HRESETn & r_SW_RESETn & !r_CORE_START); // HW Reset + SW Reset

// -----------------------------------------------------------------------------------
//	CORE START
// -----------------------------------------------------------------------------------
reg	r_CORE_BUSY;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_CORE_START	<= #1	1'b0		;
	else if(w_addr004_wr)			r_CORE_START	<= #1	i_PWDATA[0]	;
	else if(r_CORE_START)			r_CORE_START	<= #1	1'b0		;		// Notice: short pluse


//-----------------------------------------------------------------------------------------
// MODE
//-----------------------------------------------------------------------------------------

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_SPA_MODE			<= #1	32'h11			;
	else if(w_addr008_wr)		r_SPA_MODE			<= #1	i_PWDATA[31:0]	;

assign		o_RX_DPI_MODE			= r_SPA_MODE[18:16];
assign		o_TX_COLOR_MODE			= r_SPA_MODE[ 5: 4];
assign		o_RX_COLOR_MODE			= r_SPA_MODE[ 1: 0];

assign		o_SEG2_COLOR_MODE		= (o_RX_COLOR_MODE == 0) ? 0 : 2; // 0: Y, 1: RGB, 2: YCC
assign		o_CLA_COLOR_MODE		= (o_RX_COLOR_MODE == 0) ? 0 : 2; // 0: Y, 1: RGB, 2: YCC
assign		o_ACS_COLOR_MODE		= (o_RX_COLOR_MODE == 0) ? 0 : 2; // 0: Y, 1: RGB, 2: YCC
assign		o_BLANK_COLOR_MODE		= (o_RX_COLOR_MODE == 0) ? 0 : 2; // 0: Y, 1: RGB, 2: YCC
assign		o_ACBD_COLOR_MODE		= (o_RX_COLOR_MODE == 0) ? 0 : 2; // 0: Y, 1: RGB, 2: YCC
assign		o_NEWABSD_COLOR_MODE		= (o_RX_COLOR_MODE == 0) ? 0 : 2; // 0: Y, 1: RGB, 2: YCC
assign		o_ABSD_COLOR_MODE		= (o_RX_COLOR_MODE == 0) ? 0 : 2; // 0: Y, 1: RGB, 2: YCC
assign		o_MAGD_COLOR_MODE		= (o_RX_COLOR_MODE == 0) ? 0 : 2; // 0: Y, 1: RGB, 2: YCC
//-----------------------------------------------------------------------------------------
// ENABLE
//-----------------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_SPA_EN			<= #1	31'h0000_0004;
	else if(w_addr00C_wr)		r_SPA_EN			<= #1	i_PWDATA[31:0]	;

assign		o_VSD_EN 			= r_SPA_EN[ 0];
assign		o_CIS_SUB_EN			= r_SPA_EN[ 1];
assign		o_RC1_EN			= r_SPA_EN[ 2];
assign		o_S1D_EN			= r_SPA_EN[ 3];
assign		o_SEG1_EN			= r_SPA_EN[ 4];
assign		o_SCC_EN			= r_SPA_EN[ 5];
assign		o_SEG2_EN			= r_SPA_EN[ 6];
// reserved
assign		o_ABSD_EN			= r_SPA_EN[ 8];
assign		o_NEWABSD_EN        		= r_SPA_EN[ 9];
assign		o_MAGD_EN			= r_SPA_EN[10];
assign		o_ACS_EN			= r_SPA_EN[11];
assign		o_BLANK_EN			= r_SPA_EN[12];
assign		o_ACBD_EN          		= r_SPA_EN[13];
assign		o_ORI_EN	      		= r_SPA_EN[14];
assign		o_CLA_EN           		= r_SPA_EN[15];
// reserved
assign		o_BDS_EN			= r_SPA_EN[20]; 
assign		o_ADAPT_EN			= r_SPA_EN[21];
assign		o_SMAP_EN			= r_SPA_EN[22];
assign		o_TX_CH_EN			= r_SPA_EN[23]; 
//
//-----------------------------------------------------------------------------------------
// RX_XD
// RX_YD
//-----------------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_RX_XD	<= #1	16'hFFFF;
	else if(w_addr010_wr)		r_RX_XD	<= #1 	i_PWDATA[15:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_RX_YD	<= #1	16'hffff;
	else if(w_addr014_wr)			r_RX_YD	<= #1 	i_PWDATA[15:0]	;

assign		o_RX_XD				= r_RX_XD				;
assign		o_RX_YD				= r_RX_YD			;	



always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)			r_RX_XD_ALIGNED <= #1 16'h0; 
	else if(RX_DPI_MODE_RC >= 4)    r_RX_XD_ALIGNED	<= #1 {r_BNX, 7'h0}; // 128 byte aligned	
	else				r_RX_XD_ALIGNED <= #1 {r_BNX, 8'h0}; // 256 byte aligned  
end

assign	w_RX_YD_ALIGNED_450 = {r_BNY, 7'h0} - {r_BNY, 5'h0};// x 96

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)					r_RX_YD_ALIGNED <= #1  16'h0; 
	else if(RX_DPI_MODE_RC == p_600x600)		r_RX_YD_ALIGNED <= #1  {r_BNY, 7'h0}; // 128 aligned
	else if(RX_DPI_MODE_RC == p_600x450)		r_RX_YD_ALIGNED <= #1  w_RX_YD_ALIGNED_450; // 96 aligned
	else if(RX_DPI_MODE_RC == p_600x300)		r_RX_YD_ALIGNED <= #1  {r_BNY, 6'h0}; // 64 aligned
	else if(RX_DPI_MODE_RC == p_300x600)		r_RX_YD_ALIGNED <= #1  {r_BNY, 7'h0}; // 128 aligned
	else if(RX_DPI_MODE_RC == p_300x450)		r_RX_YD_ALIGNED <= #1  w_RX_YD_ALIGNED_450;// 96 aligned
	else 						r_RX_YD_ALIGNED <= #1  {r_BNY, 6'h0}; // 64 aligned
end

//-----------------------------------------------------------------------------------------
// padding
//-----------------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_RX_PADDING_VAL		<= #1	24'hff_ffff	;
	else if(w_addr01C_wr)		r_RX_PADDING_VAL		<= #1 	i_PWDATA		;

assign		o_CH2_PADDING_VAL	= r_RX_PADDING_VAL[23:16]	;
assign 		o_CH1_PADDING_VAL	= r_RX_PADDING_VAL[15: 8]	;
assign 		o_CH0_PADDING_VAL	= r_RX_PADDING_VAL[ 7: 0]	;
// -----------------------------------------------------------------------------------
//	SRAM
// -----------------------------------------------------------------------------------
reg			r_RAM_SW_MODE		;
reg		[24:0]	r_RAM_CS			;
reg			r_RAM_WEN			;
reg		[31:0]	r_RAM_DATA			;
reg		[31:0]	r_RAM_ADDR			;

always @ (negedge i_HRESETn or posedge i_PCLK) 
	if(!i_HRESETn)							r_RAM_SW_MODE	<= #1 1'b0				;
	else if(w_addr03C_wr)						r_RAM_SW_MODE	<= #1 i_PWDATA[0]		;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)							r_RAM_CS		<= #1 {25{1'h0}};
	else if(w_addr040_wr)						r_RAM_CS		<= #1 i_PWDATA[24:0];

always @(negedge i_HRESETn or posedge i_PCLK)
	if (!i_HRESETn)							r_RAM_WEN		<= #1 1;
	else if (w_addr048_wr && r_RAM_SW_MODE)				r_RAM_WEN 		<= #1 0; 
	else								r_RAM_WEN 		<= #1 1;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)							r_RAM_DATA		<= #1 0;
	else if(w_addr048_wr)						r_RAM_DATA 		<= #1 i_PWDATA;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)							r_RAM_ADDR		<= #1 0;
	else if(w_addr04C_wr)						r_RAM_ADDR		<= #1 i_PWDATA;

assign	o_RAM_SW_MODE       = r_RAM_SW_MODE;
assign	o_RAM_CSN          = { {5{1'h1}}, ~r_RAM_CS };
assign	o_RAM_WEN           = r_RAM_WEN;
assign	o_RAM_ADDR          = r_RAM_ADDR;
assign	o_RAM_DATA          = r_RAM_DATA;

// -----------------------------------------------------------------------------------
//	BS
// -----------------------------------------------------------------------------------
assign			o_RX_BLK_SIZE_X  = `BW_DRX_600x600;//272; //Block Size  // todo check
assign			o_RX_BLK_SIZE_Y  = `BH_DRX_600x600;//136; //Block Size
assign			o_RX_DWL = `DWL_DRX_600x600;//8; //Block Size
assign			o_RX_DHU = `DHU_DRX_600x600;//8; //Block Size  

reg		[15:0]	r_BNY_600;
reg		[15:0]	r_BNY_300;
reg		[15:0]	r_BNY_450;

wire		[15:0]	w_RX_YD_600_CEIL;
wire		[15:0]	w_RX_YD_300_CEIL;

assign			w_RX_YD_600_CEIL = r_RX_YD + p_BH_600_m1;
assign			w_RX_YD_300_CEIL = r_RX_YD + p_BH_300_m1;

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)			r_BNY_600 <= #1 0; 
	else				r_BNY_600 <= #1 w_RX_YD_600_CEIL[15:7]; //(r_RX_YD + p_BH_600 - 1) / p_BH_600; 


always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)			r_BNY_300 <= #1 0; 
	else				r_BNY_300 <= #1  w_RX_YD_300_CEIL[15:6];//(r_RX_YD + p_BH_300 - 1) / p_BH_300;	 

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)			r_BNY_450 <= #1 0; 
	else				r_BNY_450 <= #1 (r_RX_YD + p_BH_450 - 1) / p_BH_450;			 

assign  w_BNY =  
				(RX_DPI_MODE_RC == p_600x600)	?	r_BNY_600 	:	 
				(RX_DPI_MODE_RC == p_600x300)	?	r_BNY_300	:	 
				(RX_DPI_MODE_RC == p_600x450)	?	r_BNY_450	:	 
				(RX_DPI_MODE_RC == p_300x600)	?	r_BNY_600	:	 
				(RX_DPI_MODE_RC == p_300x450)	?	r_BNY_450	:	 
									r_BNY_300	;


wire	[15:0]	w_RC1_XD_600_CEIL ;
assign			w_RC1_XD_600_CEIL = r_RC1_XD + p_BW_600_m1;

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)			r_BNX <= #1 0; 
	else				r_BNX <= #1 w_RC1_XD_600_CEIL[15:8]; 
end

wire	[7:0]	w_BNY_CLIP;

assign	w_BNY_CLIP = (w_BNY[15:8] != 0) ? 8'hFF: w_BNY[7:0];



always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)			r_BNY <= #1 0; 
	else				r_BNY <= #1 w_BNY_CLIP; 
end


always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)			r_RC1_YD_ALIGNED <= #1 0; 
	//else				r_RC1_YD_ALIGNED <= #1 r_BNY * p_BH_600; 
	else				r_RC1_YD_ALIGNED <= #1 {r_BNY,7'h0}; // * p_BH_600; 
end
always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)			r_RC1_XD_ALIGNED <= #1 0; 
	//else				r_RC1_XD_ALIGNED <= #1 r_BNX * p_BW_600; 
	else				r_RC1_XD_ALIGNED <= #1 {r_BNX, 8'h0}; // * p_BW_600; 
end

assign	w_RC1_LAST_BAND_HEIGHT = (r_RC1_YD[6:0] == 0) ? 8'd128 : {1'h0, r_RC1_YD[6:0]};

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)			r_RC1_LAST_BAND_HEIGHT <= #1 0; 
	else				r_RC1_LAST_BAND_HEIGHT <= #1 w_RC1_LAST_BAND_HEIGHT; 
end


assign  o_ACS_LAST_BAND_HEIGHT = r_RC1_LAST_BAND_HEIGHT;
assign  o_BLANK_LAST_BAND_HEIGHT = r_RC1_LAST_BAND_HEIGHT;

// -----------------------------------------------------------------------------------
//	2) VSD
// -----------------------------------------------------------------------------------
reg		[30:0]		r_vsd_reg_a		;
reg		[31:0]		r_vsd_reg_b		;
reg		[31:0]		r_vsd_reg_c		;
reg		[30:0]		r_vsd_reg_d		;
reg		[31:0]		r_vsd_reg_e		;
reg		[30:0]		r_vsd_reg_f		;
reg		[15:0]		r_vsd_reg_g		;
reg		[16:0]		r_vsd_reg_h		;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_vsd_reg_a	   		<= #1 31'h0;
	else if(w_addr480_wr)	r_vsd_reg_a	   		<= #1 i_PWDATA[30:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_vsd_reg_b	   		<= #1 32'h108;
	else if(w_addr484_wr)	r_vsd_reg_b	   		<= #1 i_PWDATA	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_vsd_reg_c	   		<= #1 32'h0E0F_032A;
	else if(w_addr488_wr)	r_vsd_reg_c	   		<= #1 i_PWDATA	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_vsd_reg_d	   		<= #1 31'h0F03_0821;
	else if(w_addr48C_wr)	r_vsd_reg_d	   		<= #1 i_PWDATA[30:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_vsd_reg_e	   		<= #1 32'h0142_800B;
	else if(w_addr490_wr)	r_vsd_reg_e	   		<= #1 i_PWDATA	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_vsd_reg_f	   		<= #1 32'h230D_111A		;
	else if(w_addr494_wr)	r_vsd_reg_f	   		<= #1 i_PWDATA[30:0];

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)		r_vsd_reg_g	   		<= #1 16'h46A8		;
	else if(w_addr498_wr)	r_vsd_reg_g	   		<= #1 i_PWDATA[15:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)		r_vsd_reg_h	   		<= #1 17'h0		;
	else if(w_addr49C_wr)	r_vsd_reg_h	   		<= #1 i_PWDATA[16:0]	;

assign		o_VSD_CUR_MEM_INIT		= r_vsd_reg_a[30]				;
//assign		o_VSC_REF_MEM_INIT		= r_vsd_reg_a[29]				;
//assign		o_VSC_CORR_EN			= r_vsd_reg_a[28]				;
//assign		o_VSC_STUCK_DET_EN		= r_vsd_reg_a[24]				;
//assign		o_VSC_STUCK_DET_TH		= r_vsd_reg_a[23:16]			;
assign		o_VSD_DEBUG			= r_vsd_reg_a[13:12]			;
//assign		o_VSC_INDEX			= r_vsd_reg_a[ 9: 8]			;
//assign		o_VSC_DEPTH_TH			= r_vsd_reg_a[ 7: 0]			;
//assign		o_VSC_EDGE_TH			= r_vsd_reg_b[31:24]			;
//assign		o_VSC_THICKNESS_TH		= r_vsd_reg_b[23:16]			;
assign		o_VSD_TOP_BAND			= r_vsd_reg_b[11: 8]			;
assign		o_VSD_K_DEPTH_MIN		= r_vsd_reg_b[ 7: 0]			;

assign		o_VSD_K_DEPTH_MID		= r_vsd_reg_c[31:24]			;
assign		o_VSD_K_DEPTH_MAX		= r_vsd_reg_c[23:16]			;
assign		o_VSD_K_DEPTH_MIN_TOP	= r_vsd_reg_c[15: 8]			;
assign		o_VSD_K_DEPTH_MAX_TOP	= r_vsd_reg_c[ 7: 0]			;

assign		o_VSD_K_DEPTH_COND		= r_vsd_reg_d[30:24]			;
assign		o_VSD_W_DEPTH_MIN		= r_vsd_reg_d[23:16]			;
assign		o_VSD_W_DEPTH_MID		= r_vsd_reg_d[15: 8]			;
assign		o_VSD_W_DEPTH_MAX		= r_vsd_reg_d[ 7: 0]			;

assign		o_VSD_W_DEPTH_MIN_TOP	= r_vsd_reg_e[31:24]			;
assign		o_VSD_W_DEPTH_MAX_TOP	= r_vsd_reg_e[23:16]			;
assign		o_VSD_W_DEPTH_COND		= r_vsd_reg_e[15: 8]			;
assign		o_VSD_THICKNESS_TH		= r_vsd_reg_e[ 7: 0]			;

assign		o_VSD_CHROMA_TH1		= r_vsd_reg_f[30:24]			;
assign		o_VSD_CHROMA_TH2		= r_vsd_reg_f[22:16]			;
assign		o_VSD_CHROMA_TH1_TOP	= r_vsd_reg_f[14: 8]			;
assign		o_VSD_CHROMA_TH2_TOP	= r_vsd_reg_f[ 6: 0]			;


assign		o_VSD_CONTINUITY_TH		= r_vsd_reg_g[15: 8]			;
assign		o_VSD_FREQUENCY_TH		= r_vsd_reg_g[ 7: 0]			;

assign		o_VSD_REFINE_EN		= r_vsd_reg_h[16]			;
assign		o_VSD_REFINE_TH		= r_vsd_reg_h[12: 0]			;
// -----------------------------------------------------------------------------------
//	4) CIS_INTP
// -----------------------------------------------------------------------------------
reg	[ 8:0]	o_CIS_SUB_COEF_R2;
reg	[ 8:0]	o_CIS_SUB_COEF_R1;
reg	[ 8:0]	o_CIS_SUB_COEF_G2;
reg	[ 8:0]	o_CIS_SUB_COEF_G1;
reg	[ 8:0]	o_CIS_SUB_COEF_G0;
reg	[ 8:0]	o_CIS_SUB_COEF_B1;
reg	[ 8:0]	o_CIS_SUB_COEF_B0;

`IPR_SFR_SET(o_CIS_SUB_COEF_R2				, w_addr4C0_wr		, 9'h0AC			, i_PWDATA[20:12])
`IPR_SFR_SET(o_CIS_SUB_COEF_R1				, w_addr4C0_wr		, 9'h154			, i_PWDATA[ 8: 0])

`IPR_SFR_SET(o_CIS_SUB_COEF_G2				, w_addr4C4_wr		, 9'h054			, i_PWDATA[26:18])
`IPR_SFR_SET(o_CIS_SUB_COEF_G1				, w_addr4C4_wr		, 9'h158			, i_PWDATA[17: 9])
`IPR_SFR_SET(o_CIS_SUB_COEF_G0				, w_addr4C4_wr		, 9'h054			, i_PWDATA[ 8: 0])

`IPR_SFR_SET(o_CIS_SUB_COEF_B1				, w_addr4C8_wr		, 9'h154			, i_PWDATA[20:12])
`IPR_SFR_SET(o_CIS_SUB_COEF_B0				, w_addr4C8_wr		, 9'h0AC			, i_PWDATA[ 8: 0])


// -----------------------------------------------------------------------------------
//	5) RC1	
// -----------------------------------------------------------------------------------
reg	[31:0]	o_RC1_SHIFT_VAL						;
reg	[31:0]	o_RC1_SHIFT_OFST					;
reg	[ 2:0]	o_RC1_LOOP_X	,o_RC1_LOOP_Y		;
reg	[11:0]	o_RC1_X_COF_00	,o_RC1_X_COF_03		;
reg	[11:0]	o_RC1_X_COF_10	,o_RC1_X_COF_13		;
reg	[11:0]	o_RC1_X_COF_20	,o_RC1_X_COF_23		;
reg	[11:0]	o_RC1_X_COF_30	,o_RC1_X_COF_33		;
reg	[11:0]	o_RC1_X_COF_01	,o_RC1_X_COF_02		;
reg	[11:0]	o_RC1_X_COF_11	,o_RC1_X_COF_12		;
reg	[11:0]	o_RC1_X_COF_21	,o_RC1_X_COF_22		;
reg	[11:0]	o_RC1_X_COF_31	,o_RC1_X_COF_32		;
reg	[11:0]	o_RC1_Y_COF_00	,o_RC1_Y_COF_03		;
reg	[11:0]	o_RC1_Y_COF_10	,o_RC1_Y_COF_13		;
reg	[11:0]	o_RC1_Y_COF_20	,o_RC1_Y_COF_23		;
reg	[11:0]	o_RC1_Y_COF_30	,o_RC1_Y_COF_33		;
reg	[11:0]	o_RC1_Y_COF_01	,o_RC1_Y_COF_02		;
reg	[11:0]	o_RC1_Y_COF_11	,o_RC1_Y_COF_12		;
reg	[11:0]	o_RC1_Y_COF_21	,o_RC1_Y_COF_22		;
reg	[11:0]	o_RC1_Y_COF_31	,o_RC1_Y_COF_32		;

`IPR_SFR_SET(o_RC1_SHIFT_VAL				, w_addr500_wr		, 32'h0000_0000	, i_PWDATA[31: 0])

`IPR_SFR_SET(o_RC1_SHIFT_OFST				, w_addr504_wr		, 32'h0000_0000	, i_PWDATA[31: 0])
                                                    
`IPR_SFR_SET(o_RC1_LOOP_X					, w_addr508_wr		, 3'h0				, i_PWDATA[18:16])
`IPR_SFR_SET(o_RC1_LOOP_Y					, w_addr508_wr		, 3'h0				, i_PWDATA[ 2: 0])
                                                      
`IPR_SFR_SET(o_RC1_X_COF_00					, w_addr510_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_X_COF_01					, w_addr510_wr		, 12'h000			, i_PWDATA[11: 0])

`IPR_SFR_SET(o_RC1_X_COF_02					, w_addr514_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_X_COF_03					, w_addr514_wr		, 12'h000			, i_PWDATA[11: 0])

`IPR_SFR_SET(o_RC1_X_COF_10					, w_addr518_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_X_COF_11					, w_addr518_wr		, 12'h000			, i_PWDATA[11: 0])

`IPR_SFR_SET(o_RC1_X_COF_12					, w_addr51C_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_X_COF_13					, w_addr51C_wr		, 12'h000			, i_PWDATA[11: 0])

`IPR_SFR_SET(o_RC1_X_COF_20					, w_addr520_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_X_COF_21					, w_addr520_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_X_COF_22					, w_addr524_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_X_COF_23					, w_addr524_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_X_COF_30					, w_addr528_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_X_COF_31					, w_addr528_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_X_COF_32					, w_addr52C_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_X_COF_33					, w_addr52C_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_Y_COF_00					, w_addr530_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_Y_COF_01					, w_addr530_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_Y_COF_02					, w_addr534_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_Y_COF_03					, w_addr534_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_Y_COF_10					, w_addr538_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_Y_COF_11					, w_addr538_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_Y_COF_12					, w_addr53C_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_Y_COF_13					, w_addr53C_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_Y_COF_20					, w_addr540_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_Y_COF_21					, w_addr540_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_Y_COF_22					, w_addr544_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_Y_COF_23					, w_addr544_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_Y_COF_30					, w_addr548_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_Y_COF_31					, w_addr548_wr		, 12'h000			, i_PWDATA[11: 0])
`IPR_SFR_SET(o_RC1_Y_COF_32					, w_addr54C_wr		, 12'h000			, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC1_Y_COF_33					, w_addr54C_wr		, 12'h000			, i_PWDATA[11: 0])

// -----------------------------------------------------------------------------------
//	6) S1D
// -----------------------------------------------------------------------------------
// None


// -----------------------------------------------------------------------------------
// 8) SEG1
// -----------------------------------------------------------------------------------
reg	[7:0]	o_SEG1_HVline_diff_th;
reg	[7:0]	o_SEG1_HVline_minmaxdiff_th1;
reg	[7:0]	o_SEG1_HVline_minmaxdiff_th2; 
reg	[7:0]	o_SEG1_HVline_level_th;
reg	[7:0]	o_SEG1_Lowfreq_th; 
reg	[7:0]	o_SEG1_Lowfreq_th2; 
reg	[7:0]	o_SEG1_Highfreq_th; 
reg	[7:0]	o_SEG1_Uni_lowfreq_th;
reg	[7:0]	o_SEG1_Uni_highfreq_th; 
reg	[7:0]	o_SEG1_Uni_edge_th;
reg	[7:0]	o_SEG1_Uni_edge_th2;
reg	[7:0]	o_SEG1_ZC_edge_th;
reg	[2:0]	o_SEG1_ZC_scaling_shift;
reg	[7:0]	o_SEG1_White_th;
reg		o_SEG1_Enable_Y_text;


`IPR_SFR_SET(o_SEG1_Enable_Y_text			 , w_addr580_wr		, 1'h0		, i_PWDATA[4]    )

`IPR_SFR_SET(o_SEG1_HVline_diff_th        		 , w_addr584_wr		, 8'h14		, i_PWDATA[31:24])
`IPR_SFR_SET(o_SEG1_HVline_minmaxdiff_th1 		 , w_addr584_wr		, 8'h0A		, i_PWDATA[23:16])
`IPR_SFR_SET(o_SEG1_HVline_minmaxdiff_th2 		 , w_addr584_wr		, 8'h3C		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_SEG1_HVline_level_th      		 , w_addr584_wr		, 8'hBE		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_SEG1_Lowfreq_th				, w_addr588_wr		, 8'h32		, i_PWDATA[23:16])
`IPR_SFR_SET(o_SEG1_Lowfreq_th2				, w_addr588_wr		, 8'h14		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_SEG1_Highfreq_th				, w_addr588_wr		, 8'h32		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_SEG1_Uni_highfreq_th			, w_addr58C_wr		, 8'h14		, i_PWDATA[31:24])
`IPR_SFR_SET(o_SEG1_Uni_lowfreq_th  			 , w_addr58C_wr		, 8'h0A		, i_PWDATA[23:16])
`IPR_SFR_SET(o_SEG1_Uni_edge_th2    			 , w_addr58C_wr		, 8'h50		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_SEG1_Uni_edge_th     			 , w_addr58C_wr		, 8'h1E		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_SEG1_White_th        			 , w_addr590_wr		, 8'hD2		, i_PWDATA[23:16])
`IPR_SFR_SET(o_SEG1_ZC_edge_th      			 , w_addr590_wr		, 8'h0A		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_SEG1_ZC_scaling_shift			 , w_addr590_wr		, 3'h5		, i_PWDATA[ 2: 0])
// -----------------------------------------------------------------------------------
//	SCC
// -----------------------------------------------------------------------------------
reg		o_SCC_LATTICE_STEP					; // (0:17x17x17)(1: 9x9x9)
reg	[ 1:0]	o_SCC_FLOATING_MODE					;

`IPR_SFR_SET(o_SCC_FLOATING_MODE			, w_addr5C0_wr		, 2'h1		, i_PWDATA[ 5: 4])
`IPR_SFR_SET(o_SCC_LATTICE_STEP				, w_addr5C0_wr		, 1'h0		, i_PWDATA[    0])

// -----------------------------------------------------------------------------------
//	SEG2
// -----------------------------------------------------------------------------------
reg		o_SEG2_Enable_uniformtext, o_SEG2_Enable_FAR_9x9, o_SEG2_Enable_contoneImage;
reg	[7:0]	o_SEG2_FG_level_th;
reg	[1:0]	o_SEG2_text_index;
reg	[6:0]	o_SEG2_edgecnt_th, o_SEG2_halftonecnt_th, o_SEG2_uniformlinecnt_th, o_SEG2_zccnt_th, o_SEG2_bgcnt_th;
reg	[7:0]	o_SEG2_Neut_chroma_th;
reg	[3:0]	o_SEG2_Neut_chroma_th2_shiftcoef;
reg	[7:0]	o_SEG2_FAR_chroma_th, o_SEG2_FAR_Y_th;
reg	[3:0]	o_SEG2_FAR_chroma_th2_shiftcoef, o_SEG2_FAR_Y_th2_shiftcoef1, o_SEG2_FAR_Y_th3_shiftcoef2;


`IPR_SFR_SET(o_SEG2_Enable_contoneImage			, w_addr600_wr		, 1'h0		, i_PWDATA[4])
`IPR_SFR_SET(o_SEG2_Enable_uniformtext			, w_addr600_wr		, 1'h0		, i_PWDATA[1])
`IPR_SFR_SET(o_SEG2_Enable_FAR_9x9				, w_addr600_wr		, 1'h0		, i_PWDATA[0])

`IPR_SFR_SET(o_SEG2_FG_level_th					, w_addr604_wr		, 8'h96		, i_PWDATA[23:16])
`IPR_SFR_SET(o_SEG2_text_index					, w_addr604_wr		, 2'h2		, i_PWDATA[ 9: 8])
`IPR_SFR_SET(o_SEG2_edgecnt_th					, w_addr604_wr		, 7'h3		, i_PWDATA[ 6: 0])

`IPR_SFR_SET(o_SEG2_bgcnt_th					, w_addr608_wr		, 7'h3		, i_PWDATA[30:24])
`IPR_SFR_SET(o_SEG2_halftonecnt_th				, w_addr608_wr		, 7'h3		, i_PWDATA[22:16])
`IPR_SFR_SET(o_SEG2_uniformlinecnt_th			, w_addr608_wr		, 7'h3		, i_PWDATA[14: 8])
`IPR_SFR_SET(o_SEG2_zccnt_th					, w_addr608_wr		, 7'h3		, i_PWDATA[ 6: 0])

`IPR_SFR_SET(o_SEG2_FAR_chroma_th           	, w_addr60C_wr		, 8'hA		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_SEG2_FAR_chroma_th2_shiftcoef	, w_addr60C_wr		, 4'h3		, i_PWDATA[ 3: 0])

`IPR_SFR_SET(o_SEG2_FAR_Y_th					, w_addr610_wr		, 8'hAA		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_SEG2_FAR_Y_th2_shiftcoef1		, w_addr610_wr		, 4'h06		, i_PWDATA[ 7: 4])
`IPR_SFR_SET(o_SEG2_FAR_Y_th3_shiftcoef2		, w_addr610_wr		, 4'h03		, i_PWDATA[ 3: 0])

`IPR_SFR_SET(o_SEG2_Neut_chroma_th				, w_addr614_wr		, 8'h7		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_SEG2_Neut_chroma_th2_shiftcoef	, w_addr614_wr		, 4'h3		, i_PWDATA[ 3: 0])
//---------------------------------------------------------------
// ORIENTATION
//---------------------------------------------------------------
reg				o_ORI_PAGE_EN;
//reg		[13:0]	o_ORI_WIDTH;
//reg		[13:0]  o_ORI_HEIGHT;
reg		[5:0]	o_ORI_BLOCK_SIZE_W;
reg		[6:0]	o_ORI_BLOCK_SIZE_H;
reg		[13:0]	o_ORI_AREA_SIZE_W;
reg		[13:0]	o_ORI_AREA_SIZE_H;
reg		[7:0]	o_ORI_CHAR_LENGTH_MIN_V; 
reg		[7:0]	o_ORI_CHAR_THICK_MIN_V; 
reg		[7:0]	o_ORI_CHAR_THICK_MAX_V;
reg		[7:0]	o_ORI_CHAR_LENGTH_MIN_H; 
reg		[7:0]	o_ORI_CHAR_THICK_MIN_H;
reg		[7:0]	o_ORI_CHAR_THICK_MAX_H;
reg		[3:0]	o_ORI_DIFF_SHIFT1_V;
reg		[3:0]	o_ORI_DIFF_SHIFT2_V;
reg		[6:0]	o_ORI_CHANGE_RATIO_TH_V;
reg		[6:0]	o_ORI_CHANGE_CNT_TH_V;
reg		[3:0]	o_ORI_DIFF_SHIFT1_H;
reg		[3:0]	o_ORI_DIFF_SHIFT2_H;
reg		[6:0]	o_ORI_CHANGE_RATIO_TH_H;
reg		[6:0]	o_ORI_CHANGE_CNT_TH_H;
reg		[7:0]	o_ORI_DIR_MIN_TH;
reg		[7:0]	o_ORI_DIR_MAX_TH;
reg		[7:0]	o_ORI_DIR_TH;
reg		[7:0]	o_ORI_DIR_MAX_LOW_TH;
reg		[7:0]	o_ORI_DIR_MAX_HIGH_TH;
reg		[7:0]	o_ORI_DIR_DIFF_TH1;
reg		[7:0]   o_ORI_DIR_DIFF_TH2;
reg		[7:0]	o_ORI_DIR_DIFF_TH3;
reg		[10:0]	o_ORI_AREA_OFFSET_H;
reg		[10:0]	o_ORI_AREA_OFFSET_W;
reg		[10:0]	o_ORI_AREA_OFFSET;
reg		[7:0]	o_ORI_LINE_SPACE_H;
reg		[7:0]	o_ORI_LINE_SPACE_V;

`IPR_SFR_SET(o_ORI_PAGE_EN				, w_addr7C0_wr	, 1'h0		, i_PWDATA[0])

`IPR_SFR_SET(o_ORI_BLOCK_SIZE_W			, w_addr7C4_wr	, 6'h4		, i_PWDATA[13: 8])
`IPR_SFR_SET(o_ORI_BLOCK_SIZE_H			, w_addr7C4_wr	, 7'h9		, i_PWDATA[ 6: 0])

`IPR_SFR_SET(o_ORI_AREA_SIZE_W			, w_addr7C8_wr	, 14'h3E8	, i_PWDATA[29:16])
`IPR_SFR_SET(o_ORI_AREA_SIZE_H			, w_addr7C8_wr	, 14'h3E8	, i_PWDATA[13: 0])

`IPR_SFR_SET(o_ORI_CHAR_LENGTH_MIN_V	, w_addr7CC_wr	, 8'h3C		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ORI_CHAR_THICK_MIN_V		, w_addr7CC_wr	, 8'h7		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ORI_CHAR_THICK_MAX_V		, w_addr7CC_wr	, 8'h50		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ORI_CHAR_LENGTH_MIN_H	, w_addr7D0_wr	, 8'h3C		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ORI_CHAR_THICK_MIN_H		, w_addr7D0_wr	, 8'h7		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ORI_CHAR_THICK_MAX_H		, w_addr7D0_wr	, 8'h50		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ORI_DIFF_SHIFT1_V		, w_addr7D4_wr	, 4'h1		, i_PWDATA[27:24])
`IPR_SFR_SET(o_ORI_DIFF_SHIFT2_V		, w_addr7D4_wr	, 4'h4		, i_PWDATA[19:16])
`IPR_SFR_SET(o_ORI_CHANGE_RATIO_TH_V	, w_addr7D4_wr	, 7'h7		, i_PWDATA[14: 8])
`IPR_SFR_SET(o_ORI_CHANGE_CNT_TH_V		, w_addr7D4_wr	, 7'h50		, i_PWDATA[ 6: 0])

`IPR_SFR_SET(o_ORI_DIFF_SHIFT1_H		, w_addr7D8_wr	, 4'h1		, i_PWDATA[27:24])
`IPR_SFR_SET(o_ORI_DIFF_SHIFT2_H		, w_addr7D8_wr	, 4'h4		, i_PWDATA[19:16])
`IPR_SFR_SET(o_ORI_CHANGE_RATIO_TH_H	, w_addr7D8_wr	, 7'h7		, i_PWDATA[14: 8])
`IPR_SFR_SET(o_ORI_CHANGE_CNT_TH_H		, w_addr7D8_wr	, 7'h50		, i_PWDATA[ 6: 0])

`IPR_SFR_SET(o_ORI_DIR_MIN_TH			, w_addr7DC_wr	, 8'h6		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ORI_DIR_MAX_TH			, w_addr7DC_wr	, 8'h6		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ORI_DIR_TH				, w_addr7DC_wr	, 8'h5		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ORI_DIR_MAX_LOW_TH		, w_addr7DC_wr	, 8'h14		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ORI_DIR_MAX_HIGH_TH		, w_addr7E0_wr	, 8'h28 	, i_PWDATA[31:24])
`IPR_SFR_SET(o_ORI_DIR_DIFF_TH1			, w_addr7E0_wr	, 8'h5   	, i_PWDATA[23:16])
`IPR_SFR_SET(o_ORI_DIR_DIFF_TH2		  	, w_addr7E0_wr	, 8'h7	 	, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ORI_DIR_DIFF_TH3			, w_addr7E0_wr	, 8'hA		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ORI_AREA_OFFSET_H	 	, w_addr7E4_wr	, 11'h400 	, i_PWDATA[26:16])
`IPR_SFR_SET(o_ORI_AREA_OFFSET_W		, w_addr7E4_wr	, 11'h400	, i_PWDATA[10: 0])

`IPR_SFR_SET(o_ORI_AREA_OFFSET			, w_addr7E8_wr	, 11'h400	, i_PWDATA[10: 0])

`IPR_SFR_SET(o_ORI_LINE_SPACE_H			, w_addr7EC_wr	, 8'h6	 	, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ORI_LINE_SPACE_V			, w_addr7EC_wr	, 8'h6		, i_PWDATA[ 7: 0])

assign	o_ORI_WIDTH  = r_RC1_XD_ALIGNED;
assign	o_ORI_HEIGHT = r_RC1_YD_ALIGNED;


//*************************************************************************************
// SFR Set
//*************************************************************************************
// -----------------------------------------------------------------------------------
// CLA
// -----------------------------------------------------------------------------------
reg	[7:0]	o_CLA_HLcount_diffth2;
reg	[7:0]	o_CLA_HLcount_diffth1;
reg	[7:0]	o_CLA_HLcount_maxth2;
reg	[7:0]	o_CLA_HLcount_maxth1;
reg	[7:0]	o_CLA_HLgray_diffth;
reg	[10:0]	o_CLA_ContentsSizeTh;

`IPR_SFR_SET(o_CLA_HLcount_diffth2	 , w_addr900_wr		, 8'h0		, i_PWDATA[31:24])
`IPR_SFR_SET(o_CLA_HLcount_diffth1	 , w_addr900_wr		, 8'h0		, i_PWDATA[23:16])
`IPR_SFR_SET(o_CLA_HLcount_maxth2	 , w_addr900_wr		, 8'h0		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_CLA_HLcount_maxth1	 , w_addr900_wr		, 8'h0		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_CLA_ContentsSizeTh	 , w_addr904_wr		, 11'h0		, i_PWDATA[18: 8])
`IPR_SFR_SET(o_CLA_HLgray_diffth	 , w_addr904_wr		, 8'h0		, i_PWDATA[ 7: 0])

assign	o_CLA_WIDTH  = r_RC1_XD_ALIGNED;
assign	o_CLA_HEIGHT = r_RC1_YD_ALIGNED;


// -----------------------------------------------------------------------------------
// ACBD
// -----------------------------------------------------------------------------------
reg		[15:0]	o_ACBD_TOP_MARGIN				;
reg		[15:0]	o_ACBD_BOTTOM_MARGIN			;
reg		[15:0]	o_ACBD_LEFT_MARGIN			;
reg		[15:0]	o_ACBD_RIGHT_MARGIN			;
reg		[ 9:0] 	o_ACBD_LOW_THRESHOLD_MIN1		;
reg		[ 9:0]	o_ACBD_HIGH_THRESHOLD_MAX1	;
reg		[ 9:0] 	o_ACBD_LOW_THRESHOLD_MIN2		;
reg		[ 9:0]	o_ACBD_HIGH_THRESHOLD_MAX2	;
reg			o_ACBD_HIGHLIGHT_SELECT_EN	;
reg		[ 7:0]	o_ACBD_AVG_THRESHOLD			;
reg		[ 7:0]	o_ACBD_HISTCB_VAL_LOW			;
reg		[ 7:0]	o_ACBD_HISTCB_VAL_HIGH		;
reg		[ 7:0]	o_ACBD_HISTCR_VAL_LOW			;
reg		[ 7:0]	o_ACBD_HISTCR_VAL_HIGH		;
reg		[ 9:0]	o_ACBD_CB_RATION_THRESHOLD	;
reg		[ 9:0]	o_ACBD_CR_RATION_THRESHOLD	;
reg		[ 7:0]	o_ACBD_MIN_LIMIT_THRESHOLD	;
reg		[ 7:0]	o_ACBD_MAX_LIMIT_THRESHOLD	;
reg			o_ACBD_BRIGHTNESS_EN			;
reg		[ 7:0]	o_ACBD_BRIGHTNESS_THRESHOLD	;
reg		[ 7:0]	o_ACBD_STRETCHING_OFFSET		;
reg		[ 5:0]	o_ACBD_ACB_GRAY_RIDGE_TH			;		//add 17.08.18
reg		[ 7:0]	o_ACBD_ACB_LEFT_LIMIT			;		//add 17.08.18
reg		[ 7:0]	o_ACBD_ACB_RIGHT_LIMIT			;		//add 17.08.18
reg		[ 9:0]	o_ACBD_ACB_PEAK_RATIO_TH			;		//add 17.08.18
reg		[ 7:0]	o_ACBD_OBJ_INDEX_TH				;		//add 17.08.18
reg		[ 3:0]	o_ACBD_OBJ_AREA_TH				;		//add 17.08.18
reg			o_ACBD_ACS_REF_ON				;		//add 17.08.18


`IPR_SFR_SET(o_ACBD_TOP_MARGIN		, w_addr980_wr		, 16'h0		, i_PWDATA[31:16])
`IPR_SFR_SET(o_ACBD_BOTTOM_MARGIN	 , w_addr980_wr		, 16'h0		, i_PWDATA[15: 0])

`IPR_SFR_SET(o_ACBD_LEFT_MARGIN	 , w_addr984_wr		, 16'h0		, i_PWDATA[31:16])
`IPR_SFR_SET(o_ACBD_RIGHT_MARGIN	 , w_addr984_wr		, 16'h0		, i_PWDATA[15: 0])

`IPR_SFR_SET(o_ACBD_LOW_THRESHOLD_MIN1	 , w_addr988_wr		, 10'h1		, i_PWDATA[25:16])
`IPR_SFR_SET(o_ACBD_HIGH_THRESHOLD_MAX1	 , w_addr988_wr		, 10'h1		, i_PWDATA[ 9: 0])

`IPR_SFR_SET(o_ACBD_LOW_THRESHOLD_MIN2	 , w_addr98C_wr		, 10'h1		, i_PWDATA[25:16])
`IPR_SFR_SET(o_ACBD_HIGH_THRESHOLD_MAX2	 , w_addr98C_wr		, 10'h1		, i_PWDATA[ 9: 0])

`IPR_SFR_SET(o_ACBD_HIGHLIGHT_SELECT_EN	 , w_addr990_wr		, 1'h0		, i_PWDATA[0])

`IPR_SFR_SET(o_ACBD_AVG_THRESHOLD		 , w_addr994_wr		, 8'h0		, i_PWDATA[7:0])

`IPR_SFR_SET(o_ACBD_HISTCB_VAL_LOW			 , w_addr998_wr		, 8'h0		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACBD_HISTCB_VAL_HIGH		 , w_addr998_wr		, 8'h0		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACBD_HISTCR_VAL_LOW			 , w_addr998_wr		, 8'h0		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACBD_HISTCR_VAL_HIGH		 , w_addr998_wr		, 8'h0		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACBD_CB_RATION_THRESHOLD	 , w_addr99C_wr		, 10'h1		, i_PWDATA[26:16])
`IPR_SFR_SET(o_ACBD_CR_RATION_THRESHOLD	 , w_addr99C_wr		, 10'h1		, i_PWDATA[ 9: 0])

`IPR_SFR_SET(o_ACBD_MIN_LIMIT_THRESHOLD		 , w_addr9A0_wr		, 8'h0		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACBD_MAX_LIMIT_THRESHOLD		 , w_addr9A0_wr		, 8'h0		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACBD_BRIGHTNESS_EN				 , w_addr9A4_wr		, 1'h0		, i_PWDATA[16])
`IPR_SFR_SET(o_ACBD_BRIGHTNESS_THRESHOLD		 , w_addr9A4_wr		, 8'h0		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACBD_STRETCHING_OFFSET			 , w_addr9A4_wr		, 8'h0		, i_PWDATA[ 7: 0])


`IPR_SFR_SET(o_ACBD_ACB_PEAK_RATIO_TH	 , w_addr9A8_wr		, 10'h1		, i_PWDATA[17:8])
`IPR_SFR_SET(o_ACBD_ACB_GRAY_RIDGE_TH		 , w_addr9A8_wr		,  6'h0		, i_PWDATA[ 5:0])

`IPR_SFR_SET(o_ACBD_ACB_LEFT_LIMIT	 , w_addr9AC_wr		, 8'h0	, i_PWDATA[15:8])
`IPR_SFR_SET(o_ACBD_ACB_RIGHT_LIMIT	 , w_addr9AC_wr		, 8'h0	, i_PWDATA[ 7:0])

`IPR_SFR_SET(o_ACBD_OBJ_INDEX_TH  , w_addr9B0_wr	, 8'h0	, i_PWDATA[15:8])
`IPR_SFR_SET(o_ACBD_OBJ_AREA_TH	 , w_addr9B0_wr		, 4'h0	, i_PWDATA[ 3:0])

`IPR_SFR_SET(o_ACBD_ACS_REF_ON	 , w_addr9BC_wr		, 1'h0	, i_PWDATA[ 0])

// -----------------------------------------------------------------------------------
//	ABSD
// -----------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)		r_magd_pre_scan_line					<= #1 14'h78				;
	else if(w_addr880_wr)	r_magd_pre_scan_line					<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_magd_prescan_iwin					<= #1 30'h3e8_0fa0		;
	else if(w_addr884_wr)	r_magd_prescan_iwin					<= #1 i_PWDATA[29:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_magd_th							<= #1 17'h1_80ff		;
	else if(w_addr888_wr)	r_magd_th							<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_magd_valid_percentage				<= #1 7'h21				;
	else if(w_addr88C_wr)	r_magd_valid_percentage				<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_magd_bk_std_th						<= #1 8'h32				;
	else if(w_addr890_wr)	r_magd_bk_std_th						<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_magd_sigma							<= #1 22'h2_0444		;
	else if(w_addr894_wr)	r_magd_sigma							<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_magd_bg_backup						<= #1 12'h2d1			;
	else if(w_addr898_wr)	r_magd_bg_backup						<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_magd_color_exception				<= #1 24'h6c_9401		;
	else if(w_addr89C_wr)	r_magd_color_exception				<= #1 i_PWDATA			;

// Reserved
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)		r_MAGD_PRE_SCAN_START				<= 14'h78;
	else if(w_addr8A8_wr)	r_MAGD_PRE_SCAN_START				<= i_PWDATA[13:0];


assign		o_MAGD_PRE_SCAN_LINE			=	r_magd_pre_scan_line				;

assign		o_MAGD_IWIN_START				=	r_magd_prescan_iwin[29:16]		;
assign		o_MAGD_IWIN_END					=	r_magd_prescan_iwin[13: 0]		;

assign		o_MAGD_NOISE_REM				=	r_magd_th[16]					;
assign		o_MAGD_BLACK_TH					=	r_magd_th[15: 8]					;
assign		o_MAGD_WHITE_TH					=	r_magd_th[ 7: 0]					;

assign		o_MAGD_VALID_PERCENTAGE			=	r_magd_valid_percentage			;

assign		o_MAGD_BK_STD_TH				=	r_magd_bk_std_th					;

assign		o_MAGD_CONFID_SIGMA				=	r_magd_sigma[21:16]				;
assign		o_MAGD_DETECT_SIGMA				=	r_magd_sigma[13: 8]				;
assign		o_MAGD_PERCENTAGE				=	r_magd_sigma[ 6: 0]				;

assign		o_MAGD_BG_BACKUP_TH				=	r_magd_bg_backup[11:4]			;
assign		o_MAGD_BG_BACKUP_EN				=	r_magd_bg_backup[0]				;

assign		o_MAGD_COLOR_TH1				=	r_magd_color_exception[23:16]	;
assign		o_MAGD_COLOR_TH2				=	r_magd_color_exception[15: 8]	;
assign		o_MAGD_COLOR_EXCEPTION_EN		=	r_magd_color_exception[0]		;

assign		o_MAGD_PRE_SCAN_START			=	r_MAGD_PRE_SCAN_START			;


// -----------------------------------------------------------------------------------
//	ABSD
// -----------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)		r_abs_pre_scan_line					<= #1 14'h78				;
	else if(w_addr840_wr)	r_abs_pre_scan_line					<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_abs_prescan_iwin					<= #1 30'h3e8_0fa0		;
	else if(w_addr844_wr)	r_abs_prescan_iwin					<= #1 i_PWDATA[29:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_abs_th							<= #1 17'h1_80ff		;
	else if(w_addr848_wr)	r_abs_th							<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_abs_valid_percentage				<= #1 7'h21				;
	else if(w_addr84C_wr)	r_abs_valid_percentage				<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_abs_bk_std_th						<= #1 8'h32				;
	else if(w_addr850_wr)	r_abs_bk_std_th						<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_abs_sigma							<= #1 22'h2_0444		;
	else if(w_addr854_wr)	r_abs_sigma							<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_abs_bg_backup						<= #1 12'h2d1			;
	else if(w_addr858_wr)	r_abs_bg_backup						<= #1 i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_abs_color_exception				<= #1 24'h6c_9401		;
	else if(w_addr85C_wr)	r_abs_color_exception				<= #1 i_PWDATA			;

// Reserved
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)		r_ABSD_PRE_SCAN_START				<= 14'h78;
	else if(w_addr868_wr)	r_ABSD_PRE_SCAN_START				<= i_PWDATA[13:0];


assign		o_ABSD_PRE_SCAN_LINE			=	r_abs_pre_scan_line				;

assign		o_ABSD_IWIN_START				=	r_abs_prescan_iwin[29:16]		;
assign		o_ABSD_IWIN_END					=	r_abs_prescan_iwin[13: 0]		;

assign		o_ABSD_NOISE_REM				=	r_abs_th[16]					;
assign		o_ABSD_BLACK_TH					=	r_abs_th[15: 8]					;
assign		o_ABSD_WHITE_TH					=	r_abs_th[ 7: 0]					;

assign		o_ABSD_VALID_PERCENTAGE			=	r_abs_valid_percentage			;

assign		o_ABSD_BK_STD_TH				=	r_abs_bk_std_th					;

assign		o_ABSD_CONFID_SIGMA				=	r_abs_sigma[21:16]				;
assign		o_ABSD_DETECT_SIGMA				=	r_abs_sigma[13: 8]				;
assign		o_ABSD_PERCENTAGE				=	r_abs_sigma[ 6: 0]				;

assign		o_ABSD_BG_BACKUP_TH				=	r_abs_bg_backup[11:4]			;
assign		o_ABSD_BG_BACKUP_EN				=	r_abs_bg_backup[0]				;

assign		o_ABSD_COLOR_TH1				=	r_abs_color_exception[23:16]	;
assign		o_ABSD_COLOR_TH2				=	r_abs_color_exception[15: 8]	;
assign		o_ABSD_COLOR_EXCEPTION_EN		=	r_abs_color_exception[0]		;

assign		o_ABSD_PRE_SCAN_START			=	r_ABSD_PRE_SCAN_START			;

// -----------------------------------------------------------------------------------
// NEWABSD
// -----------------------------------------------------------------------------------
reg	[13:0]		o_NEWABSD_PRE_SCAN_START			;
reg	[13:0]		o_NEWABSD_PRE_SCAN_LINE_NUM			;
reg	[13:0]		o_NEWABSD_IWIN_START				;
reg	[13:0]		o_NEWABSD_IWIN_END					;
reg	[ 7:0]		o_NEWABSD_LEFT_LIMIT				;
reg	[ 7:0]		o_NEWABSD_RIGHT_LIMIT				;
reg	[ 7:0]		o_NEWABSD_GRAY_RIDGE_TH				;
reg	[ 7:0]		o_NEWABSD_COLOR_RIDGE_TH			;
reg	[ 7:0]		o_NEWABSD_CHROMA_TH					;
/*
`IPR_SFR_SET(o_NEWABSD_PRE_SCAN_START	 , w_addr8C0_wr		, 14'h78		, i_PWDATA[29:16])
`IPR_SFR_SET(o_NEWABSD_PRE_SCAN_LINE_NUM , w_addr8C0_wr		, 14'h78		, i_PWDATA[13: 0])

`IPR_SFR_SET(o_NEWABSD_IWIN_START	 , w_addr8C4_wr		, 14'h3e8		, i_PWDATA[29:16])
`IPR_SFR_SET(o_NEWABSD_IWIN_END		 , w_addr8C4_wr		, 14'hfa0		, i_PWDATA[13: 0])

`IPR_SFR_SET(o_NEWABSD_CHROMA_TH	  , w_addr8C8_wr		, 8'h0		, i_PWDATA[23:16])
`IPR_SFR_SET(o_NEWABSD_GRAY_RIDGE_TH  , w_addr8C8_wr		, 8'h0		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_NEWABSD_COLOR_RIDGE_TH , w_addr8C8_wr		, 8'h0		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_NEWABSD_LEFT_LIMIT ,  w_addr8CC_wr		, 8'h0		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_NEWABSD_RIGHT_LIMIT , w_addr8CC_wr		, 8'h0		, i_PWDATA[ 7: 0])
*/
`IPR_SFR_SET(o_NEWABSD_PRE_SCAN_START	 , w_addr8C0_wr		, 14'h00		, i_PWDATA[29:16])
`IPR_SFR_SET(o_NEWABSD_PRE_SCAN_LINE_NUM , w_addr8C0_wr		, 14'h2710		, i_PWDATA[13: 0])

`IPR_SFR_SET(o_NEWABSD_IWIN_START	 , w_addr8C4_wr		, 14'h0		    , i_PWDATA[29:16])
`IPR_SFR_SET(o_NEWABSD_IWIN_END		 , w_addr8C4_wr		, 14'h2710		, i_PWDATA[13: 0])

`IPR_SFR_SET(o_NEWABSD_CHROMA_TH	  , w_addr8C8_wr		, 8'ha		, i_PWDATA[23:16])
`IPR_SFR_SET(o_NEWABSD_GRAY_RIDGE_TH  , w_addr8C8_wr		, 8'h3		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_NEWABSD_COLOR_RIDGE_TH , w_addr8C8_wr		, 8'h3		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_NEWABSD_LEFT_LIMIT ,  w_addr8CC_wr		, 8'h80		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_NEWABSD_RIGHT_LIMIT , w_addr8CC_wr		, 8'hff		, i_PWDATA[ 7: 0])
// -----------------------------------------------------------------------------------
//	13) ACS
// -----------------------------------------------------------------------------------
reg	[ 7:0]	o_ACS_WHITE_TH					;
reg			o_ACS_RANGE_REAL_IMAGE			;
reg	[ 7:0]	o_ACS_BLOCK_SIZE_Y				;
reg	[ 7:0]	o_ACS_BLOCK_SIZE_X				;
//reg	[ 1:0]	o_ACS_DPI_Y						;
//reg		    o_ACS_DPI_X						;
reg			o_ACS_HISTO_EN					;
reg		    o_ACS_MARK_ON					;
reg		    o_ACS_BLOCK_SIZE_AUTO			;
reg		    o_ACS_HALF_CNT_AUTO				;
reg		    o_ACS_SATURATION_PXL_CNT_AUTO	;
reg	[16:0]	o_ACS_MARK_TOP		 			;
reg	[16:0]	o_ACS_MARK_BOTTOM				;
reg	[16:0]	o_ACS_MARK_LEFT		 			;
reg	[16:0]	o_ACS_MARK_RIGHT				;
reg	[ 7:0]	o_ACS_SATURATION_PXL_TH			;
reg	[14:0]	o_ACS_SATURATION_PXL_CNT_TH		;
reg	[ 7:0]	o_ACS_VALUE_PXL_TH 			;
reg	[ 7:0]	o_ACS_VALUE_BLOCK_TH 		;
reg	[ 7:0]	o_ACS_SATURATION_BLOCK_TH	 	;
reg	[14:0]	o_ACS_HALFTONE_CNT				;
reg	[14:0]	o_ACS_PUREHALFTONE_CNT			;
reg	[ 7:0]	o_ACS_CB_MAX_00					;
reg	[ 7:0]	o_ACS_CB_MAX_01					;
reg	[ 7:0]	o_ACS_CB_MAX_02					;
reg	[ 7:0]	o_ACS_CB_MAX_03					;
reg	[ 7:0]	o_ACS_CB_MAX_04					;
reg	[ 7:0]	o_ACS_CB_MAX_05					;
reg	[ 7:0]	o_ACS_CB_MAX_06					;
reg	[ 7:0]	o_ACS_CB_MAX_07					;
reg	[ 7:0]	o_ACS_CB_MAX_08					;
reg	[ 7:0]	o_ACS_CB_MAX_09					;
reg	[ 7:0]	o_ACS_CB_MAX_10					;
reg	[ 7:0]	o_ACS_CB_MAX_11					;
reg	[ 7:0]	o_ACS_CB_MAX_12					;
reg	[ 7:0]	o_ACS_CB_MAX_13					;
reg	[ 7:0]	o_ACS_CB_MAX_14					;
reg	[ 7:0]	o_ACS_CB_MAX_15					;
reg	[ 7:0]	o_ACS_CB_MIN_00					;
reg	[ 7:0]	o_ACS_CB_MIN_01					;
reg	[ 7:0]	o_ACS_CB_MIN_02					;
reg	[ 7:0]	o_ACS_CB_MIN_03					;
reg	[ 7:0]	o_ACS_CB_MIN_04					;
reg	[ 7:0]	o_ACS_CB_MIN_05					;
reg	[ 7:0]	o_ACS_CB_MIN_06					;
reg	[ 7:0]	o_ACS_CB_MIN_07					;
reg	[ 7:0]	o_ACS_CB_MIN_08					;
reg	[ 7:0]	o_ACS_CB_MIN_09					;
reg	[ 7:0]	o_ACS_CB_MIN_10					;
reg	[ 7:0]	o_ACS_CB_MIN_11					;
reg	[ 7:0]	o_ACS_CB_MIN_12					;
reg	[ 7:0]	o_ACS_CB_MIN_13					;
reg	[ 7:0]	o_ACS_CB_MIN_14					;
reg	[ 7:0]	o_ACS_CB_MIN_15					;
reg	[ 7:0]	o_ACS_CR_MAX_00					;
reg	[ 7:0]	o_ACS_CR_MAX_01					;
reg	[ 7:0]	o_ACS_CR_MAX_02					;
reg	[ 7:0]	o_ACS_CR_MAX_03					;
reg	[ 7:0]	o_ACS_CR_MAX_04					;
reg	[ 7:0]	o_ACS_CR_MAX_05					;
reg	[ 7:0]	o_ACS_CR_MAX_06					;
reg	[ 7:0]	o_ACS_CR_MAX_07					;
reg	[ 7:0]	o_ACS_CR_MAX_08					;
reg	[ 7:0]	o_ACS_CR_MAX_09					;
reg	[ 7:0]	o_ACS_CR_MAX_10					;
reg	[ 7:0]	o_ACS_CR_MAX_11					;
reg	[ 7:0]	o_ACS_CR_MAX_12					;
reg	[ 7:0]	o_ACS_CR_MAX_13					;
reg	[ 7:0]	o_ACS_CR_MAX_14					;
reg	[ 7:0]	o_ACS_CR_MAX_15					;
reg	[ 7:0]	o_ACS_CR_MIN_00					;
reg	[ 7:0]	o_ACS_CR_MIN_01					;
reg	[ 7:0]	o_ACS_CR_MIN_02					;
reg	[ 7:0]	o_ACS_CR_MIN_03					;
reg	[ 7:0]	o_ACS_CR_MIN_04					;
reg	[ 7:0]	o_ACS_CR_MIN_05					;
reg	[ 7:0]	o_ACS_CR_MIN_06					;
reg	[ 7:0]	o_ACS_CR_MIN_07					;
reg	[ 7:0]	o_ACS_CR_MIN_08					;
reg	[ 7:0]	o_ACS_CR_MIN_09					;
reg	[ 7:0]	o_ACS_CR_MIN_10					;
reg	[ 7:0]	o_ACS_CR_MIN_11					;
reg	[ 7:0]	o_ACS_CR_MIN_12					;
reg	[ 7:0]	o_ACS_CR_MIN_13					;
reg	[ 7:0]	o_ACS_CR_MIN_14					;
reg	[ 7:0]	o_ACS_CR_MIN_15					;
reg	[ 7:0]	o_ACS_CB_MAXh_00				;
reg	[ 7:0]	o_ACS_CB_MAXh_01				;
reg	[ 7:0]	o_ACS_CB_MAXh_02 				;
reg	[ 7:0]	o_ACS_CB_MAXh_03 				;
reg	[ 7:0]	o_ACS_CB_MAXh_04				;
reg	[ 7:0]	o_ACS_CB_MAXh_05				;
reg	[ 7:0]	o_ACS_CB_MAXh_06 				;
reg	[ 7:0]	o_ACS_CB_MAXh_07 				;
reg	[ 7:0]	o_ACS_CB_MAXh_08				;
reg	[ 7:0]	o_ACS_CB_MAXh_09				;
reg	[ 7:0]	o_ACS_CB_MAXh_10 				;
reg	[ 7:0]	o_ACS_CB_MAXh_11 				;
reg	[ 7:0]	o_ACS_CB_MAXh_12				;
reg	[ 7:0]	o_ACS_CB_MAXh_13				;
reg	[ 7:0]	o_ACS_CB_MAXh_14 				;
reg	[ 7:0]	o_ACS_CB_MAXh_15 				;
reg	[ 7:0]	o_ACS_CB_MINh_00				;
reg	[ 7:0]	o_ACS_CB_MINh_01				;
reg	[ 7:0]	o_ACS_CB_MINh_02 				;
reg	[ 7:0]	o_ACS_CB_MINh_03 				;
reg	[ 7:0]	o_ACS_CB_MINh_04				;
reg	[ 7:0]	o_ACS_CB_MINh_05				;
reg	[ 7:0]	o_ACS_CB_MINh_06 				;
reg	[ 7:0]	o_ACS_CB_MINh_07 				;
reg	[ 7:0]	o_ACS_CB_MINh_08				;
reg	[ 7:0]	o_ACS_CB_MINh_09				;
reg	[ 7:0]	o_ACS_CB_MINh_10 				;
reg	[ 7:0]	o_ACS_CB_MINh_11 				;
reg	[ 7:0]	o_ACS_CB_MINh_12				;
reg	[ 7:0]	o_ACS_CB_MINh_13				;
reg	[ 7:0]	o_ACS_CB_MINh_14 				;
reg	[ 7:0]	o_ACS_CB_MINh_15 				;
reg	[ 7:0]	o_ACS_CR_MAXh_00				;
reg	[ 7:0]	o_ACS_CR_MAXh_01				;
reg	[ 7:0]	o_ACS_CR_MAXh_02 				;
reg	[ 7:0]	o_ACS_CR_MAXh_03 				;
reg	[ 7:0]	o_ACS_CR_MAXh_04				;
reg	[ 7:0]	o_ACS_CR_MAXh_05				;
reg	[ 7:0]	o_ACS_CR_MAXh_06 				;
reg	[ 7:0]	o_ACS_CR_MAXh_07 				;
reg	[ 7:0]	o_ACS_CR_MAXh_08				;
reg	[ 7:0]	o_ACS_CR_MAXh_09				;
reg	[ 7:0]	o_ACS_CR_MAXh_10 				;
reg	[ 7:0]	o_ACS_CR_MAXh_11 				;
reg	[ 7:0]	o_ACS_CR_MAXh_12				;
reg	[ 7:0]	o_ACS_CR_MAXh_13				;
reg	[ 7:0]	o_ACS_CR_MAXh_14 				;
reg	[ 7:0]	o_ACS_CR_MAXh_15 				;
reg	[ 7:0]	o_ACS_CR_MINh_00				;
reg	[ 7:0]	o_ACS_CR_MINh_01				;
reg	[ 7:0]	o_ACS_CR_MINh_02 				;
reg	[ 7:0]	o_ACS_CR_MINh_03 				;
reg	[ 7:0]	o_ACS_CR_MINh_04				;
reg	[ 7:0]	o_ACS_CR_MINh_05				;
reg	[ 7:0]	o_ACS_CR_MINh_06 				;
reg	[ 7:0]	o_ACS_CR_MINh_07 				;
reg	[ 7:0]	o_ACS_CR_MINh_08				;
reg	[ 7:0]	o_ACS_CR_MINh_09				;
reg	[ 7:0]	o_ACS_CR_MINh_10 				;
reg	[ 7:0]	o_ACS_CR_MINh_11 				;
reg	[ 7:0]	o_ACS_CR_MINh_12				;
reg	[ 7:0]	o_ACS_CR_MINh_13				;
reg	[ 7:0]	o_ACS_CR_MINh_14 				;
reg	[ 7:0]	o_ACS_CR_MINh_15 				;

reg	[7:0]	o_ACSv2_BLOCK_SIZE_X;
reg	[7:0]	o_ACSv2_BLOCK_SIZE_Y;
reg	[7:0]	o_ACSv2_WHITE_TH;
reg	[ 7:0]	o_ACSv2_SATURATION_PXL_TH;
reg	[14:0]	o_ACSv2_SATURATION_PXL_CNT_TH;
reg	[ 7:0]	o_ACSv2_SATURATION_BLOCK_TH;
reg	[7:0]	o_ACSv2_VALUE_PXL_TH;
reg	[7:0]	o_ACSv2_VALUE_BLOCK_TH;
reg	[14:0]	o_ACSv2_HALFTONE_CNT;
reg	[14:0]	o_ACSv2_PUREHALFTONE_CNT;


`IPR_SFR_SET(o_ACS_WHITE_TH				, w_addr9C0_wr		, 8'hE6		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_BLOCK_SIZE_Y				, w_addr9C0_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_BLOCK_SIZE_X				, w_addr9C0_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_RANGE_REAL_IMAGE			, w_addr9C0_wr		, 1'h0		, i_PWDATA[    7])
//`IPR_SFR_SET(o_ACS_DPI_Y					, w_addr9C0_wr		, 2'h0		, i_PWDATA[ 7: 6])
//`IPR_SFR_SET(o_ACS_DPI_X					, w_addr9C0_wr		, 1'h0		, i_PWDATA[    5])
//`IPR_SFR_SET(o_ACS_HISTO_EN					, w_addr9C0_wr		, 1'h0		, i_PWDATA[    4])
`IPR_SFR_SET(o_ACS_HISTO_EN					, w_addr9C0_wr		, 1'h1		, i_PWDATA[    4])	// 2018-01-11
`IPR_SFR_SET(o_ACS_MARK_ON					, w_addr9C0_wr		, 1'h0		, i_PWDATA[    3])
`IPR_SFR_SET(o_ACS_BLOCK_SIZE_AUTO			, w_addr9C0_wr		, 1'h0		, i_PWDATA[    2])
`IPR_SFR_SET(o_ACS_HALF_CNT_AUTO			, w_addr9C0_wr		, 1'h0		, i_PWDATA[    1])
`IPR_SFR_SET(o_ACS_SATURATION_PXL_CNT_AUTO	, w_addr9C0_wr		, 1'h0		, i_PWDATA[    0])

`IPR_SFR_SET(o_ACS_MARK_TOP					, w_addr9C4_wr		,17'h0000	, i_PWDATA[16:0])

`IPR_SFR_SET(o_ACS_MARK_BOTTOM	 			, w_addr9C8_wr		,17'h1_FFFF	, i_PWDATA[16:0])

`IPR_SFR_SET(o_ACS_MARK_LEFT		 		, w_addr9CC_wr		,17'h0000	, i_PWDATA[16:0])

`IPR_SFR_SET(o_ACS_MARK_RIGHT				, w_addr9D0_wr		,17'h1_FFFF	, i_PWDATA[16:0])

`IPR_SFR_SET(o_ACS_SATURATION_PXL_TH		, w_addr9D4_wr		, 8'h000	, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_SATURATION_BLOCK_TH	 	, w_addr9D4_wr		, 8'h000	, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_HALFTONE_CNT				, w_addr9D8_wr		,15'h0000	, i_PWDATA[30:16])
`IPR_SFR_SET(o_ACS_PUREHALFTONE_CNT			, w_addr9D8_wr		,15'h0000	, i_PWDATA[14: 0])

`IPR_SFR_SET(o_ACS_CB_MAX_00				, w_addr9DC_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MAX_01				, w_addr9DC_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MAX_02				, w_addr9DC_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MAX_03				, w_addr9DC_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MAX_04				, w_addr9E0_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MAX_05				, w_addr9E0_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MAX_06				, w_addr9E0_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MAX_07				, w_addr9E0_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MAX_08				, w_addr9E4_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MAX_09				, w_addr9E4_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MAX_10				, w_addr9E4_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MAX_11				, w_addr9E4_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MAX_12				, w_addr9E8_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MAX_13				, w_addr9E8_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MAX_14				, w_addr9E8_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MAX_15				, w_addr9E8_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MIN_00				, w_addr9EC_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MIN_01				, w_addr9EC_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MIN_02				, w_addr9EC_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MIN_03				, w_addr9EC_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MIN_04				, w_addr9F0_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MIN_05				, w_addr9F0_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MIN_06				, w_addr9F0_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MIN_07				, w_addr9F0_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MIN_08				, w_addr9F4_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MIN_09				, w_addr9F4_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MIN_10				, w_addr9F4_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MIN_11				, w_addr9F4_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MIN_12				, w_addr9F8_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MIN_13				, w_addr9F8_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MIN_14				, w_addr9F8_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MIN_15				, w_addr9F8_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MAX_00				, w_addr9FC_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MAX_01				, w_addr9FC_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MAX_02				, w_addr9FC_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MAX_03				, w_addr9FC_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MAX_04				, w_addrA00_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MAX_05				, w_addrA00_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MAX_06				, w_addrA00_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MAX_07				, w_addrA00_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MAX_08				, w_addrA04_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MAX_09				, w_addrA04_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MAX_10				, w_addrA04_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MAX_11				, w_addrA04_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MAX_12				, w_addrA08_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MAX_13				, w_addrA08_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MAX_14				, w_addrA08_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MAX_15				, w_addrA08_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MIN_00				, w_addrA0C_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MIN_01				, w_addrA0C_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MIN_02				, w_addrA0C_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MIN_03				, w_addrA0C_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MIN_04				, w_addrA10_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MIN_05				, w_addrA10_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MIN_06				, w_addrA10_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MIN_07				, w_addrA10_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MIN_08				, w_addrA14_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MIN_09				, w_addrA14_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MIN_10				, w_addrA14_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MIN_11				, w_addrA14_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MIN_12				, w_addrA18_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MIN_13				, w_addrA18_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MIN_14				, w_addrA18_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MIN_15				, w_addrA18_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MAXh_00				, w_addrA1C_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MAXh_01				, w_addrA1C_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MAXh_02 				, w_addrA1C_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MAXh_03 				, w_addrA1C_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MAXh_04				, w_addrA20_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MAXh_05				, w_addrA20_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MAXh_06 				, w_addrA20_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MAXh_07 				, w_addrA20_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MAXh_08				, w_addrA24_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MAXh_09				, w_addrA24_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MAXh_10 				, w_addrA24_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MAXh_11 				, w_addrA24_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MAXh_12				, w_addrA28_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MAXh_13				, w_addrA28_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MAXh_14 				, w_addrA28_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MAXh_15 				, w_addrA28_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MINh_00				, w_addrA2C_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MINh_01				, w_addrA2C_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MINh_02 				, w_addrA2C_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MINh_03 				, w_addrA2C_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MINh_04				, w_addrA30_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MINh_05				, w_addrA30_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MINh_06 				, w_addrA30_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MINh_07 				, w_addrA30_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MINh_08				, w_addrA34_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MINh_09				, w_addrA34_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MINh_10 				, w_addrA34_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MINh_11 				, w_addrA34_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CB_MINh_12				, w_addrA38_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CB_MINh_13				, w_addrA38_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CB_MINh_14 				, w_addrA38_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CB_MINh_15 				, w_addrA38_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MAXh_00				, w_addrA3C_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MAXh_01				, w_addrA3C_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MAXh_02 				, w_addrA3C_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MAXh_03 				, w_addrA3C_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MAXh_04				, w_addrA40_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MAXh_05				, w_addrA40_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MAXh_06 				, w_addrA40_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MAXh_07 				, w_addrA40_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MAXh_08				, w_addrA44_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MAXh_09				, w_addrA44_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MAXh_10 				, w_addrA44_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MAXh_11 				, w_addrA44_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MAXh_12				, w_addrA48_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MAXh_13				, w_addrA48_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MAXh_14 				, w_addrA48_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MAXh_15 				, w_addrA48_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MINh_00				, w_addrA4C_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MINh_01				, w_addrA4C_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MINh_02 				, w_addrA4C_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MINh_03 				, w_addrA4C_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MINh_04				, w_addrA50_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MINh_05				, w_addrA50_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MINh_06 				, w_addrA50_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MINh_07 				, w_addrA50_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MINh_08				, w_addrA54_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MINh_09				, w_addrA54_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MINh_10 				, w_addrA54_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MINh_11 				, w_addrA54_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_CR_MINh_12				, w_addrA58_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACS_CR_MINh_13				, w_addrA58_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACS_CR_MINh_14 				, w_addrA58_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_CR_MINh_15 				, w_addrA58_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_VALUE_PXL_TH 			, w_addrA5C_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACS_VALUE_BLOCK_TH 			, w_addrA5C_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACS_SATURATION_PXL_CNT_TH	, w_addrB08_wr		,15'h0000	, i_PWDATA[14: 0])


assign	o_ACSv2_EN = o_ACS_EN;

`IPR_SFR_SET(o_ACSv2_WHITE_TH				, w_addrB14_wr		, 8'hE6		, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACSv2_BLOCK_SIZE_Y			, w_addrB14_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_ACSv2_BLOCK_SIZE_X			, w_addrB14_wr		, 8'h00		, i_PWDATA[15: 8])

`IPR_SFR_SET(o_ACSv2_SATURATION_PXL_TH			, w_addrB18_wr		, 8'h000	, i_PWDATA[31:24])
`IPR_SFR_SET(o_ACSv2_SATURATION_BLOCK_TH	 	, w_addrB18_wr		, 8'h000	, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_ACSv2_SATURATION_PXL_CNT_TH		, w_addrB1C_wr		,15'h0000	, i_PWDATA[14: 0])

`IPR_SFR_SET(o_ACSv2_HALFTONE_CNT			, w_addrB20_wr		,15'h0000	, i_PWDATA[30:16])
`IPR_SFR_SET(o_ACSv2_PUREHALFTONE_CNT			, w_addrB20_wr		,15'h0000	, i_PWDATA[14: 0])

`IPR_SFR_SET(o_ACSv2_VALUE_PXL_TH 			, w_addrB24_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_ACSv2_VALUE_BLOCK_TH 			, w_addrB24_wr		, 8'h00		, i_PWDATA[ 7: 0])

// added 
reg			r_ACS_BLANK_DPI_X;
reg	[1:0]	r_ACS_BLANK_DPI_Y;


always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)								r_ACS_BLANK_DPI_Y	<= #1 2'h0;	
	else if(o_RC1_EN)							r_ACS_BLANK_DPI_Y	<= #1 2'h0; //600dpi
	else begin
			 if(o_RX_DPI_MODE == p_600x600)		r_ACS_BLANK_DPI_Y	<= #1 2'h0; 
		else if(o_RX_DPI_MODE == p_600x450)		r_ACS_BLANK_DPI_Y	<= #1 2'h1;
	//	else if(o_RX_DPI_MODE == p_600x400)		r_ACS_BLANK_DPI_Y	<= #1 2'h2;
		else if(o_RX_DPI_MODE == p_600x300)		r_ACS_BLANK_DPI_Y	<= #1 2'h3;
		else if(o_RX_DPI_MODE == p_300x600)		r_ACS_BLANK_DPI_Y	<= #1 2'h0;
		else if(o_RX_DPI_MODE == p_300x450)		r_ACS_BLANK_DPI_Y	<= #1 2'h1;
	//	else if(o_RX_DPI_MODE == p_300x400)		r_ACS_BLANK_DPI_Y	<= #1 2'h2;
		else if(o_RX_DPI_MODE == p_300x300)		r_ACS_BLANK_DPI_Y	<= #1 2'h3;
	end
end

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)								r_ACS_BLANK_DPI_X	<= #1 1'h0;	
	else if(o_RC1_EN)							r_ACS_BLANK_DPI_X	<= #1 1'h0; //600dpi
	else begin
			 if(o_RX_DPI_MODE == p_600x600)		r_ACS_BLANK_DPI_X	<= #1 1'h0; // 600dpi
		else if(o_RX_DPI_MODE == p_600x450)		r_ACS_BLANK_DPI_X	<= #1 1'h0; // 600dpi
	//	else if(o_RX_DPI_MODE == p_600x400)		r_ACS_BLANK_DPI_X	<= #1 1'h0; // 600dpi
		else if(o_RX_DPI_MODE == p_600x300)		r_ACS_BLANK_DPI_X	<= #1 1'h0; // 600dpi
		else if(o_RX_DPI_MODE == p_300x600)		r_ACS_BLANK_DPI_X	<= #1 1'h1; // 300dpi
		else if(o_RX_DPI_MODE == p_300x450)		r_ACS_BLANK_DPI_X	<= #1 1'h1; // 300dpi
	//	else if(o_RX_DPI_MODE == p_300x400)		r_ACS_BLANK_DPI_X	<= #1 1'h1; // 300dpi
		else if(o_RX_DPI_MODE == p_300x300)		r_ACS_BLANK_DPI_X	<= #1 1'h1; // 300dpi
	end
end

assign	o_ACS_DPI_Y		= r_ACS_BLANK_DPI_Y;				
assign	o_ACS_DPI_X		= r_ACS_BLANK_DPI_X;				

assign	o_BLANK_DPI_V	= r_ACS_BLANK_DPI_Y;				
assign	o_BLANK_DPI_H	= r_ACS_BLANK_DPI_X;				

// -----------------------------------------------------------------------------------
//	 BLANK
// -----------------------------------------------------------------------------------

reg					o_BLANK_RANGE_REAL_IMAGE;
reg		[7:0]		o_BLANK_BLOCK_SIZE_V	;
reg		[7:0]		o_BLANK_BLOCK_SIZE_H	;
//reg		[1:0]		o_BLANK_DPI_V		;
//reg					o_BLANK_DPI_H		;
reg					o_BLANK_MARK_EN			;
reg					o_BLANK_AUTO_EN			;
reg		[7:0]		o_BLANK_CONTENTBLOCK_PCT				;
reg		[7:0]		o_BLANK_DARKBLK_TH				;
reg		[16: 0]	o_BLANK_MARK_POS_TOP			;
reg		[16: 0]	o_BLANK_MARK_POS_BOTTOM			;
reg		[16: 0]	o_BLANK_MARK_POS_LEFT			;
reg		[16: 0]	o_BLANK_MARK_POS_RIGHT			;
reg		[ 7: 0]	o_BLANK_COLORBLOCK_CB_THL		;
reg		[ 7: 0]	o_BLANK_COLORBLOCK_CB_THU		;
reg		[ 7: 0]	o_BLANK_COLORBLOCK_CR_THL		;
reg		[ 7: 0]	o_BLANK_COLORBLOCK_CR_THU		;

`IPR_SFR_SET(o_BLANK_BLOCK_SIZE_V		, w_addrB40_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_BLANK_BLOCK_SIZE_H		, w_addrB40_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_BLANK_RANGE_REAL_IMAGE		, w_addrB40_wr		, 1'b0		, i_PWDATA[    7])
//`IPR_SFR_SET(o_BLANK_DPI_V			, w_addrB40_wr		, 2'h0		, i_PWDATA[ 7: 6])
//`IPR_SFR_SET(o_BLANK_DPI_H			, w_addrB40_wr		, 1'h0		, i_PWDATA[    5])
`IPR_SFR_SET(o_BLANK_MARK_EN				, w_addrB40_wr		, 1'h0		, i_PWDATA[    3])
`IPR_SFR_SET(o_BLANK_AUTO_EN				, w_addrB40_wr		, 1'h0		, i_PWDATA[    2])

`IPR_SFR_SET(o_BLANK_CONTENTBLOCK_PCT		, w_addrB44_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_BLANK_DARKBLK_TH				, w_addrB44_wr		, 8'h00		, i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_BLANK_MARK_POS_TOP			, w_addrB48_wr		,17'h0000	, i_PWDATA[16: 0])

`IPR_SFR_SET(o_BLANK_MARK_POS_BOTTOM		, w_addrB4C_wr		,17'h1_FFFF, i_PWDATA[16: 0])

`IPR_SFR_SET(o_BLANK_MARK_POS_LEFT			, w_addrB50_wr		,17'h0000	, i_PWDATA[16: 0])

`IPR_SFR_SET(o_BLANK_MARK_POS_RIGHT			, w_addrB54_wr		,17'h1_FFFF	, i_PWDATA[16: 0])

`IPR_SFR_SET(o_BLANK_COLORBLOCK_CB_THL		, w_addrB58_wr		, 8'h00		, i_PWDATA[31:24])
`IPR_SFR_SET(o_BLANK_COLORBLOCK_CB_THU		, w_addrB58_wr		, 8'h00		, i_PWDATA[23:16])
`IPR_SFR_SET(o_BLANK_COLORBLOCK_CR_THL		, w_addrB58_wr		, 8'h00		, i_PWDATA[15: 8])
`IPR_SFR_SET(o_BLANK_COLORBLOCK_CR_THU		, w_addrB58_wr		, 8'h00		, i_PWDATA[ 7: 0])

// -----------------------------------------------------------------------------------
//	BDS
// -----------------------------------------------------------------------------------
reg			o_BDS_MIRROR;
reg		[7:0]   o_BDS_EDGE_TH;
reg		[7:0]	o_BDS_EDGE_CNT_TH  ;
reg		[7:0]	o_BDS_EDGE_Y_HIGH  ;
reg		[7:0]	o_BDS_EDGE_Y_LOW   ;
reg		[7:0]	o_BDS_EDGE_CB_HIGH ;
reg		[7:0]	o_BDS_EDGE_CB_LOW  ;
reg		[7:0]	o_BDS_EDGE_CR_HIGH ;
reg		[7:0]	o_BDS_EDGE_CR_LOW  ;
reg		[7:0]	o_BDS_EURion_Y_HIGH  ;
reg		[7:0]	o_BDS_EURion_Y_LOW   ;
reg		[7:0]	o_BDS_EURion_CB_HIGH ;
reg		[7:0]	o_BDS_EURion_CB_LOW  ;
reg		[7:0]	o_BDS_EURion_CR_HIGH ;
reg		[7:0]	o_BDS_EURion_CR_LOW  ;
reg		[7:0]	o_BDS_OFFSET_LEFT;
reg		[7:0]	o_BDS_OFFSET_RIGHT;
reg		[7:0]	o_BDS_OFFSET_TOP;
reg		[7:0]	o_BDS_OFFSET_BOTTOM;

`IPR_SFR_SET(o_BDS_EDGE_TH          , w_addrBC0_wr,  8'hA,   i_PWDATA[23:16])
`IPR_SFR_SET(o_BDS_MIRROR           , w_addrBC0_wr,  1'h0,   i_PWDATA[    0])

`IPR_SFR_SET(o_BDS_EDGE_CNT_TH      , w_addrBC4_wr,  8'd6,   i_PWDATA[23:16])
`IPR_SFR_SET(o_BDS_EDGE_Y_HIGH      , w_addrBC4_wr,  8'd210, i_PWDATA[15: 8])
`IPR_SFR_SET(o_BDS_EDGE_Y_LOW       , w_addrBC4_wr,  8'd80,  i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_BDS_EDGE_CB_HIGH     , w_addrBC8_wr,  8'd140, i_PWDATA[31:24])
`IPR_SFR_SET(o_BDS_EDGE_CB_LOW      , w_addrBC8_wr,  8'd10,  i_PWDATA[23:16])
`IPR_SFR_SET(o_BDS_EDGE_CR_HIGH     , w_addrBC8_wr,  8'd210, i_PWDATA[15: 8])
`IPR_SFR_SET(o_BDS_EDGE_CR_LOW      , w_addrBC8_wr,  8'd80,  i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_BDS_EURion_Y_HIGH    , w_addrBCC_wr,  8'd210, i_PWDATA[15: 8])
`IPR_SFR_SET(o_BDS_EURion_Y_LOW     , w_addrBCC_wr,  8'd80,  i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_BDS_EURion_CB_HIGH   , w_addrBD0_wr,  8'd140, i_PWDATA[31:24])
`IPR_SFR_SET(o_BDS_EURion_CB_LOW    , w_addrBD0_wr,  8'd10,  i_PWDATA[23:16])
`IPR_SFR_SET(o_BDS_EURion_CR_HIGH   , w_addrBD0_wr,  8'd210, i_PWDATA[15: 8])
`IPR_SFR_SET(o_BDS_EURion_CR_LOW    , w_addrBD0_wr,  8'd80,  i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_BDS_OFFSET_LEFT      , w_addrBD4_wr,  8'd25, i_PWDATA[31:24])
`IPR_SFR_SET(o_BDS_OFFSET_RIGHT     , w_addrBD4_wr,  8'd10, i_PWDATA[23:16])
`IPR_SFR_SET(o_BDS_OFFSET_TOP       , w_addrBD4_wr,  8'd10, i_PWDATA[15: 8])
`IPR_SFR_SET(o_BDS_OFFSET_BOTTOM    , w_addrBD4_wr,  8'd10, i_PWDATA[ 7: 0])

wire	[16:0]	w_RC2_OUT_W = o_RC2_OUTIMG_WIDTH  * r_BNX;
wire	[16:0]	w_RC2_OUT_H = o_RC2_OUTIMG_HEIGHT * r_BNY;

wire	[15:0]	w_BDS_PAGE_WIDTH_temp;

assign  w_BDS_PAGE_WIDTH_temp	=  (w_RC2_OUT_W + 1)/2 + 63;			

assign	o_BDS_PAGE_WIDTH	= {w_BDS_PAGE_WIDTH_temp[15:6], 6'h0};			
assign	o_BDS_PAGE_HEIGHT	= w_RC2_OUT_H[16:1]; // (w_RC2_OUT_H + 1)/2;			

// -----------------------------------------------------------------------------------
//	RC2	
// -----------------------------------------------------------------------------------
reg		[ 8:0] o_RC2_OUTIMG_WIDTH;		 	
reg		[ 7:0] o_RC2_OUTIMG_HEIGHT;		
reg				o_RC2_MASK_IMG_BD;			
reg		[ 5: 0] o_RC2_OVERLAP;				

reg		[11: 0] o_RC2_V_FRAC;				
reg		[11: 0] o_RC2_H_FRAC;

`IPR_SFR_SET(o_RC2_OUTIMG_WIDTH		 			, w_addrB80_wr	, 9'h80	,	i_PWDATA[24:16])
`IPR_SFR_SET(o_RC2_OUTIMG_HEIGHT				, w_addrB80_wr	, 8'h40	,	i_PWDATA[ 7: 0])

`IPR_SFR_SET(o_RC2_MASK_IMG_BD					, w_addrB84_wr	, 1'h0	, i_PWDATA[  8])
`IPR_SFR_SET(o_RC2_OVERLAP						, w_addrB84_wr	, 6'h8	, i_PWDATA[5:0]) // SPA

`IPR_SFR_SET(o_RC2_V_FRAC						, w_addrB88_wr	, 12'h0	, i_PWDATA[27:16])
`IPR_SFR_SET(o_RC2_H_FRAC						, w_addrB88_wr	, 12'h0	, i_PWDATA[11: 0])

// -----------------------------------------------------------------------------------
//	ADAPT
// -----------------------------------------------------------------------------------
assign	o_ASB_BLK_WIDTH  = o_RC2_OUTIMG_WIDTH;
assign	o_ASB_BLK_HEIGHT = o_RC2_OUTIMG_HEIGHT;
assign	o_ASB_BLK_X_NUM  = r_BNX;

//-------------------------
// SMAP
//-------------------------
//reg		[ 1:0]	r_smap_param_a;
reg		[31:0]	r_smap_param_b;
reg		[31:0]	r_smap_param_c;


always @ (negedge i_HRESETn or posedge i_PCLK) 
	if(!i_HRESETn)				r_smap_param_b <= #1 32'hFAFF_FAFF;
	else if(w_addrC84_wr)		r_smap_param_b <= #1 i_PWDATA;


always @ (negedge i_HRESETn or posedge i_PCLK) 
	if(!i_HRESETn)				r_smap_param_c <= #1 32'hFA_2460;
	else if(w_addrC88_wr)		r_smap_param_c <= #1 i_PWDATA;

reg	[5:0] o_SMAP_AVGDIVPARAM;
reg		  o_SMAP_ADAPTIVE_ENABLE;

reg	[31:0]	r_smap_r_max0,
			r_smap_r_max1,
			r_smap_r_max2,
			r_smap_r_max3,
			r_smap_r_max4,
			r_smap_r_max5,
			r_smap_r_max6,
			r_smap_r_max7;

reg	[31:0]	r_smap_r_min0,
			r_smap_r_min1,
			r_smap_r_min2,
			r_smap_r_min3,
			r_smap_r_min4,
			r_smap_r_min5,
			r_smap_r_min6,
			r_smap_r_min7;


reg	[31:0]	r_smap_g_max0,
			r_smap_g_max1,
			r_smap_g_max2,
			r_smap_g_max3,
			r_smap_g_max4,
			r_smap_g_max5,
			r_smap_g_max6,
			r_smap_g_max7;
reg	[31:0]	r_smap_g_min0,
			r_smap_g_min1,
			r_smap_g_min2,
			r_smap_g_min3,
			r_smap_g_min4,
			r_smap_g_min5,
			r_smap_g_min6,
			r_smap_g_min7;


reg	[31:0]	r_smap_b_max0,
			r_smap_b_max1,
			r_smap_b_max2,
			r_smap_b_max3,
			r_smap_b_max4,
			r_smap_b_max5,
			r_smap_b_max6,
			r_smap_b_max7;

reg	[31:0]	r_smap_b_min0,
			r_smap_b_min1,
			r_smap_b_min2,
			r_smap_b_min3,
			r_smap_b_min4,
			r_smap_b_min5,
			r_smap_b_min6,
			r_smap_b_min7;


`IPR_SFR_SET(o_SMAP_AVGDIVPARAM,	 w_addrC8C_wr	, 6'h8,		 i_PWDATA[9:4]) 
`IPR_SFR_SET(o_SMAP_ADAPTIVE_ENABLE, w_addrC8C_wr	, 1'h0,		 i_PWDATA[0]  ) 

`IPR_SFR_SET(r_smap_r_max0,	 w_addrC90_wr	, 32'h1810_0800, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_max1,	 w_addrC94_wr	, 32'h2823_231E, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_max2,	 w_addrC98_wr	, 32'h3732_2D28, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_max3,	 w_addrC9C_wr	, 32'h504B_4641, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_max4,	 w_addrCA0_wr	, 32'h5A5A_5550, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_max5,	 w_addrCA4_wr	, 32'h6E64_6464, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_max6,	 w_addrCA8_wr	, 32'h8278_786E, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_max7,	 w_addrCAC_wr	, 32'h8C8C_8C8C, i_PWDATA[31:0]) 

`IPR_SFR_SET(r_smap_r_min0,	 w_addrCB0_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_min1,	 w_addrCB4_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_min2,	 w_addrCB8_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_min3,	 w_addrCBC_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_min4,	 w_addrCC0_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_min5,	 w_addrCC4_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_min6,	 w_addrCC8_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_r_min7,	 w_addrCCC_wr	, 32'h0000_0000, i_PWDATA[31:0]) 

`IPR_SFR_SET(r_smap_g_max0,	 w_addrCD0_wr	, 32'h1810_0800, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_max1,	 w_addrCD4_wr	, 32'h2823_231E, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_max2,	 w_addrCD8_wr	, 32'h3732_2D28, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_max3,	 w_addrCDC_wr	, 32'h504B_4641, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_max4,	 w_addrCE0_wr	, 32'h5A5A_5550, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_max5,	 w_addrCE4_wr	, 32'h6E64_6464, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_max6,	 w_addrCE8_wr	, 32'h8278_786E, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_max7,	 w_addrCEC_wr	, 32'h8C8C_8C8C, i_PWDATA[31:0]) 

`IPR_SFR_SET(r_smap_g_min0,	 w_addrCF0_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_min1,	 w_addrCF4_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_min2,	 w_addrCF8_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_min3,	 w_addrCFC_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_min4,	 w_addrD00_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_min5,	 w_addrD04_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_min6,	 w_addrD08_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_g_min7,	 w_addrD0C_wr	, 32'h0000_0000, i_PWDATA[31:0]) 

`IPR_SFR_SET(r_smap_b_max0,	 w_addrD10_wr	, 32'h1810_0800, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_max1,	 w_addrD14_wr	, 32'h2823_231E, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_max2,	 w_addrD18_wr	, 32'h3732_2D28, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_max3,	 w_addrD1C_wr	, 32'h504B_4641, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_max4,	 w_addrD20_wr	, 32'h5A5A_5550, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_max5,	 w_addrD24_wr	, 32'h6E64_6464, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_max6,	 w_addrD28_wr	, 32'h8278_786E, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_max7,	 w_addrD2C_wr	, 32'h8C8C_8C8C, i_PWDATA[31:0]) 

`IPR_SFR_SET(r_smap_b_min0,	 w_addrD30_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_min1,	 w_addrD34_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_min2,	 w_addrD38_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_min3,	 w_addrD3C_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_min4,	 w_addrD40_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_min5,	 w_addrD44_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_min6,	 w_addrD48_wr	, 32'h0000_0000, i_PWDATA[31:0]) 
`IPR_SFR_SET(r_smap_b_min7,	 w_addrD4C_wr	, 32'h0000_0000, i_PWDATA[31:0])

//assign  o_SMAP_DPI_MODE			= r_smap_param_a[1:0];

assign  o_SMAP_R_RANGE1			= r_smap_param_b[31:24];
assign  o_SMAP_R_RANGE2 		= r_smap_param_b[23:16];
assign  o_SMAP_G_RANGE1 		= r_smap_param_b[15: 8];
assign  o_SMAP_G_RANGE2 		= r_smap_param_b[ 7: 0];

assign  o_SMAP_B_RANGE1			= r_smap_param_c[31:24];
assign  o_SMAP_B_RANGE2			= r_smap_param_c[23:16];
assign  o_SMAP_BINTH1			= r_smap_param_c[15:12];
assign  o_SMAP_BINTH2        	= r_smap_param_c[11: 8];
assign  o_SMAP_BINTH3        	= r_smap_param_c[ 7: 4];
assign  o_SMAP_REFINE_ENABLE 	= r_smap_param_c[	 0];


assign	o_SMAP_ADAP_R_MAXRANGE  = {r_smap_r_max7, r_smap_r_max6, r_smap_r_max5, r_smap_r_max4, r_smap_r_max3, r_smap_r_max2, r_smap_r_max1, r_smap_r_max0};
assign	o_SMAP_ADAP_R_MINRANGE  = {r_smap_r_min7, r_smap_r_min6, r_smap_r_min5, r_smap_r_min4, r_smap_r_min3, r_smap_r_min2, r_smap_r_min1, r_smap_r_min0};
assign	o_SMAP_ADAP_G_MAXRANGE  = {r_smap_g_max7, r_smap_g_max6, r_smap_g_max5, r_smap_g_max4, r_smap_g_max3, r_smap_g_max2, r_smap_g_max1, r_smap_g_max0};
assign	o_SMAP_ADAP_G_MINRANGE  = {r_smap_g_min7, r_smap_g_min6, r_smap_g_min5, r_smap_g_min4, r_smap_g_min3, r_smap_g_min2, r_smap_g_min1, r_smap_g_min0};
assign	o_SMAP_ADAP_B_MAXRANGE  = {r_smap_b_max7, r_smap_b_max6, r_smap_b_max5, r_smap_b_max4, r_smap_b_max3, r_smap_b_max2, r_smap_b_max1, r_smap_b_max0};
assign	o_SMAP_ADAP_B_MINRANGE  = {r_smap_b_min7, r_smap_b_min6, r_smap_b_min5, r_smap_b_min4, r_smap_b_min3, r_smap_b_min2, r_smap_b_min1, r_smap_b_min0};
//------------------------------------------------------------------------------
//	TBL
// -----------------------------------------------------------------------------------
reg		[24:0]	r_TBL_ENABLE;	
reg				r_TBL_STARTsp;	
reg				r_TBL_RW;	
reg		[39:0]	r_TBL_ADDR_00;	
reg		[39:0]	r_TBL_ADDR_01;	
reg		[39:0]	r_TBL_ADDR_02;	
reg		[39:0]	r_TBL_ADDR_03;	
reg		[39:0]	r_TBL_ADDR_04;	
reg		[39:0]	r_TBL_ADDR_05;	
reg		[39:0]	r_TBL_ADDR_06;	
reg		[39:0]	r_TBL_ADDR_07;	
reg		[39:0]	r_TBL_ADDR_08;	
reg		[39:0]	r_TBL_ADDR_09;	
reg		[39:0]	r_TBL_ADDR_10;	
reg		[39:0]	r_TBL_ADDR_11;	
reg		[39:0]	r_TBL_ADDR_12;	
reg		[39:0]	r_TBL_ADDR_13;	
reg		[39:0]	r_TBL_ADDR_14;	
reg		[39:0]	r_TBL_ADDR_15;	
reg		[39:0]	r_TBL_ADDR_16;	
reg		[39:0]	r_TBL_ADDR_17;	
reg		[39:0]	r_TBL_ADDR_18;	
reg		[39:0]	r_TBL_ADDR_19;	
reg		[39:0]	r_TBL_ADDR_20;	
reg		[39:0]	r_TBL_ADDR_21;	
reg		[39:0]	r_TBL_ADDR_22;	
reg		[39:0]	r_TBL_ADDR_23;	
reg		[39:0]	r_TBL_ADDR_24;	
//reg		[39:0]	r_TBL_ADDR_25;	
//reg		[39:0]	r_TBL_ADDR_26;	
//reg		[39:0]	r_TBL_ADDR_27;	
//reg		[39:0]	r_TBL_ADDR_28;	
//reg		[39:0]	r_TBL_ADDR_29;	
//reg		[39:0]	r_TBL_ADDR_32;	
//reg		[39:0]	r_TBL_ADDR_33;	
//reg		[39:0]	r_TBL_ADDR_34;	
//reg		[39:0]	r_TBL_ADDR_35;	
//reg		[39:0]	r_TBL_ADDR_36;	
//reg		[39:0]	r_TBL_ADDR_37;	
//reg		[39:0]	r_TBL_ADDR_38;	
//reg		[39:0]	r_TBL_ADDR_39;	
//reg		[39:0]	r_TBL_ADDR_40;	
//reg		[39:0]	r_TBL_ADDR_41;	
//reg		[39:0]	r_TBL_ADDR_42;	

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_TBL_STARTsp <= #1 0;
	else if(w_addr080_wr)		r_TBL_STARTsp <= #1 i_PWDATA[0];	
	else						r_TBL_STARTsp <= #1 0;		// Notice: short pulse
end

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_TBL_RW <= #1 0;
	else if(w_addr080_wr)		r_TBL_RW <= #1 i_PWDATA[8];
end

always @ (negedge i_HRESETn or posedge i_PCLK)  begin
	if(!i_HRESETn)				r_TBL_ENABLE  <= #1 0;
	else if(w_addr084_wr)  		r_TBL_ENABLE  <= #1 i_PWDATA[24:0];
end

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_00			<= #1 0;
	else if(w_addr08C_wr )		r_TBL_ADDR_00[31: 0]	<= #1 i_PWDATA;
	else if(w_addr108C_wr)		r_TBL_ADDR_00[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_01			<= #1 0;
	else if(w_addr090_wr )		r_TBL_ADDR_01[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1090_wr)		r_TBL_ADDR_01[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_02			<= #1 0;
	else if(w_addr094_wr )		r_TBL_ADDR_02[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1094_wr)		r_TBL_ADDR_02[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_03			<= #1 0;
	else if(w_addr098_wr )		r_TBL_ADDR_03[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1098_wr)		r_TBL_ADDR_03[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_04			<= #1 0;
	else if(w_addr09C_wr )		r_TBL_ADDR_04[31: 0]	<= #1 i_PWDATA;
	else if(w_addr109C_wr)		r_TBL_ADDR_04[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_05			<= #1 0;
	else if(w_addr0A0_wr )		r_TBL_ADDR_05[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10A0_wr)		r_TBL_ADDR_05[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_06			<= #1 0;
	else if(w_addr0A4_wr )		r_TBL_ADDR_06[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10A4_wr)		r_TBL_ADDR_06[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_07			<= #1 0;
	else if(w_addr0A8_wr )		r_TBL_ADDR_07[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10A8_wr)		r_TBL_ADDR_07[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_08			<= #1 0;
	else if(w_addr0AC_wr )		r_TBL_ADDR_08[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10AC_wr)		r_TBL_ADDR_08[39:32]	<= #1 i_PWDATA[7:0];


always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_09			<= #1 0;
	else if(w_addr0B0_wr )		r_TBL_ADDR_09[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10B0_wr)		r_TBL_ADDR_09[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_10			<= #1 0;
	else if(w_addr0B4_wr )		r_TBL_ADDR_10[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10B4_wr)		r_TBL_ADDR_10[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_11			<= #1 0;
	else if(w_addr0B8_wr )		r_TBL_ADDR_11[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10B8_wr)		r_TBL_ADDR_11[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_12			<= #1 0;
	else if(w_addr0BC_wr )		r_TBL_ADDR_12[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10BC_wr)		r_TBL_ADDR_12[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_13			<= #1 0;
	else if(w_addr0C0_wr )		r_TBL_ADDR_13[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10C0_wr)		r_TBL_ADDR_13[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_14			<= #1 0;
	else if(w_addr0C4_wr )		r_TBL_ADDR_14[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10C4_wr)		r_TBL_ADDR_14[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_15			<= #1 0;
	else if(w_addr0C8_wr )		r_TBL_ADDR_15[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10C8_wr)		r_TBL_ADDR_15[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_16			<= #1 0;
	else if(w_addr0CC_wr )		r_TBL_ADDR_16[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10CC_wr)		r_TBL_ADDR_16[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_17			<= #1 0;
	else if(w_addr0D0_wr )		r_TBL_ADDR_17[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10D0_wr)		r_TBL_ADDR_17[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_18			<= #1 0;
	else if(w_addr0D4_wr )		r_TBL_ADDR_18[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10D4_wr)		r_TBL_ADDR_18[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_19			<= #1 0;
	else if(w_addr0D8_wr )		r_TBL_ADDR_19[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10D8_wr)		r_TBL_ADDR_19[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_20			<= #1 0;
	else if(w_addr0DC_wr )		r_TBL_ADDR_20[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10DC_wr)		r_TBL_ADDR_20[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_21			<= #1 0;
	else if(w_addr0E0_wr )		r_TBL_ADDR_21[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10E0_wr)		r_TBL_ADDR_21[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_22			<= #1 0;
	else if(w_addr0E4_wr )		r_TBL_ADDR_22[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10E4_wr)		r_TBL_ADDR_22[39:32]	<= #1 i_PWDATA[7:0];
always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_23			<= #1 0;
	else if(w_addr0E8_wr )		r_TBL_ADDR_23[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10E8_wr)		r_TBL_ADDR_23[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_24			<= #1 0;
	else if(w_addr0EC_wr )		r_TBL_ADDR_24[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10EC_wr)		r_TBL_ADDR_24[39:32]	<= #1 i_PWDATA[7:0];

/*
always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_25			<= #1 0;
	else if(w_addr0F0_wr )		r_TBL_ADDR_25[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10F0_wr)		r_TBL_ADDR_25[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_26			<= #1 0;
	else if(w_addr0F4_wr )		r_TBL_ADDR_26[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10F4_wr)		r_TBL_ADDR_26[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_27			<= #1 0;
	else if(w_addr0F8_wr )		r_TBL_ADDR_27[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10F8_wr)		r_TBL_ADDR_27[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_28			<= #1 0;
	else if(w_addr0FC_wr )		r_TBL_ADDR_28[31: 0]	<= #1 i_PWDATA;
	else if(w_addr10FC_wr)		r_TBL_ADDR_28[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_29			<= #1 0;
	else if(w_addr100_wr )		r_TBL_ADDR_29[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1100_wr)		r_TBL_ADDR_29[39:32]	<= #1 i_PWDATA[7:0];

// Reserved 30, 31

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_32			<= #1 0;
	else if(w_addr10C_wr )		r_TBL_ADDR_32[31: 0]	<= #1 i_PWDATA;
	else if(w_addr110C_wr)		r_TBL_ADDR_32[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_33			<= #1 0;
	else if(w_addr110_wr )		r_TBL_ADDR_33[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1100_wr)		r_TBL_ADDR_33[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_34			<= #1 0;
	else if(w_addr114_wr )		r_TBL_ADDR_34[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1114_wr)		r_TBL_ADDR_34[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_35			<= #1 0;
	else if(w_addr118_wr )		r_TBL_ADDR_35[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1118_wr)		r_TBL_ADDR_35[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_36			<= #1 0;
	else if(w_addr11C_wr )		r_TBL_ADDR_36[31: 0]	<= #1 i_PWDATA;
	else if(w_addr111C_wr)		r_TBL_ADDR_36[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_37			<= #1 0;
	else if(w_addr120_wr )		r_TBL_ADDR_37[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1120_wr)		r_TBL_ADDR_37[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_38			<= #1 0;
	else if(w_addr124_wr )		r_TBL_ADDR_38[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1124_wr)		r_TBL_ADDR_38[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_39			<= #1 0;
	else if(w_addr128_wr )		r_TBL_ADDR_39[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1128_wr)		r_TBL_ADDR_39[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_40			<= #1 0;
	else if(w_addr12C_wr )		r_TBL_ADDR_40[31: 0]	<= #1 i_PWDATA;
	else if(w_addr112C_wr)		r_TBL_ADDR_40[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_41			<= #1 0;
	else if(w_addr130_wr )		r_TBL_ADDR_41[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1130_wr)		r_TBL_ADDR_41[39:32]	<= #1 i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)  
	if(!i_HRESETn)				r_TBL_ADDR_42			<= #1 0;
	else if(w_addr134_wr )		r_TBL_ADDR_42[31: 0]	<= #1 i_PWDATA;
	else if(w_addr1134_wr)		r_TBL_ADDR_42[39:32]	<= #1 i_PWDATA[7:0];
*/
assign		o_TBL_RW = r_TBL_RW;
// -----------------------------------------------------------------------------------
//	RX DMA
// -----------------------------------------------------------------------------------

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_RX_START				<= #1 1'b0				;
	else if(w_addr140_wr)			r_RX_START				<= #1 i_PWDATA[0]		;
	else if(r_RX_START)			r_RX_START				<= #1 1'b0				;
/*
//-----------------------------------------------------------------------------------
//	RX BAND_NUM
//-----------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)  			r_rx_band_num <= #1 8'h1;
	else if(w_addr144_wr)		r_rx_band_num <= #1 i_PWDATA[7:0]; 

//assign  w_RX_BAND_NUM			= r_rx_band_num; 
*/
//-----------------------------------------------------------------------------------
//	RX INCR
//-----------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_rx_incr				<= #1	32'h0				;
	else if(w_addr148_wr)		r_rx_incr				<= #1	i_PWDATA			;

// -----------------------------------------------------------------------------------
//	RX addr
// -----------------------------------------------------------------------------------

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_rx_ch0_start_addr		<= #1	0					;
	//else if(w_addr14C_wr)		r_rx_ch0_start_addr[31: 0]	<= #1	i_PWDATA			;
	//else if(w_addr114C_wr)	r_rx_ch0_start_addr[39:32]	<= #1	i_PWDATA[7:0]		;
	else if(w_addr164_wr)		r_rx_ch0_start_addr[31: 0]	<= #1	i_PWDATA			;
	else if(w_addr1164_wr)		r_rx_ch0_start_addr[39:32]	<= #1	i_PWDATA[7:0]		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_rx_ch1_start_addr		<= #1	0					;
	//else if(w_addr150_wr)		r_rx_ch1_start_addr[31: 0]	<= #1	i_PWDATA			;
	//else if(w_addr1150_wr)	r_rx_ch1_start_addr[39:32]	<= #1	i_PWDATA[7:0]		;
	else if(w_addr168_wr)		r_rx_ch1_start_addr[31: 0]	<= #1	i_PWDATA			;
	else if(w_addr1168_wr)		r_rx_ch1_start_addr[39:32]	<= #1	i_PWDATA[7:0]		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_rx_ch2_start_addr		<= #1	0					;
	//else if(w_addr154_wr)		r_rx_ch2_start_addr[31: 0]	<= #1	i_PWDATA			;
	//else if(w_addr1154_wr)	r_rx_ch2_start_addr[39:32]	<= #1	i_PWDATA[7:0]		;
	else if(w_addr16C_wr)		r_rx_ch2_start_addr[31: 0]	<= #1	i_PWDATA			;
	else if(w_addr116C_wr)		r_rx_ch2_start_addr[39:32]	<= #1	i_PWDATA[7:0]		;

//assign  o_RX_CH0_START_ADDR = 	r_rx_ch0_start_addr	;		
//assign  o_RX_CH1_START_ADDR = 	r_rx_ch1_start_addr	;
//assign  o_RX_CH2_START_ADDR = 	r_rx_ch2_start_addr	;
/*
// RX Top addr
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_rx_ch0_top_addr			<= #1	0					;
	else if(w_addr158_wr)		r_rx_ch0_top_addr[31: 0]	<= #1	i_PWDATA			;
	else if(w_addr1158_wr)		r_rx_ch0_top_addr[39:32]	<= #1	i_PWDATA[7:0]		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_rx_ch1_top_addr			<= #1	0					;
	else if(w_addr15C_wr)		r_rx_ch1_top_addr[31: 0]	<= #1	i_PWDATA			;
	else if(w_addr115C_wr)		r_rx_ch1_top_addr[39:32]	<= #1	i_PWDATA[7:0]		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_rx_ch2_top_addr			<= #1	0					;
	else if(w_addr160_wr)		r_rx_ch2_top_addr[31: 0]	<= #1	i_PWDATA			;
	else if(w_addr1160_wr)		r_rx_ch2_top_addr[39:32]	<= #1	i_PWDATA[7:0]		;

// RX Bottom addr

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_rx_ch0_bottom_addr		<= #1	40'hFFFF_FFFF;
	else if(w_addr164_wr)		r_rx_ch0_bottom_addr[31: 0]	<= #1	i_PWDATA			;
	else if(w_addr1164_wr)		r_rx_ch0_bottom_addr[39:32]	<= #1	i_PWDATA[7:0]		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_rx_ch1_bottom_addr		<= #1	40'hFFFF_FFFF	;
	else if(w_addr168_wr)		r_rx_ch1_bottom_addr[31: 0]	<= #1	i_PWDATA			;
	else if(w_addr1168_wr)		r_rx_ch1_bottom_addr[39:32]	<= #1	i_PWDATA[7:0]		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_rx_ch2_bottom_addr		<= #1	40'hFFFF_FFFF;
	else if(w_addr16C_wr)		r_rx_ch2_bottom_addr[31: 0]	<= #1	i_PWDATA			;
	else if(w_addr116C_wr)		r_rx_ch2_bottom_addr[39:32]	<= #1	i_PWDATA[7:0]		;
*/
//----------------------------------------------------------------------------------
// RX dma con
//----------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
//	if(!i_HRESETn)				r_rx_dma_con				<= #1	26'h100_0000	;
	if(!i_HRESETn)				r_rx_dma_con				<= #1	26'h000_0000	;
	else if(w_addr190_wr)		r_rx_dma_con				<= #1	i_PWDATA[25:0]		;

assign		o_RX_INCR				= r_rx_incr										;
//assign		o_RX_CH0_TOP_ADDR		= r_rx_ch0_top_addr								;
//assign		o_RX_CH1_TOP_ADDR		= r_rx_ch1_top_addr								;
//assign		o_RX_CH2_TOP_ADDR		= r_rx_ch2_top_addr								;
//assign		o_RX_CH0_BOT_ADDR		= r_rx_ch0_bottom_addr							;
//assign		o_RX_CH1_BOT_ADDR		= r_rx_ch1_bottom_addr							;
//assign		o_RX_CH2_BOT_ADDR		= r_rx_ch2_bottom_addr							;

assign		o_RX_SWAP_EN			= r_rx_dma_con[25:24];
assign		o_RX_ARPROT				= {r_rx_dma_con[22], r_tzpc, r_rx_dma_con[20]};
assign		o_RX_ARCACHE			= r_rx_dma_con[19:16];
assign		o_RX_ISSUE_CAP			= r_rx_dma_con[2:0];


// -----------------------------------------------------------------------------------
//	29) TX DMA
// -----------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_TX_START				<= #1	1'b0				;
	else if(w_addr1C0_wr)		r_TX_START				<= #1 	i_PWDATA[0]			;
	else if(r_TX_START)		r_TX_START				<= #1 	1'b0				;	// Note: short pluse

// -----------------------------------------------------------------------------------
//	TX DMA Control
// -----------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
//	if(!i_HRESETn)				r_tx_dma_con			<= #1 	26'h100_000b;						
	if(!i_HRESETn)				r_tx_dma_con			<= #1 	26'h000_000b;						
	else if(w_addr1C4_wr)		r_tx_dma_con			<= #1 	i_PWDATA[25:0]		;	

// -----------------------------------------------------------------------------------
//	TX BAND NUM
// -----------------------------------------------------------------------------------
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_band_num			<= #1 8'h1;
	else if(w_addr1C8_wr)		r_tx_band_num			<= #1 i_PWDATA[7:0]		;

//assign  o_TX_BAND_NUM = r_tx_band_num;

//	data incr
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_data_incr			<= #1 	0;
	else if(w_addr1CC_wr)		r_tx_data_incr			<= #1 	i_PWDATA[15:0]		;


/* 
//	alpha incr
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_alpha_incr			<= #1 	0				;
	else if(w_addr1D0_wr)		r_tx_alpha_incr			<= #1 	i_PWDATA[15:0]		;

// for SPA
//always @ (negedge i_HRESETn or posedge i_PCLK)
//	if(!i_HRESETn)				r_tx_att_start_addr				<= #1 	0;
//	else if(w_addr1E4_wr)		r_tx_att_start_addr[31: 0]		<= #1 	i_PWDATA			;
//	else if(w_addr11E4_wr)		r_tx_att_start_addr[39:32]		<= #1 	i_PWDATA[7:0]			;
*/
// Reserved
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_addr_ch0_max				<= #1 	40'hFF_FFFF_FFFF;
	else if(w_addr1F0_wr)		r_tx_addr_ch0_max[31: 0]		<= #1 	i_PWDATA	;
	else if(w_addr11F0_wr)		r_tx_addr_ch0_max[39:32]		<= #1 	i_PWDATA[7:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_addr_ch0_min				<= #1 	0;
	else if(w_addr1F4_wr)		r_tx_addr_ch0_min[31: 0]		<= #1 	i_PWDATA	;
	else if(w_addr11F4_wr)		r_tx_addr_ch0_min[39:32]		<= #1 	i_PWDATA[7:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_addr_ch1_max				<= #1 	40'hFF_FFFF_FFFF;
	else if(w_addr1F8_wr)		r_tx_addr_ch1_max[31: 0]		<= #1 	i_PWDATA	;
	else if(w_addr11F8_wr)		r_tx_addr_ch1_max[39:32]		<= #1 	i_PWDATA[7:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_addr_ch1_min				<= #1 	0;
	else if(w_addr1FC_wr)		r_tx_addr_ch1_min[31: 0]		<= #1 	i_PWDATA	;
	else if(w_addr11FC_wr)		r_tx_addr_ch1_min[39:32]		<= #1 	i_PWDATA[7:0]	;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_addr_ch2_max				<= #1 	40'hFF_FFFF_FFFF;
	else if(w_addr200_wr)		r_tx_addr_ch2_max[31: 0]		<= #1 	i_PWDATA	;
	else if(w_addr1200_wr)		r_tx_addr_ch2_max[39:32]		<= #1 	i_PWDATA[7:0]	;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_addr_ch2_min				<= #1 	0;
	else if(w_addr204_wr)		r_tx_addr_ch2_min[31: 0]		<= #1 	i_PWDATA	;
	else if(w_addr1204_wr)		r_tx_addr_ch2_min[39:32]		<= #1 	i_PWDATA[7:0]	;



// start addr
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_tx_ch0_start_addr			<= #1 	0				;
	else if(w_addr1D4_wr)		r_tx_ch0_start_addr[31: 0]	<= #1 	i_PWDATA			;
	else if(w_addr11D4_wr)		r_tx_ch0_start_addr[39:32]	<= #1 	i_PWDATA[7:0]		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_ch1_start_addr			<= #1 	0;
	else if(w_addr1D8_wr)		r_tx_ch1_start_addr[31: 0]	<= #1 	i_PWDATA;
	else if(w_addr11D8_wr)		r_tx_ch1_start_addr[39:32]	<= #1 	i_PWDATA[7:0];


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_tx_ch2_start_addr				<= #1 	0;
	else if(w_addr1DC_wr)		r_tx_ch2_start_addr[31: 0]		<= #1 	i_PWDATA			;
	else if(w_addr11DC_wr)		r_tx_ch2_start_addr[39:32]		<= #1 	i_PWDATA[7:0]			;

assign 		o_TX_MAX_WISSUE						= r_tx_dma_con[4:0]													;
assign 		o_TX_INT_CHECK						= r_tx_dma_con[ 7]													;
// reserved
assign 		o_TX_ARB_MODE						= r_tx_dma_con[ 9]													;

assign		o_TX_AWCACHE						= r_tx_dma_con[19:16];
assign		o_TX_AWPROT							= { r_tx_dma_con[22],  r_tx_dma_con[20]};
assign		o_TX_SWAP_EN						= r_tx_dma_con[25:24];

assign 		o_TX_DATA_INCR						= 	r_tx_data_incr													;

assign		o_TX_ADDR_CH0_MAX					=	r_tx_addr_ch0_max												;
assign		o_TX_ADDR_CH0_MIN					=	r_tx_addr_ch0_min												;
assign		o_TX_ADDR_CH1_MAX					=	r_tx_addr_ch1_max												;
assign		o_TX_ADDR_CH1_MIN					=	r_tx_addr_ch1_min												;
assign		o_TX_ADDR_CH2_MAX					=	r_tx_addr_ch2_max												;
assign		o_TX_ADDR_CH2_MIN					=	r_tx_addr_ch2_min												;

assign  o_TX_CH0_START_ADDR = r_tx_ch0_start_addr;		
assign  o_TX_CH1_START_ADDR = r_tx_ch1_start_addr;
assign  o_TX_CH2_START_ADDR = r_tx_ch2_start_addr;
// -----------------------------------------------------------------------------------
//	ADAPT 
// -----------------------------------------------------------------------------------
reg		[23:0]	r_adapt_dma_con			;
reg		[31:0]	r_adapt_dma_addr_incr		;
reg		[39:0]	r_adapt_dma_addr		;
reg		[39:0]	r_adapt_dma_tx_addr_max		;
reg		[39:0]	r_adapt_dma_tx_addr_min		;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_adapt_dma_con			<= #1 	24'hFF_0000			;
	else if(w_addr280_wr)		r_adapt_dma_con		 	<= #1 	i_PWDATA[23:0]		;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_adapt_dma_addr		<= #1 	32'h0				;
	else if(w_addr284_wr)		r_adapt_dma_addr[31: 0]		<= #1 	i_PWDATA			;
	else if(w_addr1284_wr)		r_adapt_dma_addr[39:32]		<= #1 	i_PWDATA[7:0]		;			

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_adapt_dma_addr_incr		<= #1 	32'h0				;
	else if(w_addr288_wr)		r_adapt_dma_addr_incr		<= #1 	i_PWDATA			;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_adapt_dma_tx_addr_max		<= #1 	40'hFF_FFFF_FFFF;
	else if(w_addr290_wr)		r_adapt_dma_tx_addr_max[31: 0]	<= #1 	i_PWDATA;
	else if(w_addr1290_wr)		r_adapt_dma_tx_addr_max[39:32]	<= #1 	i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_adapt_dma_tx_addr_min		<= #1 	0;
	else if(w_addr294_wr)		r_adapt_dma_tx_addr_min[31: 0]	<= #1 	i_PWDATA;
	else if(w_addr1294_wr)		r_adapt_dma_tx_addr_min[39:32]	<= #1 	i_PWDATA[7:0];


assign		w_ADAPT_OUT_BANDS	=	r_adapt_dma_con[23:16]	;
//assign		w_ADAPT_OUT_BANDS_m1	=	w_ADAPT_OUT_BANDS - 1;

assign		o_ASB_INT_CHECK  = r_adapt_dma_con[1:0];	

assign		o_ADAPT_DMA_ADDR		=	r_adapt_dma_addr	 	;
assign		o_ADAPT_DMA_ADDR_INCR		=	r_adapt_dma_addr_incr	;
assign		o_ADAPT_TX_ADDR_MAX		=	r_adapt_dma_tx_addr_max	;
assign		o_ADAPT_TX_ADDR_MIN		=	r_adapt_dma_tx_addr_min	;

/*
	wire 	w_ADAPT_BDS_SMAP_START ;
	assign	w_ADAPT_BDS_SMAP_START = 	(o_TX_CH_EN ) ? r_TX_START : o_RX_START ;
	assign	w_ADAPT_TX_START_ORG =	(o_ADAPT_OUT_BANDS == 8'hff)	?	r_CORE_START_3d	:	w_ADAPT_BDS_SMAP_START ;
	assign	o_ADAPT_DMA_TX_START =	(o_ADAPT_EN)	?	 w_ADAPT_TX_START_ORG  : 0;
*/

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_ADAPT_TX_START				<= #1 1'b0				;
	else if(w_addr2A0_wr)			r_ADAPT_TX_START				<= #1 i_PWDATA[0]		;
	else if(r_ADAPT_TX_START)		r_ADAPT_TX_START				<= #1 1'b0				;
end

	assign	o_ADAPT_DMA_TX_START =	(o_ADAPT_EN)	?	 r_ADAPT_TX_START  : 0;
										
	assign  o_ADAPT_OUT_BANDS = w_ADAPT_OUT_BANDS;

/*
	assign  w_ADAPT_BAND_END_M_sp	=	(r_ADAPT_TX_BAND_CNT == w_ADAPT_OUT_BANDS_m1)&&i_ADAPT_DMA_OUTPUT_BAND_END;
	always @ (negedge i_HRESETn or posedge i_PCLK)
		if(!i_HRESETn)										r_ADAPT_TX_BAND_CNT <= #1 0; 
		else if(o_CORE_START)									r_ADAPT_TX_BAND_CNT <= #1 0; 
		else if(i_ADAPT_DMA_OUTPUT_BAND_END&&(r_ADAPT_TX_BAND_CNT == w_ADAPT_OUT_BANDS_m1))	r_ADAPT_TX_BAND_CNT <= #1 0; 
		else if(i_ADAPT_DMA_OUTPUT_BAND_END)							r_ADAPT_TX_BAND_CNT <= #1 r_ADAPT_TX_BAND_CNT + 1; 
*/

// -----------------------------------------------------------------------------------
//	SMAP
// -----------------------------------------------------------------------------------
reg		[23:0]	r_smap_dma_con				;
reg		[39:0]	r_smap_dma_addr_incr		;
reg		[39:0]	r_smap_dma_addr			;
reg		[39:0]	r_smap_dma_tx_addr_max		;
reg		[39:0]	r_smap_dma_tx_addr_min		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_smap_dma_con			<= #1 	24'hFF_0000			;
	else if(w_addr2C0_wr)		r_smap_dma_con		 	<= #1 	i_PWDATA[23:0]		;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_smap_dma_addr			<= #1 	32'h0				;
	else if(w_addr2C4_wr)		r_smap_dma_addr[31: 0] 		<= #1 	i_PWDATA			;
	else if(w_addr12C4_wr)		r_smap_dma_addr[39:32]	 	<= #1 	i_PWDATA[7:0]		;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_smap_dma_addr_incr		<= #1 	32'h0				;
	else if(w_addr2C8_wr)		r_smap_dma_addr_incr		<= #1 	i_PWDATA			;
// Reserved
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_smap_dma_tx_addr_max			<= #1 	40'hFF_FFFF_FFFF;
	else if(w_addr2D0_wr)		r_smap_dma_tx_addr_max[31: 0]	<= #1 	i_PWDATA;
	else if(w_addr12D0_wr)		r_smap_dma_tx_addr_max[39:32]	<= #1 	i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_smap_dma_tx_addr_min			<= #1 	0;
	else if(w_addr2D4_wr)		r_smap_dma_tx_addr_min[31: 0]	<= #1 	i_PWDATA;
	else if(w_addr12D4_wr)		r_smap_dma_tx_addr_min[39:32]	<= #1 	i_PWDATA[7:0];


assign		w_SMAP_OUT_BANDS		= r_smap_dma_con[23:16]	;
assign		o_SMAP_DMA_ADDR			=	r_smap_dma_addr	 	;
assign		o_SMAP_DMA_ADDR_INCR		=	r_smap_dma_addr_incr	;
assign		o_SMAP_TX_ADDR_MAX		=	r_smap_dma_tx_addr_max	;
assign		o_SMAP_TX_ADDR_MIN		=	r_smap_dma_tx_addr_min	;


always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_SMAP_TX_START				<= #1 1'b0				;
	else if(w_addr2E0_wr)			r_SMAP_TX_START				<= #1 i_PWDATA[0]		;
	else if(r_SMAP_TX_START)		r_SMAP_TX_START				<= #1 1'b0				;
end

/*
	assign	w_SMAP_TX_START_ORG =	(o_SMAP_OUT_BANDS == 8'hff)	?	r_CORE_START_3d	:	w_ADAPT_BDS_SMAP_START ;
	assign	o_SMAP_DMA_TX_START=	(o_SMAP_EN)	?	w_SMAP_TX_START_ORG : 0;
*/
	assign	o_SMAP_DMA_TX_START=	(o_SMAP_EN)	?	r_SMAP_TX_START : 0;

	assign  o_SMAP_OUT_BANDS = w_SMAP_OUT_BANDS;
/*
	assign  w_SMAP_BAND_END_M_sp	=	(r_SMAP_TX_BAND_CNT == w_SMAP_OUT_BANDS_m1) && i_SMAP_DMA_OUTPUT_BAND_END;
	always @ (negedge i_HRESETn or posedge i_PCLK)
		if(!i_HRESETn)							r_SMAP_TX_BAND_CNT <= #1 0; 
		else if(o_CORE_START)						r_SMAP_TX_BAND_CNT <= #1 0; 
		else if(i_SMAP_DMA_OUTPUT_BAND_END&&(r_SMAP_TX_BAND_CNT == w_SMAP_OUT_BANDS_m1)	)		r_SMAP_TX_BAND_CNT <= #1 0; 
		else if(i_SMAP_DMA_OUTPUT_BAND_END)								r_SMAP_TX_BAND_CNT <= #1 r_SMAP_TX_BAND_CNT + 1; 
*/
// -----------------------------------------------------------------------------------
//	BDS
// -----------------------------------------------------------------------------------
reg		[23:0]	r_bds_dma_con				;
reg		[39:0]	r_bds_dma_addr_incr		;
reg		[39:0]	r_bds_dma_addr			;
reg		[39:0]	r_bds_dma_tx_addr_max		;
reg		[39:0]	r_bds_dma_tx_addr_min		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_bds_dma_con			<= #1 	24'hFF_0000			;
	else if(w_addr300_wr)		r_bds_dma_con		 	<= #1 	i_PWDATA[23:0]		;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_bds_dma_addr			<= #1 	32'h0				;
	else if(w_addr304_wr)		r_bds_dma_addr[31: 0] 		<= #1 	i_PWDATA			;
	else if(w_addr1304_wr)		r_bds_dma_addr[39:32]	 	<= #1 	i_PWDATA[7:0]		;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_bds_dma_addr_incr		<= #1 	32'h0				;
	else if(w_addr308_wr)		r_bds_dma_addr_incr		<= #1 	i_PWDATA			;
// Reserved
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_bds_dma_tx_addr_max		<= #1 	40'hFF_FFFF_FFFF;
	else if(w_addr310_wr)		r_bds_dma_tx_addr_max[31: 0]	<= #1 	i_PWDATA;
	else if(w_addr1310_wr)		r_bds_dma_tx_addr_max[39:32]	<= #1 	i_PWDATA[7:0];

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)			r_bds_dma_tx_addr_min		<= #1 	0;
	else if(w_addr314_wr)		r_bds_dma_tx_addr_min[31: 0]	<= #1 	i_PWDATA;
	else if(w_addr1314_wr)		r_bds_dma_tx_addr_min[39:32]	<= #1 	i_PWDATA[7:0];


assign		w_BDS_OUT_BANDS		= r_bds_dma_con[23:16]	;
//assign		w_BDS_OUT_BANDS_m1	= w_BDS_OUT_BANDS - 1;	

assign		o_BDS_DMA_ADDR		=	r_bds_dma_addr	 	;
assign		o_BDS_DMA_ADDR_INCR	=	r_bds_dma_addr_incr	;
assign		o_BDS_TX_ADDR_MAX	=	r_bds_dma_tx_addr_max	;
assign		o_BDS_TX_ADDR_MIN	=	r_bds_dma_tx_addr_min	;

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_BDS_TX_START				<= #1 1'b0				;
	else if(w_addr320_wr)			r_BDS_TX_START				<= #1 i_PWDATA[0]		;
	else if(r_BDS_TX_START)			r_BDS_TX_START				<= #1 1'b0				;
end
/*
	assign	w_BDS_TX_START_ORG =	(o_BDS_OUT_BANDS == 8'hff)	?	r_CORE_START_3d	:	w_ADAPT_BDS_SMAP_START ;
	assign	o_BDS_DMA_TX_START	=	(o_BDS_EN )	?	w_BDS_TX_START_ORG : 0;
*/
	assign	o_BDS_DMA_TX_START	=	(o_BDS_EN )	?	r_BDS_TX_START: 0;

	assign  o_BDS_OUT_BANDS = w_BDS_OUT_BANDS;
//	assign  w_BDS_BAND_END_M_sp	=	(r_BDS_TX_BAND_CNT == w_BDS_OUT_BANDS_m1)&&i_BDS_DMA_OUTPUT_BAND_END;

	//always @ (negedge i_HRESETn or posedge i_PCLK)
	//	if(!i_HRESETn)									r_BDS_TX_BAND_CNT <= #1 0; 
	//	else if(o_CORE_START)								r_BDS_TX_BAND_CNT <= #1 0; 
	//	else if(i_BDS_DMA_OUTPUT_BAND_END&&(r_BDS_TX_BAND_CNT == w_BDS_OUT_BANDS_m1)	)		r_BDS_TX_BAND_CNT <= #1 0; 
	//	else if(i_BDS_DMA_OUTPUT_BAND_END)								r_BDS_TX_BAND_CNT <= #1 r_BDS_TX_BAND_CNT + 1; 

/*
//---------------------------------------------------------------------------------------------
// TX ADDR ERR
//---------------------------------------------------------------------------------------------
wire	w_TX_ADDR_ERR_sp;

reg	r_TX_ADDR_ERR_CH0;
reg	r_TX_ADDR_ERR_CH1;
reg	r_TX_ADDR_ERR_CH2;

assign  w_TX_ADDR_ERR_sp = i_DMA_TX_ADDR_ERR_CH2 ||  i_DMA_TX_ADDR_ERR_CH1 || i_DMA_TX_ADDR_ERR_CH0;

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_TX_ADDR_ERR_CH0	<= #1 	1'h0;
	if(r_CORE_START)			r_TX_ADDR_ERR_CH0	<= #1 	1'h0;
	else if(i_DMA_TX_ADDR_ERR_CH0)		r_TX_ADDR_ERR_CH0	<= #1 	1'h1;
end

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_TX_ADDR_ERR_CH1	<= #1 	1'h0;
	if(r_CORE_START)			r_TX_ADDR_ERR_CH1	<= #1 	1'h0;
	else if(i_DMA_TX_ADDR_ERR_CH1)		r_TX_ADDR_ERR_CH1	<= #1 	1'h1;
end

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)				r_TX_ADDR_ERR_CH2	<= #1 	1'h0;
	if(r_CORE_START)			r_TX_ADDR_ERR_CH2	<= #1 	1'h0;
	else if(i_DMA_TX_ADDR_ERR_CH2)		r_TX_ADDR_ERR_CH2	<= #1 	1'h1;
end
*/
//-----------------------------------------------------------------------------------
// IRQ
//-----------------------------------------------------------------------------------
reg		[31:0]	r_irq_enable		;
reg		[31:0]	r_irq_svc_cnt		;
reg			r_irq_svc_flag		;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)						r_irq_enable		<= #1	32'h0				;
	else if(w_addr030_wr)					r_irq_enable		<= #1 	i_PWDATA[31:0]				;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)						r_irq_svc_flag		<= #1 	1'b0						;
	else if(w_addr038_wr)					r_irq_svc_flag		<= #1 	1'b1						;
	else if(w_addr038_rd)					r_irq_svc_flag		<= #1 	1'b0						;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)						r_irq_svc_cnt		<= #1 	32'h0						;
	else if(w_addr038_wr)					r_irq_svc_cnt		<= #1 	32'h0						;
	else if(r_irq_svc_flag == 1'b1)				r_irq_svc_cnt		<= #1 	r_irq_svc_cnt + 32'h1		;

wire	[31:0]	w_irq_src, 	w_irq_pend, 	w_irq_clr;

reg				r_irq_pend0, 
				r_irq_pend1, 
				r_irq_pend2, 
				r_irq_pend3, 
				r_irq_pend4, 
				r_irq_pend5, 
				r_irq_pend6, 
				r_irq_pend7, 
				r_irq_pend8, 
				r_irq_pend9, 
				r_irq_pend10, 
				r_irq_pend11, 
				r_irq_pend12, 
				r_irq_pend13, 
				r_irq_pend14, 
				r_irq_pend15, 
				r_irq_pend16, 
				r_irq_pend17, 
				r_irq_pend18,
				r_irq_pend19,
				r_irq_pend20,
				r_irq_pend21,
				r_irq_pend22,
				r_irq_pend23,
				r_irq_pend24,
				r_irq_pend25,
				r_irq_pend26,
				r_irq_pend27,
				r_irq_pend28,
				r_irq_pend29,
				r_irq_pend30,
				r_irq_pend31;


assign		w_irq_src	=	{	
								w_TX_PAGE_DONE_sp, // 31
								i_TX_CH_START_ERR, // 30
								i_VSD_DONE_sp, // 29
								i_ACS_DONE_sp, // 28
								w_ACBD_DETECT_DONE_sp,   // 27  for SPA
								w_NEWABSD_DETECT_DONE_sp,   // 26  for SPA
								w_ORI_DONE_sp,   // 25  for SPA
								i_BDS_TX_ADDR_ERR,		//24
								i_BDS_START_ERR,		 //23
								i_BDS_DMA_TX_END,		 //22
								i_RRESP_ERR_INT,		 // 21
								i_YD_ERR,			 // 20 
								o_TBL_END_M_sp,			 // 19		
								i_SMAP_TX_ADDR_ERR,		 // 18
								i_ADAPT_TX_ADDR_ERR,     // 17
								w_CLA_DONE_sp,   // 16
								i_MAGD_DETECT_DONE_sp,   // 15
								i_DMA_TX_ADDR_ERR_CH2,   // 14
								i_DMA_TX_ADDR_ERR_CH1,   // 13
								i_DMA_TX_ADDR_ERR_CH0,	 // 12
								i_SMAP_START_ERR,		 // 11
								i_ADAPT_START_ERR,		 // 10
								i_TX_ERR,				 // 9
								i_DMA_RESET_DONE_sp,     // 8 //o_sw_reset_done_sp,		// 8
								i_SMAP_DMA_TX_END,       // 7 //w_SMAP_END_M_sp,		// 7
								i_ADAPT_DMA_TX_END,      // 6  //w_ADAPT_END_M_sp,		// 6
								i_ABSD_DETECT_DONE_sp,	// 5
								w_PAGE_DONE_sp,	 // 4
								w_BAND_DONE_sp,	 // 3
								i_TX_START_INT,		// 2
								i_RX_BAND_DONE,		 // 1
								i_RX_START_INT		 // 0
								};		

  assign		w_irq_clr	= {32{w_addr034_wr}} & i_PWDATA[31:0];

assign		w_irq_pend	= {	
							r_irq_pend31,		// 31
							r_irq_pend30,		// 30
							r_irq_pend29,		// 29
							r_irq_pend28,		// 28
							r_irq_pend27,		// 27
							r_irq_pend26,		// 26
							r_irq_pend25,		// 25
							r_irq_pend24,		// 24
							r_irq_pend23,		// 23
							r_irq_pend22,		// 22	
							r_irq_pend21,		
							r_irq_pend20,		
							r_irq_pend19,
							r_irq_pend18, 
							r_irq_pend17, 
							r_irq_pend16, 
							r_irq_pend15, 
							r_irq_pend14, 
							r_irq_pend13, 
							r_irq_pend12, 
							r_irq_pend11, 
							r_irq_pend10, 
							r_irq_pend9, 
							r_irq_pend8, 
							r_irq_pend7, 
							r_irq_pend6, 
							r_irq_pend5, 
							r_irq_pend4, 
							r_irq_pend3, 
							r_irq_pend2, 
							r_irq_pend1, 
							r_irq_pend0 
						};


  assign	o_IRQ = |( r_irq_enable & w_irq_pend);


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_irq_pend0		<= #1 	1'h0;
	else if(w_irq_src[0])			r_irq_pend0		<= #1 	1'h1;
	else if(w_irq_clr[0])			r_irq_pend0		<= #1 	1'b0;
	
always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_irq_pend1		<= #1 	1'h0;
	else if(w_irq_src[1])			r_irq_pend1		<= #1 	1'h1;
	else if(w_irq_clr[1])			r_irq_pend1		<= #1 	1'b0;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_irq_pend2		<= #1 	1'h0;
	else if(w_irq_src[2])			r_irq_pend2		<= #1 	1'h1;
	else if(w_irq_clr[2])			r_irq_pend2		<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_irq_pend3		<= #1 	1'h0;
	else if(w_irq_src[3])			r_irq_pend3		<= #1 	1'h1;
	else if(w_irq_clr[3])			r_irq_pend3		<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend4		<= #1 	1'h0;
	else if(w_irq_src[4])			r_irq_pend4		<= #1 	1'h1;
	else if(w_irq_clr[4])			r_irq_pend4		<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_irq_pend5		<= #1 	1'h0;
	else if(w_irq_src[5])			r_irq_pend5		<= #1 	1'h1;
	else if(w_irq_clr[5])			r_irq_pend5		<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend6		<= #1 	1'h0;
	else if(w_irq_src[6])			r_irq_pend6		<= #1 	1'h1;
	else if(w_irq_clr[6])			r_irq_pend6		<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend7		<= #1 	1'h0;
	else if(w_irq_src[7])			r_irq_pend7		<= #1 	1'h1;
	else if(w_irq_clr[7])			r_irq_pend7		<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend8		<= #1 	1'h0;
	else if(w_irq_src[8])			r_irq_pend8		<= #1 	1'h1;
	else if(w_irq_clr[8])			r_irq_pend8		<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend9		<= #1 	1'h0;
	else if(w_irq_src[9])			r_irq_pend9		<= #1 	1'h1;
	else if(w_irq_clr[9])			r_irq_pend9		<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend10	<= #1 	1'h0;
	else if(w_irq_src[10])			r_irq_pend10	<= #1 	1'h1;
	else if(w_irq_clr[10])			r_irq_pend10	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend11	<= #1 	1'h0;
	else if(w_irq_src[11])			r_irq_pend11	<= #1 	1'h1;
	else if(w_irq_clr[11])			r_irq_pend11	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend12	<= #1 	1'h0;
	else if(w_irq_src[12])			r_irq_pend12	<= #1 	1'h1;
	else if(w_irq_clr[12])			r_irq_pend12	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend13	<= #1 	1'h0;
	else if(w_irq_src[13])			r_irq_pend13	<= #1 	1'h1;
	else if(w_irq_clr[13])			r_irq_pend13	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend14	<= #1 	1'h0;
	else if(w_irq_src[14])			r_irq_pend14	<= #1 	1'h1;
	else if(w_irq_clr[14])			r_irq_pend14	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend15	<= #1 	1'h0;
	else if(w_irq_src[15])			r_irq_pend15	<= #1 	1'h1;
	else if(w_irq_clr[15])			r_irq_pend15	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend16	<= #1 	1'h0;
	else if(w_irq_src[16])			r_irq_pend16	<= #1 	1'h1;
	else if(w_irq_clr[16])			r_irq_pend16	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend17	<= #1 	1'h0;
	else if(w_irq_src[17])			r_irq_pend17	<= #1 	1'h1;
	else if(w_irq_clr[17])			r_irq_pend17	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend18	<= #1 	1'h0;
	else if(w_irq_src[18])			r_irq_pend18	<= #1 	1'h1;
	else if(w_irq_clr[18])			r_irq_pend18	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend19	<= #1 	1'h0;
	else if(w_irq_src[19])			r_irq_pend19	<= #1 	1'h1;
	else if(w_irq_clr[19])			r_irq_pend19	<= #1 	1'b0;


always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend20	<= #1 	1'h0;
	else if(w_irq_src[20])			r_irq_pend20	<= #1 	1'h1;
	else if(w_irq_clr[20])			r_irq_pend20	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend21	<= #1 	1'h0;
	else if(w_irq_src[21])			r_irq_pend21	<= #1 	1'h1;
	else if(w_irq_clr[21])			r_irq_pend21	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend22	<= #1 	1'h0;
	else if(w_irq_src[22])			r_irq_pend22	<= #1 	1'h1;
	else if(w_irq_clr[22])			r_irq_pend22	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend23	<= #1 	1'h0;
	else if(w_irq_src[23])			r_irq_pend23	<= #1 	1'h1;
	else if(w_irq_clr[23])			r_irq_pend23	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend24	<= #1 	1'h0;
	else if(w_irq_src[24])			r_irq_pend24	<= #1 	1'h1;
	else if(w_irq_clr[24])			r_irq_pend24	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend25	<= #1 	1'h0;
	else if(w_irq_src[25])			r_irq_pend25	<= #1 	1'h1;
	else if(w_irq_clr[25])			r_irq_pend25	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend26	<= #1 	1'h0;
	else if(w_irq_src[26])			r_irq_pend26	<= #1 	1'h1;
	else if(w_irq_clr[26])			r_irq_pend26	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)					r_irq_pend27	<= #1 	1'h0;
	else if(w_irq_src[27])			r_irq_pend27	<= #1 	1'h1;
	else if(w_irq_clr[27])			r_irq_pend27	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_irq_pend28	<= #1 	1'h0;
	else if(w_irq_src[28])			r_irq_pend28	<= #1 	1'h1;
	else if(w_irq_clr[28])			r_irq_pend28	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_irq_pend29	<= #1 	1'h0;
	else if(w_irq_src[29])			r_irq_pend29	<= #1 	1'h1;
	else if(w_irq_clr[29])			r_irq_pend29	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_irq_pend30	<= #1 	1'h0;
	else if(w_irq_src[30])			r_irq_pend30	<= #1 	1'h1;
	else if(w_irq_clr[30])			r_irq_pend30	<= #1 	1'b0;

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_irq_pend31	<= #1 	1'h0;
	else if(w_irq_src[31])			r_irq_pend31	<= #1 	1'h1;
	else if(w_irq_clr[31])			r_irq_pend31	<= #1 	1'b0;

//---------------------------------------------------------------------------------------
//	Read SFR.
//---------------------------------------------------------------------------------------
always @ (*) begin
	case(1'b1)
		w_addr000_rd	: r_prdata = {16'h0, 7'h0, r_SW_RESET, 7'h0, r_DMA_STOP};
		w_addr004_rd	: r_prdata = {30'h0, r_CORE_BUSY, r_CORE_START};
		w_addr008_rd	: r_prdata = {  13'h0,	r_SPA_MODE[18:16],
										8'h0,	 
										2'h0,	r_SPA_MODE[ 5: 4],
										2'h0,	r_SPA_MODE[ 1: 0]		};
		w_addr00C_rd	: r_prdata = { 8'h0,  r_SPA_EN[23:20], 4'h0, r_SPA_EN[15:8], 1'h0, r_SPA_EN[6:0]};		
		w_addr010_rd	: r_prdata = o_RX_XD;
		w_addr014_rd	: r_prdata = o_RX_YD;
	//	w_addr018_rd	: r_prdata = {o_TX_YD, o_TX_XD};
		w_addr018_rd	: r_prdata = {r_RX_YD_ALIGNED, r_RX_XD_ALIGNED};
		w_addr01C_rd	: r_prdata = { 8'h0, r_RX_PADDING_VAL};
	//	w_addr020_rd	:    
		w_addr024_rd	: r_prdata = 32'h2018_0312;
	//	w_addr028_rd	: r_prdata =
//+---------------------+---------------+------------------------------------------------------------+
//		 02C				reserved
//+---------------------+---------------+------------------------------------------------------------+
		// IRQ
		w_addr030_rd	: r_prdata = r_irq_enable;
		w_addr034_rd	: r_prdata = w_irq_pend;
		w_addr038_rd	: r_prdata = r_irq_svc_cnt;

		// SRAM
		w_addr03C_rd	: r_prdata = {31'h0, r_RAM_SW_MODE	  };
		w_addr040_rd	: r_prdata = { 7'h0, r_RAM_CS[24:0] };
		w_addr048_rd	: r_prdata = i_RAM_RD_DATA;
		w_addr04C_rd	: r_prdata = r_RAM_ADDR;
//		w_addr050_rd	: //reserved
		w_addr054_rd	: r_prdata = {23'h0, i_CORE_BAND_END};
		w_addr058_rd	: r_prdata = {23'h0, i_CORE_PAGE_END};
//		w_addr060_rd	: //reserved
//		w_addr064_rd	: //reserved
//		w_addr068_rd	: //reserved
		w_addr06C_rd	: r_prdata = { r_TBL_RX_START_CNT, r_TBL_RX_END_CNT };
		w_addr070_rd	: r_prdata = { r_TBL_TX_START_CNT, r_TBL_TX_END_CNT };
		w_addr074_rd	: r_prdata =  r_TBL_END_STATUS1;
	//	w_addr078_rd	: r_prdata = { 21'h0, r_TBL_END_STATUS2};
	// TBL_DRX
		w_addr080_rd	: r_prdata = {23'h0, r_TBL_RW, 7'h0, r_TBL_STARTsp};
		w_addr084_rd	: r_prdata = { 7'h0, r_TBL_ENABLE[24:0]};
	//	w_addr088_rd	: r_prdata = {21'h0, r_TBL_ENABLE[42:32]};
		
		w_addr08C_rd	: r_prdata = r_TBL_ADDR_00[31:0];
		w_addr090_rd	: r_prdata = r_TBL_ADDR_01[31:0];
		w_addr094_rd	: r_prdata = r_TBL_ADDR_02[31:0];
		w_addr098_rd	: r_prdata = r_TBL_ADDR_03[31:0];
		w_addr09C_rd	: r_prdata = r_TBL_ADDR_04[31:0];
		w_addr0A0_rd	: r_prdata = r_TBL_ADDR_05[31:0];
		w_addr0A4_rd	: r_prdata = r_TBL_ADDR_06[31:0];
		w_addr0A8_rd	: r_prdata = r_TBL_ADDR_07[31:0];
		w_addr0AC_rd    : r_prdata = r_TBL_ADDR_08[31:0];
		w_addr0B0_rd    : r_prdata = r_TBL_ADDR_09[31:0];
		w_addr0B4_rd    : r_prdata = r_TBL_ADDR_10[31:0];
		w_addr0B8_rd    : r_prdata = r_TBL_ADDR_11[31:0];
		w_addr0BC_rd    : r_prdata = r_TBL_ADDR_12[31:0];
		w_addr0C0_rd    : r_prdata = r_TBL_ADDR_13[31:0];
		w_addr0C4_rd    : r_prdata = r_TBL_ADDR_14[31:0];
		w_addr0C8_rd	: r_prdata = r_TBL_ADDR_15[31:0];
		w_addr0CC_rd	: r_prdata = r_TBL_ADDR_16[31:0];
		w_addr0D0_rd	: r_prdata = r_TBL_ADDR_17[31:0];
		w_addr0D4_rd	: r_prdata = r_TBL_ADDR_18[31:0];
		w_addr0D8_rd	: r_prdata = r_TBL_ADDR_19[31:0];
		w_addr0DC_rd	: r_prdata = r_TBL_ADDR_20[31:0];
		w_addr0E0_rd	: r_prdata = r_TBL_ADDR_21[31:0];
		w_addr0E4_rd	: r_prdata = r_TBL_ADDR_22[31:0];
		w_addr0E8_rd	: r_prdata = r_TBL_ADDR_23[31:0];
		w_addr0EC_rd	: r_prdata = r_TBL_ADDR_24[31:0];
///	w_addr0F0_rd	: r_prdata = r_TBL_ADDR_25[31:0];
///	w_addr0F4_rd	: r_prdata = r_TBL_ADDR_26[31:0];
///	w_addr0F8_rd	: r_prdata = r_TBL_ADDR_27[31:0];
///	w_addr0FC_rd	: r_prdata = r_TBL_ADDR_28[31:0];
///	w_addr100_rd	: r_prdata = r_TBL_ADDR_29[31:0];
		//30  104
		//31  108
//w_addr10C_rd	: r_prdata = r_TBL_ADDR_32[31:0];
//w_addr110_rd	: r_prdata = r_TBL_ADDR_33[31:0];
//w_addr114_rd	: r_prdata = r_TBL_ADDR_34[31:0];
//w_addr118_rd	: r_prdata = r_TBL_ADDR_35[31:0];
//
//w_addr11C_rd	: r_prdata = r_TBL_ADDR_36[31:0];
//w_addr120_rd	: r_prdata = r_TBL_ADDR_37[31:0];
//w_addr124_rd	: r_prdata = r_TBL_ADDR_38[31:0];
//w_addr128_rd	: r_prdata = r_TBL_ADDR_39[31:0];
//w_addr12C_rd	: r_prdata = r_TBL_ADDR_40[31:0];
//w_addr130_rd	: r_prdata = r_TBL_ADDR_41[31:0];
//w_addr134_rd	: r_prdata = r_TBL_ADDR_42[31:0];

		// RX DMA
		w_addr140_rd	: r_prdata = {31'h0,	r_RX_START			};		
	//	w_addr144_rd	: r_prdata = {24'h0, r_rx_band_num}; 
		w_addr148_rd	: r_prdata = r_rx_incr;

		w_addr14C_rd	: r_prdata = w_RX_CH0_PREV_ADDR[31:0];
		w_addr150_rd	: r_prdata = w_RX_CH1_PREV_ADDR[31:0];
		w_addr154_rd	: r_prdata = w_RX_CH2_PREV_ADDR[31:0];
		w_addr158_rd	: r_prdata = o_RX_CH0_CURR_ADDR[31:0];
		w_addr15C_rd	: r_prdata = o_RX_CH1_CURR_ADDR[31:0];
		w_addr160_rd	: r_prdata = o_RX_CH2_CURR_ADDR[31:0];
		w_addr164_rd	: r_prdata = r_rx_ch0_start_addr[31:0];
		w_addr168_rd	: r_prdata = r_rx_ch1_start_addr[31:0];
		w_addr16C_rd	: r_prdata = r_rx_ch2_start_addr[31:0];
		w_addr170_rd	: r_prdata = {8'h0, i_RX_BAND_CNT, 8'h0, i_RX_BLK_CNT};
		w_addr174_rd	: r_prdata = {31'h0, r_RX_BUSY}; 
		w_addr178_rd	: r_prdata = i_RX_CUR_ADDR_CH0[31: 0];
		w_addr17C_rd	: r_prdata = i_RX_CUR_ADDR_CH1[31: 0];
		w_addr180_rd	: r_prdata = i_RX_CUR_ADDR_CH2[31: 0];
		w_addr184_rd	: r_prdata = i_RX_SVC_CNT_CH0;
		w_addr188_rd	: r_prdata = i_RX_SVC_CNT_CH1;
		w_addr18C_rd	: r_prdata = i_RX_SVC_CNT_CH2;
		w_addr190_rd	: r_prdata = {6'h0, r_rx_dma_con[25:24], 1'h0, r_rx_dma_con[22], r_tzpc,r_rx_dma_con[20:16], 13'h0, r_rx_dma_con[2:0] };
		w_addr194_rd	: r_prdata = {26'h0, i_RRESP_ERR_RRESP[1:0],  i_RRESP_ERR_RID[3:0]};
	//	w_addr198_rd	: r_prdata =
	//	w_addr19C_rd	: r_prdata =
	//	w_addr1A0_rd	: r_prdata =

		// TX DMA
		w_addr1C0_rd	: r_prdata = {31'h0, r_TX_START};
		w_addr1C4_rd	: r_prdata = {6'h0, r_tx_dma_con[25:24], 1'h0,r_tx_dma_con[22], r_tzpc,  r_tx_dma_con[20:16], 6'h0, r_tx_dma_con[9:7], 2'h0,r_tx_dma_con[4:0] };

		w_addr1C8_rd	: r_prdata = {24'h0, r_tx_band_num};
		w_addr1CC_rd	: r_prdata = {16'h0, r_tx_data_incr};
	//	w_addr1D0_rd	: r_prdata = r_tx_alpha_incr;
		w_addr1D4_rd	: r_prdata = r_tx_ch0_start_addr[31:0]; // for SPA
		w_addr1D8_rd	: r_prdata = r_tx_ch1_start_addr[31:0]; // for SPA
		w_addr1DC_rd	: r_prdata = r_tx_ch2_start_addr[31:0]; // for SPA
	//w_addr260_rd	: r_prdata = r_tx_att0_start_addr[31:0]; // for SPA
	//w_addr264_rd	: r_prdata = r_tx_att1_start_addr[31:0]; // for SPA
	//w_addr268_rd	: r_prdata = r_tx_att2_start_addr[31:0]; // for SPA

		w_addr1E8_rd	: r_prdata = {8'h0, i_TX_BAND_CNT, 8'h0, i_TX_BLK_CNT};
		w_addr1EC_rd	: r_prdata = {31'h0, r_TX_BUSY};
		w_addr1F0_rd	: r_prdata = r_tx_addr_ch0_max[31:0];
		w_addr1F4_rd	: r_prdata = r_tx_addr_ch0_min[31:0];
		w_addr1F8_rd	: r_prdata = r_tx_addr_ch1_max[31:0];
		w_addr1FC_rd	: r_prdata = r_tx_addr_ch1_min[31:0];
		w_addr200_rd	: r_prdata = r_tx_addr_ch2_max[31:0];
		w_addr204_rd	: r_prdata = r_tx_addr_ch2_min[31:0];

		w_addr218_rd	: r_prdata = i_TX_CH0_CUR_ADDR[31:0];
		w_addr21C_rd	: r_prdata = i_TX_CH1_CUR_ADDR[31:0];
		w_addr220_rd	: r_prdata = i_TX_CH2_CUR_ADDR[31:0];

		w_addr22C_rd	: r_prdata = i_TX_CH0_SVC_CNT;
		w_addr230_rd	: r_prdata = i_TX_CH1_SVC_CNT;
		w_addr234_rd	: r_prdata = i_TX_CH2_SVC_CNT;

		w_addr240_rd	: r_prdata = {26'h0, i_TX_ERR_RESP[1:0],  i_TX_ERR_ID[3:0]};
	//	w_addr244_rd	: r_prdata = {29'h0, r_TX_ADDR_ERR_CH2, r_TX_ADDR_ERR_CH1, r_TX_ADDR_ERR_CH0};


		// ADAPT DMA
		w_addr280_rd	: r_prdata = {r_adapt_dma_con[23:16], 14'h0, r_adapt_dma_con[1:0] };
		w_addr284_rd	: r_prdata = r_adapt_dma_addr[31: 0];
		w_addr288_rd	: r_prdata = r_adapt_dma_addr_incr;
		w_addr28C_rd	: r_prdata = { i_ADAPT_OUT_LINES, 15'h0, i_ADAPT_DMA_TX_BUSY };
		w_addr290_rd	: r_prdata = r_adapt_dma_tx_addr_max[31:0];
		w_addr294_rd	: r_prdata = r_adapt_dma_tx_addr_min[31:0];
		w_addr298_rd	: r_prdata = i_ADAPT_TX_CUR_ADDR[31:0];
		w_addr29C_rd	: r_prdata = i_ADAPT_TX_SVC_CNT[31:0];
		w_addr2A0_rd	: r_prdata = {31'h0, r_ADAPT_TX_START};
		w_addr2A4_rd	: r_prdata = {24'h0, r_ADAPT_BAND_CNT};

		// SMAP
		w_addr2C0_rd	: r_prdata = {r_smap_dma_con[23:16], 16'h0 };
		w_addr2C4_rd	: r_prdata = r_smap_dma_addr[31: 0];		
		w_addr2C8_rd	: r_prdata = r_smap_dma_addr_incr;
		w_addr2CC_rd	: r_prdata = { i_SMAP_OUT_LINES, 15'h0, i_SMAP_DMA_TX_BUSY };
		w_addr2D0_rd	: r_prdata = r_smap_dma_tx_addr_max[31:0];
		w_addr2D4_rd	: r_prdata = r_smap_dma_tx_addr_min[31:0];
		w_addr2D8_rd	: r_prdata = i_SMAP_TX_CUR_ADDR[31:0];
		w_addr2DC_rd	: r_prdata = i_SMAP_TX_SVC_CNT[31:0];
		w_addr2E0_rd	: r_prdata = {31'h0, r_SMAP_TX_START};
		w_addr2E4_rd	: r_prdata = {24'h0, r_SMAP_BAND_CNT};

		//BDS
		w_addr300_rd	: r_prdata = {r_bds_dma_con[23:16], 16'h0 };
		w_addr304_rd	: r_prdata = r_bds_dma_addr[31: 0];		
		w_addr308_rd	: r_prdata = r_bds_dma_addr_incr;
		w_addr30C_rd	: r_prdata = { i_BDS_OUT_LINES, 15'h0, i_BDS_DMA_TX_BUSY };
		w_addr310_rd	: r_prdata = r_bds_dma_tx_addr_max[31:0];
		w_addr314_rd	: r_prdata = r_bds_dma_tx_addr_min[31:0];
		w_addr318_rd	: r_prdata = i_BDS_TX_CUR_ADDR[31:0];
		w_addr31C_rd	: r_prdata = i_BDS_TX_SVC_CNT[31:0];
		w_addr320_rd	: r_prdata = {31'h0, r_BDS_TX_START};
		w_addr324_rd	: r_prdata = {24'h0, r_BDS_BAND_CNT};

		// CRC
		w_addr340_rd		: r_prdata = i_DRX_CH0_CRC		;
		w_addr344_rd		: r_prdata = i_DRX_CH1_CRC		;
		w_addr348_rd		: r_prdata = i_DRX_CH2_CRC		;
		         
		w_addr350_rd		: r_prdata = i_RC1_CH0_CRC		;
		w_addr354_rd		: r_prdata = i_RC1_CH1_CRC		;
		w_addr358_rd		: r_prdata = i_RC1_CH2_CRC		;
		         
		w_addr360_rd		: r_prdata = i_BSC1_CH0_CRC;
		w_addr364_rd		: r_prdata = i_BSC1_CH1_CRC;
		w_addr368_rd		: r_prdata = i_BSC1_CH2_CRC;
		
		w_addr370_rd		: r_prdata = i_S1D_CH0_CRC		;
		w_addr374_rd		: r_prdata = i_S1D_CH1_CRC		;
		w_addr378_rd		: r_prdata = i_S1D_CH2_CRC		;
		         
		w_addr380_rd		: r_prdata = i_SEG1_CH0_CRC		;
		w_addr384_rd		: r_prdata = i_SEG1_CH1_CRC		;
		w_addr388_rd		: r_prdata = i_SEG1_CH2_CRC		;
		w_addr38C_rd		: r_prdata = i_SEG1_ATT_CRC	;
		
		w_addr390_rd		: r_prdata = i_SCC_CH0_CRC		;
		w_addr394_rd		: r_prdata = i_SCC_CH1_CRC		;
		w_addr398_rd		: r_prdata = i_SCC_CH2_CRC		;
		w_addr39C_rd		: r_prdata = i_SCC_ATT_CRC		;
		
		w_addr3A0_rd		: r_prdata = i_SEG2_CH0_CRC		;
		w_addr3A4_rd		: r_prdata = i_SEG2_CH1_CRC		;
		w_addr3A8_rd		: r_prdata = i_SEG2_CH2_CRC		;
		w_addr3AC_rd		: r_prdata = i_SEG2_ATT_CRC		;
		         
		w_addr3B0_rd		: r_prdata = i_BSSA_CH0_CRC		;
		w_addr3B4_rd		: r_prdata = i_BSSA_CH1_CRC		;
		w_addr3B8_rd		: r_prdata = i_BSSA_CH2_CRC		;
		
		w_addr3C0_rd		: r_prdata = i_DTX_CH0_CRC	;
		w_addr3C4_rd		: r_prdata = i_DTX_CH1_CRC	;
		w_addr3C8_rd		: r_prdata = i_DTX_CH2_CRC	;
		
		w_addr3D0_rd		: r_prdata = i_RC2_CH0_CRC		;
		w_addr3D4_rd		: r_prdata = i_RC2_CH1_CRC		;
		w_addr3D8_rd		: r_prdata = i_RC2_CH2_CRC		;
		
		w_addr3E0_rd		: r_prdata = i_ADAPT_CRC		;
		w_addr3E4_rd		: r_prdata = i_SMAP_CRC			;
		w_addr3E8_rd		: r_prdata = i_BDS_CRC			;

		w_addr3F0_rd		: r_prdata = i_VSD_CRC_0		;
		w_addr3F4_rd		: r_prdata = i_VSD_CRC_1		;
		w_addr3F8_rd		: r_prdata = i_VSD_CRC_2		;
		
		w_addr400_rd		: r_prdata = i_CIS_CRC_0	;
		w_addr404_rd		: r_prdata = i_CIS_CRC_1	;
		w_addr408_rd		: r_prdata = i_CIS_CRC_2	;
		
		w_addr410_rd		: r_prdata = i_BSSB_CH0_CRC		;
		w_addr414_rd		: r_prdata = i_BSSB_CH1_CRC		;
		w_addr418_rd		: r_prdata = i_BSSB_CH2_CRC		;
		
///

		w_addr440_rd	: r_prdata = {24'h0, i_S1D_DEBUG_FLAG			};
		w_addr444_rd	: r_prdata = {24'h0, i_SCC_DEBUG_FLAG			};
		w_addr448_rd	: r_prdata = {24'h0, i_BDS_DEBUG_FLAG			};
		w_addr44C_rd	: r_prdata = {24'h0, i_BSSA_DEBUG_FLAG			};
		w_addr450_rd	: r_prdata = {24'h0, i_BSSB_DEBUG_FLAG			};


		// VSC
		w_addr480_rd	: r_prdata = {
		       						1'h0,	r_vsd_reg_a[30],
		       						16'h0,	
								r_vsd_reg_a[13:12],
		       						12'h0		};
		w_addr484_rd	: r_prdata = {
		        							
		      							20'h0,	r_vsd_reg_b[11: 0]		};		
		w_addr488_rd	: r_prdata = r_vsd_reg_c;
		w_addr48C_rd	: r_prdata = r_vsd_reg_d;
		w_addr490_rd	: r_prdata = r_vsd_reg_e;
		w_addr494_rd	: r_prdata = {			
		      								r_vsd_reg_f[30:24],
		      							1'h0,	r_vsd_reg_f[22:16],
		      							1'h0,	r_vsd_reg_f[14: 8],
		      							1'h0,	r_vsd_reg_f[ 6: 0]	};
		w_addr498_rd	: r_prdata = r_vsd_reg_g;
		w_addr49C_rd	: r_prdata = {15'h0, r_vsd_reg_h[16], 3'h0, r_vsd_reg_h[12:0]};
// Reserved
//
	// CIS_INTP
		w_addr4C0_rd	: r_prdata = {11'h0, o_CIS_SUB_COEF_R2, 3'h0, o_CIS_SUB_COEF_R1};
		w_addr4C4_rd	: r_prdata = { 5'h0, o_CIS_SUB_COEF_G2, o_CIS_SUB_COEF_G1, o_CIS_SUB_COEF_G0}; 
		w_addr4C8_rd	: r_prdata = {	8'h0, 
										3'h0, o_CIS_SUB_COEF_B1,		//12bit	
										3'h0, o_CIS_SUB_COEF_B0	};		//12bit
		// RC1
		w_addr500_rd	: r_prdata = {o_RC1_SHIFT_VAL};
		w_addr504_rd	: r_prdata = {o_RC1_SHIFT_OFST};
		w_addr508_rd	: r_prdata = {13'h0, o_RC1_LOOP_X, 13'h0, o_RC1_LOOP_Y};
                
		w_addr510_rd	: r_prdata = {4'h0, o_RC1_X_COF_00, 4'h0, o_RC1_X_COF_01};
		w_addr514_rd	: r_prdata = {4'h0, o_RC1_X_COF_02, 4'h0, o_RC1_X_COF_03};
		w_addr518_rd	: r_prdata = {4'h0, o_RC1_X_COF_10, 4'h0, o_RC1_X_COF_11};
		w_addr51C_rd	: r_prdata = {4'h0, o_RC1_X_COF_12, 4'h0, o_RC1_X_COF_13};
		w_addr520_rd	: r_prdata = {4'h0, o_RC1_X_COF_20, 4'h0, o_RC1_X_COF_21};
		w_addr524_rd	: r_prdata = {4'h0, o_RC1_X_COF_22, 4'h0, o_RC1_X_COF_23};
		w_addr528_rd	: r_prdata = {4'h0, o_RC1_X_COF_30, 4'h0, o_RC1_X_COF_31};
		w_addr52C_rd	: r_prdata = {4'h0, o_RC1_X_COF_32, 4'h0, o_RC1_X_COF_33};
		w_addr530_rd	: r_prdata = {4'h0, o_RC1_Y_COF_00, 4'h0, o_RC1_Y_COF_01};
		w_addr534_rd	: r_prdata = {4'h0, o_RC1_Y_COF_02, 4'h0, o_RC1_Y_COF_03};
		w_addr538_rd	: r_prdata = {4'h0, o_RC1_Y_COF_10, 4'h0, o_RC1_Y_COF_11};
		w_addr53C_rd	: r_prdata = {4'h0, o_RC1_Y_COF_12, 4'h0, o_RC1_Y_COF_13};
		w_addr540_rd	: r_prdata = {4'h0, o_RC1_Y_COF_20, 4'h0, o_RC1_Y_COF_21};
		w_addr544_rd	: r_prdata = {4'h0, o_RC1_Y_COF_22, 4'h0, o_RC1_Y_COF_23};
		w_addr548_rd	: r_prdata = {4'h0, o_RC1_Y_COF_30, 4'h0, o_RC1_Y_COF_31};
		w_addr54C_rd	: r_prdata = {4'h0, o_RC1_Y_COF_32, 4'h0, o_RC1_Y_COF_33};

		// S1D


		// SEG1
		w_addr580_rd	: r_prdata = {24'h0 , 3'h0, o_SEG1_Enable_Y_text, 4'h0};
		w_addr584_rd	: r_prdata = {	o_SEG1_HVline_diff_th        , o_SEG1_HVline_minmaxdiff_th1 	, o_SEG1_HVline_minmaxdiff_th2 	, o_SEG1_HVline_level_th      	};
		w_addr588_rd	: r_prdata = {8'h0, o_SEG1_Lowfreq_th , o_SEG1_Lowfreq_th2 , o_SEG1_Highfreq_th };
		w_addr58C_rd	: r_prdata = {o_SEG1_Uni_highfreq_th,o_SEG1_Uni_lowfreq_th ,o_SEG1_Uni_edge_th2   ,o_SEG1_Uni_edge_th    };
		w_addr590_rd	: r_prdata = {8'h0, o_SEG1_White_th    , o_SEG1_ZC_edge_th      , 5'h0, o_SEG1_ZC_scaling_shift};

		// SCC
		w_addr5C0_rd	: r_prdata = {26'h0, o_SCC_FLOATING_MODE, 3'h0, o_SCC_LATTICE_STEP }								;

        // SEG2
		w_addr600_rd	: r_prdata = {24'h0, 3'h0, o_SEG2_Enable_contoneImage, 2'h0, o_SEG2_Enable_uniformtext , o_SEG2_Enable_FAR_9x9     };
		w_addr604_rd	: r_prdata = {8'h0, o_SEG2_FG_level_th,   6'h0,o_SEG2_text_index, 1'h0,    o_SEG2_edgecnt_th      };
		w_addr608_rd    : r_prdata = {1'h0, o_SEG2_bgcnt_th, 1'h0,o_SEG2_halftonecnt_th,1'h0,   	 o_SEG2_uniformlinecnt_th,	 1'h0, o_SEG2_zccnt_th         	 };
		w_addr60C_rd    : r_prdata = {16'h0, o_SEG2_FAR_chroma_th ,4'h0, o_SEG2_FAR_chroma_th2_shiftcoef};
		w_addr610_rd    : r_prdata = {16'h0,  o_SEG2_FAR_Y_th,   o_SEG2_FAR_Y_th2_shiftcoef1 ,o_SEG2_FAR_Y_th3_shiftcoef2 };
		w_addr614_rd    : r_prdata = {16'h0, o_SEG2_Neut_chroma_th  ,   4'h0, o_SEG2_Neut_chroma_th2_shiftcoef };

		//--------------------------------------------------------------------------------------------------------
		// Orientation
		//--------------------------------------------------------------------------------------------------------
		w_addr7C0_rd   : r_prdata = { 15'h0, o_ORI_PAGE_EN };
		w_addr7C4_rd   : r_prdata = { 18'h0, o_ORI_BLOCK_SIZE_W, 1'h0, o_ORI_BLOCK_SIZE_H};
		w_addr7C8_rd   : r_prdata = { 2'h0, o_ORI_AREA_SIZE_W, 2'h0, o_ORI_AREA_SIZE_H};
		w_addr7CC_rd   : r_prdata = { 8'h0, o_ORI_CHAR_LENGTH_MIN_V	, o_ORI_CHAR_THICK_MIN_V, o_ORI_CHAR_THICK_MAX_V };
		w_addr7D0_rd   : r_prdata = { 8'h0, o_ORI_CHAR_LENGTH_MIN_H	,  o_ORI_CHAR_THICK_MIN_H, 	o_ORI_CHAR_THICK_MAX_H};
		w_addr7D4_rd   : r_prdata = { 4'h0, o_ORI_DIFF_SHIFT1_V	,4'h0,	  o_ORI_DIFF_SHIFT2_V, 1'h0, o_ORI_CHANGE_RATIO_TH_V	, 1'h0, o_ORI_CHANGE_CNT_TH_V	};
		w_addr7D8_rd   : r_prdata = { 4'h0, o_ORI_DIFF_SHIFT1_H		, 	4'h0, o_ORI_DIFF_SHIFT2_H		, 	1'h0, o_ORI_CHANGE_RATIO_TH_H	, 	1'h0, o_ORI_CHANGE_CNT_TH_H		};
		w_addr7DC_rd   : r_prdata = { o_ORI_DIR_MIN_TH			, 	o_ORI_DIR_MAX_TH			, 	o_ORI_DIR_TH				, 		o_ORI_DIR_MAX_LOW_TH		};
		w_addr7E0_rd   : r_prdata = { o_ORI_DIR_MAX_HIGH_TH		, 		o_ORI_DIR_DIFF_TH1			,  		o_ORI_DIR_DIFF_TH2		  	, 		o_ORI_DIR_DIFF_TH3			};
		w_addr7E4_rd   : r_prdata = {  5'h0, o_ORI_AREA_OFFSET_H  	, 	5'h0, o_ORI_AREA_OFFSET_W	};
		w_addr7E8_rd   : r_prdata = {  21'h0, o_ORI_AREA_OFFSET  	};
		w_addr7EC_rd   : r_prdata = {  16'h0,  o_ORI_LINE_SPACE_H, o_ORI_LINE_SPACE_V };
		w_addr7F0_rd   : r_prdata = {29'h0, i_ORI_TEXT_FLAG3, i_ORI_TEXT_FLAG2, i_ORI_TEXT_FLAG1  };
		w_addr7F4_rd   : r_prdata = {  2'h0, i_ORI_TEXT_AREA1_ST_W, 2'h0, i_ORI_TEXT_AREA1_EN_W };
		w_addr7F8_rd   : r_prdata = {  2'h0, i_ORI_TEXT_AREA1_ST_H, 2'h0, i_ORI_TEXT_AREA1_EN_H };
		w_addr7FC_rd   : r_prdata = {  2'h0, i_ORI_TEXT_AREA2_ST_W, 2'h0, i_ORI_TEXT_AREA2_EN_W };
		w_addr800_rd   : r_prdata = {  2'h0, i_ORI_TEXT_AREA2_ST_H, 2'h0, i_ORI_TEXT_AREA2_EN_H };
		w_addr804_rd   : r_prdata = {  2'h0, i_ORI_TEXT_AREA3_ST_W, 2'h0, i_ORI_TEXT_AREA3_EN_W };
		w_addr808_rd   : r_prdata = {  2'h0, i_ORI_TEXT_AREA3_ST_H, 2'h0, i_ORI_TEXT_AREA3_EN_H };

		//--------------------------------------------------------------------------------------------------------
		// Classifier
		//--------------------------------------------------------------------------------------------------------

		w_addr900_rd	: r_prdata = { o_CLA_HLcount_diffth2, 	o_CLA_HLcount_diffth1, 	o_CLA_HLcount_maxth2, 	o_CLA_HLcount_maxth1};
		w_addr904_rd	: r_prdata = { 13'h0, o_CLA_ContentsSizeTh,	o_CLA_HLgray_diffth};
		w_addr908_rd	: r_prdata = 	i_CLA_TOTAL_BIN_CNT;
		w_addr90C_rd	: r_prdata = 	i_CLA_HL_range2;
		w_addr910_rd	: r_prdata = 	i_CLA_HL_color2;
		w_addr914_rd	: r_prdata = 	i_CLA_BTEXT_CNT;
		w_addr918_rd	: r_prdata = 	i_CLA_TEXT_CNT;
		w_addr91C_rd	: r_prdata = 	i_CLA_HT_CNT;
		w_addr920_rd	: r_prdata = 	i_CLA_EDGE_CNT;
		w_addr924_rd	: r_prdata = 	i_CLA_WHITE_CNT;
		w_addr928_rd	: r_prdata = 	i_CLA_CONTONE_CNT;
		w_addr92C_rd	: r_prdata = 	i_CLA_WHITE_WO_TEXT_CNT;
		w_addr930_rd	: r_prdata = 	i_CLA_WHITE_WO_HT_TEXT_CNT;
		w_addr934_rd	: r_prdata = 	{2'h0,	i_CLA_ContentSizeH, 2'h0, i_CLA_ContentSizeW};
		
		w_addr980_rd	: r_prdata = { o_ACBD_TOP_MARGIN	, o_ACBD_BOTTOM_MARGIN};
		w_addr984_rd	: r_prdata = {o_ACBD_LEFT_MARGIN,  o_ACBD_RIGHT_MARGIN};
		w_addr988_rd	: r_prdata = {6'h0,	o_ACBD_LOW_THRESHOLD_MIN1, 6'h0, o_ACBD_HIGH_THRESHOLD_MAX1 };
		w_addr98C_rd	: r_prdata = {6'h0,	o_ACBD_LOW_THRESHOLD_MIN2, 6'h0, o_ACBD_HIGH_THRESHOLD_MAX2 };
		w_addr990_rd	: r_prdata = {15'h0, o_ACBD_HIGHLIGHT_SELECT_EN};
		w_addr994_rd	: r_prdata = {24'h0, o_ACBD_AVG_THRESHOLD	};
		w_addr998_rd	: r_prdata = { o_ACBD_HISTCB_VAL_LOW	, o_ACBD_HISTCB_VAL_HIGH	, o_ACBD_HISTCR_VAL_LOW	, o_ACBD_HISTCR_VAL_HIGH} ;
		
		w_addr99C_rd	: r_prdata = {6'h0, o_ACBD_CB_RATION_THRESHOLD, 	6'h0, o_ACBD_CR_RATION_THRESHOLD};
		
		w_addr9A0_rd	: r_prdata = 	{16'h0,	o_ACBD_MIN_LIMIT_THRESHOLD, o_ACBD_MAX_LIMIT_THRESHOLD};
		w_addr9A4_rd	: r_prdata = 	{15'h0,	o_ACBD_BRIGHTNESS_EN	,o_ACBD_BRIGHTNESS_THRESHOLD, o_ACBD_STRETCHING_OFFSET};

		w_addr9A8_rd	: r_prdata = 	{14'h0,	o_ACBD_ACB_PEAK_RATIO_TH, 2'h0, o_ACBD_ACB_GRAY_RIDGE_TH};
		w_addr9AC_rd	: r_prdata = 	{16'h0,	o_ACBD_ACB_LEFT_LIMIT,  o_ACBD_ACB_RIGHT_LIMIT};
		w_addr9B0_rd	: r_prdata = 	{16'h0,	o_ACBD_OBJ_INDEX_TH, 4'h0, o_ACBD_OBJ_AREA_TH};
		w_addr9B4_rd	: r_prdata = 	{8'h0, i_ACBD_FINAL_MIN, i_ACBD_FINAL_MAX, i_ACBD_BRIGHT_OFFSET};
		w_addr9B8_rd	: r_prdata = 	{12'h0, i_ACBD_MEM_READ_STAT, i_ACBD_ANKER_POINT, i_ACBD_PEAK_ID};
		w_addr9BC_rd	: r_prdata = 	{31'h0, o_ACBD_ACS_REF_ON};


		// ABSD
		w_addr840_rd	: r_prdata = { 18'h0, r_abs_pre_scan_line }																			;
		w_addr844_rd	: r_prdata = { 2'h0, r_abs_prescan_iwin[29:16], 2'h0, r_abs_prescan_iwin[13: 0]  }									;
		w_addr848_rd	: r_prdata = { 15'h0, r_abs_th }																					;
		w_addr84C_rd	: r_prdata = { 25'h0, r_abs_valid_percentage }																		;
		w_addr850_rd	: r_prdata = { 24'h0, r_abs_bk_std_th }																				;
		w_addr854_rd	: r_prdata = { 10'h0, r_abs_sigma[21:16], 2'h0, r_abs_sigma[13: 8], 1'h0, r_abs_sigma[ 6: 0] }						;
		w_addr858_rd	: r_prdata = { 20'h0, r_abs_bg_backup[11:4], 3'h0, r_abs_bg_backup[0] }												;
		w_addr85C_rd	: r_prdata = { 8'h0, r_abs_color_exception[23:16], r_abs_color_exception[15: 8], 7'h0, r_abs_color_exception[0] }	;
		w_addr860_rd	: r_prdata = { r_ABSD_MAX_CR, r_ABSD_MAX_CB, r_ABSD_TOP_BG_LEVEL };
		w_addr864_rd	: r_prdata = { r_ABSD_RESULT_SUCCESS, 1'h0, r_ABSD_TOP_PEAK_CONFIDENCE };
		w_addr868_rd	: r_prdata = r_ABSD_PRE_SCAN_START; 

		// MAGD
		w_addr880_rd	: r_prdata = { 18'h0, r_magd_pre_scan_line }																			;
		w_addr884_rd	: r_prdata = { 2'h0, r_magd_prescan_iwin[29:16], 2'h0, r_magd_prescan_iwin[13: 0]  }									;
		w_addr888_rd	: r_prdata = { 15'h0, r_magd_th }																					;
		w_addr88C_rd	: r_prdata = { 25'h0, r_magd_valid_percentage }																		;
		w_addr890_rd	: r_prdata = { 24'h0, r_magd_bk_std_th }																				;
		w_addr894_rd	: r_prdata = { 10'h0, r_magd_sigma[21:16], 2'h0, r_magd_sigma[13: 8], 1'h0, r_magd_sigma[ 6: 0] }						;
		w_addr898_rd	: r_prdata = { 20'h0, r_magd_bg_backup[11:4], 3'h0, r_magd_bg_backup[0] }												;
		w_addr89C_rd	: r_prdata = { 8'h0, r_magd_color_exception[23:16], r_magd_color_exception[15: 8], 7'h0, r_magd_color_exception[0] }	;
		w_addr8A0_rd	: r_prdata = { r_MAGD_MAX_CR, r_MAGD_MAX_CB, r_MAGD_TOP_BG_LEVEL };
		w_addr8A4_rd	: r_prdata = { r_MAGD_RESULT_SUCCESS, 1'h0, r_MAGD_TOP_PEAK_CONFIDENCE };
		w_addr8A8_rd	: r_prdata = r_MAGD_PRE_SCAN_START;

		// NEWABSD
		w_addr8C0_rd	: r_prdata = { 2'h0, o_NEWABSD_PRE_SCAN_START, 2'h0, o_NEWABSD_PRE_SCAN_LINE_NUM };
		w_addr8C4_rd	: r_prdata = { 2'h0, o_NEWABSD_IWIN_START,2'h0, o_NEWABSD_IWIN_END};
		w_addr8C8_rd	: r_prdata = {8'h0,o_NEWABSD_CHROMA_TH	,o_NEWABSD_GRAY_RIDGE_TH, o_NEWABSD_COLOR_RIDGE_TH};
		w_addr8CC_rd	: r_prdata = {16'h0, o_NEWABSD_LEFT_LIMIT,o_NEWABSD_RIGHT_LIMIT} ;
		w_addr8D0_rd	: r_prdata = {16'h0, i_NEWABSD_HISTO_GRAY_PEAK, i_NEWABSD_HISTO_COLOR_PEAK} ;
		w_addr8D4_rd	: r_prdata = {16'h0, i_NEWABSD_HISTO_GRAY_LEFT, i_NEWABSD_HISTO_COLOR_LEFT} ;
		w_addr8D8_rd	: r_prdata = {16'h0, i_NEWABSD_HISTO_GRAY_RIGHT,i_NEWABSD_HISTO_COLOR_RIGHT} ;
		w_addr8DC_rd	: r_prdata = {16'h0, 4'h0, i_NEWABSD_MEM_READ_STAT ,7'h0, i_NEWABSD_PAPER_COLOR_FLAG} ;


		// ACS
		w_addr9C0_rd	: r_prdata = { o_ACS_WHITE_TH,  o_ACS_BLOCK_SIZE_Y,
									   o_ACS_BLOCK_SIZE_X, o_ACS_RANGE_REAL_IMAGE, 2'h0, o_ACS_HISTO_EN, o_ACS_MARK_ON, o_ACS_BLOCK_SIZE_AUTO, o_ACS_HALF_CNT_AUTO,o_ACS_SATURATION_PXL_CNT_AUTO};
		w_addr9C4_rd	: r_prdata = { 15'h0, o_ACS_MARK_TOP};
		w_addr9C8_rd	: r_prdata = { 15'h0, o_ACS_MARK_BOTTOM};
		w_addr9CC_rd	: r_prdata = { 15'h0, o_ACS_MARK_LEFT};
		w_addr9D0_rd	: r_prdata = { 15'h0, o_ACS_MARK_RIGHT};
		w_addr9D4_rd	: r_prdata = { o_ACS_SATURATION_PXL_TH, 16'h0 ,o_ACS_SATURATION_BLOCK_TH};
		w_addr9D8_rd	: r_prdata = { 1'h0, o_ACS_HALFTONE_CNT, 1'h0, o_ACS_PUREHALFTONE_CNT};
		w_addr9DC_rd	: r_prdata = { o_ACS_CB_MAX_00, o_ACS_CB_MAX_01, o_ACS_CB_MAX_02, o_ACS_CB_MAX_03};
		w_addr9E0_rd	: r_prdata = { o_ACS_CB_MAX_04, o_ACS_CB_MAX_05, o_ACS_CB_MAX_06, o_ACS_CB_MAX_07};
		w_addr9E4_rd	: r_prdata = { o_ACS_CB_MAX_08, o_ACS_CB_MAX_09, o_ACS_CB_MAX_10, o_ACS_CB_MAX_11};
		w_addr9E8_rd	: r_prdata = { o_ACS_CB_MAX_12, o_ACS_CB_MAX_13, o_ACS_CB_MAX_14, o_ACS_CB_MAX_15};
		w_addr9EC_rd	: r_prdata = { o_ACS_CB_MIN_00, o_ACS_CB_MIN_01, o_ACS_CB_MIN_02, o_ACS_CB_MIN_03};
		w_addr9F0_rd	: r_prdata = { o_ACS_CB_MIN_04, o_ACS_CB_MIN_05, o_ACS_CB_MIN_06, o_ACS_CB_MIN_07};
		w_addr9F4_rd	: r_prdata = { o_ACS_CB_MIN_08, o_ACS_CB_MIN_09, o_ACS_CB_MIN_10, o_ACS_CB_MIN_11};
		w_addr9F8_rd	: r_prdata = { o_ACS_CB_MIN_12, o_ACS_CB_MIN_13, o_ACS_CB_MIN_14, o_ACS_CB_MIN_15};
		w_addr9FC_rd	: r_prdata = { o_ACS_CR_MAX_00, o_ACS_CR_MAX_01, o_ACS_CR_MAX_02, o_ACS_CR_MAX_03};
		w_addrA00_rd	: r_prdata = { o_ACS_CR_MAX_04, o_ACS_CR_MAX_05, o_ACS_CR_MAX_06, o_ACS_CR_MAX_07};
		w_addrA04_rd	: r_prdata = { o_ACS_CR_MAX_08, o_ACS_CR_MAX_09, o_ACS_CR_MAX_10, o_ACS_CR_MAX_11};
		w_addrA08_rd	: r_prdata = { o_ACS_CR_MAX_12, o_ACS_CR_MAX_13, o_ACS_CR_MAX_14, o_ACS_CR_MAX_15};
		w_addrA0C_rd	: r_prdata = { o_ACS_CR_MIN_00, o_ACS_CR_MIN_01, o_ACS_CR_MIN_02, o_ACS_CR_MIN_03};
		w_addrA10_rd	: r_prdata = { o_ACS_CR_MIN_04, o_ACS_CR_MIN_05, o_ACS_CR_MIN_06, o_ACS_CR_MIN_07};
		w_addrA14_rd	: r_prdata = { o_ACS_CR_MIN_08, o_ACS_CR_MIN_09, o_ACS_CR_MIN_10, o_ACS_CR_MIN_11};
		w_addrA18_rd	: r_prdata = { o_ACS_CR_MIN_12, o_ACS_CR_MIN_13, o_ACS_CR_MIN_14, o_ACS_CR_MIN_15};
		w_addrA1C_rd	: r_prdata = { o_ACS_CB_MAXh_00, o_ACS_CB_MAXh_01, o_ACS_CB_MAXh_02, o_ACS_CB_MAXh_03};
		w_addrA20_rd	: r_prdata = { o_ACS_CB_MAXh_04, o_ACS_CB_MAXh_05, o_ACS_CB_MAXh_06, o_ACS_CB_MAXh_07};
		w_addrA24_rd	: r_prdata = { o_ACS_CB_MAXh_08, o_ACS_CB_MAXh_09, o_ACS_CB_MAXh_10, o_ACS_CB_MAXh_11};
		w_addrA28_rd	: r_prdata = { o_ACS_CB_MAXh_12, o_ACS_CB_MAXh_13, o_ACS_CB_MAXh_14, o_ACS_CB_MAXh_15};
		w_addrA2C_rd	: r_prdata = { o_ACS_CB_MINh_00, o_ACS_CB_MINh_01, o_ACS_CB_MINh_02, o_ACS_CB_MINh_03};
		w_addrA30_rd	: r_prdata = { o_ACS_CB_MINh_04, o_ACS_CB_MINh_05, o_ACS_CB_MINh_06, o_ACS_CB_MINh_07};
		w_addrA34_rd	: r_prdata = { o_ACS_CB_MINh_08, o_ACS_CB_MINh_09, o_ACS_CB_MINh_10, o_ACS_CB_MINh_11};
		w_addrA38_rd	: r_prdata = { o_ACS_CB_MINh_12, o_ACS_CB_MINh_13, o_ACS_CB_MINh_14, o_ACS_CB_MINh_15};
		w_addrA3C_rd	: r_prdata = { o_ACS_CR_MAXh_00, o_ACS_CR_MAXh_01, o_ACS_CR_MAXh_02, o_ACS_CR_MAXh_03};
		w_addrA40_rd	: r_prdata = { o_ACS_CR_MAXh_04, o_ACS_CR_MAXh_05, o_ACS_CR_MAXh_06, o_ACS_CR_MAXh_07};
		w_addrA44_rd	: r_prdata = { o_ACS_CR_MAXh_08, o_ACS_CR_MAXh_09, o_ACS_CR_MAXh_10, o_ACS_CR_MAXh_11};
		w_addrA48_rd	: r_prdata = { o_ACS_CR_MAXh_12, o_ACS_CR_MAXh_13, o_ACS_CR_MAXh_14, o_ACS_CR_MAXh_15};
		w_addrA4C_rd	: r_prdata = { o_ACS_CR_MINh_00, o_ACS_CR_MINh_01, o_ACS_CR_MINh_02, o_ACS_CR_MINh_03};
		w_addrA50_rd	: r_prdata = { o_ACS_CR_MINh_04, o_ACS_CR_MINh_05, o_ACS_CR_MINh_06, o_ACS_CR_MINh_07};
		w_addrA54_rd	: r_prdata = { o_ACS_CR_MINh_08, o_ACS_CR_MINh_09, o_ACS_CR_MINh_10, o_ACS_CR_MINh_11};
		w_addrA58_rd	: r_prdata = { o_ACS_CR_MINh_12, o_ACS_CR_MINh_13, o_ACS_CR_MINh_14, o_ACS_CR_MINh_15};
		w_addrA5C_rd	: r_prdata = { 16'h0, o_ACS_VALUE_PXL_TH, o_ACS_VALUE_BLOCK_TH		};
		w_addrA60_rd	: r_prdata = { i_ACS_TBLK_PAGE};
		w_addrA64_rd	: r_prdata = { i_ACS_TBLK_NPAGE};
		w_addrA68_rd	: r_prdata = { i_ACS_CBLK};
		w_addrA6C_rd	: r_prdata = { i_ACS_SBLK_PAGE};
		w_addrA70_rd	: r_prdata = { i_ACS_SPXL_BLK_PAGE};
		w_addrA74_rd	: r_prdata = { i_ACS_SPXL_PAGE[31:0]};
		w_addrA78_rd	: r_prdata = { i_ACS_TEXT_PAGE[31:0]};
		w_addrA7C_rd	: r_prdata = { i_ACS_HT_PAGE[31:0]};
		w_addrA80_rd	: r_prdata = { i_ACS_EDGE_PAGE[31:0]};
//	Reserved w_addrA84_rd
		w_addrA88_rd	: r_prdata = { i_ACS_AVG_HT00};
		w_addrA8C_rd	: r_prdata = { i_ACS_AVG_HT01};
		w_addrA90_rd	: r_prdata = { i_ACS_AVG_HT02};
		w_addrA94_rd	: r_prdata = { i_ACS_AVG_HT03};
		w_addrA98_rd	: r_prdata = { i_ACS_AVG_HT04};
		w_addrA9C_rd	: r_prdata = { i_ACS_AVG_HT05};
		w_addrAA0_rd	: r_prdata = { i_ACS_AVG_HT06};
		w_addrAA4_rd	: r_prdata = { i_ACS_AVG_HT07};
		w_addrAA8_rd	: r_prdata = { i_ACS_AVG_HT08};
		w_addrAAC_rd	: r_prdata = { i_ACS_AVG_HT09};
		w_addrAB0_rd	: r_prdata = { i_ACS_AVG_HT10};
		w_addrAB4_rd	: r_prdata = { i_ACS_AVG_HT11};
		w_addrAB8_rd	: r_prdata = { i_ACS_AVG_HT12};
		w_addrABC_rd	: r_prdata = { i_ACS_AVG_HT13};
		w_addrAC0_rd	: r_prdata = { i_ACS_AVG_HT14};
		w_addrAC4_rd	: r_prdata = { i_ACS_AVG_HT15};
		w_addrAC8_rd	: r_prdata = { i_ACS_AVG_NHT00};
		w_addrACC_rd	: r_prdata = { i_ACS_AVG_NHT01};
		w_addrAD0_rd	: r_prdata = { i_ACS_AVG_NHT02};
		w_addrAD4_rd	: r_prdata = { i_ACS_AVG_NHT03};
		w_addrAD8_rd	: r_prdata = { i_ACS_AVG_NHT04};
		w_addrADC_rd	: r_prdata = { i_ACS_AVG_NHT05};
		w_addrAE0_rd	: r_prdata = { i_ACS_AVG_NHT06};
		w_addrAE4_rd	: r_prdata = { i_ACS_AVG_NHT07};
		w_addrAE8_rd	: r_prdata = { i_ACS_AVG_NHT08};
		w_addrAEC_rd	: r_prdata = { i_ACS_AVG_NHT09};
		w_addrAF0_rd	: r_prdata = { i_ACS_AVG_NHT10};
		w_addrAF4_rd	: r_prdata = { i_ACS_AVG_NHT11};
		w_addrAF8_rd	: r_prdata = { i_ACS_AVG_NHT12};
		w_addrAFC_rd	: r_prdata = { i_ACS_AVG_NHT13};
		w_addrB00_rd	: r_prdata = { i_ACS_AVG_NHT14};
		w_addrB04_rd	: r_prdata = { i_ACS_AVG_NHT15};
		w_addrB08_rd	: r_prdata = { 17'h0, o_ACS_SATURATION_PXL_CNT_TH};
		w_addrB0C_rd	: r_prdata = { 2'h0, i_ACS_VALID_TOP, 2'h0, i_ACS_VALID_BOTTOM};
		w_addrB10_rd	: r_prdata = { 2'h0, i_ACS_VALID_LEFT, 2'h0, i_ACS_VALID_RIGHT};
                w_addrB14_rd    : r_prdata = { o_ACSv2_WHITE_TH,  o_ACSv2_BLOCK_SIZE_Y, o_ACSv2_BLOCK_SIZE_X, 8'h0 };
		w_addrB18_rd	: r_prdata = { o_ACSv2_SATURATION_PXL_TH, 16'h0 ,o_ACSv2_SATURATION_BLOCK_TH};
		w_addrB1C_rd	: r_prdata = { 17'h0, o_ACSv2_SATURATION_PXL_CNT_TH};
		w_addrB20_rd	: r_prdata = { 1'h0, o_ACSv2_HALFTONE_CNT, 1'h0, o_ACSv2_PUREHALFTONE_CNT};
		w_addrB24_rd	: r_prdata = { 16'h0, o_ACSv2_VALUE_PXL_TH, o_ACSv2_VALUE_BLOCK_TH		};
		w_addrB28_rd	: r_prdata = { i_ACSv2_TBLK_PAGE};
		w_addrB2C_rd	: r_prdata = { i_ACSv2_TBLK_NPAGE};
		w_addrB30_rd	: r_prdata = { i_ACSv2_CBLK};
		w_addrB34_rd	: r_prdata = { i_ACSv2_SBLK_PAGE};
		w_addrB38_rd	: r_prdata = { i_ACSv2_SPXL_BLK_PAGE};
		w_addrB3C_rd	: r_prdata = { i_ACSv2_SPXL_PAGE[31:0]};



		// BLANK
		w_addrB40_rd	: r_prdata = { 8'h0,  o_BLANK_BLOCK_SIZE_V, o_BLANK_BLOCK_SIZE_H,o_BLANK_RANGE_REAL_IMAGE,2'h0, 1'h0, o_BLANK_MARK_EN, o_BLANK_AUTO_EN, 2'h0};
		w_addrB44_rd	: r_prdata = { 16'h0, o_BLANK_CONTENTBLOCK_PCT, o_BLANK_DARKBLK_TH};

		w_addrB48_rd	: r_prdata = { 15'h0,  o_BLANK_MARK_POS_TOP			};
		w_addrB4C_rd	: r_prdata = { 15'h0,  o_BLANK_MARK_POS_BOTTOM		};
		w_addrB50_rd	: r_prdata = { 15'h0,  o_BLANK_MARK_POS_LEFT		};
		w_addrB54_rd	: r_prdata = { 15'h0,  o_BLANK_MARK_POS_RIGHT		};
		w_addrB58_rd	: r_prdata = { o_BLANK_COLORBLOCK_CB_THL, o_BLANK_COLORBLOCK_CB_THU, o_BLANK_COLORBLOCK_CR_THL, o_BLANK_COLORBLOCK_CR_THU};

		w_addrB5C_rd	: r_prdata = { i_BLANK_TBLK_PAGE		};
		w_addrB60_rd	: r_prdata = { i_BLANK_ContBLK_PAGE};
		w_addrB64_rd	: r_prdata = { i_BLANK_BlankBLK_PAGE};
		w_addrB68_rd	: r_prdata = { i_BLANK_DarkBLK};
		w_addrB6C_rd	: r_prdata = { i_BLANK_CBLK};
		w_addrB70_rd	: r_prdata = { 16'h0,i_BLANK_Y_MIN	,i_BLANK_Y_MAX	};
		w_addrB74_rd	: r_prdata = { 16'h0,i_BLANK_CB_MIN	,i_BLANK_CB_MAX	};
		w_addrB78_rd	: r_prdata = { 16'h0,i_BLANK_CR_MIN	,i_BLANK_CR_MAX	};

		// RC2
		w_addrB80_rd	: r_prdata = {7'h0, o_RC2_OUTIMG_WIDTH, 8'h0, o_RC2_OUTIMG_HEIGHT};
		w_addrB84_rd	: r_prdata = {23'h0, o_RC2_MASK_IMG_BD, 2'h0, o_RC2_OVERLAP};
		w_addrB88_rd	: r_prdata = {4'h0, o_RC2_V_FRAC, 4'h0, o_RC2_H_FRAC};
		// BDS
		w_addrBC0_rd    :  r_prdata = {8'h0, o_BDS_EDGE_TH, 15'h0, o_BDS_MIRROR};
		w_addrBC4_rd    :  r_prdata = {8'h0, o_BDS_EDGE_CNT_TH, o_BDS_EDGE_Y_HIGH, o_BDS_EDGE_Y_LOW };
		w_addrBC8_rd    :  r_prdata = {o_BDS_EDGE_CB_HIGH     , o_BDS_EDGE_CB_LOW      ,  o_BDS_EDGE_CR_HIGH     ,   o_BDS_EDGE_CR_LOW  };
		w_addrBCC_rd    :  r_prdata = {16'h0, o_BDS_EURion_Y_HIGH, o_BDS_EURion_Y_LOW};
		w_addrBD0_rd    :  r_prdata = {o_BDS_EURion_CB_HIGH  ,  o_BDS_EURion_CB_LOW    , o_BDS_EURion_CR_HIGH   , o_BDS_EURion_CR_LOW    };
		w_addrBD4_rd    :  r_prdata = {o_BDS_OFFSET_LEFT      ,  o_BDS_OFFSET_RIGHT    , 	o_BDS_OFFSET_TOP      ,		o_BDS_OFFSET_BOTTOM   };
		w_addrBD8_rd    :  r_prdata = {i_BDS_CONTENTS_START, i_BDS_CONTENTS_END} ;
		// SMAP
//		w_addrC80_rd	: r_prdata = r_smap_param_a;
		w_addrC84_rd	: r_prdata = r_smap_param_b; 
		w_addrC88_rd	: r_prdata = {r_smap_param_c[31:4], 3'h0, r_smap_param_c[0]};
		w_addrC8C_rd    : r_prdata = {22'h0,  o_SMAP_AVGDIVPARAM,  3'h0, o_SMAP_ADAPTIVE_ENABLE};
		w_addrC90_rd    : r_prdata = r_smap_r_max0;
		w_addrC94_rd    : r_prdata = r_smap_r_max1;
		w_addrC98_rd    : r_prdata = r_smap_r_max2;
		w_addrC9C_rd    : r_prdata = r_smap_r_max3;
		w_addrCA0_rd    : r_prdata = r_smap_r_max4;
		w_addrCA4_rd    : r_prdata = r_smap_r_max5;
		w_addrCA8_rd    : r_prdata = r_smap_r_max6;
		w_addrCAC_rd    : r_prdata = r_smap_r_max7;
		w_addrCB0_rd    : r_prdata = r_smap_r_min0;
		w_addrCB4_rd    : r_prdata = r_smap_r_min1;
		w_addrCB8_rd    : r_prdata = r_smap_r_min2;
		w_addrCBC_rd    : r_prdata = r_smap_r_min3;
		w_addrCC0_rd    : r_prdata = r_smap_r_min4;
		w_addrCC4_rd    : r_prdata = r_smap_r_min5;
		w_addrCC8_rd    : r_prdata = r_smap_r_min6;
		w_addrCCC_rd    : r_prdata = r_smap_r_min7;
		w_addrCD0_rd    : r_prdata = r_smap_g_max0;
		w_addrCD4_rd    : r_prdata = r_smap_g_max1;
		w_addrCD8_rd    : r_prdata = r_smap_g_max2;
		w_addrCDC_rd    : r_prdata = r_smap_g_max3;
		w_addrCE0_rd    : r_prdata = r_smap_g_max4;
		w_addrCE4_rd    : r_prdata = r_smap_g_max5;
		w_addrCE8_rd    : r_prdata = r_smap_g_max6;
		w_addrCEC_rd    : r_prdata = r_smap_g_max7;
		w_addrCF0_rd    : r_prdata = r_smap_g_min0;
		w_addrCF4_rd    : r_prdata = r_smap_g_min1;
		w_addrCF8_rd    : r_prdata = r_smap_g_min2;
		w_addrCFC_rd    : r_prdata = r_smap_g_min3;
		w_addrD00_rd    : r_prdata = r_smap_g_min4;
		w_addrD04_rd    : r_prdata = r_smap_g_min5;
		w_addrD08_rd    : r_prdata = r_smap_g_min6;
		w_addrD0C_rd    : r_prdata = r_smap_g_min7;
		w_addrD10_rd    : r_prdata = r_smap_b_max0;
		w_addrD14_rd    : r_prdata = r_smap_b_max1;
		w_addrD18_rd    : r_prdata = r_smap_b_max2;
		w_addrD1C_rd    : r_prdata = r_smap_b_max3;
		w_addrD20_rd    : r_prdata = r_smap_b_max4;
		w_addrD24_rd    : r_prdata = r_smap_b_max5;
		w_addrD28_rd    : r_prdata = r_smap_b_max6;
		w_addrD2C_rd    : r_prdata = r_smap_b_max7;
		w_addrD30_rd    : r_prdata = r_smap_b_min0;
		w_addrD34_rd    : r_prdata = r_smap_b_min1;
		w_addrD38_rd    : r_prdata = r_smap_b_min2;
		w_addrD3C_rd    : r_prdata = r_smap_b_min3;
		w_addrD40_rd    : r_prdata = r_smap_b_min4;
		w_addrD44_rd    : r_prdata = r_smap_b_min5;
		w_addrD48_rd    : r_prdata = r_smap_b_min6;
		w_addrD4C_rd    : r_prdata = r_smap_b_min7;

		w_addr108C_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_00[39:32]};
		w_addr1090_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_01[39:32]};
		w_addr1094_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_02[39:32]};
		w_addr1098_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_03[39:32]};
		w_addr109C_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_04[39:32]};
		w_addr10A0_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_05[39:32]};
		w_addr10A4_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_06[39:32]};
		w_addr10A8_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_07[39:32]};
		w_addr10AC_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_08[39:32]};
		w_addr10B0_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_09[39:32]};
		w_addr10B4_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_10[39:32]};
		w_addr10B8_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_11[39:32]};
		w_addr10BC_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_12[39:32]};
		w_addr10C0_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_13[39:32]};
		w_addr10C4_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_14[39:32]};
		w_addr10C8_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_15[39:32]};
		w_addr10CC_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_16[39:32]};
		w_addr10D0_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_17[39:32]};
		w_addr10D4_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_18[39:32]};
		w_addr10D8_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_19[39:32]};
		w_addr10DC_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_20[39:32]};
		w_addr10E0_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_21[39:32]};
		w_addr10E4_rd	: r_prdata ={ 24'h0, r_TBL_ADDR_22[39:32]};
	w_addr10E8_rd	: r_prdata = r_TBL_ADDR_23[39:32];
	w_addr10EC_rd	: r_prdata = r_TBL_ADDR_24[39:32];
//	w_addr10F0_rd	: r_prdata = r_TBL_ADDR_25[39:32];
//	w_addr10F4_rd	: r_prdata = r_TBL_ADDR_26[39:32];
//	w_addr10F8_rd	: r_prdata = r_TBL_ADDR_27[39:32];
//	w_addr10FC_rd	: r_prdata = r_TBL_ADDR_28[39:32];
//	w_addr1100_rd	: r_prdata = r_TBL_ADDR_29[39:32];
		//    1104
		//    1108
	//w_addr110C_rd	: r_prdata = r_TBL_ADDR_32[39:32];
	//w_addr1110_rd	: r_prdata = r_TBL_ADDR_33[39:32];
	//w_addr1114_rd	: r_prdata = r_TBL_ADDR_34[39:32];
	//w_addr1118_rd	: r_prdata = r_TBL_ADDR_35[39:32];


	//w_addr111C_rd	: r_prdata = r_TBL_ADDR_36[39:32];
	//w_addr1120_rd	: r_prdata = r_TBL_ADDR_37[39:32];
	//w_addr1124_rd	: r_prdata = r_TBL_ADDR_38[39:32];
	//w_addr1128_rd	: r_prdata = r_TBL_ADDR_39[39:32];
	//w_addr112C_rd	: r_prdata = r_TBL_ADDR_40[39:32];
	//w_addr1130_rd	: r_prdata = r_TBL_ADDR_41[39:32];
	//w_addr1134_rd	: r_prdata = r_TBL_ADDR_42[39:32];


		w_addr114C_rd	: r_prdata ={24'h0, w_RX_CH0_PREV_ADDR[39:32]	}; 
		w_addr1150_rd	: r_prdata ={24'h0, w_RX_CH1_PREV_ADDR[39:32]	}; 
		w_addr1154_rd	: r_prdata ={24'h0, w_RX_CH2_PREV_ADDR[39:32]	}; 
		w_addr1158_rd	: r_prdata ={24'h0, o_RX_CH0_CURR_ADDR[39:32]		};
		w_addr115C_rd	: r_prdata ={24'h0, o_RX_CH1_CURR_ADDR[39:32]		};
		w_addr1160_rd	: r_prdata ={24'h0, o_RX_CH2_CURR_ADDR[39:32]		};
		w_addr1164_rd	: r_prdata ={24'h0, r_rx_ch0_start_addr[39:32]	};
		w_addr1168_rd	: r_prdata ={24'h0, r_rx_ch1_start_addr[39:32]	};
		w_addr116C_rd	: r_prdata ={24'h0, r_rx_ch2_start_addr[39:32]	};
               
		w_addr1178_rd	: r_prdata ={24'h0, i_RX_CUR_ADDR_CH0[39:32]	};
		w_addr117C_rd	: r_prdata ={24'h0, i_RX_CUR_ADDR_CH1[39:32]	};
		w_addr1180_rd	: r_prdata ={24'h0, i_RX_CUR_ADDR_CH2[39:32]	};
                
		w_addr11D4_rd	: r_prdata ={24'h0, r_tx_ch0_start_addr[39:32]	};
		w_addr11D8_rd	: r_prdata ={24'h0, r_tx_ch1_start_addr[39:32]	};
		w_addr11DC_rd	: r_prdata ={24'h0, r_tx_ch2_start_addr[39:32]	};
                  
		w_addr11F0_rd	: r_prdata ={24'h0, r_tx_addr_ch0_max[39:32]	};
		w_addr11F4_rd	: r_prdata ={24'h0, r_tx_addr_ch0_min[39:32]	};
		w_addr11F8_rd	: r_prdata ={24'h0, r_tx_addr_ch1_max[39:32]	};
		w_addr11FC_rd	: r_prdata ={24'h0, r_tx_addr_ch1_min[39:32]	};
		w_addr1200_rd	: r_prdata ={24'h0, r_tx_addr_ch2_max[39:32]	};
		w_addr1204_rd	: r_prdata ={24'h0, r_tx_addr_ch2_min[39:32]	};

		w_addr1218_rd	: r_prdata ={24'h0, i_TX_CH0_CUR_ADDR[39:32]	};
		w_addr121C_rd	: r_prdata ={24'h0, i_TX_CH1_CUR_ADDR[39:32]	};
		w_addr1220_rd	: r_prdata ={24'h0, i_TX_CH2_CUR_ADDR[39:32]	};
		          
		w_addr1284_rd	: r_prdata ={24'h0, r_adapt_dma_addr[39:32]	};
                  
		w_addr1290_rd	: r_prdata ={24'h0, r_adapt_dma_tx_addr_max[39:32]	};
		w_addr1294_rd	: r_prdata ={24'h0, r_adapt_dma_tx_addr_min[39:32]	};
	 	w_addr1298_rd	: r_prdata ={24'h0, i_ADAPT_TX_CUR_ADDR[39:32]		};
                 
		w_addr12C4_rd	: r_prdata ={24'h0, r_smap_dma_addr[39:32]	};	
                  
		w_addr12D0_rd	: r_prdata ={24'h0, r_smap_dma_tx_addr_max[39:32]	};
		w_addr12D4_rd	: r_prdata ={24'h0, r_smap_dma_tx_addr_min[39:32]	};
		w_addr12D8_rd	: r_prdata ={24'h0, i_SMAP_TX_CUR_ADDR[39:32]	};

		w_addr1304_rd	: r_prdata ={24'h0, r_bds_dma_addr[39:32]	};		
                  
		w_addr1310_rd	: r_prdata ={24'h0, r_bds_dma_tx_addr_max[39:32]	};
		w_addr1314_rd	: r_prdata ={24'h0, r_bds_dma_tx_addr_min[39:32]	};
		w_addr1318_rd	: r_prdata ={24'h0, i_BDS_TX_CUR_ADDR[39:32]		};


		default			: r_prdata = 32'h0					;
	endcase
end

assign o_PRDATA = r_prdata;



SPA_TBL	U_TBL	(
	 .CLK							(i_PCLK					 	)				
	,.RESETn                        (o_GRESETn          	)

	,.i_core_start_sp	            (o_CORE_START		     	)	//(kjm20130207)

	  //TBL_DRX
	,.i_TBL_ENDsp					(i_TBL_ENDsp			)
	,.i_TBL_ENABLE					(r_TBL_ENABLE				)
	,.i_TBL_STARTsp					(r_TBL_STARTsp				)

	,.i_TBL_ADDR_00					(r_TBL_ADDR_00				)
	,.i_TBL_ADDR_01					(r_TBL_ADDR_01				)
	,.i_TBL_ADDR_02					(r_TBL_ADDR_02				)
	,.i_TBL_ADDR_03					(r_TBL_ADDR_03				)
	,.i_TBL_ADDR_04					(r_TBL_ADDR_04				)
	,.i_TBL_ADDR_05					(r_TBL_ADDR_05				)
	,.i_TBL_ADDR_06					(r_TBL_ADDR_06				)
	,.i_TBL_ADDR_07					(r_TBL_ADDR_07				)
	,.i_TBL_ADDR_08					(r_TBL_ADDR_08				)
	,.i_TBL_ADDR_09					(r_TBL_ADDR_09				)
	,.i_TBL_ADDR_10					(r_TBL_ADDR_10				)
	,.i_TBL_ADDR_11					(r_TBL_ADDR_11				)
	,.i_TBL_ADDR_12					(r_TBL_ADDR_12				)
	,.i_TBL_ADDR_13					(r_TBL_ADDR_13				)
	,.i_TBL_ADDR_14					(r_TBL_ADDR_14				)
	,.i_TBL_ADDR_15					(r_TBL_ADDR_15				)
	,.i_TBL_ADDR_16					(r_TBL_ADDR_16				)
	,.i_TBL_ADDR_17					(r_TBL_ADDR_17				)
	,.i_TBL_ADDR_18					(r_TBL_ADDR_18				)
	,.i_TBL_ADDR_19					(r_TBL_ADDR_19				)
	,.i_TBL_ADDR_20					(r_TBL_ADDR_20				)
	,.i_TBL_ADDR_21					(r_TBL_ADDR_21				)
	,.i_TBL_ADDR_22					(r_TBL_ADDR_22				)
	,.i_TBL_ADDR_23					(r_TBL_ADDR_23				)
	,.i_TBL_ADDR_24					(r_TBL_ADDR_24				)

	,.o_TBL_ADDR					(o_TBL_ADDR					)
	,.o_TBL_STARTsp					(o_TBL_STARTsp				)
	,.o_TBL_CNT						(o_TBL_CNT					)
	,.o_TBL_END_M_sp				(o_TBL_END_M_sp				)

);


always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)								r_TBL_RX_START_CNT	 	<= #1 	16'h0;
	else if(r_SW_RESET | r_DMA_STOP ) 					r_TBL_RX_START_CNT	 	<= #1 	16'h0;
	else if(r_TBL_STARTsp & (!r_TBL_RW) )					r_TBL_RX_START_CNT	 	<= #1 	r_TBL_RX_START_CNT + 1;
end
always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)								r_TBL_RX_END_CNT	 	<= #1 	16'h0;
	else if(r_SW_RESET | r_DMA_STOP )					r_TBL_RX_END_CNT	 	<= #1 	16'h0;
	else if(o_TBL_END_M_sp & (!r_TBL_RW) )					r_TBL_RX_END_CNT		<= #1 	r_TBL_RX_END_CNT + 1;
end

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)								r_TBL_TX_START_CNT	 	<= #1 	16'h0;
	else if(r_SW_RESET | r_DMA_STOP )					r_TBL_TX_START_CNT	 	<= #1 	16'h0;
	else if(r_TBL_STARTsp & r_TBL_RW )					r_TBL_TX_START_CNT	 	<= #1 	r_TBL_TX_START_CNT + 1;
end
always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)								r_TBL_TX_END_CNT	 	<= #1 	16'h0;
	else if(r_SW_RESET | r_DMA_STOP )					r_TBL_TX_END_CNT	 	<= #1 	16'h0;
	else if(o_TBL_END_M_sp & r_TBL_RW )					r_TBL_TX_END_CNT		<= #1 	r_TBL_TX_END_CNT + 1;
end

reg	[5:0]	r_TBL_CNT;
always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)								r_TBL_CNT	 	<= #1 	6'h0;
	else if(r_SW_RESET | r_DMA_STOP )					r_TBL_CNT	 	<= #1 	6'h0;
	else									r_TBL_CNT		<= #1 	o_TBL_CNT;
end

reg		r_TBL_ENDsp;
always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)								r_TBL_ENDsp	 	<= #1 	1'h0;
	else if(r_SW_RESET | r_DMA_STOP )					r_TBL_ENDsp	 	<= #1 	1'h0;
	else									r_TBL_ENDsp		<= #1 	i_TBL_ENDsp;
end

always @ (negedge i_HRESETn or posedge i_PCLK) begin
	if(!i_HRESETn)							r_TBL_END_STATUS1		 	<= #1 	32'h0;
	else if(r_SW_RESET | r_DMA_STOP )				r_TBL_END_STATUS1		 	<= #1 	32'h0;
	else if(r_TBL_STARTsp)						r_TBL_END_STATUS1		 	<= #1 	32'h0;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  0) )			r_TBL_END_STATUS1[ 0]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  1) )			r_TBL_END_STATUS1[ 1]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  2) )			r_TBL_END_STATUS1[ 2]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  3) )			r_TBL_END_STATUS1[ 3]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  4) )			r_TBL_END_STATUS1[ 4]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  5) )			r_TBL_END_STATUS1[ 5]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  6) )			r_TBL_END_STATUS1[ 6]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  7) )			r_TBL_END_STATUS1[ 7]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  8) )			r_TBL_END_STATUS1[ 8]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT ==  9) )			r_TBL_END_STATUS1[ 9]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 10) )			r_TBL_END_STATUS1[10]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 11) )			r_TBL_END_STATUS1[11]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 12) )			r_TBL_END_STATUS1[12]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 13) )			r_TBL_END_STATUS1[13]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 14) )			r_TBL_END_STATUS1[14]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 15) )			r_TBL_END_STATUS1[15]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 16) )			r_TBL_END_STATUS1[16]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 17) )			r_TBL_END_STATUS1[17]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 18) )			r_TBL_END_STATUS1[18]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 19) )			r_TBL_END_STATUS1[19]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 20) )			r_TBL_END_STATUS1[20]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 21) )			r_TBL_END_STATUS1[21]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 22) )			r_TBL_END_STATUS1[22]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 23) )			r_TBL_END_STATUS1[23]		<= #1 	1;
	else if(r_TBL_ENDsp && (r_TBL_CNT == 24) )			r_TBL_END_STATUS1[24]		<= #1 	1;
end


SPA_SCATTERED_DRX_CON	U_SCATTERED_DRX_CON	 (

	 .CLK					(i_PCLK						)
	,.RESETn				(o_GRESETn						)		
                       
	,.i_CORE_START_sp       (o_CORE_START					)
	,.i_RX_START_SFR_sp     (r_RX_START			)
	,.o_RX_START_sp         (w_RX_START_SCATTERD			)
                      
	,.i_RX0_ADDR_SFR        (r_rx_ch0_start_addr		)
	,.i_RX1_ADDR_SFR        (r_rx_ch1_start_addr		)
	,.i_RX2_ADDR_SFR        (r_rx_ch2_start_addr		)
	,.i_RX3_ADDR_SFR        (40'h0				)
                     
	,.o_RX0_ADDR_PRE        (w_RX_CH0_PREV_ADDR			)
	,.o_RX1_ADDR_PRE        (w_RX_CH1_PREV_ADDR			)
	,.o_RX2_ADDR_PRE        (w_RX_CH2_PREV_ADDR			)
	,.o_RX3_ADDR_PRE        (				)
	,.o_RX0_ADDR_CUR        (o_RX_CH0_CURR_ADDR				)
	,.o_RX1_ADDR_CUR        (o_RX_CH1_CURR_ADDR				)
	,.o_RX2_ADDR_CUR        (o_RX_CH2_CURR_ADDR				)
	,.o_RX3_ADDR_CUR        (				)
	,.o_RX0_ADDR_NXT        (o_RX_CH0_NEXT_ADDR				)
	,.o_RX1_ADDR_NXT        (o_RX_CH1_NEXT_ADDR				)
	,.o_RX2_ADDR_NXT        (o_RX_CH2_NEXT_ADDR				)
	,.o_RX3_ADDR_NXT        (				)

);

always @ (negedge i_HRESETn or posedge i_PCLK)
	if(!i_HRESETn)				r_CORE_BUSY	<= #1	1'b0;
	else if(r_SW_RESET)			r_CORE_BUSY	<= #1   1'b0;
	else if(r_CORE_START)			r_CORE_BUSY	<= #1	1'h1;
	else if(w_PAGE_DONE_sp)			r_CORE_BUSY	<= #1	1'b0;	



endmodule
