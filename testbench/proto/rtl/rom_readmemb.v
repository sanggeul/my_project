module rom_readmemb (/*AUTOARG*/
   // Outputs
   data,
   // Inputs
   clk, resetn, addr, ce, ren
   );

parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 8;
parameter RAM_DEPTH  = (1 << ADDR_WIDTH);

// Automatics
/*AUTOINPUT*/
input                  clk;
input                  resetn;

input [ADDR_WIDTH-1:0] addr;
input                  ce;
input                  ren;

/*AUTOOUTPUT*/

/*AUTOINOUT*/
output [DATA_WIDTH-1:0] data;

/*AUTOWIRE*/
/*AUTOREG*/
reg [DATA_WIDTH-1:0] mem[0:RAM_DEPTH-1];

// Body
//statements, etc go here.
assign data = (ce && ren) ? mem[addr] : 8'bx;

initial begin
	//$readmemb("rom_data.mem", mem);
	$readmemb("rtl/rom_data.mem", mem);
end

endmodule


