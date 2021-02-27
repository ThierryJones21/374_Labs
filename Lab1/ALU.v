module ALU (input [31:0] A, B, output reg [31:0]Zlow, ZHi, input wire [3:0]cntrl);

	wire [31:0] mul_lowOut, mul_hiOut, div_lowOut, div_hiOut;
	mul mymul(mul_lowOut, mul_hiOut, A, B);
	div mydiv(div_lowOut, div_hiOut, A, B);

	always @(A, B ,cntrl) begin
		case(cntrl)
				11  :   begin
							ZLow = div_lowOut;
							ZHi = div_highOut;
						end
				10  :   begin
							ZLow = mul_lowOut;
							ZHi = mul_highOut;
						end
				9   :   begin   // rotate right
						Zlow= 1 >> B;
						Zlow[31] = B[0];
					end
				8   :   begin           // rotate left
						Zlow= 1 << B;
						Zlow[0] = B[31];
							end  
				7   :   Zlow= A >>> B; // right arithmetic shift - A = how many shifts, B = the number you want to shift 
				6   :   Zlow = A <<< B; // left arithtmatic shift - A = how many shifts, B = the number you want to shift 
				5   :   Zlow = !B; // logical not 
				4   :   Zlow = -B; //negation function
				3   :   Zlow = A - B;
				2   :   Zlow = A + B;
				1   :   Zlow = A | B;
			0   :   Zlow = A & B;
		endcase
	end

endmodule


