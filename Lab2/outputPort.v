module outputPort #(parameter VAL = 0) (input clk, clr, outPortIn, input [31:0] BusMuxOut, output reg [31:0] outputUnit);
    always@(posedge clk or negedge clr)
    begin
        if(clr == 0) outputUnit <= 0;
        else if(outPortIn) outputUnit <= BusMuxOut;
    end
    initial outputUnit = VAL; // assigns initial value
endmodule 