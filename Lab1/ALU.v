module ALU (input [31:0] A, B, output reg [63:0]C, input wire [3:0]cntrl);

	wire[63:0] div_quotient;

function [63:0] booth;

    input[31:0] X, Y;      
    
    reg [1:0] temp;
    
    integer i;
    
    reg E1;
    
    reg [31:0] Y1;

	begin
		booth = 64'd0;
		E1 = 1'd0;
	for (i = 0; i < 32; i = i + 1)
		begin
			temp = {X[i], E1};  // concatenation

			Y1 = -Y; // 2's complement
		
			case (temp)
				2'd2 : booth [63 : 31] = booth [63 : 31] + Y1;
				2'd1 : booth [63 : 31] = booth [63 : 31] + Y;
				default : begin end
			endcase
			
			booth = booth >> 1; // logical shift right
		
			booth[31] = booth[30]; //Arithmetic shift
		
			E1 = X[i];
		end
		
		if (Y == 16'd32)
		begin
			booth = - booth;
		end

	end  
    
endfunction


 //division algorthim module instance
 div myDivalgo (div_quotient, A, B);

always @(A, B ,cntrl) begin
    case(cntrl)
			11  :   C = div_quotient;
				//div myDivalgo (C, A, B);  //TO-DO: Make cool division algo
			10  :   C = booth(A,B);
			9   :   begin   // rotate right
                    C[31:0]= 1 >> B;
                    C[31] = B[0];
                end
			8   :   begin           // rotate left
                    C[31:0]= 1 << B;
                    C[0] = B[31];
						end  
			7   :   C[31:0] = A >>> B;// right arithmetic shift - A = how many shifts, B = the number you want to shift 
			6   :   C[31:0] = A <<< B; // left arithtmatic shift - A = how many shifts, B = the number you want to shift 
			5   :   C[31:0] = !B; // logical not 
			4   :   C[31:0] = -B; //negation function
			3   :   C[31:0] = A - B;
			2   :   C[31:0] = A + B;
			1   :   C[31:0] = A | B;
         0   :   C[31:0] = A & B; //ToDO: add upper half assignments
	endcase
end

endmodule


