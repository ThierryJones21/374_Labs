module booth_op(output [63:0] booth, input[31:0] x, y);      
	integer i;
	reg [63:0] P, y_temp, y_temp_neg;  
	reg rightBit;
	
	
	always @(x,y) begin
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
	assign booth = P;
endmodule 