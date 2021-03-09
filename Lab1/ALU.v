module ALU (input[31:0] A, B, output reg[31:0] C_LO, C_HI, input wire [3:0]cntrl);

	wire[63:0] div_quotient;
	
	reg [63:0] booth_result;

	//reg[63:0] C_temp;

function [63:0] booth;

   input[31:0] x, y;      
     
   integer i;
	
	reg [63:0] P, y_temp, y_temp_neg; 
    
   reg rightBit;
   begin
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
	end
endfunction

div my_divalgo(.quotient_and_remainder(div_quotient), .dividend(A), .divisor(B));

 //division algorthim module instance
	//assign div_temp = div myDivalgo (div_quotient, A, B);

always @(A, B ,cntrl) begin
    case(cntrl)
			11  :   begin  C_LO = div_quotient[31:0];	
								C_HI = div_quotient[63:32];
								end
				//div myDivalgo (C, A, B);  //TO-DO: Make cool division algo
			10  :   begin 
						booth_result = booth (A,B);
						C_LO = booth_result[31:0];
						C_HI = booth_result [63:32];
						end
			9   :   begin   // rotate right
                    C_LO[31:0]= 1 >> B;
                    C_LO[31] = B[0];
                end
			8   :   begin           // rotate left
                    C_LO[31:0]= 1 << B;
                    C_LO[0] = B[31];
						end  
			7   :   C_LO[31:0] = A >>> B;// right arithmetic shift - A = how many shifts, B = the number you want to shift 
			6   :   C_LO[31:0] = A <<< B; // left arithtmatic shift - A = how many shifts, B = the number you want to shift 
			5   :   C_LO[31:0] = !B; // logical not 
			4   :   C_LO[31:0] = -B; //negation function
			3   :   C_LO[31:0] = A - B;
			2   :   C_LO[31:0] = A + B;
			1   :   C_LO[31:0] = A | B;
         0   :   C_LO[31:0] = A & B; //ToDO: add upper half assignments
	endcase
end
endmodule


