module ram(Data, Address, Read, Write, clk);

inout [31:0] Data;
input [8:0] Address;
input Read, Write, clk;

reg [31:0] RAM1 [0:511];
reg [31:0] data_out;

assign Data = (Read) ? data_out : 32'bz;

always @(posedge clk)
begin
    if (Write)
        RAM1[Address] <= Data;

    if (Read)
        data_out <= RAM1[Address];
end

endmodule
