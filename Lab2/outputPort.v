module outputPort( input [31:0] BusMuxOut, input clr, clk, outPortIn, output reg [31:0] outputUnit);
//D = BusMuxOut, Q = outputUnit, enable = outPortIn, clr, clk
  reg tempBus;//one bit

  always @(posedge clk) begin
    outputUnit = (clr == 1) ? 0 : BusMuxOut;

  end

endmodule
