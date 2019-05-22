module ModName (/*AUTOARG*/);

	// Input
	//input signal;

	// Output

	// Automatics
	/*AUTOWIRE*/
	/*AUTOREG*/

	// Body
	//statements, etc go here.

	// Linting
	wire  _unused_ok = &amp; {1'b0,
				// Put list of unsed signals here
				1'b0};

	// Instatance Module
	InstModule instName
		(/*AUTOINST*/);

	always @(/*AS*/) begin	// or, @* if using Verilog-2001
		...
	end

	// Auto Reset
	always @(posedge clk or negedge reset_1) begin
		if (!reset_1) begin
			c <= 1;
			/*AUTORESET*/
		a <= 3'b0;
		b <= 1'b0;
		end
		else begin
			a <= in_a;
			b <= in_b;
			c <= in_c;
		end
	end
	
	always @* begin
		if (!reset_1) begin
			/*AUTORESET*/
		a_combo <= 3'b0;
		end
		else begin
			a_combo <= in_a;
		end
	end


endmodule


module ModNameStub (/*AUTOARG*/);

	/*AUTOINOUTPARAM("ModName")*/
	/*AUTOINOUTMODULE(ModName)*/

	/*AUTOWIRE*/
	/*AUTOREG*/

	/*AUTOTIEOFF*/

	wire  _unused_ok = &amp; {1'b0,
				// Put list of unsed signals here
				1'b0};

endmodule


module ModNameTest;

	/*AUTOWIRE*/
	/*AUTOREGINPUT*/

	// Instatance Module
	InstModule instName
		(/*AUTOINST*/);

	//=== Stimulus
	// You then put code here to set all of the inputs to the DUT.
	// The autos have created registers for all of theh needed signals.

	//=== Stimulus
	// You then put code here to check all of the output from the DUT.
	// The autos have createde wires for all of the needed signals.

endmodule



