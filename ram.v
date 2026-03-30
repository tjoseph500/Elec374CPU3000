module ram(Datain, Dataout, Address, Read, Write, clk);

input [31:0] Datain;
output reg [31:0] Dataout;
input [8:0] Address;
input Read, Write, clk;

reg [31:0] RAM1 [0:511];

integer i;

initial begin
    for (i = 0; i < 512; i = i + 1)
	 begin
        RAM1[i] = 32'd0;
    end
end

always @(posedge clk)
begin
    if (Write)
        RAM1[Address] <= Datain;

    if (Read)
        Dataout <= RAM1[Address];
	 else if (Read==0)
		Dataout <= 32'hzzzzzzzz;
end

endmodule