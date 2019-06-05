
`timescale 1ns/1ps

`ifdef DUV
	`include "./tb/tb_duv.v"
`elsif ARBITER
	`include "./tb/tb_arbiter.v"
`elsif ARRAY
	`include "./tb/tb_array.v"
`elsif DYNAMIC
	`include "./tb/tb_dynamic.v"
`elsif RAM_SP_SR_SW
	`include "./tb/tb_ram_sp_sr_sw.v"
`elsif ROM_READMEMB
	`include "./tb/tb_rom_readmemb.v"
`elsif ROM_CASE
	`include "./tb/tb_rom_case.v"
`else // DUV
	`include "./tb/tb_duv.v"
`endif

`ifdef DUMP
	// e.g. ./dump/dump.v
	`include `DUMPMODULE
`endif

