module datapath(PCout, MDRout, MARin, Zin, Zhighout, Zlowout, PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, Clock, Mdatain, Clear, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in);

	input PCout, MDRout, MARin, Zin, Zhighout, Zlowout, PCin, MDRin, IRin, Yin, IncPC, Read, Clock, Clear;
	input [31:0] Mdatain;
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
	input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
		
	input[3:0] CONTROL;	
	wire [31:0] Bus_Mux_Out; // output of bus
	wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, 
					BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_Z_HI, BusMuxIn_Z_LO, 
					BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_PC; // register "storage"
					
	wire [63:0] ZOut; // ALU output
	wire [31:0] MDR_wire_out;
	wire [31:0] Y_contents;
	
	wire highout, lowout, highin, lowin;

	// 15 Registers
	Register myR0 (Clock, Clear, Bus_Mux_Out, R0in, BusMuxIn_R0); 
	Register myR1 (Clock, Clear, Bus_Mux_Out, R1in, BusMuxIn_R1); 
	Register myR2 (Clock, Clear, Bus_Mux_Out, R2in, BusMuxIn_R2); 
	Register myR3 (Clock, Clear, Bus_Mux_Out, R3in, BusMuxIn_R3); 
	Register myR4 (Clock, Clear, Bus_Mux_Out, R4in, BusMuxIn_R4); 
	Register myR5 (Clock, Clear, Bus_Mux_Out, R5in, BusMuxIn_R5); 
	// Register myR6 (Clock, Clear, Bus_Mux_Out, R6in, R6out); 
	// Register myR7 (Clock, Clear, Bus_Mux_Out, R7in, R7out); 
	// Register myR8 (Clock, Clear, Bus_Mux_Out, R8in, R8out); 
	// Register myR9 (Clock, Clear, Bus_Mux_Out, R9in, R9out); 
	// Register myR10 (Clock, Clear, Bus_Mux_Out, R10in, R10out); 
	// Register myR11 (Clock, Clear, Bus_Mux_Out, R11in, R11out);  
	// Register myR12 (Clock, Clear, Bus_Mux_Out, R12in, R12out); 
	// Register myR13 (Clock, Clear, Bus_Mux_Out, R13in, R13out); 
	// Register myR14 (Clock, Clear, Bus_Mux_Out, R14in, R14out); 
	// Register myR15 (Clock, Clear, Bus_Mux_Out, R15in, R15out);
	
	// For multiplication/division
	Register HI (Clock, Clear, Bus_Mux_Out, highin, BusMuxIn_HI);
	Register LO (Clock, Clear, Bus_Mux_Out, lowin, BusMuxIn_LO);
	// Unneeded b/c ZXX stores on the bus, whereas HI/LO read from the bus
	Register Z_HI (Clock, Clear, ZOut[63:32], Zin, BusMuxIn_Z_HI);
	Register Z_LO (Clock, Clear, ZOut[31:0], Zin, BusMuxIn_Z_LO);

	// PC IR IN_PORT
		Register PC (Clock, Clear, Bus_Mux_Out, PCin, BusMuxIn_PC);
	// Register IR (Clock, Clear, Bus_Mux_Out, IRin), IROut);
	// Register IN_PORT (Clock, Clear, Bus_Mux_Out, IRin, PCOut);
		Register Y (Clock, Clear, Bus_Mux_Out, Yin, Y_contents);

												
	Bus myBusMux (.R0_out(R0out), .R1_out(R1out), .R2_out(R2out), .R3_out(R3out), .R4_out(R4out), .R5_out(R5out), 
	// .R6_out(R6in), .R7_out(R7in), .R8_out(R8in), .R9_out(R9in), .R10_out(R10in), .R11_out(R11in), .R12_out(R12in), .R13_out(R13in), .R14_out(R14in), .R15_out(R15in), 
	.HI_out(highout), .LO_out(lowout), .Z_high_out(Zhighout), .Z_low_out(Zlowout), .PC_out(PCOut), .MDR_out(MDRout), 
	// .In_Portout(), .C_out(), 
	.BusMuxIn_R0(BusMuxIn_R0), .BusMuxIn_R1(BusMuxIn_R1), .BusMuxIn_R2(BusMuxIn_R2), .BusMuxIn_R3(BusMuxIn_R3), .BusMuxIn_R4(BusMuxIn_R4), .BusMuxIn_R5(BusMuxIn_R5),
	//  .BusMuxIn_R6(R6out), .BusMuxIn_R7(R7out), .BusMuxIn_R8(R8out), .BusMuxIn_R9(R9out), .BusMuxIn_R10(R10out), .BusMuxIn_R11(R11out), .BusMuxIn_R12(R12out), .BusMuxIn_R13(R13out), .BusMuxIn_R14(R14out), .BusMuxIn_R15(R15out), 
	.BusMuxIn_HI(BusMuxIn_HI), .BusMuxIn_LO(BusMuxIn_LO), .BusMuxIn_Z_HI(BusMuxIn_Z_HI), .BusMuxIn_Z_LO(BusMuxIn_Z_LO), .BusMuxIn_PC(BusMuxIn_PC), .BusMuxIn_MDR(MDR_wire_out),
	//  .BusMuxIn_IN_PORT(), .C_Sign_Extended(), 
	 .BusMuxOut(Bus_Mux_Out));

	ALU myALU	(.A(Y_contents), .B(Bus_Mux_Out), .C(ZOut), .cntrl(CONTROL));
					
	MDR myMDR (.Read(Read), .clk(Clock), .MDRin(MDRin), .BusMuxOut(Bus_Mux_Out), .Mdatain(Mdatain),  .MDRout(MDR_wire_out));
				
endmodule 