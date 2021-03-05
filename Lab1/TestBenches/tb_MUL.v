T0: begin//see if you need to de-assertthese signals
    #10 PCout<= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
end
T1: begin
    #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h7120000; //opcode for MUL  R2, R4 01110 0010 0100 0000 0000 0000 000 pad 3 bits
end
T2: begin
    #10 MDRout<= 1; IRin <= 1;
end
T3: begin
    #10 R2out<= 1; Yin <= 1;
end
T4: begin
    // put value in R4 on bus; mul
    #10 R4out<= 1; CONTROL <= 10; Zlowin <= 1; Zhighin <= 1;
end
T5: begin
    #10 Zlowout<= 1; Zlowin <= 0;
end
T6: begin
    #10 Zhighout<= 1; Zhighin <= 0;
end
