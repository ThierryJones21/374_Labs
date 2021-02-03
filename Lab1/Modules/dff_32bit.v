module dff (clr, clk, enable, [31:0]D, [31:0]Q);
    input clr, clk, enable, [31:0]D;
    output [31:0]Q;

    always@(posedge clk or negedge clr)
    begin
            if(clr == 0) Q <= 0000 0000 0000 0000 0000 0000 0000 0000;
            else if(enable) Q <= D;
    end	
endmodule;