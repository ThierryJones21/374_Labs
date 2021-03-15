module MAR #(parameter VAL = 0)(input [31:0] BusMuxOut, input MARin, clk, clr, output reg [31:0] Address);
    always@(posedge clk or negedge clr)
    begin
        if(clr == 0) Address <= 0;
        else if(MARin) Address <= BusMuxOut;
    end
    initial Address = VAL; // assigns initial value
endmodule