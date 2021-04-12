`timescale 1ns /10 ps

 module Lab3;

 reg Clock , Reset , Stop ;

 parameter Default = 4'b0000 , T0 = 4' b0001 ;

 reg [3:0] Present_state = Default ;

 datapath DUT (. Clock ( Clock ), . Reset ( Reset ), . Stop ( Stop ));

 initial begin
 Clock = 0;
 forever #10 Clock = ~ Clock ;
 end

	 always @(posedge Clock) // finite state machine, executes on the clock's rising edge
		begin
			 case (Present_state)
				Default : Present_state = T0;
			 endcase
		end

 
	 always @(Present_state)
	 begin
		case (Present_state) 
			Default	:	begin
								Clock <= 0; Reset <= 0; Stop <= 0;
							end
		endcase
	 end
endmodule