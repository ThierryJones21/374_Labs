module ALU ([31:0]A, [31:0]B, [31:0]C, [3:0]cntrl):

input [31:0]A, [31:0]B , [3:0]cntrl;

output [63:0] C;


function [63:0] booth

    input[31:0] X, [31:0] Y;
 
    input en;      
    
    reg [1:0] temp;
    
    integer i;
    
    reg E1;
    
    reg [31:0] Y1;

    //beginning of algorithm
    always @ (X, Y,en)
        begin
            booth = 64'd0;
            E1 = 1'd0;
        for (i = 0; i < 32; i = i + 1)
                begin
                temp = {X[i], E1};  // concatenation
     
     
       Y1 = -Y;
     
        //Y1 is the 2’ complement of Y
     
       case (temp)
           2'd2 : booth [63 : 31] = booth [63 : 31] + Y1;
           2'd1 : booth [63 : 31] = booth [63 : 31] + Y;
           default : begin end
       endcase
       
       booth = booth >> 1;
       /*The above statement is a logical shift of one position to
           the right*/
     
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
         
    
endfunction


// function [31:0] divInt
//         input[31:0] X, [31:0] Y;


//     ;
    
//endfunction


always @(A, B ,cntrl) begin
    case(cntrl)
        0   :   and(C,A,B);
        1   :   or(C,A,B);
        2   :   C = A + B;
        3   :   C = A - B;
        4   :   C = -B; //negation function
        5   :   C = !B; // logical not 
        6   :   C = <<< B; /// left arithtmatic shift
        7   :   C = >>> B; // right arithmetic shift
        8   :   begin           // rotate left
                    C = << B;
                    C[0] = B[31];
                end  
        9   :   begin   // rotate right
                    C = >> B;
                    C[31] = B[0];
                end
        10  :   C = booth(A,B);
        11  :   C = A/B;  //TO-DO

end




