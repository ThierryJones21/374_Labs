`timescale 1ns/10ps

module Lab2;
	
	reg PCout, Zlowout, Zhighout, MDRout, Clock, Clear, Yout, COut, outPortIn, inPortOut;
    reg BAout, Rin, Rout, Gra, Grb, Grc;
    reg MARin, Zhighin, Zlowin, lowin, highin, PCin, MDRin, IRin, Yin;
    reg IncPC, Read;
	reg[3:0] CONTROL;
    
    reg[31:0] Mdatain;

    parameter Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010, Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100, T6 = 4'b1101, T7 = 4'b1110;

    reg[3:0] Present_state= Default;

	datapath DUT(PCout, MDRout, MARin, Zhighout, Zlowout, Zhighin, Zlowin, highin, lowin, PCin, MDRin, IRin, Yin, IncPC, Read, CONTROL, Clock, Mdatain, Clear, BAout, Rin, Rout, Gra, Grb, Grc, COut, outPortIn, inPortOut);
    
    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock;
    end


    always @(posedge Clock)//finite state machine; if clock rising-edge
    begin
        case (Present_state)
            Default     :   Present_state = Reg_load1a;
            Reg_load1a  :   #40 Present_state = Reg_load1b;
            Reg_load1b  :   #40 Present_state = Reg_load2a;
            Reg_load2a  :   #40 Present_state = Reg_load2b;
            Reg_load2b  :   #40 Present_state = Reg_load3a;
            Reg_load3a  :   #40 Present_state = Reg_load3b;
            Reg_load3b  :   #40 Present_state = T0;
            T0          :   #40 Present_state = T1;
            T1          :   #40 Present_state = T2;
            T2          :   #40 Present_state = T3;
            T3          :   #40 Present_state = T4;
            T4          :   #40 Present_state = T5;
			T5			:	#40 Present_state = T6;
			T6			:	#40 Present_state = T7;
        endcase
    end

	 /*
	always @(Present_state)// do the required job ineach state
	begin
        case (Present_state) //assert the required signals in each clock cycle
            Default: begin //initialize the signals
                PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout<= 0;  //initialize the signals
                R2out <= 0; R4out <= 0; MARin <= 0; Zlowin <= 0; Zhighin <= 0;
                PCin <= 0; MDRin <= 0; IRin  <= 0; Yin <= 0;
                IncPC <= 0; Read <= 0; CONTROL <= 0;
                Clear <= 1; Yout <= 0; highin <= 0; lowin <= 0;
                R5in <= 0; R2in <= 0; R4in <= 0; Mdatain <= 32'h00000000;
            end
            Reg_load1a: begin 
                Mdatain<= 32'h0000004; // loads hex 4 into MDR
                Read = 0; MDRin = 0; //the first zero is there for completeness
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRin <= 0;
            end
            Reg_load1b: begin
                #10 MDRout<= 1; R2in <= 1; // copies from MDR into R2
                #15 MDRout<= 0; R2in <= 0; // initialize R2 with the value $22
            end
            Reg_load2a: begin 
                Mdatain <= 32'h00000009; // loads hex 9 into MDR
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRin <= 0;
            end
            Reg_load2b: begin
                #10 MDRout<= 1; R4in <= 1; // copies from MDR into R4
                #15 MDRout<= 0; R4in <= 0; // initialize R4 with the value $24 
            end
            Reg_load3a: begin 
                Mdatain <= 32'h00000026; // loads hex 26 into MDR
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRin <= 0;
            end
            Reg_load3b: begin
                #10 MDRout<= 1; R5in <= 1; // copies from MDR into R5 - so that we know it overwrites!
                #15 MDRout<= 0; R5in <= 0; // initialize R5 with the value $26 
            end
				T0: begin //see if you need to de-assertthese signals
                #10 PCout<= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
                #15 PCout<= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
            end
            T1: begin
                #10 Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h4A920000; //opcode for AND R5, R2, R4 
                #15 Zlowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;
            end
            T2: begin
                #10 MDRout<= 1; IRin <= 1;
                #15 MDRout<= 0; IRin <= 0;
            end
            T3: begin
                #10 R2out<= 1; Yin <= 1;
                #15 R2out<= 0; Yin <= 0;
            end
            T4: begin
                #10 R4out<= 1; CONTROL <= 0; Zlowin <= 1;
                #15 R4out<= 0; Zlowin <= 0;
            end
            T5: begin
                #10 Zlowout<= 1; R5in <= 1;
                #15 Zlowout<= 0; R5in <= 0;
            end
        endcase
	end
	*/
endmodule 
