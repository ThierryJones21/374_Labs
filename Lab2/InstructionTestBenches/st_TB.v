// store -> read from register and put in RAM
// pu value in R1 into address 90 in ram
always @(Present_state)// do the required job ineach state
begin
    case (Present_state) //assert the required signals in each clock cycle
        Default: begin //initialize the signals
            PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout<= 0;  //initialize the signals
            MARin <= 0; Zlowin <= 0; Zhighin <= 0;
            PCin <= 0; MDRin <= 0; IRin  <= 0; Yin <= 0;
            IncPC <= 0; Read <= 0; CONTROL <= 0;
            Clear <= 1; Yout <= 0; highin <= 0; lowin <= 0;
            Mdatain <= 32'h00000000;
            BAout <= 0; Rin <= 0; Rout <= 0; Gra <= 0; Grb <= 0; Grc <= 0; ram_enable <= 0;
        end    
        T0: begin 
            #10 PCout <= 1; MARin <= 1; IncPC <= 1; Zin<= 1;  //initialize the signals         
            #15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin<= 0;
        end
        T1: begin
            #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h10080090; // opcode for st 90 r1 // put Mdatain into PC, Zlowiut, MDR
            #15 Zlowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;
        end
        T2: begin
            #10 MDRout<= 1; IRin <= 1; // read MDR into IR
            #15 MDRout<= 0; IRin <= 0;
        end
        T3: begin
            #10 Grb <= 1; BAout<= 1; Rout <= 1; MDRin <= 1; // store value of R1 in MDR
            #15 Grb <= 0; BAout<= 0; Rout <= 0; MDRin <= 0; // R1out is enabled from Grb, BAout, Rout -> put vaule in R1 into bus -> MDRin  enabeld ,means store from bus into MDR
        end
        T4: begin
            #10 Cout<= 1; MARin <= 1; // Cout contains the address, wire to MAR
            #10 Cout<= 0; MARin <= 0;
        end
        T5: begin
            #10 MDRout <= 1; ram_enable <= 1;  // MDROut has value of R1, put it on bus, enable write to RAM
            #15 MDRout <= 0; ram_enable <= 0;
        end
    endcase
end