module datapath(PCout, MDRout, MARin, Zhighout, Zlowout, Zhighin, Zlowin, highin, lowin, PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, Clock, Mdatain, Clear, BAout, Rin, Rout, Gra, Grb, Grc, con_in, COut, outPortIn, inPortOut);

	input PCout, MDRout, MARin, Zhighout, Zlowout, Zhighin, Zlowin, highin, lowin, PCin, MDRin, IRin, Yin, IncPC, Read, Clock, Clear, Rin, Rout, Gra, Grb, Grc, con_in, COut, outPortIn, inPortOut;
	input [31:0] Mdatain;
	input BAout; 
		
	input[3:0] CONTROL;	
	wire [31:0] Bus_Mux_Out; // output of bus
	wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_Z_HI, BusMuxIn_Z_LO, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_PC, BusMuxIn_IR, BusMuxIn_IN_PORT; // register "storage"
					
	wire [31:0] ZOut_HI; // ALU output
	wire [31:0] ZOut_LO;
	
	wire [31:0] MDR_wire_out;
	wire [31:0] Y_contents;
	
	wire [31:0] CSignExtended;
	
	wire highout, lowout, PCOut, toControlUnit;
	
	wire [15:0] RXin, RXout;
	
	wire [31:0] to_output_unit, from_input_unit;

	// What is the Memory Initialization file (MIF) (Section 2.1 - the RAM unit I think)
	// used to load values inside RAM
	// @NAOD look here https://onq.queensu.ca/d2l/le/content/505088/viewContent/3034601/View
	
	// NOTE toControlUnit is it just a wire to be used later -> CPU made in phase 3
	
	// 15 Registers
	register_zero R0 (Clock, Clear, BAout, Bus_Mux_Out, RXin[0], BusMuxIn_R0); 
	Register #(1) R1 (Clock, Clear, Bus_Mux_Out, RXin[1], BusMuxIn_R1); // preloads 1 into R1
	Register R2 (Clock, Clear, Bus_Mux_Out, RXin[2], BusMuxIn_R2); 
	Register R3 (Clock, Clear, Bus_Mux_Out, RXin[3], BusMuxIn_R3); 
	Register R4 (Clock, Clear, Bus_Mux_Out, RXin[4], BusMuxIn_R4); 
	Register R5 (Clock, Clear, Bus_Mux_Out, RXin[5], BusMuxIn_R5); 
	Register R6 (Clock, Clear, Bus_Mux_Out, RXin[6], BusMuxIn_R6); 
	Register R7 (Clock, Clear, Bus_Mux_Out, RXin[7], BusMuxIn_R7); 
	Register R8 (Clock, Clear, Bus_Mux_Out, RXin[8], BusMuxIn_R8); 
	Register R9 (Clock, Clear, Bus_Mux_Out, RXin[9], BusMuxIn_R9); 
	Register R10 (Clock, Clear, Bus_Mux_Out, RXin[10], BusMuxIn_R10); 
	Register R11 (Clock, Clear, Bus_Mux_Out, RXin[11], BusMuxIn_R11);  
	Register R12 (Clock, Clear, Bus_Mux_Out, RXin[12], BusMuxIn_R12); 
	Register R13 (Clock, Clear, Bus_Mux_Out, RXin[13], BusMuxIn_R13); 
	Register R14 (Clock, Clear, Bus_Mux_Out, RXin[14], BusMuxIn_R14); 
	Register R15 (Clock, Clear, Bus_Mux_Out, RXin[15], BusMuxIn_R15);
	
	/* For multiplication/division */
	
	Register HI (Clock, Clear, Bus_Mux_Out, highin, BusMuxIn_HI);
	Register LO (Clock, Clear, Bus_Mux_Out, lowin, BusMuxIn_LO);
	
	Register Z_HI (Clock, Clear, ZOut_HI, Zhighin, BusMuxIn_Z_HI);
	Register Z_LO (Clock, Clear, ZOut_LO, Zlowin, BusMuxIn_Z_LO);

	/* PC IR IN_PORT Y */
	Register PC (Clock, Clear, Bus_Mux_Out, PCin, BusMuxIn_PC);
	Register IR (Clock, Clear, Bus_Mux_Out, IRin, BusMuxIn_IR);
	Register IN_PORT (Clock, Clear, Bus_Mux_Out, IRin, PCOut);
	Register Y (Clock, Clear, Bus_Mux_Out, Yin, Y_contents);
												
	Bus bus (.R0_out(RXout[0]), .R1_out(RXout[1]), .R2_out(RXout[2]), .R3_out(RXout[3]), .R4_out(RXout[4]), .R5_out(RXout[5]), .R6_out(RXout[6]), .R7_out(RXout[7]), .R8_out(RXout[8]), .R9_out(RXout[9]), .R10_out(RXout[10]), .R11_out(RXout[11]), .R12_out(RXout[12]), .R13_out(RXout[13]), .R14_out(RXout[14]), .R15_out(RXout[15]), .HI_out(highout), .LO_out(lowout), .Z_high_out(Zhighout), .Z_low_out(Zlowout), .PC_out(PCOut), .MDR_out(MDRout), .In_Portout(inPortOut), .C_out(COut), .BusMuxIn_R0(BusMuxIn_R0), .BusMuxIn_R1(BusMuxIn_R1), .BusMuxIn_R2(BusMuxIn_R2), .BusMuxIn_R3(BusMuxIn_R3), .BusMuxIn_R4(BusMuxIn_R4), .BusMuxIn_R5(BusMuxIn_R5), .BusMuxIn_R6(BusMuxIn_R6), .BusMuxIn_R7(BusMuxIn_R7), .BusMuxIn_R8(BusMuxIn_R8), .BusMuxIn_R9(BusMuxIn_R9), .BusMuxIn_R10(BusMuxIn_R10), .BusMuxIn_R11(BusMuxIn_R11), .BusMuxIn_R12(BusMuxIn_R12), .BusMuxIn_R13(BusMuxIn_R13), .BusMuxIn_R14(BusMuxIn_R14), .BusMuxIn_R15(BusMuxIn_R15), .BusMuxIn_HI(BusMuxIn_HI), .BusMuxIn_LO(BusMuxIn_LO), .BusMuxIn_Z_HI(BusMuxIn_Z_HI), .BusMuxIn_Z_LO(BusMuxIn_Z_LO), .BusMuxIn_PC(BusMuxIn_PC), .BusMuxIn_MDR(MDR_wire_out), .BusMuxIn_IN_PORT(BusMuxIn_IN_PORT), .C_Sign_Extended(CSignExtended), .BusMuxOut(Bus_Mux_Out));

	ALU alu	(.A(Y_contents), .B(Bus_Mux_Out), .C_LO(ZOut_LO), .C_HI(ZOut_HI), .cntrl(CONTROL));
					
	MDR mdr (.Read(Read), .clk(Clock), .MDRin(MDRin), .BusMuxOut(Bus_Mux_Out), .Mdatain(Mdatain),  .MDRout(MDR_wire_out));

	select_and_encode IR_select(Gra, Grb, Grc, Rin, Rout, BAout, BusMuxIn_IR, RXin, RXout, CSignExtended);
	
	// unsure what toControlUnit actually does at this point - do we just need to graph it
	con_ff con_logic(con_in, BusMuxIn_IR[22:19], Bus_Mux_Out, toControlUnit);
	
	outputPort outPort(Bus_Mux_Out, Clear, Clock, outPortIn, to_output_unit);
	
	inputPort inPort(from_input_unit, Clear, Clock, BusMuxIn_IN_PORT);
endmodule 