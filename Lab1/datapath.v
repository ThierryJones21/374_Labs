module datapath(output reg PCout, Zlowout, MDRout, R2out, R4out, input MARin, Zin, 
					 PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, R5in, R2in, R4in, Clock, Mdatain, R0out, R1out);    //WE NEEED A CLEAAAARRRR!!!

			
			wire [31:0] Bus_Mux_Out;
			reg [31:0] IR;
			
			reg [31:0] ALU_HI, ALU_LO;
			reg[63:0] ALU_Out;
					 
					 
			Registers dataReg (.R2_in(R2in),.R4_in(R4in), .R5_in(R5in), .clk(Clock),
									
										.BusMuxIn_R0(R0out), .BusMuxIn_R1(R1out), .BusMuxIn_R2(R2out), .BusMuxIn_R4(R4out), .BusMuxOut(Bus_Mux_Out));
									
			bus myBusMux (.R0_out(R0out), .R1_out(R1out), .R2_out(R2out), .R4_out(R4out), .Z_low_out(Zlowout), .PC_out(PCout), .MDR_out(MDRout), 
							  .BusMuxIn_R2(R2in), .BusMuxIn_R4(R4in), .BusMuxIn_R5(R5in), .BusMuxIn_PC(PCin), .BusMuxIn_MDR(MDRin), .BusMuxOut(Bus_Mux_Out));
							  

			ALU myALU	(.A(R2out), .B(R4out), .C(ALU_Out), .cntrl(CONTROL));
							
			MDR myMDR (.Read(Read), .clk(Clock), .MDRin(MDRin), .R5in(Bus_Mux_Out), .Mdatain(Mdatain),  .MDRout(MDRout));     
			
			always @(ALU_Out) begin
				ALU_HI <= ALU_Out[63:32];
				ALU_LO <= ALU_Out[31:0];
			end
				
endmodule 