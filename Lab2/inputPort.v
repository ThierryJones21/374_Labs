module inputPort( input [31:0] inputUnit, input clr, clk, output reg [31:0] busMuxIn_In_PortIn);
//D = InputUnit, Q = BusMuxIn_In.Port, Strobe Unit if desired, clr, clk

	always @(posedge clk) begin
		busMuxIn_In_PortIn = (clr == 1'b1) ? 0 : inputUnit;
	end

endmodule
