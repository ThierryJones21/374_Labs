module div(output [63:0] Zlow, Zhigh, input [31:0] x, y);

reg [5:0] i;
reg [64:0] A;
reg [32:0] M;

always @(x or y) begin
	//Initialize the lowest 32 bits of a to be the dividend of the division and the upper 32 bits to be 0
	A[31:0] = y;
	A[64:32] = 0;
	M[31:0] = x;

	//Loop through for the entire length of the dividend
	for(i=0; i<32; i=i+1) begin
		//Sign extend the divisor by one bit to perform add/subtract with upper 33 bits of A
		M[32] = M[31];
		//Shift A and Q (Q wraps into least significant bit of A)
		A = A << 1;
		//Subtract M
		A[64:32] = A[64:32] - x;
		//If A is negative (1 in most significant bit) restore A[63:32] (add M back to it)
		if (A[63] == 1) begin 
			A[0] = 0;
			A[64:32] = A[64:32] + M;
		//If A is positive (0 in the most significant bit) don't restore A
		end else if (A[63] == 0) begin
			A[0] = 1;
		end
	end
end

//Append the least significant 32 bits of A (the quotient) to Zlow for output and the most significant 32 bits of A (the remainder) to Zhigh for output
assign Zlow = A[31:0];
assign Zhigh = A[63:32];

endmodule