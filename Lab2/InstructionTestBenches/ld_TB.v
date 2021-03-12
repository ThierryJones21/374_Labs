module ld_TB ();
  
always @(Present_state)// do the required job ineach state
begin
    case (Present_state) //assert the required signals in each clock cycle
            
        T0: begin 
            #10 PCout <= 1; MARin <= 1; IncPC <= 1; Zin<= 1;  //initialize the signals         
            #15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin<= 0;
        end
        T1: begin
            #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h4A920000; //opcode for ld, Ra, C 0000101000000xxxxxxxxxxxxxxxxxx
            #15 Zlowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;
        end
        T2: begin
            #10 MDRout<= 1; IRin <= 1;
            #15 MDRout<= 0; IRin <= 0;
        end
        T3: begin
            #10 Grb <= 1; BAout<= 1; Yin <= 1;
            #15 Grb <= 0; BAout<= 0; Yin <= 0;
        end
        T4: begin
            #10 Cout<= 1; ADD <= 1; Zlowin <= 1;
            #10 Cout<= 0; ADD <= 0; Zlowin <= 0;
        end
        T5: begin
            #10 Zlowout<= 1; R5in <= 1;
            #15 Zlowout<= 0; R5in <= 0;
        end
        T6: begin
            #10 Read <= 1; MDRin <= 1; Mdatain <= 32'h4A920000;
            #15 Read <= 0; MDRin <= 0; 
        end
        T7: begin
            #10 MDRout <= 1; Gra <= 1; Rin <= 1; 
            #15 MDRout <= 0; Gra <= 0; Rin <= 0;
        end
    endcase
end

endmodule 
