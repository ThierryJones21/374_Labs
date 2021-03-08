module ALU (input [31:0] A, B, output reg [63:0]C, input wire [3:0]cntrl);

reg[63:0] div_quotient;

function [63:0] booth;

    input[31:0] x, y;      
   
    
    integer i;
	
	reg [63:0] P, y_temp, y_temp_neg; 
    
    reg rightBit;
   
    	P = 64'd0;
    	y_temp = 64'd0 + y;
    	y_temp_neg = 64'd0 - y;
    	rightBit = 0;
     
    	for(i=0;i<32;i =i+1) begin
    		// 00 or 11
    		if(x[i] != rightBit) begin
    			if(rightBit == 1) begin //01
    				P = P + (y_temp << i);
    			end else begin
    				P = P + (y_temp_neg << i);
    			end
    			if(x[i] == 1) begin
    				rightBit = 1;
    			end else begin
    				rightBit = 0;
    			end
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


