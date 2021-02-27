// `include "Modules/mux21_32bit.v"
// `include "Modules/dff_32bit.v"

module MDR (input Read, clr, clk, MDRin, input [31: 0]BusMuxOut, Mdatain, output reg [31:0] MDRout);


	reg [31:0]MDMuxOut;

    // multiplexer logic
	 //mux21_32_bit myMuxyMux(BusMuxOut, Mdatain, Read, MDMuxOut);
	  always @(BusMuxOut,Mdatain,Read)
    begin
    if(Read)
        MDMuxOut=Mdatain;
    else
        MDMuxOut=BusMuxOut;
    end    
	 
	 
    // flip flop logic
    //dff_32_bit myDff (clk, clr, MDRin, MDMuxOut, MDRout);
		 always@(posedge clk or negedge clr)
    begin
            if(clr == 0) MDRout <= 00000000000000000000000000000000; //32 zeros
            else if(MDRin) MDRout <= MDMuxOut;
    end	
	 
endmodule 
