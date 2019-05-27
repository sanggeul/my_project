
`timescale 1ns/1ps

`ifdef DUV
	`include "./tb/tb_duv.v"
`elsif ARBITER
	`include "./tb/tb_arbiter.v"
`elsif ARRAY
	`include "./tb/tb_array.v"
`elsif DYNAMIC
	`include "./tb/tb_dynamic.v"
`else // DUV
	`include "./tb/tb_duv.v"
`endif

`ifdef DUMP
	// e.g. ./dump/dump.v
	`include `DUMPMODULE
`endif

