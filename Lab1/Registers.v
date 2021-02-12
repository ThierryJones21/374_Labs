//passsing dataIN and dataOUT
module Registers(R0_in, R1_in, R2_in, R3_in, R4_in, R5_in, R6_in, R7_in, R8_in, R9_in, 
R10_in, R11_in, R12_in, R13_in, R14_in, R15_in, clk, clr, BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6,
BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, 
BusMuxIn_R15, BusMuxOut);


input [31:0] R0_in, R1_in, R2_in, R3_in, R4_in, R5_in, R6_in, R7_in, R8_in, R9_in, 
R10_in, R11_in, R12_in, R13_in, R14_in, R15_in, BusMuxOut;
input clk, clr;
output reg[31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6,
BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, 
BusMuxIn_R15;

//designing the registers
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R0 <= 0;
		else if(R0_in) BusMuxIn_R0 <= BusMuxOut;
end		

always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R1 <= 0;
		else if(R1_in) BusMuxIn_R1 <= BusMuxOut;
end		

always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R2 <= 0;
		else if(R2_in) BusMuxIn_R2 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R3 <= 0;
		else if(R3_in) BusMuxIn_R3 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R4 <= 0;
		else if(R4_in) BusMuxIn_R4 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R5 <= 0;
		else if(R5_in) BusMuxIn_R5 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R6 <= 0;
		else if(R6_in) BusMuxIn_R6 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R7 <= 0;
		else if(R7_in) BusMuxIn_R7 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R8 <= 0;
		else if(R8_in) BusMuxIn_R8 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R9 <= 0;
		else if(R9_in) BusMuxIn_R9 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R10 <= 0;
		else if(R10_in) BusMuxIn_R10 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R11 <= 0;
		else if(R11_in) BusMuxIn_R11 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R12 <= 0;
		else if(R12_in) BusMuxIn_R12 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R13 <= 0;
		else if(R13_in) BusMuxIn_R13 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R14 <= 0;
		else if(R14_in) BusMuxIn_R14 <= BusMuxOut;
end		
always@(posedge clk or negedge clr)
begin
		if(clr == 0) BusMuxIn_R15 <= 0;
		else if(R15_in) BusMuxIn_R15 <= BusMuxOut;
end	

		
endmodule
