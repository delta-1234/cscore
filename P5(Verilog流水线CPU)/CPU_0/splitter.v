module splitter(
    input [31:0] instr,
    output [5:0] opCode,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [5:0] func,
    output [15:0] imm,
    output [25:0] index
);
assign opCode = instr[31:26];
assign rs = instr[25:21];
assign rt = instr[20:16];
assign rd = instr[15:11];
assign func = instr[5:0];
assign imm = instr[15:0];
assign index = instr[25:0];
endmodule