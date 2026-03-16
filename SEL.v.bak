//SEL
module SEL(IRin, Gra, Grb, Grc, Rin, Rout, BAout, Cout, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out);

input [31:0] IRin;
input Gra, Grb, Grc, Rin, Rout, BAout, Cout;
output reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
output reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;

wire [3:0] Ra;
wire [3:0] Rb;
wire [3:0] Rc;
wire [3:0] reg_sel;

assign Ra = IRin[26:23];
assign Rb = IRin[22:19];
assign Rc = IRin[18:15];

assign reg_sel = ({4{Gra}} & Ra) | ({4{Grb}} & Rb) | ({4{Grc}} & Rc);
always@(*)
begin
	R0in=0;
	R1in=0;
	R2in=0;
	R3in=0;
	R4in=0;
	R5in=0;
	R6in=0;
	R7in=0;
	R8in=0;
	R9in=0;
	R10in=0;
	R11in=0;
	R12in=0;
	R13in=0;
	R14in=0;
	R15in=0;
	R0out=0;
	R1out=0;
	R2out=0;
	R3out=0;
	R4out=0;
	R5out=0;
	R6out=0;
	R7out=0;
	R8out=0;
	R9out=0;
	R10out=0;
	R11out=0;
	R12out=0;
	R13out=0;
	R14out=0;
	R15out=0;
	if (Rin)
	begin
		if (reg_sel == 4'b0000) R0in=1;
		if (reg_sel == 4'b0001) R1in=1;
		if (reg_sel == 4'b0010) R2in=1;
		if (reg_sel == 4'b0011) R3in=1;
		if (reg_sel == 4'b0100) R4in=1;
		if (reg_sel == 4'b0101) R5in=1;
		if (reg_sel == 4'b0110) R6in=1;
		if (reg_sel == 4'b0111) R7in=1;
		if (reg_sel == 4'b1000) R8in=1;
		if (reg_sel == 4'b1001) R9in=1;
		if (reg_sel == 4'b1010) R10in=1;
		if (reg_sel == 4'b1011) R11in=1;
		if (reg_sel == 4'b1100) R12in=1;
		if (reg_sel == 4'b1101) R13in=1;
		if (reg_sel == 4'b1110) R14in=1;
		if (reg_sel == 4'b1111) R15in=1;
	end
	if (Rout | BAout)
		begin
		if (reg_sel == 4'b0000) R0out=1;
		if (reg_sel == 4'b0001) R1out=1;
		if (reg_sel == 4'b0010) R2out=1;
		if (reg_sel == 4'b0011) R3out=1;
		if (reg_sel == 4'b0100) R4out=1;
		if (reg_sel == 4'b0101) R5out=1;
		if (reg_sel == 4'b0110) R6out=1;
		if (reg_sel == 4'b0111) R7out=1;
		if (reg_sel == 4'b1000) R8out=1;
		if (reg_sel == 4'b1001) R9out=1;
		if (reg_sel == 4'b1010) R10out=1;
		if (reg_sel == 4'b1011) R11out=1;
		if (reg_sel == 4'b1100) R12out=1;
		if (reg_sel == 4'b1101) R13out=1;
		if (reg_sel == 4'b1110) R14out=1;
		if (reg_sel == 4'b1111) R15out=1;
		end
	end
endmodule