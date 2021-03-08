module con_ff (con_in, IR, BusMuxOut, toControlUnit);

    input con_in; // enable
    input [3:0] IR;
    input [31:0] BusMuxOut;
    output reg [31:0] toControlUnit; // this is PC + 1 + C (signExtended)
    always @(posedge con_in) begin
        
    // Note: Nor with same input is a not. Negated again, it is the original.
        if (con_in) begin
            case (IR)
                0: toControlUnit <= !BusMuxOut; // branch if zero
                1: toControlUnit <= BusMuxOut; // branch if non zero
                2: toControlUnit <= !BusMuxOut[31]; // branch if greater than zero
                3: toControlUnit <= BusMuxOut[31]; // branch if less than zero
                default: begin end // otherwise do nothing
            endcase
        end else toControlUnit <= 0; // set 0
    end

endmodule

// module con_ff (con_in, IR, BusMuxOut, toControlUnit);

//     input con_in; // enable
//     input [3:0] IR;
//     input [31:0] BusMuxOut;
//     output reg [31:0] toControlUnit; // this is PC + 1 + C (signExtended)

//     // Note: Nor with same input is a not. Negated again, it is the original.
//     // Note: AND ing a 32 bit number and 1 bit number means only the last bit matters?
//     if (con_in) begin
//         case (IR)
//             0: toControlUnit <= !BusMuxOut[0]; // branch if zero
//             1: toControlUnit <= BusMuxOut[0]; // branch if non zero
//             2: toControlUnit <= !BusMuxOut[31]; // branch if greater than zero
//             3: toControlUnit <= BusMuxOut[31]; // branch if less than zero
//             default: begin end // otherwise do nothing
//         endcase
//     end else toControlUnit <= 0; // set 0

// endmodule