module mux21( D0, D1, S, Y); // D0, D1 are the inputs, S is the read, Y is the output
    input wire D0, D1, S;
    output reg Y;

    always @(D0 or D1 or S)
    begin

        if(S) 
        Y= D1;
        else
        Y=D0;

    end

endmodule