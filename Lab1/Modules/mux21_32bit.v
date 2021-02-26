module mux21_32_bit(input [31: 0]a, b, input select, output reg muxOut);
     
    always @(a,b,select)
    begin
    if(select)
        muxOut=b;
    else
        muxOut=a;
    end
    
endmodule