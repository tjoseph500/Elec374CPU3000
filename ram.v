module ram(Datain, Dataout, Address, Read, Write, clk);

input [31:0] Datain;
output reg [31:0] Dataout;
input [8:0] Address;
input Read, Write, clk;

reg [31:0] RAM1 [0:511];

always @(posedge clk)
begin
    if (Write)
        RAM1[Address] <= Datain;

    if (Read)
        Dataout <= RAM1[Address];
end

endmodule