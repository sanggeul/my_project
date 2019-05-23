module arbiter (
	 clk, 
	 nreset, 
	 req_0,
	 req_1, 
	 gnt_0,
	 gnt_1
);

input clk;
input nreset;
input req_0;
input req_1;

output gnt_0;
output gnt_1;

reg gnt_0;
reg gnt_1;

always @ (posedge clk or negedge nreset) begin
    if (!nreset) begin
        gnt_0 <= 0;
        gnt_1 <= 0;
    end
    else if (req_0) begin
        gnt_0 <= 1;
        gnt_1 <= 0;
    end
    else if (req_1) begin
        gnt_0 <= 0;
        gnt_1 <= 1;
    end
end

endmodule
