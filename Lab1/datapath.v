module datapath(PCout, MDRout, MARin, Zhighin, Zlowin, Highin, Lowin, PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, Clock, Mdatain, Clear, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in);

	input PCout, MDRout, MARin, Zhighin, Zlowin, Highin, Lowin, PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, Clock, Clear;
	input [31:0] Mdatain;
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
	input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;

	// NOTE: RXin are enables; RXout are outputs
			
	wire [31:0] Bus_Mux_Out;
	
	wire [63:0] ZOut;

	// 15 Registers
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
	
	// For multiplication/division
	Register HI (Clock, Clear, Bus_Mux_Out, Highin, ZOut[63:32]);
	Register LO (Clock, Clear, Bus_Mux_Out, Lowin, ZOut[31:0]);
	Register Z_HI (Clock, Clear, Bus_Mux_Out, Zhighin, ZOut[63:32]);
	Register Z_LO (Clock, Clear, Bus_Mux_Out, Zlowin, ZOut[31:0]);

	// MAR MDR PC IR IN_PORT
	Register MAR (Clock, Clear, Bus_Mux_Out, MARin, MARout);
	Register MDR (Clock, Clear, Bus_Mux_Out, MDRin, MDRout);
	Register PC (Clock, Clear, Bus_Mux_Out, PCin, PCOut);
	// Register IR (Clock, Clear, Bus_Mux_Out, IRin), IROut);
	Register IN_PORT (Clock, Clear, Bus_Mux_Out, IRin, PCOut);
												
	Bus myBusMux (.R0_out(R0in), .R1_out(R1in), .R2_out(R2in), .R3_out(R3in), .R4_out(R4in), .R5_out(R5in), .R6_out(R6in), .R7_out(R7in), .R8_out(R8in), .R9_out(R9in), .R10_out(R10in), .R11_out(R11in), .R12_out(R12in), .R13_out(R13in), .R14_out(R14in), .R15_out(R15in), .HI_out(Highin), .LO_out(Lowin), .Z_high_out(Zhighin), .Z_low_out(Zlowin), .PC_out(PCOut), .MDR_out(MDRout), .In_Portout(), .C_out(), .BusMuxIn_R0(R0out), .BusMuxIn_R1(R1out), .BusMuxIn_R2(R2out), .BusMuxIn_R3(R3out), .BusMuxIn_R4(R4out), .BusMuxIn_R5(R5out), .BusMuxIn_R6(R6out), .BusMuxIn_R7(R7out), .BusMuxIn_R8(R8out), .BusMuxIn_R9(R9out), .BusMuxIn_R10(R10out), .BusMuxIn_R11(R11out), .BusMuxIn_R12(R12out), .BusMuxIn_R13(R13out), .BusMuxIn_R14(R14out), .BusMuxIn_R15(R15out), .BusMuxIn_HI(ZOut[63:32]), .BusMuxIn_LO(ZOut[31:0]), .BusMuxIn_Z_HI(ZOut[63:32]), .BusMuxIn_Z_LO(ZOut[31:0]), .BusMuxIn_PC(PCout), .BusMuxIn_MDR(MDRout), .BusMuxIn_IN_PORT(), .C_Sign_Extended(), .BusMuxOut(Bus_Mux_Out));

	ALU myALU	(.A(R2out), .B(R4out), .C(ZOut), .cntrl(CONTROL));
					
	MDR myMDR (.Read(Read), .clk(Clock), .MDRin(MDRin), .BusMuxOut(R5in), .Mdatain(Mdatain),  .MDRout(MDRout));
				
endmodule 