
`timescale 1ns/1ps

module tb;

`define NULL 0    
`define	CYCLE 20 

integer	    fp    ; // file handler
integer     handle;

reg		    clk;
reg		    nrst;

//reg [8*1-1:0] strings;
reg [8*32-1:0] strings;
reg [8*5-1:0] cmd, op1, op2;
//reg [0:8*32-1] strings;
reg [255:0] str;

initial begin
    nrst 	= 1'b1;
    clk  	= 1'b0;
    forever #(`CYCLE/2) clk = ~clk;
end


initial begin
    handle  = 1;
    fp = $fopen("tb/tb_readline.dat", "r");

    if (fp == `NULL) begin
        $display("file handle was NULL");
        $finish;
    end
  
	while(! $feof(fp)) begin
		//$fgets(strings, fp);
		$fscanf(fp, "%s %h %h\n", cmd, op1, op2);
		//strings = $fgetc(fp);
		//$display("strings: %s",strings);
		//$display("strings: %s",strings[8*16-1:8*10]);
		//$display("handle: %d",handle);
		//$display("fp: %d",fp);
		$display("cmd op1 op2: %6s %4h %8h",cmd, op1, op2);
		handle = handle + 1;
	end

    $fclose(fp);
    $finish;
end

endmodule
