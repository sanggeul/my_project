
`timescale 1ns/1ps

module tb;

reg clk, resetn;

reg ce, ren;
reg [7:0] addr;
wire [7:0] data;
integer i;

initial begin
    $monitor ("ce=%b,ren=%b,addr=%x,data=%x", ce, ren, addr, data);
    clk = 0;
    resetn = 0;

	addr = 0;

	// write
    #10 {ce, ren} = 2'b00;
    #10 {ce, ren} = 2'b01;
    #10 {ce, ren} = 2'b10;
    #10 {ce, ren} = 2'b11;
    #10 {ce, ren} = 2'b00;

	for (i=0;i<256;i=i+1) begin
        #10 addr = i; {ce, ren} = 2'b11;
        #10 {ce, ren} = 2'b00;
	end

    #10 $finish;
end

always begin
 #5 clk = !clk;
end

// instance
rom_readmemb u_duv (
    .clk    (clk)
   ,.resetn (resetn)

   ,.data   (data)

   ,.addr   (addr)
   ,.ce     (ce)
   ,.ren    (ren)
);

endmodule

