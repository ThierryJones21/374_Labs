T0: begin//see if you need to de-assertthese signals
    #10 PCout<= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
end
T1: begin
    #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h82A0000; //opcode for NEG R5, R2 10000 0101 0100 000 0000 0000 0000 
end
T2: begin
    #10 MDRout<= 1; IRin <= 1;
end
T3: begin
    // neg
    #10 R2out<= 1; CONTROL <= 4; Zlowin <= 1;
end
T4: begin
    #10 Zlowout<= 1; R5in <= 1;
end
