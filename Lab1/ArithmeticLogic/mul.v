module mul (output [63:0] booth, input[31:0] X, Y);
    
    reg [1:0] temp;
    
    integer i;
    
    reg E1;
    
    reg [31:0] Y1;

    //beginning of algorithm
    always @ (X, Y)
        begin
            booth = 64'd0;
            E1 = 1'd0;
        for (i = 0; i < 32; i = i + 1) begin
            temp = {X[i], E1};  // concatenation
            
    
            Y1 = -Y;
        
            //Y1 is the 2's complement of Y
        
            case (temp)
                2'd2 : booth [63 : 31] = booth [63 : 31] + Y1;
                2'd1 : booth [63 : 31] = booth [63 : 31] + Y;
                default : begin end
            endcase
            
            booth = booth >> 1; /*logical shift right */
        
            booth[31] = booth[30];
            /*The above two statements perform arithmetic shift where
            the sign of the number is preserved after the shift. */
        
            E1 = X[i];
        end
            
            if (Y == 16'd32)
                /*If Y = 1000; then according to our code,
                Y1 = 1000 (-8 not 8, because Y1 is 4 bits only).
                The statement sum = - sum adjusts the answer.*/
            begin
                booth = - booth;
            end

        end  
    end
endmodule