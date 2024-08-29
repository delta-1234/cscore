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
    output RegDst,
    output ALUSrc,
    output MemtoReg,
    output RegWrite,
    output MemWrite,
    output Branch,
    output JEn,
    output ExtOp,
    output [3:0] ALUOp,
    output Jal,
    output Jr,
    output Byte
);
or or1(RegDst,add,sub,sllv,slt);
or or2(ALUSrc,lb,ori,lui,lw,sw,addi,sb);
or or3(MemtoReg,lw,lb);
or or4(RegWrite,lb,addi,sllv,add,sub,ori,lui,lw,slt,jal);
or or5(MemWrite,sw,sb);
or or6(Branch,beq);
or or7(JEn,j,jal);
or or9(ExtOp,lw,sw,addi,sb,lb,beq);
or or10(Jal,jal);
or or11(Jr,jr);
or or12(Byte,sb,lb);
assign ALUOp = (add == 1'b1) ? `aluAdd :
                (sub == 1'b1) ? `aluSub :
                (beq == 1'b1) ? `aluBeq :
                (ori == 1'b1) ? `aluOr :
                (lui == 1'b1) ? `aluLui :
                (lw == 1'b1) ? `aluAdd :
                (sw == 1'b1) ? `aluAdd :
                (addi == 1'b1) ? `aluAdd :
                (sllv == 1'b1) ? `aluSll :
                (slt == 1'b1) ? 4'b1001 :
                (sb == 1'b1) ? `aluAdd :
                (lb == 1'b1) ? `aluAdd :
                4'bxxxx;
endmodule