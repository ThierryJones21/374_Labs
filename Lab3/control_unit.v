module control_unit(

output reg Gra,Grb, Grc, Rin, Rout, BAout, Cout, Zloout, Zhighout// here, you will define the inputs and outputs to your Control Unit
Yin, Zin,PCout, IncPC, MARin,Read, Write, Clear, ADD, AND, SHR,

input[31:0] IR, 
input Clock, Reset, Stop, Con_FF);           

parameter Reset_state = 0, fetch0 = 1, fetch1 = 2, fetch2= 3, add3 = 4, add4= 5, add5= 6, ror6 = 7, ror7 = 8, ror8 = 9 ; //same as T

reg [3:0] Present_state= Reset_state; // adjust the bit pattern based on the number of states

always@(posedge Clock, posedge Reset)// finite state machine; if clock or reset rising-edge
	begin if(Reset == 1'b1)
		Present_state =  Reset_state;
		else case(Present_state)
			Reset_state			:				Present_state = fetch0;
			
			fetch0				:				Present_state = fetch1;
			
			fetch1				:				Present_state = fetch2;
			fetch2				:				begin
														case(IR[31:27])   //inst. decoding based on the opcode to set the next state
															5'b00000: Present_state = ld3;
															5'b00001: Present_state = ldi3;
															5'b00010: Present_state = st3;
															5'b00011: Present_state = add3;// this is the add instruction 
															5'b00100: Presentstate = sub3;
															5'b00101: Present_state = shr3;
															5'b00110: Present_state = shl3;
															5'b00111: Present_state = ror3;
															5'b01000: Present_state = ro13;
															5'b01001: Present_state = and3;
															5'b01010: Present_state = or3;
															5'b01011: Present_state = addi3;
															5'b01100: Present_state = andi3;
															5'b01101: Present_state = ori3;
															5'b01110: Present_state = mul3;
															5'b01111: Present_state = div3;
															5'b10000: Present_state = neg3;
															5'b10001: Present_state = not3;
															5'b10010: Present_state = br_all3;
															5'b10011: Present_state = jr3;
															5'b10100: Present_state = jal3;
															5'b10101; Present_state = in3;
															5'b10110: Present_state = out3;
															5'b10111: Present_state = mfhi3;
															5'b11000: Present_state = mflo3;
															5'b11001: Present_state = nop3;
															5'b11010: Present_state = halt3;
														endcase
													end
			add3					:				Present_state = add4;
			add4					:				Present_state = add5;
			add5					: 				Present_state = fetch0;
			
			sub3					:				Present_state = sub4;
			sub4					:				Present_state = sub5;
			sub5					: 				Present_state = fetch0;
			
			shr3					:				Present_state = shr4;
			shr4					:				Present_state = shr5;
			shr5					: 				Present_state = fetch0;
			
			shl3					:				Present_state = shl4;
			shl4					:				Present_state = shl5;
			shl5					: 				Present_state = fetch0;
			
			ror3					:				Present_state = ror4;
			ror4					:				Present_state = ror5;
			ror5					: 				Present_state = fetch0;
			
			rol3					:				Present_state = rol4;
			rol4					:				Present_state = rol5;
			rol5					: 				Present_state = fetch0;
			
			and3					:				Present_state = and4;
			and4					:				Present_state = and5;
			and5					: 				Present_state = fetch0;
			
			or3					:				Present_state = or4;
			or4					:				Present_state = or5;
			or5					: 				Present_state = fetch0;
			
			addi3					:				Present_state = addi4;
			addi4					:				Present_state = addi5;
			addi5					: 				Present_state = fetch0;
			
			andi3					:				Present_state = andi4;
			andi4					:				Present_state = andi5;
			andi5					: 				Present_state = fetch0;
			
			ori3					:				Present_state = ori4;
			ori4					:				Present_state = ori5;
			ori5					: 				Present_state = fetch0;
			
			mul3					:				Present_state = mul4;
			mul4					:				Present_state = mul5;
			mul5					: 				Present_state = fetch0;
			
			div3					:				Present_state = div4;
			div4					:				Present_state = div5;
			div5					: 				Present_state = fetch0;
			
			neg3					:				Present_state = neg4;
			neg4					:				Present_state = neg5;
			neg5					: 				Present_state = fetch0;
			
			not3					:				Present_state = not4;
			not4					:				Present_state = not5;
			not5					: 				Present_state = fetch0;
			
			br_all3					:				Present_state = br_all4;
			br_all4					:				Present_state = br_all5;
			br_all5					: 				Present_state = fetch0;
			
			jr3					:				Present_state = jr4;
			jr4					:				Present_state = jr5;
			jr5					: 				Present_state = fetch0;
			
			jal3					:				Present_state = jal4;
			jal4					:				Present_state = jal5;
			jal5					: 				Present_state = fetch0;
			
			rol3					:				Present_state = rol4;
			rol4					:				Present_state = rol5;
			rol5					: 				Present_state = fetch0;
		endcase
	end
	
always@(Present_state)// do the job for each state
	begin case(Present_state)              // assert the required signals in each state
			Reset_state			:				begin Gra <= 0;   
														   Grb <= 0;  	 
															Grc <= 0; 
															Yin <= 0; //initialize the signals
													end
													
			fetch0				:				begin PCout<= 1; // see if you need to de-assert these signals 
															MARin <= 1;  
															IncPC <= 1; 
															Zin <= 0;
													end 
													
			add3					: 				begin Grb <= 1; 
															Grb <= 0;
															Rout<= 1;  
															Yin <= 0; 
													end
			add4						:				
				
			
		endcase end
		
endmodule 