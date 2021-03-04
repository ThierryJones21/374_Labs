// Will require Zhighout, Zlowin, Zhighin (as opposed to just Zin)
// Not sure if this is right - double check where quotient is tored?

T0: begin//see if you need to de-assertthese signals
    PCout<= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
end
T1: begin
    Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1;
    Mdatain <= 32'h7920000; //opcode for DIV R2, R4 01111 0010 0100 000 0000 0000 0000 
end
T2: begin
    MDRout<= 1; IRin <= 1;
end
T3: begin
    R2out<= 1; Yin <= 1;
end
T4: begin
    // put value in R4 on bus
    R4out<= 1; 
    // Division
    CONTROL <= 11;
    // to put in Z register
    Zlowin <= 1; Zhighin <= 1;
end
T5: begin
    Zlowout<= 1; Zlowin <= 0;
end
T6: begin
    Zhighout<= 1; Zhighin <= 0;
end
