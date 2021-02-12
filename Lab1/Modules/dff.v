module dff (input clr, clk, enable, D, output Q);
//    input clr, clk, enable, D;
//    output Q;

    always@(posedge clk or negedge clr)
    begin
            if(clr == 0) Q <= 0;
            else if(enable) Q <= D;
    end	
endmodule 