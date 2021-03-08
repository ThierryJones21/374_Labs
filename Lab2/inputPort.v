module inputPort( input [31:0] inputUnit, input clr, clk, output [31:0] busMuxIn_In_PortIn);
//D = InputUnit, Q = BusMuxIn_In.Port, Strobe Unit if desired, clr, clk
reg tempBus;//one bit
  
always @(posedge clk) begin
  if(clr == 1'b1) begin//1'b1 is one bit wide where as 1 is 32 bits wide
		tempBus <= 0;
	end else begin
		tempBus <= inputUnit;
	end
end

assign busMuxIn_In_PortIn = tempBus;

endmodule
