module select_and_encode (Gra, Grb, Grc, Rin, Rout, BAout, IR, RXin, RXout, CSignExtended);

    input Gra, Grb, Grc, Rin, Rout, BAout; // from CPU
    input [31:0] IR;
    output reg [15:0] RXin, RXout; // Registers 0 - 15 in/out
    output reg [31:0] CSignExtended;

    reg [3:0] selected_register;

    always @(Gra, Grb, Grc, IR, BAout, Rin, Rout) // are these the right thingsin the sensitivity list
    begin
        
        // Select
        if (Gra == 1) selected_register = IR[26:23]; else
        if (Grb == 1) selected_register = IR[22:19]; else
        if (Grc == 1) selected_register = IR[18:15];
		  
        if (BAout == 1|| Rout == 1) begin 
            RXout = 0;
            RXout[selected_register] = 1;
            // C_sign_extended
            CSignExtended = $signed(IR[18:0]);
        end else 
        if (Rin) begin 
            RXin = 0;
            RXin[selected_register] = 1;
            // C_sign_extended
            CSignExtended = $signed(IR[18:0]);
        end

    end


endmodule