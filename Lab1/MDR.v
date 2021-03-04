module MDR (input Read, clr, clk, MDRin, input [31: 0]BusMuxOut, Mdatain, output reg [31:0] MDRout);
	 
    always@(posedge clk or negedge clr)
    begin
        if(clr == 0) MDRout <= 0; // 32'h0000_0000 zeroes work
        else if(MDRin) MDRout <= Read ? Mdatain : BusMuxOut;
    end	
	 
endmodule 
