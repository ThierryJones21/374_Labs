module div(quotient_and_remainder, dividend, divisor);
	input [31:0] dividend, divisor;
   output reg [63:0] quotient_and_remainder;

    reg [5:0] i; // iterator for the for loop
    reg [64:0] A; // signextended, quotient and remainder - renamed so type less
    reg [32:0] M; // signextended dividend

    always @(dividend or divisor) begin
        A[31:0] = divisor; // lowest 32 = divisor
        A[64:32] = 0;
        M[31:0] = dividend;

        // Loop 32 time because dividend is 32 bits
        for(i=0; i<32; i=i+1) begin
            M[32] = M[31]; // sign extend dividend
            A = A << 1; // shift a by 1
            A[64:32] = A[64:32] - dividend; // subtract m - the sign extended dividend
            //If A is negative, restore and set A[0] to 0 note that this will be shifted in the next iteration
            if (A[63] == 1) begin 
                A[0] = 0;
                A[64:32] = A[64:32] + M; // restore
            //If A is positive, DO NOT restore and set A[0] to 1 note that this will be shifted in the next iteration
            end else if (A[63] == 0) begin
                A[0] = 1;
            end
        end  
		 quotient_and_remainder <= A; // at the very end, assign the output 
    end
	 

endmodule 