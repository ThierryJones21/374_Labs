T0: begin
    #10 PCout<= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
end
T1: begin
    #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h2A920000; //opcode for SHR R5, R2, R4 00101 0101 0010 0100 000
end
T2: begin
    #10 MDRout<= 1; IRin <= 1;
end
T3: begin
    #10 R2out<= 1; Yin <= 1;
end
T4: begin
    // Shift right
    #10 CONTROL <= 7; Zlowin <= 1;
end
T5: begin
    #10 Zlowout<= 1; R5in <= 1;
end
