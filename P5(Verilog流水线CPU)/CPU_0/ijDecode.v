module ijDecode(
    input [5:0] opCode,
    input en,
    output ori,
    output lw,
    output sw,
    output beq,
    output lui,
    output addi,
    output j,
    output jal,
    output sb,
    output lb
);
assign ori = (en == 1'b1) ? ((opCode == 6'b001101) ? 1'b1 : 1'b0) : 1'b0;
assign lw = (en == 1'b1) ? ((opCode == 6'b100011) ? 1'b1 : 1'b0) : 1'b0;
assign sw = (en == 1'b1) ? ((opCode == 6'b101011) ? 1'b1 : 1'b0) : 1'b0;
assign beq = (en == 1'b1) ? ((opCode == 6'b000100) ? 1'b1 : 1'b0) : 1'b0;
assign lui = (en == 1'b1) ? ((opCode == 6'b001111) ? 1'b1 : 1'b0) : 1'b0;
assign addi = (en == 1'b1) ? ((opCode == 6'b001000) ? 1'b1 : 1'b0) : 1'b0;
assign j = (en == 1'b1) ? ((opCode == 6'b000010) ? 1'b1 : 1'b0) : 1'b0;
assign jal = (en == 1'b1) ? ((opCode == 6'b000011) ? 1'b1 : 1'b0) : 1'b0;
assign sb = (en == 1'b1) ? ((opCode == 6'b101000) ? 1'b1 : 1'b0) : 1'b0;
assign lb = (en == 1'b1) ? ((opCode == 6'b100000) ? 1'b1 : 1'b0) : 1'b0;
endmodule