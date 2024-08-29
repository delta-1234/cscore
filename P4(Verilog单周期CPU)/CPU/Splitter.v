module Splitter(
    input [31:0] Instr,
    output [5:0] Opcode,
    output [4:0] Rs,
    output [4:0] Rt,
    output [4:0] Rd,
    output [4:0] S,
    output [5:0] Func,
    output [15:0] Imm
);
assign Opcode = Instr[31:26];
assign Rs = Instr[25:21];
assign Rt = Instr[20:16];
assign Rd = Instr[15:11];
assign S = Instr[10:6];
assign Func = Instr[5:0];
assign Imm = Instr[15:0];
endmodule