module ram_sp_sr_sw (/*AUTOARG*/
   // Inouts
   data,
   // Inputs
   clk, resetn, addr, cs, we, oe
   );

parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 8;
parameter RAM_DEPTH  = (1 << ADDR_WIDTH);

// Automatics
/*AUTOINPUT*/
input                  clk;
input                  resetn;

input [ADDR_WIDTH-1:0] addr;
input                  cs;
input                  we;
input                  oe;

/*AUTOOUTPUT*/

/*AUTOINOUT*/
inout [DATA_WIDTH-1:0] data;

/*AUTOWIRE*/
/*AUTOREG*/
reg [DATA_WIDTH-1:0] dout;
typedef reg [ADDR_WIDTH-1:0] maddr;
reg [DATA_WIDTH-1:0] mem[maddr];

// Body
//statements, etc go here.
assign data = (cs && !we && oe) ? dout : 8'bz;

always @ (posedge clk) begin : M_WR
	if (cs && we) begin
		mem[addr] = data;
	end
end

always @ (posedge clk) begin : M_RD
	if (cs && !we && oe) begin
		dout = mem[addr];
	end
end

endmodule


