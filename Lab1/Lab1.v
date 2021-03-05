`timescale 1ns/10ps

module Lab1;
	
	 reg PCout, Zlowout, Zhighout, MDRout, R2out, R4out, Clock, Clear, Yout;
    // add any other signals to see in your simulation
    reg MARin, Zin, PCin, MDRin, IRin, Yin;
    reg IncPC,Read, CONTROL, R5in, R2in, R4in;
	 //reg[3:0] cntrl;
    //reg Clock;
    reg[31:0] Mdatain;

    parameter Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010, Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
				  Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100;
				//,T6 = 4'b1101;

    reg[3:0] Present_state= Default;

	datapath DUT(.PCout(PCout), .Zin(Zin), .MDRout(MDRout), .R2out(R2out), .Zhighout(Zhighout), .Zlowout(Zlowout),
					 .R4out(R4out), .MARin(MARin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), 
					 .IncPC(IncPC), .Read(Read), .CONTROL(CONTROL), .R5in(R5in), .R2in(R2in), .R4in(R4in), 
					 .Clock(Clock), .Mdatain(Mdatain), .Clear(Clear));
// add test logic here
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
				//T5				:	 Present_state = T6;
        endcase
    end

always @(Present_state)// do the required job ineach state
    begin
        case (Present_state) //assert the required signals in each clock cycle
            Default: begin
                PCout <= 0; Zlowout <= 0; MDRout<= 0;  //initialize the signals
                R2out <= 0; R4out <= 0; MARin <= 0; Zin <= 0;
                PCin <= 0; MDRin <= 0; IRin  <= 0; Yin <= 0;
                IncPC <= 0; Read <= 0; CONTROL <= 0;
                R5in <= 0; R2in <= 0; R4in <= 0; Mdatain <= 32'h00000000;
            end
            Reg_load1a: begin 
                Mdatain<= 32'h00000022; // loads hex 22 into MDR
                Read = 0; MDRin = 0; //the first zero is there for completeness
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRin <= 0;
            end
            Reg_load1b: begin
                #10 MDRout<= 1; R2in <= 1; // copies from MDR into R2
                #15 MDRout<= 0; R2in <= 0; // initialize R2 with the value $22
            end
            Reg_load2a: begin 
                Mdatain <= 32'h00000024; // loads hex 24 into MDR
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
				
            //**********************This is the logic for the Specific instruction we are testing**********************\\
				
            // different OPcodes can be found in the CPU_Spec file
            // Use the R formats
            // Registers in opcode are their binary -> R5 = 101

            T0: begin //see if you need to de-assertthese signals
                #10 PCout<= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
					 #15 PCout<= 0; MARin <= 0; IncPC <= 0; Zin <= 0;

					 
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
                #10 R4out<= 1; CONTROL <= 0; Zin <= 1;
					 #15 R4out<= 0; Zin <= 0;
            end
            T5: begin
                #10 Zlowout<= 1; R5in <= 1;
					 #15 Zlowout<= 0; R5in <= 0;

            end
        endcase
    end
endmodule 
