`timescale 1ns/10ps

module Lab2;
	
	reg PCout, Zlowout, Zhighout, MDRout, Clock, Clear, Yout, Cout, outPortIn, inPortOut, inPortIn, highout, lowout, con_in;
    reg BAout, Rin, Rout, Gra, Grb, Grc;
    reg MARin, Zhighin, Zlowin, lowin, highin, PCin, MDRin, IRin, Yin, ram_enable, R15_enable, PC_enable;
    reg IncPC, Read;
	reg[3:0] CONTROL;
    
    reg[31:0] Mdatain;

    parameter Default = 4'b0000, T0 = 4'b0001, T1 = 4'b0010, T2 = 4'b0011, T3 = 4'b0100, T4 = 4'b0101, T5 = 4'b0110, T6 = 4'b0111, T7 = 4'b1000, T8 = 4'b1001, T9 = 4'b1010;
	 
    reg[3:0] Present_state= Default;

	datapath DUT(PCout, MDRout, MARin, Zhighout, Zlowout, Zhighin, Zlowin, highin, lowin, PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, Clock, Mdatain, Clear, BAout, Rin, Rout, Gra, Grb, Grc, con_in, Cout, outPortIn, inPortOut, inPortIn, ram_enable, highout, lowout, R15_enable, PC_enable);
    
    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock;
    end


    always @(posedge Clock)//finite state machine; if clock rising-edge
    begin
        case (Present_state)
            Default     :   Present_state = T0;
            T0          :   #40 Present_state = T1;
            T1          :   #40 Present_state = T2;
            T2          :   #40 Present_state = T3;
            T3          :   #40 Present_state = T4;
            T4          :   #40 Present_state = T5;
            T5			:	#40 Present_state = T6;
            T6			:	#40 Present_state = T7;
            T7			:	#40 Present_state = T8;
            T8			:	#40 Present_state = T9;
        endcase
    end

    // the contents of this always statement, except for the default state, changes for the different instructions. That is, the control sequences for each testbench is different
    always @(Present_state)// do the required job ineach state
    begin
        case (Present_state) //assert the required signals in each clock cycle
            Default: begin //initialize the signals
                PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout<= 0;  //initialize the signals
                MARin <= 0; Zlowin <= 0; Zhighin <= 0;
                PCin <= 0; MDRin <= 0; IRin  <= 0; Yin <= 0;
                IncPC <= 0; Read <= 0; CONTROL <= 0;
                Clear <= 1; Yout <= 0; highin <= 0; lowin <= 0;
                Cout <= 0; outPortIn <= 0; inPortOut <= 0; inPortIn<= 0; con_in <= 0;
                Mdatain <= 32'h00000000; highout <= 0; lowout <= 0;
                BAout <= 0; Rin <= 0; Rout <= 0; Gra <= 0; Grb <= 0; Grc <= 0; ram_enable <= 0;
                R15_enable <= 0; PC_enable <= 0;
            end    
            T0: begin 
                #10 PCout <= 1; MARin <= 1; IncPC <= 1; Zlowin<= 1;       
                #15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin<= 0; 
            end
            T1: begin
                #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; // Mdatain <= 32'h91000023; // opcode for brzr R2, 35  (10010 0010 0000 0000 000 0000 0010 0011)//  
                #15 Zlowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;
            end
            T2: begin
                #10 MDRout<= 1; IRin <= 1; 
                #15 MDRout<= 0; IRin <= 0; 
            end
            T3: begin
                #10 Gra <= 1; Rout <= 1; con_in <= 1;  
                #15 Gra <= 0; Rout <= 0; con_in <= 0; 
            end
            T4: begin
                #10 PCout<= 1; Yin <= 1;  // put PC in Y register
                #10 PCout<= 0; Yin <= 0; 
            end
            T5: begin
                #10 Cout<= 1; CONTROL <= 2; Zlowin <= 1;  // add PC with branch, store in Z_LO
                #15 Cout<= 0; Zlowin <= 0; 
            end
            T6: begin // enable the PC
                #10 Zlowout <= 1; PC_enable <= 1; //Reading from PCin
                #15 Zlowout <= 0; PC_enable <= 0; 
            end
        endcase
    end
endmodule 
