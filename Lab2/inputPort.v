module inputPort #(parameter VAL = 0)(input clk, clr, strobe, input [31:0] inputUnit, output reg [31:0] busMuxIn_In_PortIn);
    always@(posedge clk or negedge clr)
    begin
        if(clr == 0) busMuxIn_In_PortIn <= 0;
        else if(strobe) busMuxIn_In_PortIn <= inputUnit;
    end
    initial busMuxIn_In_PortIn = VAL; // assigns initial value
endmodule 