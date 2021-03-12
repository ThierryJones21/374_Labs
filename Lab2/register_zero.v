module register_zero (input clk, clr, BAout, input [31:0] BusMuxOut, input R0in, output reg [31:0] BusMuxIn_R0);
    always@(posedge clk or negedge clr)
    begin
        if(clr == 0 || BAout == 0) BusMuxIn_R0 <= 0;
        else if(R0in) BusMuxIn_R0 <= BusMuxOut;
    end
endmodule 