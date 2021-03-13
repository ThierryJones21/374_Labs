always @(Present_state)// do the required job ineach state
	begin
        case (Present_state) //assert the required signals in each clock cycle
            Default: begin //initialize the signals
                PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout<= 0;  //initialize the signals
                R2out <= 0; R4out <= 0; MARin <= 0; Zlowin <= 0; Zhighin <= 0;
                PCin <= 0; MDRin <= 0; IRin  <= 0; Yin <= 0;
                IncPC <= 0; Read <= 0; CONTROL <= 0;
                Clear <= 1; Yout <= 0; highin <= 0; lowin <= 0;
                R5in <= 0; R2in <= 0; R4in <= 0; Mdatain <= 32'h00000000;
            end
            Reg_load1a: begin 
                Mdatain<= 32'h00000004; // loads hex 4 into MDR
                Read = 0; MDRin = 0; //the first zero is there for completeness
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRin <= 0;
            end
            Reg_load1b: begin
                #10 MDRout<= 1; R2in <= 1; // copies from MDR into R2
                #15 MDRout<= 0; R2in <= 0; // initialize R2 with the value $22
            end
            Reg_load2a: begin 
                Mdatain <= 32'h00000009; // loads hex 9 into MDR
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRin <= 0;
            end
            Reg_load2b: begin
                #10 MDRout<= 1; R4in <= 1; // copies from MDR into R4
                #15 MDRout<= 0; R4in <= 0; // initialize R4 with the value $24 
            end
            Reg_load3a: begin 
                Mdatain <= 32'h00000026; // loads hex 26 into MDR
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRin <= 0;
            end
            Reg_load3b: begin
                #10 MDRout<= 1; R5in <= 1; // copies from MDR into R5 - so that we know it overwrites!
                #15 MDRout<= 0; R5in <= 0; // initialize R5 with the value $26 
            end
            
           T0: begin//see if you need to de-assertthese signals
					 #10 PCout<= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
					 #15 PCout<= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
				end
				T1: begin
					 #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h42920000; //opcode for ROL R5, R2, R4 --> 0100 0010 1001 0010 0000
					 #15 Zlowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;
				end
				T2: begin
					 #10 MDRout <= 1; IRin <= 1;
					 #15 MDRout <= 0; IRin <= 0;
				end
				T3: begin
					 #10 R2out <= 1; Yin <= 1;
					 #15 R2out <= 0; Yin <= 0;
				end
				T4: begin
					 // Rotate left
					 #10 CONTROL <= 8; Zlowin <= 1;
					 #15 Zlowin <= 0;
				end
				T5: begin
					 #10 Zlowout<= 1; R5in <= 1;
					 #15 Zlowout<= 0; R5in <= 0;
				end