module TB_con_ff (reg [31:0] toControlUnit);

    reg con_in, Clock;
    reg [3:0] IR;
    reg [31:0] BusMuxOut;

    reg[3:0] Present_state= Default;
    parameter Default = 4'b0000, T0= 4'b0001, T1= 4'b0010, T2= 4'b0011, T3=4'b0100 ;

    con_ff my_on_ff (con_in, IR, BusMuxOut, toControlUnit);

    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock;
    end

    always @(posedge Clock)//finite state machine; if clock rising-edge
    begin
        case (Present_state)
            Default     :   Present_state = T0;
            T0          :   Present_state = T1;
            T1          :   Present_state = T2;
            T2          :   Present_state = T3;
        endcase
    end

    always @(Present_state) 
    begin 
        case (Present_state)
            default: begin
                // default 7 value 
                // should read XXX
				con_in <= 1;
                IR <= 0;
                BusMuxOut <= 10011001100110011001100110011001;
            end
            T0: begin 
                IR <= 1;
                BusMuxOut <= 10011001100110011001100110011001
            end
            T1: begin 
                IR <= 2;
                BusMuxOut <= 10011001100110011001100110011001
            end
            T2: begin 
                IR <= 3;
                BusMuxOut <= 10011001100110011001100110011001
            end
        endcase
    end

    always @(toControlUnit) begin
        $display("%b", toControlUnit);
    end

endmodule