module control_unit(

output reg Gra,Grb, Grc, Rin, Rout, BAout, Cout, Zloout, Zhighout// here, you will define the inputs and outputs to your Control Unit
Yin, Zin,PCout, IncPC, MARin,Read, Write, Clear, ADD, AND, SHR,

input[31:0] IR, 
input Clock, Reset, Stop, Con_FF);           

parameter Initialize_Reset = -1 , Reset_state = 0 , fetch0 = 1 , fetch1 = 2 , fetch2 = 3 , // basic
 // add
 add3 = 4 , add4 = 5 , add5 = 6 ,
 // sub
 sub3 = 7 , sub4 = 8 , sub5 = 9 ,
 // shr
 shr3 = 10 , shr4 = 11 , shr5 = 12 ,
 // shl
 shl3 = 13 , shl4 = 14 , shl5 = 15 ,
 // ror
 ror3 = 16 , ror4 = 17 , ror5 = 18 ,
 // rol
 rol3 = 19 , rol4 = 20 , rol5 = 21 ,
 // and
 and3 = 22 , and4 = 23 , and5 = 24 ,
 // or
 or3 = 25 , or4 = 26 , or5 = 27 ,
 // addi
addi3 = 28 , addi4 = 29 , addi5 = 30 ,
 // andi
 andi3 = 31 , andi4 = 32 , andi5 = 33 ,
 // ori
 ori3 = 34 , ori4 = 35 , ori5 = 36 ,
 // mul
 mul3 = 37 , mul4 = 38 , mul5 = 39 , mul6 = 40 ,
 // div
 div3 = 41 , div4 = 42 , div5 = 43 , div6 = 44 ,
 // neg
neg3 = 45 , neg4 = 46 ,
 // not
 not3 = 47 , not4 = 48 ,
 // ld
 ld3 = 49 , ld4 = 50 , ld5 = 51 , ld6 = 52 , ld7 = 53 ,
 // ldi
 ldi3 = 54 , ldi4 = 55 , ldi5 = 56 ,
 // st
 st3 = 57 , st4 = 58 , st5 = 59 , st6 = 60 , st7 = 61 ,
 // bracnh
 branch3 = 62 , branch4 = 63 , branch5 = 64 , branch6 = 65 ,
 // jr
 jr3 = 76 ,
 // jal
 jal3 = 77 , jal4 = 78 ,
 // in
 in3 = 79 ,
 // out
 out3 = 80 ,
 // mfhi
 mfhi3 = 81 ,
 // mflo
 mflo3 = 82 ,
 // nop
 nop3 = 83 ,
 // halt
 halt3 = 84;

 integer Present_state = Reset_state ; 

 always@ ( posedge Clock , posedge Reset , posedge Stop )
 	begin
 		if( Reset ) Present_state = #50 Initialize_Reset ;
 		if( Stop ) Present_state = halt3 ; 
 		else case ( Present_state )
			Initialize_Reset : #40 Present_state = Reset_state ;
			Reset_state : #50 Present_state = fetch0 ;
			fetch0 : #50 Present_state = fetch1 ;
			fetch1 : #50 Present_state = fetch2 ;
			fetch2 : #50 begin
				case (IR [31:27]) 
				5 ' b00000 : Present_state = ld3;
				5 ' b00001 : Present_state = ldi3;
				5 ' b00010 : Present_state = st3;
				5 ' b00011 : Present_state = add3;
				5 ' b00100 : Present_state = sub3;
				5 ' b00101 : Present_state = shr3;
				5 ' b00110 : Present_state = shl3;
				5 ' b00111 : Present_state = ror3;
				5 ' b01000 : Present_state = rol3;
				5 ' b01001 : Present_state = and3;
				5 ' b01010 : Present_state = or3; 
				5 ' b01011 : Present_state = addi3 ;
				5 ' b01100 : Present_state = andi3 ;
				5 ' b01101 : Present_state = ori3; 
				5 ' b01110 : Present_state = mul3; 
				5 ' b01111 : Present_state = div3; 
				5 ' b10000 : Present_state = neg3; 
				5 ' b10001 : Present_state = not3; 
				5 ' b10010 : Present_state =branch3; 
				5 ' b10011 : Present_state = jr3;
				5 ' b10100 : Present_state = jal3; 
				5 ' b10101 : Present_state = in3;
				5 ' b10110 : Present_state = out3; 
				5 ' b10111 : Present_state =mfhi3; 
				5 ' b11000 : Present_state =mflo3; 
				5 ' b11001 : Present_state = nop3; 
				5 ' b11010 : Present_state = halt3; 
				default : begin end
 			endcase
 		end
		add3 : #50 Present_state = add4 ;
		add4 : #50 Present_state = add5 ;
		add5 : #50 Present_state = fetch0 ;
		sub3 : #50 Present_state = sub4 ;
		sub4 : #50 Present_state = sub5 ;
		sub5 : #50 Present_state = fetch0 ;
		shr3 : #50 Present_state = shr4 ;
		shr4 : #50 Present_state = shr5 ;
		shr5 : #50 Present_state = fetch0 ;
		shl3 : #50 Present_state = shl4 ;
		shl4 : #50 Present_state = shl5 ;
		shl5 : #50 Present_state = fetch0 ;
		ror3 : #50 Present_state = ror4 ;
		ror4 : #50 Present_state = ror5 ;
		ror5 : #50 Present_state = fetch0 ;
		rol3 : #50 Present_state = rol4 ;
		rol4 : #50 Present_state = rol5 ;
		rol5 : #50 Present_state = fetch0 ;
		and3 : #50 Present_state = and4 ;
		and4 : #50 Present_state = and5 ;
		and5 : #50 Present_state = fetch0 ;
		or3 : #50 Present_state = or4 ;
		or4 : #50 Present_state = or5 ;
		or5 : #50 Present_state = fetch0 ;
		addi3 : #50 Present_state = addi4 ;
		addi4 : #50 Present_state = addi5 ;
		addi5 : #50 Present_state = fetch0 ;
		andi3 : #50 Present_state = andi4 ;
		andi4 : #50 Present_state = andi5 ;
		andi5 : #50 Present_state = fetch0 ;
		ori3 : #50 Present_state = ori4 ;
		ori4 : #50 Present_state = ori5 ;
		ori5 : #50 Present_state = fetch0 ;
		mul3 : #50 Present_state = mul4 ;
		mul4 : #50 Present_state = mul5 ;
		mul5 : #50 Present_state = mul6 ;
		mul6 : #50 Present_state = fetch0 ;
		div3 : #50 Present_state = div4 ;
		div4 : #50 Present_state = div5 ;
		div5 : #50 Present_state = div6 ;
		div6 : #50 Present_state = fetch0 ;
		neg3 : #50 Present_state = neg4 ;
		neg4 : #50 Present_state = fetch0 ;
		not3 : #50 Present_state = not4 ;
		not4 : #50 Present_state = fetch0 ;
		ld3 : #50 Present_state = ld4 ;
		ld4 : #50 Present_state = ld5 ;
		ld5 : #50 Present_state = ld6 ;
		ld6 : #50 Present_state = ld7 ;
		ld7 : #50 Present_state = fetch0 ;
		ldi3 : #50 Present_state = ldi4 ;
		ldi4 : #50 Present_state = ldi5 ;
		ldi5 : #50 Present_state = fetch0 ;
		st3 : #50 Present_state = st4 ;
		st4 : #50 Present_state = st5 ;
		st5 : #50 Present_state = st6 ;
		st6 : #50 Present_state = st7 ;
		st7 : #50 Present_state = fetch0 ;
		branch3 : #50 Present_state = branch4 ;
		branch4 : #50 Present_state = branch5 ;
		branch5 : #50 Present_state = branch6 ;
		branch6 : #50 Present_state = fetch0 ;
		jr3 : #50 Present_state = fetch0 ;
		jal3 : #50 Present_state = jal4 ;
		jal4 : #50 Present_state = fetch0 ;
		in3 : #50 Present_state = fetch0 ;
		out3 : #50 Present_state = fetch0 ;
		mfhi3 : #50 Present_state = fetch0 ;
		mflo3 : #50 Present_state = fetch0 ;
		nop3 : #50 Present_state = fetch0 ;
 		default : begin end
	endcase
end

always@ ( Present_state ) 
begin
	 case ( Present_state ) 
	Initialize_Reset : Clear <= 0;
	Reset_state : begin
		#10 Clear <= 0;
		#15 Clear <= 1;
		PCout <= 0; Zlowout <= 0; Zhighout <= 0;
		MDRout <= 0; // initialize the signals
		MARin <= 0; Zlowin <= 0; Zhighin <= 0;
		PCin <= 0; MDRin <= 0; IRin <= 0; Yin <= 0;
		IncPC <= 0; Read <= 0; Write <= 0;
		highin <= 0; lowin <= 0;
		Cout <= 0; outPortIn <= 0; inPortOut <= 0;
		con_in <= 0;
		highout <= 0; lowout <= 0;
		ADD <= 0; SUB <= 0; SHR <= 0; SHL <= 0; ROR
		<= 0; ROL <= 0; AND <= 0; OR <= 0;
		MUL <= 0; DIV <= 0; NEG <= 0; NOT <= 0;
		BAout <= 0; Rin <= 0; Rout <= 0; Gra <= 0;
		Grb <= 0; Grc <= 0;
		R15_enable <= 0; PC_enable <= 0;
		Run <= 1; 
		end
	fetch0 : begin
		#10 PCout <= 1; MARin <= 1; IncPC <= 1;
		Zlowin <= 1;
		#15 PCout <= 0; MARin <= 0; IncPC <= 0;
		Zlowin <= 0;
		end
	fetch1 : begin
		#10 Zlowout <= 1; PCin <= 1; Read <= 1; MDRin<= 1;
		#15 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin<= 0;
		end
	fetch2 : begin
		#10 MDRout <= 1; IRin <= 1;
		#15 MDRout <= 0; IRin <= 0;
		end
	add3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	add4 : begin 
		#10 Grc <= 1; Rout <= 1; Zlowin <= 1; ADD <=1;
		#15 Grc <= 0; Rout <= 0; Zlowin <= 0; ADD <=0;
		end
	add5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	sub3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	sub4 : begin 
		#10 Grc <= 1; Rout <= 1; Zlowin <= 1; SUB <=1;
		#15 Grc <= 0; Rout <= 0; Zlowin <= 0; SUB <=0;
		end
	sub5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	shr3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	shr4 : begin 
		#10 Grc <= 1; Rout <= 1; Zlowin <= 1; SHR <=1;
		#15 Grc <= 0; Rout <= 0; Zlowin <= 0; SHR <=0;
		end
	shr5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	shl3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	shl4 : begin 
		#10 Grc <= 1; Rout <= 1; Zlowin <= 1; SHL <=1;
		#15 Grc <= 0; Rout <= 0; Zlowin <= 0; SHL <=0;
		end
	shl5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	ror3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	ror4 : begin 
		#10 Grc <= 1; Rout <= 1; ROR <= 1; Zlowin <=1;
		#15 Grc <= 0; Rout <= 0; ROR <= 0; Zlowin <=0;
		end
	ror5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	rol3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	rol4 : begin 
		#10 Grc <= 1; Rout <= 1; ROL <= 1; Zlowin <=1;
		#15 Grc <= 0; Rout <= 0; ROL <= 0; Zlowin <=0;
		end
	rol5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	and3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	and4 : begin 
		#10 Grc <= 1; Rout <= 1; AND <= 1; Zlowin <=1;
		#15 Grc <= 0; Rout <= 0; AND <= 0; Zlowin <=0;
		end
	and5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	or3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	or4 : begin 
		#10 Grc <= 1; Rout <= 1; OR <= 1; Zlowin <=1;
		#15 Grc <= 0; Rout <= 0; OR <= 0; Zlowin <=0;
		end
	or5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	addi3 : begin
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	addi4 : begin
		#10 Cout <= 1; Zlowin <= 1; ADD <= 1;
		#15 Cout <= 0; Zlowin <= 0; ADD <= 0;
		end
	addi5 : begin
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#20 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	andi3 : begin
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	andi4 : begin
		#10 Cout <= 1; Zlowin <= 1; AND <= 1;
		#15 Cout <= 0; Zlowin <= 0; AND <= 0;
		end
	andi5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#20 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	ori3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	ori4 : begin 
		#10 Cout <= 1; Zlowin <= 1; OR <= 1;
		#15 Cout <= 0; Zlowin <= 0; OR <= 0;
		end
	ori5 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#20 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	mul3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
	mul4 : begin 
		#10 Gra <= 1; Rout <= 1; MUL <= 1; Zlowin <=1; Zhighin <= 1;
		#35 Gra <= 0; Rout <= 0; MUL <= 0; Zlowin <=0; Zhighin <= 0;
		end
	mul5 : begin 
		#10 Zlowout <= 1; lowin <= 1;
		#15 Zlowout <= 0; lowin <= 0;
		end
	mul6 : begin 
		#10 Zhighout <= 1; highin <= 1;
		#15 Zhighout <= 0; highin <= 0;
		end
	div3 : begin 
		#10 Gra <= 1; Rout <= 1; Yin <= 1;
		#15 Gra <= 0; Rout <= 0; Yin <= 0;
		end
	div4 : begin 
		#10 Grb <= 1; Rout <= 1; DIV <= 1; Zlowin <=1; Zhighin <= 1;
		#35 Grb <= 0; Rout <= 0; DIV <= 0; Zlowin <=0; Zhighin <= 0;
		end
	div5 : begin 
		#10 Zlowout <= 1; lowin <= 1;
		#15 Zlowout <= 0; lowin <= 0;
		end
	div6 : begin 
		#10 Zhighout <= 1; highin <= 1;
		#15 Zhighout <= 0; highin <= 0;
		end
	neg3 : begin 
		#10 Grb <= 1; Rout <= 1; Zlowin <= 1; NEG <=1;
		#15 Grb <= 0; Rout <= 0; Zlowin <= 0; NEG <=0;
		end
	neg4 : begin 
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#20 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	not3 : begin 
		#10 Grb <= 1; Rout <= 1; Zlowin <= 1; NOT <=1;
		#15 Grb <= 0; Rout <= 0; Zlowin <= 0; NOT <=0;
		end
	not4 : begin
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#20 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	ld3 : begin 
		#10 Grb <= 1; BAout <= 1; Yin <= 1;
		#15 Grb <= 0; BAout <= 0; Yin <= 0;
		end
	ld4 : begin 
		#10 Cout <= 1; Zlowin <= 1; ADD <= 1;
		#15 Cout <= 0; Zlowin <= 0; ADD <= 0;
		end
	ld5 : begin 
		#10 Zlowout <= 1; MARin <= 1;
		#15 Zlowout <= 0; MARin <= 0;
		end
	ld6 : begin 
		#10 Read <= 1; MDRin <= 1;
		#15 Read <= 0; MDRin <= 0;
		end
	ld7 : begin 
		#10 MDRout <= 1; Gra <= 1; Rin <= 1;
		#15 MDRout <= 0; Gra <= 0; Rin <= 0;
		end
	ldi3 : begin
		#10 Grb <= 1; BAout <= 1; Yin <= 1;
		#15 Grb <= 0; BAout <= 0; Yin <= 0;
		end
	ldi4 : begin
		#10 Cout <= 1; Zlowin <= 1; ADD <= 1;
		#15 Cout <= 0; Zlowin <= 0; ADD <= 0;
		end
	ldi5 : begin
		#10 Zlowout <= 1; Gra <= 1; Rin <= 1;
		#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
	st3 : begin 
		#10 Grb <= 1; Rout <= 1; Yin <= 1; BAout <=1;
		#15 Grb <= 0; Rout <= 0; Yin <= 0; BAout <=0;
		end
	st4 : begin 
		#10 Cout <= 1; Zlowin <= 1; ADD <= 1;
		#15 Cout <= 0; Zlowin <= 0; ADD <= 0;
		end
	st5 : begin 
		#10 Zlowout <= 1; MARin <= 1;
		#15 Zlowout <= 0; MARin <= 0;
		end
	st6 : begin 
		#10 Gra <= 1; Rout <= 1; MDRin <= 1;
		#15 Gra <= 0; Rout <= 0; MDRin <= 0;
		end
	st7 : begin 
		#10 MDRout <= 1; Write <= 1;
		#15 MDRout <= 0; Write <= 0;
		end
	branch3 : begin 
		#10 Gra <= 1; Rout <= 1; con_in <= 1;
		#15 Gra <= 0; Rout <= 0; con_in <= 0;
		end
	branch4 : begin 
		#10 PCout <= 1; Yin <= 1;
		#10 PCout <= 0; Yin <= 0;
		end
	branch5 : begin 
		#10 Cout <= 1; Zlowin <= 1; ADD <= 1;
		#15 Cout <= 0; Zlowin <= 0; ADD <= 0;
		end
	branch6 : begin 
		if ( Con_FF ) begin
			#10 Zlowout <= 1; PC_enable <= 1; 
			#15 Zlowout <= 0; PC_enable <= 0;
			end
		end
	jr3 : begin
		#10 Gra <= 1; Rout <= 1; PCin <= 1;
		#15 Gra <= 0; Rout <= 0; PCin <= 0;
		end
	jal3 : begin 
		#10 R15_enable <= 1; PCout <= 1;
		#15 R15_enable <= 0; PCout <= 0;
		end
	jal4 : begin 
		#10 Gra <= 1; Rout <= 1; PCin <= 1;
		#15 Gra <= 0; Rout <= 0; PCin <= 0;
		end
	in3 : begin 
		#10 Gra <= 1; Rin <= 1; inPortOut <= 1;
		#15 Gra <= 0; Rin <= 0; inPortOut <= 0;
		end
	out3 : begin 
		#10 Gra <= 1; Rout <= 1; outPortIn <= 1;
		#15 Gra <= 0; Rout <= 0; outPortIn <= 0;
		end
	mfhi3 : begin 
		#10 Gra <= 1; Rin <= 1; highout <= 1;
		#15 Gra <= 0; Rin <= 0; highout <= 0;
		end
	mflo3 : begin
		#10 Gra <= 1; Rin <= 1; lowout <= 1;
		#15 Gra <= 0; Rin <= 0; lowout <= 0;
		end
	nop3 : begin end // nothing
	halt3 : Run <= 0; // no Run 
 			default : begin end
 		endcase
	end
 endmodule 
