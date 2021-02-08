`include "Lab1_3.1_Registers.v"
`include "Lab1_3.2_Bus.v"
`include "Lab1_3.3_MDR.v"
`include "Lab1_3.4_ALU.v"

module Datapath(output PCout, Zlowout, MDRout, R2out, R4out, input MARin, Zin, 
					 PCin, MDRin, IRin, Yin, IncPC, Read, AND, R5in, R2in, R4in, Clock, Mdatain, R0_out, R1_out);

			datapathIO dataReg (R0_in, R1_in,.R2in(R2_in), R3_,.R4in(R4_in), .R5in(R5_in), R6_in, R7_in, R8_in, R9_in, R10_in, R11_in, R12_in,
									R13_in, R14_in, R15_in, .PCin(PC), .Clock(clk), Clear, R0_out, R1_out, .R2out(R2_out), R3_out, .R4out(R4_out), 
									R5_out, R6_out, R7_out, R8_out, R9_out, R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, 
									
									BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6,
									BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, 
									BusMuxIn_R15, BusMuxOut, .IRin(IR), .Yin(HI), .Yin(Lo), .Zin(Z))
									
			bus myBusMux (R0_out, R1_out, .R2out(R2_out), R3_out, .R4out(R4_out), R5_out, R6_out, R7_out, R8_out, R9_out, R10_out, R11_out, R12_out,
							  R13_out, R14_out, R15_out, HI_out, LO_out, Z_high_out, .Zlowout(Z_low_out), .PCout(PC_out), .MDRout(MDR_out), 
							  In_Portout, C_out,BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6,
							  BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, 
							  BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Z_HI, 
							  BusMuxIn_Z_LO, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_IN_PORT, C_Sign_Extended, BusMuxOut);
)
									
      )
		
		
		
		
