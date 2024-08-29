module IM(
    input [31:0] PC,
    output [31:0] Instr
);
reg [31:0] InstrROM[0:4095];
initial begin
    $readmemh("code.txt",InstrROM);
end
wire [31:0] address;
assign address = (PC - 32'h00003000);
assign Instr = InstrROM[address[13:2]];
endmodule