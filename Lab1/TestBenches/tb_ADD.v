T0: begin//see if you need to de-assertthese signals
    #10 PCout<= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
    #15 PCout<= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
end
T1: begin
    #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h1A920000; //opcode for ADD R5, R2, R4 0001 1 010 1 001 0 010 0000 0000 0000 0000 
    #15 Zlowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
T2: beg5n
    #10 MDRout<= 1; IRin <= 1;
    #15 MDRout<= 0; IRin <= 0;
end
T3: begin
    #10 R2out<= 1; Yin <= 1;
    #15 R2out<= 0; Yin <= 0;
end
T4: begin
    // add
    #10 R4out<= 1; CONTROL <= 2; Zlowin <= 1;
    #15 R4out<= 0; Zlowin <= 0;
end
T5: begin
    #10 Zlowout<= 1; R5in <= 1;
    #15 Zlowout<= 0; R5in <= 0;
end
