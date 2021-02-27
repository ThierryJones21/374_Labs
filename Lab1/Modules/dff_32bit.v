module dff_32_bit (input clr, clk, enable, input [31:0]D, output reg [31:0]Q);

    always @(posedge clk or negedge clr)
    begin
            if(clr == 0) Q <= 00000000000000000000000000000000; //32 zeros
            else if(enable) Q <= D;
    end	
    
endmodule 