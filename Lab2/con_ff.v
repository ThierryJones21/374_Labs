module con_ff (con_in, IR, BusMuxOut, toControlUnit);

    input con_in; // enable
    input [3:0] IR;
    input [31:0] BusMuxOut;
    output [31:0] toControlUnit; // this is PC + 1 + C (signExtended)

    // Note: Nor with same input is a not. Negated again, it is the original.
    if (con_in) begin
        case (IR)
            0: toControlUnit <= !BusMuxOut; // branch if zero
            1: toControlUnit <= BusMuxOut; // branch if non zero
            2: toControlUnit <= !BusMuxOut[31]; // branch if greater than zero
            3: toControlUnit <= BusMuxOut[31]; // branch if less than zero
            default: begin end; // otherwise do nothing
        endcase
    end else toControlUnit <= 0; // set 0

endmodule