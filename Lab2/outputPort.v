module outputPort( input [31:0] BusMuxOut, input clr, clk, outPortIn, output [31:0] outputUnit);
//D = BusMuxOut, Q = outputUnit, enable = outPortIn, clr, clk
reg tempBus;//one bit
  
  always @(posedge clk) begin
  if(clr == 1) begin
		tempBus <= 0;
  end 
   if(outPortIn == 1) begin
		tempBus <= BusMuxOut;
	end
end

assign outputUnit = tempBus;

endmodule
