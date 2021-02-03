`include "Modules/mux21.v"
`include "Modules/dff.v"

module MDR (Read, clr, clk, MDRin, [31: 0]BusMuxOut , [31:0] Mdatain, [31:0] MDRout );
    input Read, clr, clk, MDRin, BusMuxOut, Mdatain;
    output MDRout;
    wire MDMuxOut;

    // multiplexer logic
    for(i = 0; i < 32; i = i+1)
        begin
            mux21 m (BusMuxOut[i], Mdatain[i], Read, MDMuxOut[i]);
        end
    end
    // mux21 m0 (BusMuxOut[0], Mdatain[0], Read, MDMuxOut[0]);
    // mux21 m1 (BusMuxOut[1], Mdatain[1], Read, MDMuxOut[1]);
    // mux21 m2 (BusMuxOut[2], Mdatain[2], Read, MDMuxOut[2]);
    // mux21 m3 (BusMuxOut[3], Mdatain[3], Read, MDMuxOut[3]);
    // mux21 m4 (BusMuxOut[4], Mdatain[4], Read, MDMuxOut[4]);
    // mux21 m5 (BusMuxOut[5], Mdatain[5], Read, MDMuxOut[5]);
    // mux21 m6 (BusMuxOut[6], Mdatain[6], Read, MDMuxOut[6]);
    // mux21 m7 (BusMuxOut[7], Mdatain[7], Read, MDMuxOut[7]);
    // mux21 m8 (BusMuxOut[8], Mdatain[8], Read, MDMuxOut[8]);
    // mux21 m9 (BusMuxOut[9], Mdatain[9], Read, MDMuxOut[9]);
    // mux21 m10 (BusMuxOut[10], Mdatain[10], Read, MDMuxOut[10]);
    // mux21 m11 (BusMuxOut[11], Mdatain[11], Read, MDMuxOut[11]);
    // mux21 m12 (BusMuxOut[12], Mdatain[12], Read, MDMuxOut[12]);
    // mux21 m13 (BusMuxOut[13], Mdatain[13], Read, MDMuxOut[13]);
    // mux21 m14 (BusMuxOut[14], Mdatain[14], Read, MDMuxOut[14]);
    // mux21 m15 (BusMuxOut[15], Mdatain[15], Read, MDMuxOut[15]);
    // mux21 m16 (BusMuxOut[16], Mdatain[16], Read, MDMuxOut[16]);
    // mux21 m17 (BusMuxOut[17], Mdatain[17], Read, MDMuxOut[17]);
    // mux21 m18 (BusMuxOut[18], Mdatain[18], Read, MDMuxOut[18]);
    // mux21 m19 (BusMuxOut[19], Mdatain[19], Read, MDMuxOut[19]);
    // mux21 m20 (BusMuxOut[20], Mdatain[20], Read, MDMuxOut[20]);
    // mux21 m21 (BusMuxOut[21], Mdatain[21], Read, MDMuxOut[21]);
    // mux21 m22 (BusMuxOut[22], Mdatain[22], Read, MDMuxOut[22]);
    // mux21 m23 (BusMuxOut[23], Mdatain[23], Read, MDMuxOut[23]);
    // mux21 m24 (BusMuxOut[24], Mdatain[24], Read, MDMuxOut[24]);
    // mux21 m25 (BusMuxOut[25], Mdatain[25], Read, MDMuxOut[25]);
    // mux21 m26 (BusMuxOut[26], Mdatain[26], Read, MDMuxOut[26]);
    // mux21 m27 (BusMuxOut[27], Mdatain[27], Read, MDMuxOut[27]);
    // mux21 m28 (BusMuxOut[28], Mdatain[28], Read, MDMuxOut[28]);
    // mux21 m29 (BusMuxOut[29], Mdatain[29], Read, MDMuxOut[29]);
    // mux21 m30 (BusMuxOut[30], Mdatain[30], Read, MDMuxOut[30]);
    // mux21 m31 (BusMuxOut[31], Mdatain[31], Read, MDMuxOut[31]);

    // flip flop logic
    dff d0 (clr, clk, MDRin, MDMuxOut[0], MDRout[0]);
    dff d1 (clr, clk, MDRin, MDMuxOut[1], MDRout[1]);
    dff d2 (clr, clk, MDRin, MDMuxOut[2], MDRout[2]);
    dff d3 (clr, clk, MDRin, MDMuxOut[3], MDRout[3]);
    dff d4 (clr, clk, MDRin, MDMuxOut[4], MDRout[4]);
    dff d5 (clr, clk, MDRin, MDMuxOut[5], MDRout[5]);
    dff d6 (clr, clk, MDRin, MDMuxOut[6], MDRout[6]);
    dff d7 (clr, clk, MDRin, MDMuxOut[7], MDRout[7]);
    dff d8 (clr, clk, MDRin, MDMuxOut[8], MDRout[8]);
    dff d9 (clr, clk, MDRin, MDMuxOut[9], MDRout[9]);
    dff d10 (clr, clk, MDRin, MDMuxOut[10], MDRout[10]);
    dff d11 (clr, clk, MDRin, MDMuxOut[11], MDRout[11]);
    dff d12 (clr, clk, MDRin, MDMuxOut[12], MDRout[12]);
    dff d13 (clr, clk, MDRin, MDMuxOut[13], MDRout[13]);
    dff d14 (clr, clk, MDRin, MDMuxOut[14], MDRout[14]);
    dff d15 (clr, clk, MDRin, MDMuxOut[15], MDRout[15]);
    dff d16 (clr, clk, MDRin, MDMuxOut[16], MDRout[16]);
    dff d17 (clr, clk, MDRin, MDMuxOut[17], MDRout[17]);
    dff d18 (clr, clk, MDRin, MDMuxOut[18], MDRout[18]);
    dff d19 (clr, clk, MDRin, MDMuxOut[19], MDRout[19]);
    dff d20 (clr, clk, MDRin, MDMuxOut[20], MDRout[20]);
    dff d21 (clr, clk, MDRin, MDMuxOut[21], MDRout[21]);
    dff d22 (clr, clk, MDRin, MDMuxOut[22], MDRout[22]);
    dff d23 (clr, clk, MDRin, MDMuxOut[23], MDRout[23]);
    dff d24 (clr, clk, MDRin, MDMuxOut[24], MDRout[24]);
    dff d25 (clr, clk, MDRin, MDMuxOut[25], MDRout[25]);
    dff d26 (clr, clk, MDRin, MDMuxOut[26], MDRout[26]);
    dff d27 (clr, clk, MDRin, MDMuxOut[27], MDRout[27]);
    dff d28 (clr, clk, MDRin, MDMuxOut[28], MDRout[28]);
    dff d29 (clr, clk, MDRin, MDMuxOut[29], MDRout[29]);
    dff d30 (clr, clk, MDRin, MDMuxOut[30], MDRout[30]);
    dff d31 (clr, clk, MDRin, MDMuxOut[31], MDRout[31]);

endmodule;
