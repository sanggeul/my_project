
`timescale 1ns/1ps

module tb;

reg clk, resetn;

reg cs, we, oe;
reg [7:0] addr;
wire [7:0] data;

initial begin
    $monitor ("cs=%b,we=%b,oe=%b,addr=%x,data=%x", cs, we, oe, addr, data);
    clk = 0;
    resetn = 0;

	addr = 0;
	//data = 0;

	// write
    #10 {cs, we, oe} = 3'b000;
    #10 {cs, we, oe} = 3'b001;
    #10 {cs, we, oe} = 3'b010;
    #10 {cs, we, oe} = 3'b011;
    #10 {cs, we, oe} = 3'b100;
    #10 {cs, we, oe} = 3'b101;
    #10 {cs, we, oe} = 3'b110;
    #10 {cs, we, oe} = 3'b111;

    #10 $finish;
end

always begin
 #5 clk = !clk;
end

// instance
ram_sp_sr_sw u_duv (
    .clk    (clk)
   ,.resetn (resetn)

   ,.data   (data)

   ,.addr   (addr)
   ,.cs     (cs)
   ,.we     (we)
   ,.oe     (oe)
);

endmodule

