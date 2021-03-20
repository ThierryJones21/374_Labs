module brmi_TB ();//uses ConFF to determine what branch instruction to use op code is different however
  // opcode for brmi PC <- PC + 1 + C (10010xxxx-10xxxxxxxxxxxx10)//  
  
always @(Present_state)// do the required job ineach state
begin
    case (Present_state) //assert the required signals in each clock cycle
        Default: begin //initialize the signals
            PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout<= 0;  //initialize the signals
            MARin <= 0; Zlowin <= 0; Zhighin <= 0;
            PCin <= 0; MDRin <= 0; IRin  <= 0; Yin <= 0;
            IncPC <= 0; Read <= 0; 
            Mdatain <= 32'h00000000; Rout <= 0; 
            Gra <= 0; ADD <= 0; con_in <= 0;
        end    
        T0: begin 
            #10 PCout <= 1; MARin <= 1; IncPC <= 1; Zin<= 1;  //initialize the signals         
            #15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin<= 0;
        end
        T1: begin
            #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h91401180; // opcode for brmi R2, 35 (10010 0010 1000 0000 0010 0011 0000 000)//  
            #15 Zlowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;
        end
        T2: begin
            #10 MDRout<= 1; IRin <= 1; 
            #15 MDRout<= 0; IRin <= 0; 
        end
        T3: begin
            #10 Gra <= 1; Rout <= 1; con_in <= 1;  
            #15 Gra <= 0; Rout <= 0; con_in <= 0; 
        end
        T4: begin
            #10 PCout<= 1; Yin <= 1; 
            #10 PCout<= 0; Yin <= 0; 
        end
        T5: begin
            #10 Cout<= 1; ADD <= 1; Zlowin <= 1; 
            #15 Cout<= 0; ADD <= 0; Zlowin <= 0; 
        end
        T6: begin
            #10 Zlowout <= 1; con_in <= PCin; //Reading from PCin
            #15 Read <= 0; MDRin <= 0; 
        end
    endcase
end

endmodule 
