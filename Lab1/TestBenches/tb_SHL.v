T0: begin//see if you need to de-assertthese signals
    PCout<= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
end
T1: begin
    Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1;
    Mdatain <= 32'h32920000; //opcode for SHL R5, R2, R4 --> 0011 0010 1001 0010 0000
end
T2: begin
    MDRout<= 1; IRin <= 1;
end
T3: begin
    R2out<= 1; Yin <= 1;
end
T4: begin
    // Shift left
    CONTROL <= 6; Zin <= 1;
end
T5: begin
    Zlowout<= 1; R5in <= 1;
end
