module TB_div ();

    reg [31:0] dividend, divisor;
    reg [63:0] quotient_and_remainder;

    DIV restoring_div(dividend, divisor, quotient_and_remainder);

    initial begin
        // no remainder
        dividend = 16;
        divisor = 160;
        // remainder
        // dividend = 16;
        // divisor = 161;
    end
    
    always @(quotient_and_remainder) begin
        $display("divisor: %d", dividend);
        $display("dividend: %d", divisor);
        $display("quotient: %d", quotient_and_remainder[31:0]);
        $display("remainder %d", quotient_and_remainder[63:32]);
    end
  
endmodule 