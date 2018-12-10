
`timescale 1ns/1ps

//--------------------------------------
// wrapper in cmbus
//--------------------------------------

// lib
`include    "./rtl/lib/lib_syn.v"
`include    "./rtl/lib/lib_async_ff.v"
`include    "./rtl/lib/lib_sec_ff.v"

//// h2h
//`include	"./rtl/h2h/h2h_master.v"
//`include	"./rtl/h2h/h2h_master_core.v"
//`include	"./rtl/h2h/h2h_sync1.v"

// arb
`include    "./rtl/top_arb/arb.v"

`include    "./rtl/top_arb/arb_fsm.v"
`include    "./rtl/top_arb/arb_lock.v"
`include    "./rtl/top_arb/arb_cfg.v"

// reg
`include    "./rtl/top_reg/reg.v"

`include    "./rtl/top_reg/reg_cont.v"

`include    "./rtl/top_reg/reg_prog.v"
`include    "./rtl/top_reg/reg_prog_64to32.v"
`include    "./rtl/top_reg/reg_prog_ahbif.v"

// con
`include    "./rtl/top_con/con.v"

`include    "./rtl/top_con/con_trans.v"

`include    "./rtl/top_con/con_test.v"
`include    "./rtl/top_con/con_test_mx.v"
`include    "./rtl/top_con/con_test_tmx.v"
`include    "./rtl/top_con/con_test_nmx.v"

// ini
`include    "./rtl/top_ini/ini.v"

`include    "./rtl/top_ini/ini_dec.v"
`include    "./rtl/top_ini/ini_dec_cfg.v"
`include    "./rtl/top_ini/ini_dec_key.v"

`include    "./rtl/top_ini/ini_don.v"
`include    "./rtl/top_ini/ini_dum.v"
`include    "./rtl/top_ini/ini_tim.v"
`include    "./rtl/top_ini/ini_pmu.v"
`include    "./rtl/top_ini/ini_cmb.v" // cmb + key
`include    "./rtl/top_ini/ini_ca1.v"
`include    "./rtl/top_ini/ini_ca2.v"
`include    "./rtl/top_ini/ini_rng.v"


// obf
`include    "./rtl/top_obf/obf.v"

//`include    "./rtl/top_obf/sec_obf_rtl_list.inc"
`include    "./rtl/top_obf/sec_obf_define.v"

`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_rcon.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_keyexpansion.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_sbox.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_subbytes.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_shiftrows.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_mixcolumns.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_addroundkey.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_inv_sbox.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_inv_subbytes.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_inv_shiftrows.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_inv_mixcolumns.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_encoder.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_decoder.v"
`include    "./rtl/top_obf/sec_obf_aes/sec_obf_aes_core.v"
`include    "./rtl/top_obf/sec_obf.v"
`include    "./rtl/top_obf/sec_obf_key_selector.v"

`include    "./rtl/top_obf/sec_obf_undefine.v"

// err
`include    "./rtl/top_err/err.v"

`include    "./rtl/top_err/err_dec.v"

// top and wrapper
`include    "./rtl/top.v"
`include    "./rtl/ahbmx.v"

`include    "./rtl/wrap.v"


