module TB_con_ff ();

    reg con_in, Clock;
    reg [3:0] IR;
    reg [31:0] BusMuxOut;
    reg toControlUnit;

    reg[3:0] Present_state= Default;
    parameter Default = 4'b0000, T0= 4'b0001, T1= 4'b0010, T2= 4'b0011, T3=4'b0100, T4= 4'b0101, T5= 4'b0110, T6= 4'b0111 ;

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
            T3          :   Present_state = T4;
            T4          :   Present_state = T5;
            T5          :   Present_state = T6;
        endcase
    end

    always @(Present_state) 
    begin 
        case (Present_state)
            default: begin
                // should be 1
				con_in <= 1;
                IR <= 0;
                BusMuxOut <= 0;
            end
            T0: begin 
                // should be 0
                IR <= 1;
                BusMuxOut <= 0;
            end
            T1: begin 
                // should be 1
                IR <= 2;
                BusMuxOut <= 10;
            end
            T2: begin 
                // should be 0
                IR <= 3;
                BusMuxOut <= 10;
            end
            T3: begin
                // should be 0
				con_in <= 1;
                IR <= 0;
                BusMuxOut <= 7;
            end
            T4: begin 
                // should be 1
                IR <= 1;
                BusMuxOut <= 7;
            end
            T5: begin 
                // should be 0
                IR <= 2;
                BusMuxOut <= -10;
            end
            T6: begin 
                // should be 1
                IR <= 3;
                BusMuxOut <= -10;
            end
        endcase
    end

    always @(IR) begin
        $display("IR: %b", IR);
        $display("%b", toControlUnit);
    end

endmodule