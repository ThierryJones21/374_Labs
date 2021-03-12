module Register #(parameter VAL = 0)(input clk, clr, input [31:0] BusMuxOut, input Rin, output reg [31:0] BusMuxIn);
    always@(posedge clk or negedge clr)
    begin
        if(clr == 0) BusMuxIn <= 0;
        else if(Rin) BusMuxIn <= BusMuxOut;
    end
    initial BusMuxIn = VAL; // assigns initial value
endmodule 
// It overwrite the 0 when a register is instantiated?
// TODO - remove regloads !
