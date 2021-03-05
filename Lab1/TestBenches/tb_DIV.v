// Will require Zhighout, Zlowin, Zhighin (as opposed to just Zin)
// Not sure if this is right - double check where quotient is tored?

T0: begin//see if you need to de-assertthese signals
    #10 PCout<= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
end
T1: begin
    #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1;
    Mdatain <= 32'h4A920000; //opcode for AND R5, R2, R4
end
T2: begin
    #10 MDRout<= 1; IRin <= 1;
end
T3: begin
    #10 R2out<= 1; Yin <= 1;
end
T4: begin
    // put value in R4 on bus
    #10 R4out<= 1; CONTROL <= 11; Zlowin <= 1; Zhighin <= 1;
end
T5: begin
    #10 Zlowout<= 1; Zlowin <= 0;
end
T6: begin
    #10 Zhighout<= 1; Zhighin <= 0;
end