module con_ff (con_in, IR, BusMuxOut, toControlUnit);

    input con_in; // enable
    input [3:0] IR;
    input [31:0] BusMuxOut;
    output reg toControlUnit; // this is PC + 1 + C (signExtended)

    function triple_nor(input [31:0] BusMuxOut);
        // as long as 1 bit is 1, return true. Since this is then put through a NOT gate, it means
        // as long as 1 bit is 1, return false
        // that is, if zero, return true
        triple_nor = (BusMuxOut == 0) ? 1 : 0;
    endfunction

    always @(posedge con_in) begin
        
    // Note: Nor with same input is a not. Negated again, it is the original.
        if (con_in) begin
            case (IR[3:2])
                0: toControlUnit = triple_nor(BusMuxOut); // branch if zero
                1: toControlUnit = !triple_nor(BusMuxOut); // branch if non zero
                2: toControlUnit = !BusMuxOut[31]; // branch if greater than zero
                3: toControlUnit = BusMuxOut[31]; // branch if less than zero
                default: begin end // otherwise do nothing
            endcase
        end else toControlUnit <= 0; // set 0
    end

endmodule