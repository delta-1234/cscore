module ALU(
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [3:0] ALUOp,
    output [31:0] ALUResult
);
assign ALUResult = (ALUOp == 4'b0000) ? SrcA & SrcB :
                   (ALUOp == 4'b0001) ? SrcA | SrcB :
                   (ALUOp == 4'b0010) ? SrcA + SrcB :
                   (ALUOp == 4'b0011) ? ~SrcA & SrcB :
                   (ALUOp == 4'b0100) ? SrcA & ~SrcB :
                   (ALUOp == 4'b0101) ? {SrcB[15:0],SrcA[15:0]} :
                   (ALUOp == 4'b0110) ? SrcA - SrcB :
                   (ALUOp == 4'b0111) ? ((SrcA == SrcB)?32'b1:32'b0) :
                   (ALUOp == 4'b1000) ? SrcB >> SrcA :
                   (ALUOp == 4'b1001) ? (($signed(SrcA) < $signed(SrcB))?32'b1:32'b0) :
                   (ALUOp == 4'b1010) ? (($signed(SrcA) > $signed(SrcB))?32'b1:32'b0) :
                   (ALUOp == 4'b1011) ? SrcB << SrcA : 32'b0;
endmodule