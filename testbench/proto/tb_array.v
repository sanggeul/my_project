
`timescale 1ns/1ps

module tb();
// arrays_data
// multi dimension array

reg clk, nreset;

always begin
    #5 clk = !clk;
end

reg [7:0] memory [0:3] = {8'h9, 8'h7, 8'h5, 8'h3};
reg [7:0] memory1 [0:1][0:3]=
   '{'{8'h0,8'h1,8'h2,8'h3},'{8'h4,8'h5,8'h6,8'h7}};

initial begin
	memory1[0][0] = 8'hf0;
	memory1[0][1] = 8'hf1;
	memory1[0][2] = 8'hf2;
	memory1[0][3] = 8'hf3;
	memory1[1][0] = 8'hf4;
	memory1[1][1] = 8'hf5;
	memory1[1][2] = 8'hf6;
	memory1[1][3] = 8'hf7;
	memory1[3][0] = 8'hc1;
	memory1[3][1] = 8'hc2;
	memory1[4][2] = 8'hc3;
    #10;
    $display ("memory[0]            = %b", memory[0]);
    $display ("memory[1]            = %b", memory[1]);
    $display ("memory[2]            = %b", memory[2]);
    $display ("memory[3]            = %b", memory[3]);
    $display ("memory[2][0]         = %b", memory[2][0]);
    $display ("memory[2][1]         = %b", memory[2][1]);
    $display ("memory[2][2]         = %b", memory[2][2]);
    $display ("memory[2][3]         = %b", memory[2][3]);

    $display ("memory1[0][1]        = %b", memory1[0][1]);
    $display ("memory1[0][1]        = %b", memory1[0][1]);
    $display ("memory1[0][2]        = %b", memory1[0][2]);
    $display ("memory1[0][3]        = %b", memory1[0][3]);
    $display ("memory1[1][1]        = %b", memory1[1][1]);
    $display ("memory1[1][1]        = %b", memory1[1][1]);
    $display ("memory1[1][2]        = %b", memory1[1][2]);
    $display ("memory1[1][3]        = %b", memory1[1][3]);

    $display ("memory1[3][0]        = %b", memory1[3][0]);
    $display ("memory1[3][1]        = %b", memory1[3][1]);
    $display ("memory1[4][2]        = %b", memory1[4][2]);
    #10  $finish;
end

endmodule

