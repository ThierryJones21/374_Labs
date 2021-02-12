module mux21_32_bit(input [31: 0]a, b, input select, output reg muxOut);
//   input wire [31:0] a, [31:0] b, select;
//   output reg [31:0] muxOut;
     
    always @(a,b,select)
    begin
    if(select)
        muxOut=b;
    else
        muxOut=a;
    end    
endmodule