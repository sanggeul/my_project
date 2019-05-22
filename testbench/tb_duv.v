
`timescale 1ns/1ps

module tb;

reg clk, nreset, sel, in0, in1;
wire out;

initial begin
    $monitor ("sel=%b,in0=%b,in1=%b,out=%b", sel, in0, in1, out);
    clk = 0;
    nreset = 0;
    sel = 0;
    {in0, in1} = 0;
    #5 nreset = 1;

    #10 nreset = 0;
    #10 nreset = 1;

    sel = 0;
#1
    #10 {in0,in1} = 2'b00;
    #10 {in0,in1} = 2'b01;
    #10 {in0,in1} = 2'b10;
    #10 {in0,in1} = 2'b11;

    #10 nreset = 0;
    #10 nreset = 1;

    sel = 1;
    #10 {in0,in1} = 2'b00;
    #10 {in0,in1} = 2'b01;
    #10 {in0,in1} = 2'b10;
    #10 {in0,in1} = 2'b11;

    #10 $finish;
end

always begin
 #5 clk = !clk;
end

// instance
duv U0 (
    .clk    (clk)
   ,.nreset (nreset)
   ,.sel    (sel)
   ,.in0    (in0)
   ,.in1    (in1)
   ,.out    (out)
);

endmodule

