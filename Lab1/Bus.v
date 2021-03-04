module Bus (R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out,  R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out, In_Portout, C_out, BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Z_HI, BusMuxIn_Z_LO, BusMuxIn_PC, BusMuxIn_MDR,  BusMuxIn_IN_PORT, C_Sign_Extended, BusMuxOut);

    input wire R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out,  R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out, In_Portout, C_out;

    input wire BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Z_HI, BusMuxIn_Z_LO, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_IN_PORT, C_Sign_Extended;

    output reg [31:0] BusMuxOut;

    reg [4:0] encoderOut;

    always @ (R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out,  R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out, In_Portout, C_out)
        begin
            if (C_out) BusMuxOut = C_Sign_Extended; else
            if (In_Portout) BusMuxOut = BusMuxIn_IN_PORT; else
            if (MDR_out)    BusMuxOut = BusMuxIn_MDR; else
            if (PC_out)     BusMuxOut = BusMuxIn_PC; else
            if (Z_low_out)  BusMuxOut = BusMuxIn_Z_LO; else
            if (Z_high_out) BusMuxOut = BusMuxIn_Z_HI; else
            if (LO_out)     BusMuxOut = BusMuxIn_LO; else
            if (HI_out)     BusMuxOut = BusMuxIn_HI; else
            if (R15_out)    BusMuxOut = BusMuxIn_R15; else
            if (R14_out)    BusMuxOut = BusMuxIn_R14; else
            if (R13_out)    BusMuxOut = BusMuxIn_R13; else
            if (R12_out)    BusMuxOut = BusMuxIn_R12; else
            if (R11_out)    BusMuxOut = BusMuxIn_R11; else
            if (R10_out)    BusMuxOut = BusMuxIn_R10; else
            if (R9_out)     BusMuxOut = BusMuxIn_R9; else
            if (R8_out)     BusMuxOut = BusMuxIn_R8; else
            if (R7_out)     BusMuxOut = BusMuxIn_R7; else
            if (R6_out)     BusMuxOut = BusMuxIn_R6; else
            if (R5_out)     BusMuxOut = BusMuxIn_R5; else
            if (R4_out)     BusMuxOut = BusMuxIn_R4; else
            if (R3_out)     BusMuxOut = BusMuxIn_R3; else
            if (R2_out)     BusMuxOut = BusMuxIn_R2; else
            if (R1_out)     BusMuxOut = BusMuxIn_R1; else
            if (R0_out)     BusMuxOut = BusMuxIn_R0; else
                            BusMuxOut = C_Sign_Extended;
        end
       
endmodule
