module duv (
	 clk 
	,nreset
    ,sel
    ,in0
    ,in1
    ,out
);

input clk;
input nreset;
input sel;
input in0;
input in1;

output out;

reg q0;
reg mux_out;

wire out;
//wire mux_out;
wire d0;

//assign mux_out = sel ? in1 : in0;
always @(*) begin
	case (sel)
		0: mux_out = in0;
		1: mux_out = in1;
		default: mux_out = in0;
	endcase
end

//assign d0 = mux_out;
//always @ (posedge clk or negedge nreset) begin
//    if (!nreset) begin
//        q0 <= 0;
//    end
//    else begin
//        q0 <= d0;
//    end
//end
//assign out = q0;

assign out = mux_out;

endmodule
