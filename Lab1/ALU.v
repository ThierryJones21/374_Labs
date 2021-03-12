module ALU (input[31:0] A, B, output reg[31:0] C_LO, C_HI, input wire [3:0]cntrl);

	wire[63:0] div_quotient;
	
	wire [63:0] booth_result;
	
	div restoring_div(.quotient_and_remainder(div_quotient), .dividend(A), .divisor(B));

	mul booth (booth_result, A, B);

	always @(*) begin
    	case(cntrl)
			11	:	begin // division
						C_LO = div_quotient[31:0];	
						C_HI = div_quotient[63:32];
					end
			10  :   begin // multiplication
						C_LO = booth_result[31:0];
						C_HI = booth_result [63:32];
					end
			9   :   begin  // rotate right
						C_LO[31:0]= 1 >> B;
						C_LO[31] = B[0];
					end
			8   :   begin // rotate left
						C_LO[31:0]= 1 << B;
						C_LO[0] = B[31];
					end
			7   :   C_LO[31:0] = A >>> B; // right arithmetic shift - A = how many shifts, B = the number you want to shift 
			6   :   C_LO[31:0] = A <<< B; // left arithtmatic shift - A = how many shifts, B = the number you want to shift 
			5   :   C_LO[31:0] = !B; // logical not 
			4   :   C_LO[31:0] = -B; //negation function
			3   :   C_LO[31:0] = A - B;
			2   :   C_LO[31:0] = A + B;
			1   :   C_LO[31:0] = A | B;
			0   :   C_LO[31:0] = A & B;
			default	:	begin end
		endcase
	end
endmodule


