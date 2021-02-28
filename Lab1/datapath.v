module datapath(input PCout, MDRout, MARin, Zlowin, Zhighin, 
					 PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL,Clock, 
					 Mdatain, Clear, input [31:0] R0out, R1out, R2out, R3out, R4out, R5out, R6out,
					 R7out,R8out,R9out,R10out,R11out,R12out,R13out,R14out,R15out,
					R0in, R1in, R2in, R3in, R4in, R5in, R6in,
					 R7in, R8in, R9in,R10in,R11in,R12in,R13in,R14in,R15in,
					 output reg [31:0] Zlowout, Zhighout);    

			
			wire [31:0] Bus_Mux_Out;
			reg [31:0] IR;
			
			//reg [31:0] ALU_HI, ALU_LO;
			wire[63:0] C;
					
         Register myR0 (Clock, Clear, Bus_Mux_Out, R0in, R0out); 
         Register myR1 (Clock, Clear, Bus_Mux_Out, R1in, R1out); 
			Register myR2 (Clock, Clear, Bus_Mux_Out, R2in, R2out); 
			Register myR3 (Clock, Clear, Bus_Mux_Out, R3in, R3out); 
			Register myR4 (Clock, Clear, Bus_Mux_Out, R4in, R4out);  
			Register myR5 (Clock, Clear, Bus_Mux_Out, R5in, R5out); 
			Register myR6 (Clock, Clear, Bus_Mux_Out, R6in, R6out); 
			Register myR7 (Clock, Clear, Bus_Mux_Out, R7in, R7out); 
			Register myR8 (Clock, Clear, Bus_Mux_Out, R8in, R8out); 
			Register myR9 (Clock, Clear, Bus_Mux_Out, R9in, R9out); 
			Register myR10 (Clock, Clear, Bus_Mux_Out, R10in, R10out); 
			Register myR11 (Clock, Clear, Bus_Mux_Out, R11in, R11out);  
			Register myR12 (Clock, Clear, Bus_Mux_Out, R12in, R12out); 
			Register myR13 (Clock, Clear, Bus_Mux_Out, R13in, R13out); 
			Register myR14 (Clock, Clear, Bus_Mux_Out, R14in, R14out); 
			Register myR15 (Clock, Clear, Bus_Mux_Out, R15in, R15out); 
								
														
			Bus myBusMux (R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out,  R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out, In_Portout, C_out,
								BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15,
								BusMuxIn_HI, BusMuxIn_LO,
 BusMuxIn_Z_HI, BusMuxIn_Z_LO, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_IN_PORT, C_Sign_Extended, BusMuxOut);


			ALU myALU	(R2out, R4out, R5in, CONTROL);
							
			MDR myMDR (.Read(Read), .clk(Clock), .MDRin(MDRin), .BusMuxOut(R5in), .Mdatain(Mdatain),  .MDRout(MDRout));     
			
			always @(C) begin
				Zhighout <= C[63:32];
				Zlowout <= C[31:0];
			end
				
endmodule 