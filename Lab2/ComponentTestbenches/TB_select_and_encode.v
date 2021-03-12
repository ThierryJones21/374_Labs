//`timescale 1ns/10ps

module TB_select_and_encode ();

    // add any other signals to see in your simulation
    reg Clock, Gra, Grb, Grc, Rin, Rout, BAout;
    reg [15:0] RXin, RXout;
    reg [31:0] IR, CSignExtended;
	select_and_encode test(Gra, Grb, Grc, Rin, Rout, BAout, IR, RXin, RXout, CSignExtended);

    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock;
    end

    always @(posedge Clock)//finite state machine; if clock rising-edge
    begin
        IR <= 32'h4A920000; //and R5, R2, R4
        Gra <= 1; // register A
        Grb <= 0; // register B
        Grc <= 0; // register C
        BAout <= 0;
        Rout <= 0;
        Rin <= 1; // set to rIn 
        // RXin should be 0000000000100000
    end

    always @(CSignExtended)
    begin
        $display("RXin: %b", RXin);
        $display("RXout: %b", RXout);
        $display("CSignExtended: %b", CSignExtended);
    end

endmodule 