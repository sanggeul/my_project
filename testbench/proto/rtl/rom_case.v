module rom_case (/*AUTOARG*/
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
reg [DATA_WIDTH-1:0] data;

// Body
//statements, etc go here.
//always @(*) begin
always_comb begin

    case (addr)
        0  : data = 8'd32;
        1  : data = 8'd31;
        2  : data = 8'd30;
        3  : data = 8'd29;
        4  : data = 8'd28;
        5  : data = 8'd27;
        6  : data = 8'd26;
        7  : data = 8'd25;
        8  : data = 8'd24;
        9  : data = 8'd23;
        10 : data = 8'd22;
        11 : data = 8'd21;
        12 : data = 8'd20;
        13 : data = 8'd19;
        14 : data = 8'd18;
        15 : data = 8'd17;
        16 : data = 8'd16;
        17 : data = 8'd15;
        18 : data = 8'd14;
        19 : data = 8'd13;
        20 : data = 8'd12;
        21 : data = 8'd11;
        22 : data = 8'd10;
        23 : data = 8'd9;
        24 : data = 8'd8;
        25 : data = 8'd7;
        26 : data = 8'd6;
        27 : data = 8'd5;
        28 : data = 8'd4;
        29 : data = 8'd3;
        30 : data = 8'd2;
        31 : data = 8'd1;
	    default : data = 8'hxx;
    endcase
end

endmodule


