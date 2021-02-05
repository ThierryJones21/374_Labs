module mux21_32bit([31: 0]a, [31:0]b, select, muxOut);
    input wire [31:0] a, [31:0] b, select;
    output reg [31:0] muxOut;
     
    always @(a,b,select)
    begin
    if(select)
        muxOut=b;
    else
        muxOut=a;
    end    
endmodule