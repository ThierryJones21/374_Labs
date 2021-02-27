module Register (input clk, clr, input [31:0] BusMuxOut, Rin, output reg [31:0] BusMuxIn);
    always@(posedge clk or negedge clr)
    begin
            if(clr == 0) BusMuxIn <= 0;
            else if(Rin) BusMuxIn <= BusMuxOut;
    end
endmodule 