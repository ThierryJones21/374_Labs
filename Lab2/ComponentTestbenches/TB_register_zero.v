//`timescale 1ns/10ps

module TB_register_zero ();

    // add any other signals to see in your simulation
    reg Clock, clr, BAout, R0in;
    reg [31:0] BusMuxOut, BusMuxIn_R0;
	register_zero test(Clock, clr, BAout, BusMuxOut, R0in, BusMuxIn_R0);
    
    reg[3:0] Present_state= Default;
    parameter Default = 4'b0000, T0= 4'b0001, T1= 4'b0010, T2= 4'b0011;
	
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
        endcase
    end


    always @(Present_state) 
    begin 
        case (Present_state)
            default: begin
                // default 7 value 
                // should read XXX
				BusMuxOut <= 7; clr <= 0; BAout <= 0; R0in <= 0;
            end
            T0: begin 
                // should read 0
                #15 BAout <= 1; R0in <= 0;
            end
            T1: begin 
                // should read 0
              	#15 BAout <= 0; R0in <= 1;
            end
            T1: begin 
                // should read 7
                #15 BAout <= 1; R0in <= 1;
            end
            T2: begin 
                // should read 0
                #15 clr <= 1; BAout <= 1; R0in <= 1;
            end
        endcase
    end

  always @(Present_state)
    begin
        $display("Present State: %b", Present_state);
        $display("BusMuxOut: %b", BusMuxOut);
        $display("R0in: %b", R0in);
        $display("BAout: %b", BAout);
        $display("Clr: %b", clr);
        $display("BusMuxIn_R0: %b", BusMuxIn_R0);
    end

endmodule 