`timescale 1ns/10ps
module control_unit(

	output reg PCout, Zhighout, Zlowout, MDRout, HIout, LOout, InPortout, Gra, Grb, Grc, Rin, Rout, BAout, Cout,
	
 	output reg HIin, LOin, MARin, Zin, Zhighin, Zlowin, PCin, MDRin, IRin, Yin, OutPortin, ConIn,
	
	output reg Read, Write, clear,
	 
	output reg ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, AND, OR, NEG, NOT, IncPC,
    
	input wire clock, reset, stop, con_ff,
	
	input wire [31:0] IR
	
	);
	 
    parameter reset_state     = 7'b0000000,
				  fetch0	  			= 7'b0000001,
              fetch1          = 7'b0000010,
              fetch2          = 7'b0000011,
              nop3          	= 7'b0000100,
              halt3          	= 7'b0000101,
				  and3          	= 7'b0000110,
				  and4          	= 7'b0000111,
				  and5		    	= 7'b0001000,
				  or3		  			= 7'b0001001,
              or4		         = 7'b0001010,
              or5		         = 7'b0001011,
              not3          	= 7'b0001100,
              not4          	= 7'b0001101,
				  neg3          	= 7'b0001110,
				  neg4          	= 7'b0001111,
				  add3		      = 7'b0010000,
				  add4	  			= 7'b0010001,
              add5 	         = 7'b0010010,
              sub3	         = 7'b0010011,
              sub4          	= 7'b0010100,
              sub5          	= 7'b0010101,
				  shr3          	= 7'b0010110,
				  shr4          	= 7'b0010111,
				  shr5		      = 7'b0011000,
				  shra3	  			= 7'b0011001,
              shra4	         = 7'b0011010,
              shra5 			   = 7'b0011011,
              shl3          	= 7'b0011100,
              shl4          	= 7'b0011101,
				  shl5          	= 7'b0011110,
				  ror3          	= 7'b0011111,
				  ror4			   = 7'b0100000,
				  ror5	  			= 7'b0100001,
              rol3	         = 7'b0100010,
              rol4	         = 7'b0100011,
              rol5          	= 7'b0100100,
              mul3          	= 7'b0100101,
				  mul4          	= 7'b0100110,
				  mul5          	= 7'b0100111,
				  mul6			   = 7'b0101000,
				  div3	  			= 7'b0101001,
              div4	         = 7'b0101010,
              div5	         = 7'b0101011,
              div6          	= 7'b0101100,
              andi3          	= 7'b0101101,
				  andi4          	= 7'b0101110,
				  andi5          	= 7'b0101111,
				  ori3 				= 7'b0110000,
				  ori4	  			= 7'b0110001,
              ori5 	         = 7'b0110010,
              addi3	         = 7'b0110011,
              addi4         	= 7'b0110100,
              addi5          	= 7'b0110101,
				  ld3          	= 7'b0110110,
				  ld4          	= 7'b0110111,
				  ld5    			= 7'b0111000,
				  ld6	  				= 7'b0111001,
              ld7		         = 7'b0111010,
              ldi3         	= 7'b0111011,
              ldi4          	= 7'b0111100,
              ldi5          	= 7'b0111101,
				  st3          	= 7'b0111110,
				  st4          	= 7'b0111111,
				  branch3     		= 7'b1000000,
				  branch4	  		= 7'b1000001,
              branch5         = 7'b1000010,
              branch6         = 7'b1000011,
              jr3          	= 7'b1000100,
              jal3          	= 7'b1000101,
				  jal4          	= 7'b1000110,
				  mfhi3          	= 7'b1000111,
				  mflo3		    	= 7'b1001000,
				  out3	  			= 7'b1001001,
              in3		         = 7'b1001010,
				  exit		      = 7'b1001011,
				  st5          	= 7'b1001100,
				  st6          	= 7'b1001101,
				  st7          	= 7'b1001110,
				  subi3          	= 7'b1001111;


	reg [6:0] present_state = reset_state;
	
always @(posedge clock, posedge reset) // finite state machine; if clock or reset rising-edge
	begin
		if (reset == 1'b1)
		begin
			present_state = reset_state;
		end
		else
		begin
			case (present_state)
			reset_state: present_state = fetch0;
			fetch0: 		present_state = fetch1;
			fetch1: 		present_state = fetch2;
			fetch2: 		begin
								case(IR[31:27])
								 5'b11010: 	present_state = nop3;
								 5'b11011: 	present_state = halt3;
								 5'b00010: 	present_state = and3;
								 5'b01010: 	present_state = andi3;
								 5'b00011: 	present_state = or3;
								 5'b01011: 	present_state = ori3;
								 5'b01110: 	present_state = neg3;
								 5'b01111: 	present_state = not3;
								 5'b00000: 	present_state = add3;
								 5'b01001: 	present_state = addi3;
								 5'b00001: 	present_state = sub3;
								 5'b11111: 	present_state = subi3;
								 5'b01101: 	present_state = mul3;
								 5'b01100: 	present_state = div3;
								 5'b00100: 	present_state = shr3;
								 5'b00101: 	present_state = shra3;
								 5'b00110: 	present_state = shl3;
								 5'b00111: 	present_state = ror3;
								 5'b01000: 	present_state = rol3;
								 5'b10000: 	present_state = ld3;
								 5'b10001: 	present_state = ldi3;
								 5'b10010: 	present_state = st3;
								 5'b10101: 	present_state = branch3;
								 5'b10100: 	present_state = jr3;
								 5'b10011: 	present_state = jal3;
								 5'b11000: 	present_state = mfhi3;
								 5'b11001: 	present_state = mflo3;
								 5'b10110: 	present_state = in3;
								 5'b10111: 	present_state = out3;
								endcase
							end

			nop3: present_state = reset_state;
			halt3: present_state = exit;
			
			// AND
			and3: present_state = and4;
			and4: present_state = and5;
			and5: present_state = reset_state;

			// OR
			or3: present_state = or4;
			or4: present_state = or5;
			or5: present_state = reset_state;

			// NOT
			not3: present_state = not4;
			not4: present_state = reset_state;

			// NEG
			neg3: present_state = neg4;
			neg4: present_state = reset_state;

			// ADD
			add3: present_state = add4;
			add4: present_state = add5;
			add5: present_state = reset_state;

			// SUB
			sub3: present_state = sub4;
			sub4: present_state = sub5;
			sub5: present_state = reset_state;

			// SHR
			shr3: present_state = shr4;
			shr4: present_state = shr5;
			shr5: present_state = reset_state;

			// SHRA
			shra3: present_state = shra4;
			shra4: present_state = shra5;
			shra5: present_state = reset_state;

			// SHL
			shl3: present_state = shl4;
			shl4: present_state = shl5;
			shl5: present_state = reset_state;

			// ROR
			ror3: present_state = ror4;
			ror4: present_state = ror5;
			ror5: present_state = reset_state;

			// ROL
			rol3: present_state = rol4;
			rol4: present_state = rol5;
			rol5: present_state = reset_state;

			// MUL
			mul3: present_state = mul4;
			mul4: present_state = mul5;
			mul5: present_state = mul6;
			mul6: present_state = reset_state;

			// DIV
			div3: present_state = div4;
			div4: present_state = div5;
			div5: present_state = div6;
			div6: present_state = reset_state;

			// ANDI
			andi3: present_state = andi4;
			andi4: present_state = andi5;
			andi5: present_state = reset_state;

			// ORI
			ori3: present_state = ori4;
			ori4: present_state = ori5;
			ori5: present_state = reset_state;

			// ADDI
			addi3: present_state = addi4;
			addi4: present_state = addi5;
			addi5: present_state = reset_state;

			// LD
			ld3: present_state = ld4;
			ld4: present_state = ld5;
			ld5: present_state = ld6;
			ld6: present_state = ld7;
			ld7: present_state = reset_state;

			// LDI
			ldi3: present_state = ldi4;
			ldi4: present_state = ldi5;
			ldi5: present_state = reset_state;

			// ST
			st3: present_state = st4;
			st4: present_state = st5;
			st5: present_state = st6;
			st6: present_state = st7;
			st7: present_state = reset_state;

			// BRANCH
			branch3: present_state = branch4;
			branch4: present_state = branch5;
			branch5: present_state = branch6;
			branch6: present_state = reset_state;

			// JR
			jr3: present_state = reset_state;

			// JAL
			jal3: present_state = jal4;
			jal4: present_state = reset_state;

			// MFHI
			mfhi3: present_state = reset_state;

			// MFLO
			mflo3: present_state = reset_state;

			// OUT
			out3: present_state = reset_state;
			endcase
		end
	end
		
	always @(present_state) // do the job for each state
	begin
		case (present_state) // assert the required signals in each state
			reset_state:
			begin
					PCout <= 0; Zhighout <= 0; Zlowout <= 0; MDRout <= 0; 
					HIout <= 0; LOout <= 0; InPortout <= 0; 
					Gra <= 0; Grb <= 0; Grc <= 0; 
					Rin <= 0; Rout <= 0; BAout <= 0; Cout <= 0;

					HIin <= 0; LOin <= 0; MARin <= 0; Zin <= 0; 
					Zhighin <= 0; Zlowin <= 0; PCin <= 0; MDRin <= 0; 
					IRin <= 0; Yin <= 0; OutPortin <= 0; ConIn <= 0;

					Read <= 0; Write <= 0;

					ADD <= 0; SUB <= 0; MUL <= 0; DIV <= 0; 
					SHR <= 0; SHRA <= 0; SHL <= 0; ROR <= 0; 
					ROL <= 0; AND <= 0; OR <= 0; NEG <= 0; 
					NOT <= 0; IncPC <= 0;

					clear <= 0;
			end
			fetch0: begin
			       PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
					 #15 PCout <= 0; IncPC <= 0; MARin<=0; Zin<=0;
			end
			fetch1: begin
                Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
					 #15 Zlowout <= 0; Read<=0; PCin <= 0; MDRin <= 0;
			end
			fetch2: begin
                MDRout <= 1; IRin <= 1;
					 #15 MDRout <= 0; IRin <= 0;
			end
			
			nop3: begin
			end
			
			halt3: begin
			end
			
			and3: begin
				Grb <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Grb <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			and4: begin
				Grc <= 1; AND <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grc <= 0; AND <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			and5: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			or3: begin
				Grb <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Grb <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			or4: begin
				Grc <= 1; OR <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grc <= 0; OR <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			or5: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			not3: begin
				Grb <= 1; NOT <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grb <= 0; NOT <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			not4: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			neg3: begin
				Grb <= 1; NEG <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grb <= 0; NEG <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			neg4: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			add3: begin
				Grb <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Grb <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			add4: begin
				Grc <= 1; ADD <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grc <= 0; ADD <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			add5: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			sub3: begin
				Grb <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Grb <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			sub4: begin
				Grc <= 1; SUB <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grc <= 0; SUB <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			sub5: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			shr3: begin
				Grb <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Grb <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			shr4: begin
				Grc <= 1; SHR <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grc <= 0; SHR <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			shr5: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			shra3: begin
				Grb <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Grb <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			shra4: begin
				Grc <= 1; SHRA <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grc <= 0; SHRA <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			shra5: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			shl3: begin
				Grb <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Grb <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			shl4: begin
				Grc <= 1; SHL <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grc <= 0; SHL <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			shl5: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			ror3: begin
				Grb <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Grb <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			ror4: begin
				Grc <= 1; ROR <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grc <= 0; ROR <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			ror5: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			rol3: begin
				Grb <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Grb <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			rol4: begin
				Grc <= 1; ROL <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grc <= 0; ROL <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			rol5: begin
				Zlowout <= 1; Gra <= 1; Rin<=1;
				#15 Zlowout <= 0; Gra <= 0; Rin<=0;
			end
			
			mul3: begin
				Gra <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Gra <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			mul4: begin
				Grb <= 1; MUL <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grb <= 0; MUL <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			mul5: begin
				Zlowout <= 1; LOin <= 1;
				#15 Zlowout <= 0; LOin <= 0;
			end
			mul6: begin
				Zhighout <= 1; HIin <= 1;
				#15 Zhighout <= 0; HIin <= 0;
			end
			
			div3: begin
				Gra <= 1; Yin <= 1; Rout<=1; BAout<=1;
				#15 Gra <= 0; Yin <= 0; Rout<=1;  BAout<=0;
			end
			div4: begin
				Grb <= 1; DIV <= 1; Zin <= 1; Rout<=1;  BAout<=1;
				#15 Grb <= 0; DIV <= 0; Zin <= 0;  Rout<=0;  BAout<=0;
			end
			div5: begin
				Zlowout <= 1; LOin <= 1;
				#15 Zlowout <= 0; LOin <= 0;
			end
			div6: begin
				Zhighout <= 1; HIin <= 1;
				#15 Zhighout <= 0; HIin <= 0;
			end
			
			andi3: begin
				 Grb <= 1; Rout <= 1; Yin<=1; BAout<=1;
				 #15 Grb <= 0; Rout <= 0; Yin<=0; BAout<=0;
			end

			andi4: begin
				 Cout <= 1; AND <= 1; Zin <= 1;
				 #15 Cout <= 0; AND <= 0; Zin<=0;
			end

			andi5: begin
				 Zlowout <= 1;  Gra<= 1; Rin<=1;
				 #15 Zlowout <= 0;  Gra<= 0; Rin<=0;
			end
			
			ori3: begin
				 Grb <= 1; Rout <= 1; Yin<=1; BAout<=1;
				 #15 Grb <= 0; Rout <= 0; Yin<=0; BAout<=0;
			end

			ori4: begin
				 Cout <= 1; OR <= 1; Zin <= 1;
				 #15 Cout <= 0; OR <= 0; Zin<=0;
			end

			ori5: begin
				 Zlowout <= 1;  Gra<= 1; Rin<=1;
				 #15 Zlowout <= 0;  Gra<= 0; Rin<=0;
			end
			
			addi3: begin
				 Grb <= 1; Rout <= 1; Yin<=1; BAout<=1;
				 #15 Grb <= 0; Rout <= 0; Yin<=0; BAout<=0;
			end

			addi4: begin
				 Cout <= 1; ADD <= 1; Zin <= 1;
				 #15 Cout <= 0; ADD <= 0; Zin<=0;
			end

			addi5: begin
				 Zlowout <= 1;  Gra<= 1; Rin<=1;
				 #15 Zlowout <= 0;  Gra<= 0; Rin<=0;
			end
			
			ld3: begin
				 Grb <= 1; Rout <= 1; Yin<=1; BAout<=1;
				 #15 Grb <= 0; Rout <= 0; Yin<=0; BAout<=0;
			end
			ld4: begin
				 Cout <= 1; ADD <= 1; Zin <= 1;
				 #15 Cout <= 0; ADD <= 0; Zin<=0;
			end
			ld5: begin
				 Zlowout <= 1; MARin <= 1;
				 #15 Zlowout <= 0; MARin <= 0;
			end
			ld6: begin
				 Read <= 1; MDRin <= 1;
				 #15 Read <= 0; MDRin <= 0;
			end
			ld7: begin
				 MDRout <= 1; Gra <= 1; Rin<=1; 
				 #15 MDRout <= 0; Gra <= 0; Rin<=0;
			end
			
			ldi3: begin
				 Grb <= 1; Rout <= 1; Yin<=1; BAout<=0;
				 #15 Grb <= 0; Rout <= 0; Yin<=0;
			end

			ldi4: begin
				 Cout <= 1; ADD <= 1; Zin <= 1;
				 #15 Cout <= 0; ADD <= 0; Zin<=0;
			end

			ldi5: begin
				 Zlowout <= 1;  Gra<= 1; Rin<= 1;
				 #15 Zlowout <= 0;  Gra<= 0; Rin<= 0;
			end
			
			st3: begin
				 Grb <= 1; Rout <= 1; Yin<=1;  BAout<=0;
				 #15 Grb <= 0; Rout <= 0; Yin<=0;  BAout<=0;
			end

			st4: begin
				 Cout <= 1; ADD <= 1; Zin <= 1;
				 #15 Cout <= 0; ADD <= 0; Zin<=0;
			end

			st5: begin
				 Zlowout <= 1;  MARin<= 1;
				 #15 Zlowout <= 0;  MARin<= 0;
			end
			
			st6: begin
				 MDRin <= 1; Gra<=1; Rout<=1; BAout <= 1;
				 #15 MDRin <= 0; Gra<=0; Rout<=0; BAout <= 0;
			end
			
			st7: begin
				 Write <= 1; MDRout<=1;
				 #15 Write <= 0; MDRout<=0;
			end
			
			branch3: begin
				 Gra <= 1; Rout <= 1; ConIn<=1; BAout <= 1;
				 #15 Gra <= 0; Rout <= 0; ConIn<=0; BAout <= 0;
			end

			branch4: begin
				 PCout <= 1; Yin <= 1;
				 #15 PCout <= 0; Yin <= 0;
			end

			branch5: begin
				 Cout <= 1;  ADD<= 1; Zin<=1;
				 #15 Cout <= 0;  ADD<= 0; Zin<=0;
			end
			
			branch6: begin
				 Zlowout <= 1; PCin <= con_ff;
				 #15 Zlowout <= 0; PCin<=0;
			end
		
			jr3: begin
				 Gra <= 1; Rout <= 1; PCin<=1;
				 #15 Gra <= 0; Rout <= 0; PCin<=0;
			end
			
			jal3: begin
				 PCout <= 1; Grb <= 1; Rin <= 1;
				 #15 PCout <= 0; Grb <= 0; Rin <= 0;
			end

			jal4: begin
				 Gra <= 1; Rout <= 1; PCin<=1;
				 #15 Gra <= 0; Rout <= 0; PCin<=0;
			end
			
			mfhi3: begin
				 HIout <= 1; Gra <= 1; Rin <= 1;
				 #15 HIout <= 0; Gra <= 0; Rin <= 0;
			end
			
			mflo3: begin
				 LOout <= 1; Gra <= 1; Rin <= 1;
				 #15 LOout <= 0; Gra <= 0; Rin <= 0;
			end
			
			out3: begin
				 OutPortin <= 1; Gra <= 1; Rout <= 1; BAout <= 1;
				 #15 OutPortin <= 0; Gra <= 0; Rout <= 0; BAout <= 0;
         end
			
			in3: begin
				 InPortout <= 1; Gra <= 1; Rout <= 1; BAout <= 1;
				 #15 InPortout <= 0; Gra <= 0; Rout <= 0;  BAout <= 0;
         end
		endcase
	end

endmodule 