module MAR(input [31:0] BusMuxOut, input MARin, clk, clr, output reg [8:0] Address);
    always@(posedge clk or negedge clr)
    begin
        if(clr == 0) Address <= 0;
        else if(MARin) Address <= BusMuxOut[8:0];
    end
endmodule 