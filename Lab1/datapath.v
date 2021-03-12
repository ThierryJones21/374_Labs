module datapath(PCout, MDRout, MARin, Zhighout, Zlowout, Zhighin, Zlowin, highin, lowin, PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, Clock, Mdatain, Clear, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in);

	input PCout, MDRout, MARin, Zhighout, Zlowout, Zhighin, Zlowin, highin, lowin, PCin, MDRin, IRin, Yin, IncPC, Read, Clock, Clear;
	input [31:0] Mdatain;
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
	input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
		
	input[3:0] CONTROL;	
	wire [31:0] Bus_Mux_Out; // output of bus
	wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_Z_HI, BusMuxIn_Z_LO, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_PC; // register "storage"
					
	wire [31:0] ZOut_HI; // ALU output
	wire [31:0] ZOut_LO;
	
	wire [31:0] MDR_wire_out;
	wire [31:0] Y_contents;
	
	wire highout, lowout, IROut, PCOut;
	
	// 15 Registers
	Register R0 (Clock, Clear, Bus_Mux_Out, R0in, BusMuxIn_R0); 
	Register R1 (Clock, Clear, Bus_Mux_Out, R1in, BusMuxIn_R1); 
	Register R2 (Clock, Clear, Bus_Mux_Out, R2in, BusMuxIn_R2); 
	Register R3 (Clock, Clear, Bus_Mux_Out, R3in, BusMuxIn_R3); 
	Register R4 (Clock, Clear, Bus_Mux_Out, R4in, BusMuxIn_R4); 
	Register R5 (Clock, Clear, Bus_Mux_Out, R5in, BusMuxIn_R5); 
	Register R6 (Clock, Clear, Bus_Mux_Out, R6in, BusMuxIn_R6); 
	Register R7 (Clock, Clear, Bus_Mux_Out, R7in, BusMuxIn_R7); 
	Register R8 (Clock, Clear, Bus_Mux_Out, R8in, BusMuxIn_R8); 
	Register R9 (Clock, Clear, Bus_Mux_Out, R9in, BusMuxIn_R9); 
	Register R10 (Clock, Clear, Bus_Mux_Out, R10in, BusMuxIn_R10); 
	Register R11 (Clock, Clear, Bus_Mux_Out, R11in, BusMuxIn_R11);  
	Register R12 (Clock, Clear, Bus_Mux_Out, R12in, BusMuxIn_R12); 
	Register R13 (Clock, Clear, Bus_Mux_Out, R13in, BusMuxIn_R13); 
	Register R14 (Clock, Clear, Bus_Mux_Out, R14in, BusMuxIn_R14); 
	Register R15 (Clock, Clear, Bus_Mux_Out, R15in, BusMuxIn_R15);
	
	/* For multiplication/division */
	
	Register HI (Clock, Clear, Bus_Mux_Out, highin, BusMuxIn_HI);
	Register LO (Clock, Clear, Bus_Mux_Out, lowin, BusMuxIn_LO);
	
	Register Z_HI (Clock, Clear, ZOut_HI, Zhighin, BusMuxIn_Z_HI);
	Register Z_LO (Clock, Clear, ZOut_LO, Zlowin, BusMuxIn_Z_LO);

	/* PC IR IN_PORT Y */
	Register PC (Clock, Clear, Bus_Mux_Out, PCin, BusMuxIn_PC);
	Register IR (Clock, Clear, Bus_Mux_Out, IRin, IROut);
	Register IN_PORT (Clock, Clear, Bus_Mux_Out, IRin, PCOut);
	Register Y (Clock, Clear, Bus_Mux_Out, Yin, Y_contents);

												
	Bus bus (.R0_out(R0out), .R1_out(R1out), .R2_out(R2out), .R3_out(R3out), .R4_out(R4out), .R5_out(R5out), .R6_out(R6out), .R7_out(R7out), .R8_out(R8out), .R9_out(R9out), .R10_out(R10out), .R11_out(R11out), .R12_out(R12out), .R13_out(R13out), .R14_out(R14out), .R15_out(R15out), 
	.HI_out(highout), .LO_out(lowout), .Z_high_out(Zhighout), .Z_low_out(Zlowout), .PC_out(PCOut), .MDR_out(MDRout), 
	// .In_Portout(), .C_out(), 
	.BusMuxIn_R0(BusMuxIn_R0), .BusMuxIn_R1(BusMuxIn_R1), .BusMuxIn_R2(BusMuxIn_R2), .BusMuxIn_R3(BusMuxIn_R3), .BusMuxIn_R4(BusMuxIn_R4), .BusMuxIn_R5(BusMuxIn_R5), .BusMuxIn_R6(BusMuxIn_R6), .BusMuxIn_R7(BusMuxIn_R7), .BusMuxIn_R8(BusMuxIn_R8), .BusMuxIn_R9(BusMuxIn_R9), .BusMuxIn_R10(BusMuxIn_R10), .BusMuxIn_R11(BusMuxIn_R11), .BusMuxIn_R12(BusMuxIn_R12), .BusMuxIn_R13(BusMuxIn_R13), .BusMuxIn_R14(BusMuxIn_R14), .BusMuxIn_R15(BusMuxIn_R15), .BusMuxIn_HI(BusMuxIn_HI), .BusMuxIn_LO(BusMuxIn_LO), .BusMuxIn_Z_HI(BusMuxIn_Z_HI), .BusMuxIn_Z_LO(BusMuxIn_Z_LO), .BusMuxIn_PC(BusMuxIn_PC), .BusMuxIn_MDR(MDR_wire_out),
	//  .BusMuxIn_IN_PORT(), .C_Sign_Extended(), 
	 .BusMuxOut(Bus_Mux_Out));

	ALU alu	(.A(Y_contents), .B(Bus_Mux_Out), .C_LO(ZOut_LO), .C_HI(ZOut_HI), .cntrl(CONTROL));
					
	MDR mdr (.Read(Read), .clk(Clock), .MDRin(MDRin), .BusMuxOut(Bus_Mux_Out), .Mdatain(Mdatain),  .MDRout(MDR_wire_out));
			
endmodule 