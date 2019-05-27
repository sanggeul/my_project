
`timescale 1ns/1ps

module tb;

reg clk, nreset, sel, in0, in1;
wire out;

reg [3:0] a, b, c, d, e, f;

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

	#10;
    $display ("%t: bit operation ", $time);
	a = 8'ha;
	b = 8'hb;
	c = 8'hc;
	d = 8'hd;
	e = 8'he;
	f = 8'hf;
    $display ("%t: a        = %b", $time, a    );
    $display ("%t: b        = %b", $time, b    );
    $display ("%t: c        = %b", $time, c    );
    $display ("%t: d        = %b", $time, d    );
    $display ("%t: e        = %b", $time, e    );
    $display ("%t: f        = %b", $time, f    );
    $display ("%t: a&b      = %b", $time, a&b  );
    $display ("%t: a&&b     = %b", $time, a&&b );
    $display ("%t: a&b&c    = %b", $time, a&b&c);
    $display ("%t: &c       = %b", $time, &c   );
    $display ("%t: &f       = %b", $time, &f   );
    $display ("%t: a&b&&c   = %b", $time, a&b&&c);
    $display ("%t: a&(b&&c) = %b", $time, a&(b&&c));


    #10 $finish;
end

always begin
 #5 clk = !clk;
end

// instance
duv u_duv (
    .clk    (clk)
   ,.nreset (nreset)
   ,.sel    (sel)
   ,.in0    (in0)
   ,.in1    (in1)
   ,.out    (out)
);

endmodule

