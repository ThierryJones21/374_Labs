module div(output reg [63:0] quotient_and_remainder, input [31:0] divisor, dividend);

reg [5:0] i; // for loop iterator
reg [64:0] A; // just so that we have a shorter name to work with
reg [32:0] M; // signextended divisor

always @(divisor or dividend) begin
	
	A[31:0] = dividend; // lowest 32 = divident
	A[64:32] = 0; // highest 32 = 0
	M[31:0] = divisor;

	//Loop through for the entire length of the dividend
	for (i = 0; i < 32; i = i + 1) begin
		// Sign extend divisor
		M[32] = M[31];
		// Shift A
		A = A << 1;
		// Subtract divisor -- should this be the signextended one (M)
		A[64:32] = A[64:32] - divisor;
		// If A is negative (sign bit == 1) restore
		if (A[63] == 1) begin 
			A[0] = 0; // set positive
			A[64:32] = A[64:32] + M; // restoring
		// If A is positive (sign bit == 1) no restoring
		end else if (A[63] == 0) begin
			A[0] = 1; // set negative
		end
	end
	quotient_and_remainder <= A; // at the very end, assign the output

end

 
endmodule 