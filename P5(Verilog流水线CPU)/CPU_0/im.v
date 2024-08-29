module im(
    input [31:0] PC,
    output [31:0] instr
);
reg [31:0] instrROM[0:4095];
initial begin
    $readmemh("code.txt",instrROM);
end
wire [31:0] address;
assign address = (PC - 32'h00003000);
assign instr = instrROM[address[13:2]];
endmodule