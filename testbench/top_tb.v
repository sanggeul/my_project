
`timescale 1ns/1ps

`ifdef ARBITER
	`include "tb_arbiter.v"
`else // DUV
	`include "tb_duv.v"
`endif

`ifdef DUMP
	// e.g. ./dump/dump.v
	`include `DUMPMODULE
`endif

