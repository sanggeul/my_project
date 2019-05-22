
`timescale 1ns/1ps

module dump;

initial begin
	`ifdef DUMPFILE
		$fsdbDumpfile(`DUMPFILE);
	`else
		$fsdbDumpfile("./dump/dump.fsdb");
	`endif

	// dump scope
	$fsdbDumpvars(0, tb);
	//$fsdbDumpvars(0, U0);
end

endmodule
