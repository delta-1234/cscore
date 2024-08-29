module IJDecode(
    input [5:0] OpCode,
    input En,
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
assign ori = (En == 1'b1) ? ((OpCode == 6'b001101) ? 1'b1 : 1'b0) : 1'b0;
assign lw = (En == 1'b1) ? ((OpCode == 6'b100011) ? 1'b1 : 1'b0) : 1'b0;
assign sw = (En == 1'b1) ? ((OpCode == 6'b101011) ? 1'b1 : 1'b0) : 1'b0;
assign beq = (En == 1'b1) ? ((OpCode == 6'b000100) ? 1'b1 : 1'b0) : 1'b0;
assign lui = (En == 1'b1) ? ((OpCode == 6'b001111) ? 1'b1 : 1'b0) : 1'b0;
assign addi = (En == 1'b1) ? ((OpCode == 6'b001000) ? 1'b1 : 1'b0) : 1'b0;
assign j = (En == 1'b1) ? ((OpCode == 6'b000010) ? 1'b1 : 1'b0) : 1'b0;
assign jal = (En == 1'b1) ? ((OpCode == 6'b000011) ? 1'b1 : 1'b0) : 1'b0;
assign sb = (En == 1'b1) ? ((OpCode == 6'b101000) ? 1'b1 : 1'b0) : 1'b0;
assign lb = (En == 1'b1) ? ((OpCode == 6'b100000) ? 1'b1 : 1'b0) : 1'b0;
endmodule