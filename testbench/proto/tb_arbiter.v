
`timescale 1ns/1ps

module tb;

reg clk, nreset, req0, req1;
wire gnt0, gnt1;

initial begin
    $monitor ("req0=%b,req1=%b,gnt0=%b,gnt1=%b", req0,req1,gnt0,gnt1);
    clk = 0;
    nreset = 0;
    req0 = 0;
    req1 = 0;
    #5 nreset = 1;

    #10 nreset = 0;
    #10 nreset = 1;
    #10 req0 = 1;
    #10 req0 = 0;
    #10 req1 = 1;
    #10 req1 = 0;
    #10 {req0,req1} = 2'b11;
    #10 {req0,req1} = 2'b00;

    #10 nreset = 0;
    #10 nreset = 1;
    #10 req0 = 1;
    #10 req0 = 0;
    #10 req1 = 1;
    #10 req1 = 0;
    #10 {req0,req1} = 2'b11;
    #10 {req0,req1} = 2'b00;
    #10 $finish;
end

always begin
 #5 clk = !clk;
end

// instance
arbiter u_duv (
    .clk    (clk)
   ,.nreset (nreset)
   ,.req_0  (req0)
   ,.req_1  (req1)
   ,.gnt_0  (gnt0)
   ,.gnt_1  (gnt1)
);

endmodule

