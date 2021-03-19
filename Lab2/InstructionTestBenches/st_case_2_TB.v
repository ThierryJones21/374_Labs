always @(Present_state)// do the required job ineach state
begin
    case (Present_state) //assert the required signals in each clock cycle
        Default: begin //initialize the signals
            PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout<= 0;  //initialize the signals
            MARin <= 0; Zlowin <= 0; Zhighin <= 0;
            PCin <= 0; MDRin <= 0; IRin  <= 0; Yin <= 0;
            IncPC <= 0; Read <= 0; CONTROL <= 0;
            Clear <= 1; Yout <= 0; highin <= 0; lowin <= 0;
            Cout <= 0; outPortIn <= 0; inPortOut <= 0; inPortIn<= 0; con_in <= 0;
            Mdatain <= 32'h00000000; highout <= 0; lowout <= 0;
            BAout <= 0; Rin <= 0; Rout <= 0; Gra <= 0; Grb <= 0; Grc <= 0; ram_enable <= 0;
        end    
        T0: begin // put opcode into in_port register
            #10 PCout <= 1; IncPC <= 1; inPortIn <= 1; Mdatain <= 32'h10080090; // opcode for st 90 r1 
            #15 PCout <= 0; IncPC <= 0; inPortIn <= 0;
        end
        T1: begin // read from inport to IR and figure out what register is involved
            #10 inPortOut<= 1; IRin <= 1; Grb <= 1; BAout<= 1; Rout <= 1; 
            #15 inPortOut<= 0; IRin <= 0; Grb <= 0; BAout<= 0; Rout <= 0;  // R1out is enabled from Grb, BAout, Rout -> put vaule in R1 into bus -> MDRin  enabeld ,means store from bus into MDR
        end
        T2: begin // store that register's value in MDR
            #10 MDRin <= 1; Read <= 0; // Read = 0 reads from the bus
            #15 MDRin <= 0;
        end
        T3: begin // store the address in register A
            #10 Cout<= 1; Yin <= 1; 
            #15 Cout<= 0; Yin <= 0;
        end
        T4: begin // get the value in R1 and add it to the address, store in ZLO
            #10 MDRout <= 1; CONTROL <= 2; Zlowin <= 1;
            #15 MDRout <= 0; CONTROL <= 2; Zlowin <= 1;
        end
        T5: begin // store the address to write to RAM in the MAR
            #10 Zlowout<= 1; MARin <= 1;
            #15 Zlowout<= 0; MARin <= 0;
        end
        T6: begin // MDRout has value of R1, put it on bus, enable write to RAM
            #10 MDRout <= 0; ram_enable <= 1;  
            #15 MDRout <= 0; ram_enable <= 0;
        end
    endcase
end