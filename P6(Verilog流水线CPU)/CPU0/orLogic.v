`include "constant.v"
module orLogic(
    input add,
    input sub,
    input beq,
    input ori,
    input lui,
    input lw,
    input sw,
    input addi,
    input sllv,
    input slt,
    input j,
    input jal,
    input jr,
    input sb,
    input lb,
    input andR,
    input orR,
    input sltu,
    input andi,
    input sh,
    input lh,
    input bne,
    input mult,
    input multu,
    input div,
    input divu,
    input mfhi,
    input mflo,
    input mthi,
    input mtlo,
    output RegDst,
    output ALUSrc,
    output MemtoReg,
    output RegWrite,
    output MemWrite,
    output BeqEn,
    output BneEn,
    output JEn,
    output ExtOp,
    output [3:0] ALUOp,
    output Jal,
    output Jr,
    output Byte,
    output Half,
    output Start,
    output LOWrite,
    output HIWrite,
    output LORead,
    output HIRead
);
or or1(RegDst,add,sub,sllv,slt,andR,orR,sltu,mfhi,mflo);
or or2(ALUSrc,lb,ori,lui,lw,sw,addi,sb,andi,sh,lh);
or or3(MemtoReg,lw,lb,lh);
or or4(RegWrite,lb,addi,sllv,add,sub,ori,lui,lw,slt,jal,
andR,orR,sltu,andi,lh,mfhi,mflo);
or or5(MemWrite,sw,sb,sh);
or or6(BeqEn,beq);
or or7(BneEn,bne);
or or8(JEn,j,jal);
or or9(ExtOp,lw,sw,addi,sb,lb,beq,sh,lh,bne);
or or10(Jal,jal);
or or11(Jr,jr);
or or12(Byte,sb,lb);
or or13(Half,sh,lh);
or or14(Start,mult,multu,div,divu);
or or15(LOWrite,mtlo);
or or16(HIWrite,mthi);
or or17(LORead,mflo);
or or18(HIRead,mfhi);

assign ALUOp = (add == 1'b1) ? `aluAdd :
                (sub == 1'b1) ? `aluSub :
                (beq == 1'b1) ? `aluBeq :
                (ori == 1'b1) ? `aluOr :
                (lui == 1'b1) ? `aluLui :
                (lw == 1'b1) ? `aluAdd :
                (sw == 1'b1) ? `aluAdd :
                (addi == 1'b1) ? `aluAdd :
                (sllv == 1'b1) ? `aluSll :
                (slt == 1'b1) ? `aluLess :
                (sb == 1'b1) ? `aluAdd :
                (lb == 1'b1) ? `aluAdd :
                (andR == 1'b1) ? `aluAnd :
                (orR == 1'b1) ? `aluOr :
                (sltu == 1'b1) ? `aluLessU :
                (andi == 1'b1) ? `aluAnd :
                (sh == 1'b1) ? `aluAdd :
                (lh == 1'b1) ? `aluAdd :
                (mult == 1'b1) ? `aluMult :
                (multu == 1'b1) ? `aluMultU :
                (div == 1'b1) ? `aluDiv :
                (divu == 1'b1) ? `aluDivU :
                4'bxxxx;
endmodule