module bus (R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out,  R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out, In_Portout, C_out,
BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Z_HI, BusMuxIn_Z_LO, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_IN_PORT, C_Sign_Extended, BusMuxOut);

    input wire R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out,  R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out, In_Portout, C_out;

    input wire BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Z_HI, BusMuxIn_Z_LO, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_IN_PORT, C_Sign_Extended;

    output reg [31:0] BusMuxOut;

    wire [4:0] encoderOut;

    // Encoder
    always @ (R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out,  R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out, In_Portout, C_out)
        begin
            if (C_out) encoderOut = 23; else
            if (In_Portout) encoderOut = 22; else
            if (MDR_out)    encoderOut = 21; else
            if (PC_out)     encoderOut = 20; else
            if (Z_low_out)  encoderOut = 19; else
            if (Z_high_out) encoderOut = 18; else
            if (LO_out)     encoderOut = 17; else
            if (HI_out)     encoderOut = 16; else
            if (R15_out)    encoderOut = 15; else
            if (R14_out)    encoderOut = 14; else
            if (R13_out)    encoderOut = 13; else
            if (R12_out)    encoderOut = 12; else
            if (R11_out)    encoderOut = 11; else
            if (R10_out)    encoderOut = 10; else
            if (R6_out)     encoderOut = 6; else
            if (R9_out)     encoderOut = 9; else
            if (R8_out)     encoderOut = 8; else
            if (R7_out)     encoderOut = 7; else
            if (R5_out)     encoderOut = 5; else
            if (R4_out)     encoderOut = 4; else
            if (R3_out)     encoderOut = 3; else
            if (R2_out)     encoderOut = 2; else
            if (R1_out)     encoderOut = 1; else
            if (R0_out)     encoderOut = 0; else
                            encoderOut = 23; // otherwise is C_out
        end

    // multiplexer
    always @(encoderOut)
    begin
        case(encoderOut)
            0       :     BusMuxOut = BusMuxIn_R0;
            1       :     BusMuxOut = BusMuxIn_R1;
            2       :     BusMuxOut = BusMuxIn_R2;
            3       :     BusMuxOut = BusMuxIn_R3;
            4       :     BusMuxOut = BusMuxIn_R4;
            5       :     BusMuxOut = BusMuxIn_R5;
            6       :     BusMuxOut = BusMuxIn_R6;
            7       :     BusMuxOut = BusMuxIn_R7;
            8       :     BusMuxOut = BusMuxIn_R8;
            9       :     BusMuxOut = BusMuxIn_R9;
            10      :     BusMuxOut = BusMuxIn_R10;
            11      :     BusMuxOut = BusMuxIn_R11;
            12      :     BusMuxOut = BusMuxIn_R12;
            13      :     BusMuxOut = BusMuxIn_R13;
            14      :     BusMuxOut = BusMuxIn_R14;
            15      :     BusMuxOut = BusMuxIn_R15;
            16      :     BusMuxOut = BusMuxIn_HI;
            17      :     BusMuxOut = BusMuxIn_LO;
            18      :     BusMuxOut = BusMuxIn_Z_HI;
            19      :     BusMuxOut = BusMuxIn_Z_LO;
            20      :     BusMuxOut = BusMuxIn_PC;
            21      :     BusMuxOut = BusMuxIn_MDR;
            22      :     BusMuxOut = BusMuxIn_IN_PORT;
            23      :     BusMuxOut = C_Sign_Extended;
            default :     BusMuxOut = C_Sign_Extended;
			endcase
    end
       
endmodule
