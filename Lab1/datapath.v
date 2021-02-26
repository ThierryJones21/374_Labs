module datapath(input PCout, Zlowout, MDRout, R2out, R4out, MARin, Zin, 
					 PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, R5in, R2in, R4in, Clock, Mdatain, Clear, R0out, R1out, R2out, R3out, R4out, R5out, R6out
					 R7out,R8out,R9out,R10out,R11out,R12out,R13out,R14out,R15out);    

			
			wire [31:0] Bus_Mux_Out;
			reg [31:0] IR;
			
			reg [31:0] ALU_HI, ALU_LO;
			wire[63:0] C;
					
			Register myR0 (Clock, Clear, Bus_Mux_Out, R0out);
         Register myR1 (Clock, Clear, Bus_Mux_Out, R1out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R2out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R3out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R4out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R5out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R6ut); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R7out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R8out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R9out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R10out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R11out);  
			Register myR1 (Clock, Clear, Bus_Mux_Out, R12out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R13out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R14out); 
			Register myR1 (Clock, Clear, Bus_Mux_Out, R15out); 
								
														
			Bus myBusMux (R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out,  R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out, In_Portout, C_out,
								BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15,
								BusMuxIn_HI, BusMuxIn_LO,
 BusMuxIn_Z_HI, BusMuxIn_Z_LO, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_IN_PORT, C_Sign_Extended, BusMuxOut);


			ALU myALU	(.A(R2out), .B(R4out), .C(C), .cntrl(CONTROL));
							
			MDR myMDR (.Read(Read), .clk(Clock), .MDRin(MDRin), .BusMuxOut(R5in), .Mdatain(Mdatain),  .MDRout(MDRout));     
			
			always @(C) begin
				ALU_HI <= C[63:32];
				ALU_LO <= C[31:0];
			end
				
endmodule 