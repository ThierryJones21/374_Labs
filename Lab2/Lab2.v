`timescale 1ns/10ps

module Lab2;
	
	reg PCout, Zlowout, Zhighout, MDRout, Clock, Clear, Yout, Cout, outPortIn, inPortOut, inPortIn, highout, lowout, con_in;
    reg BAout, Rin, Rout, Gra, Grb, Grc;
    reg MARin, Zhighin, Zlowin, lowin, highin, PCin, MDRin, IRin, Yin, ram_enable, R15_enable;
    reg IncPC, Read;
	reg[3:0] CONTROL;
    
    reg[31:0] Mdatain;

    parameter Default = 4'b0000, T0 = 4'b0001, T1 = 4'b0010, T2 = 4'b0011, T3 = 4'b0100, T4 = 4'b0101, T5 = 4'b0110, T6 = 4'b0111, T7 = 4'b1000, T8 = 4'b1001, T9 = 4'b1010;
	 
    reg[3:0] Present_state= Default;

	datapath DUT(PCout, MDRout, MARin, Zhighout, Zlowout, Zhighin, Zlowin, highin, lowin, PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, Clock, Mdatain, Clear, BAout, Rin, Rout, Gra, Grb, Grc, con_in, Cout, outPortIn, inPortOut, inPortIn, ram_enable, highout, lowout, R15_enable);
    
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
            end    
            T0: begin // put opcode into in_port register
                #10 PCout <= 1; IncPC <= 1; inPortIn <= 1; Mdatain <= 32'h10080090; // opcode for st 90 r1 
                #15 PCout <= 0; IncPC <= 0; inPortIn <= 0;
            end
            T1: begin // read from inport to IR and figure out what register is involved
                #10 inPortOut<= 1; IRin <= 1; Grb <= 1; BAout<= 1; Rout <= 1; 
                #15 inPortOut<= 0; IRin <= 0; Grb <= 0; BAout<= 0; Rout <= 0;  // R1out is enabled from Grb, BAout, Rout -> put vaule in R1 into bus -> MDRin  enabeld ,means store from bus into MDR
            end
            T2: begin // store that register's value in MDR
                #10 MDRin <= 1; Read <= 0; // Read = 0 reads from the bus
                #15 MDRin <= 0;
            end
            T3: begin // store the address to write to RAM in the MAR
                #10 Cout<= 1; MARin <= 1; // Cout contains the address, wire to MAR
                #15 Cout<= 0; MARin <= 0;
            end
            T4: begin // MDRout has value of R1, put it on bus, enable write to RAM
                #10 MDRout <= 0; ram_enable <= 1;  
                #15 MDRout <= 0; ram_enable <= 0;
            end
        endcase
    end
endmodule 