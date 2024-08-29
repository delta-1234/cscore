module OrLogic(
    input add,
    input sub,
    input beq,
    input ori,
    input lui,
    input lw,
    input sw,
    input addi,
    input sll,
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
    output SllEn,
    output ExtOp,
    output [3:0] ALUCtr,
    output Jal,
    output Jr,
    output Byte
);
or or1(RegDst,add,sub,sll,sllv,slt);
or or2(ALUSrc,lb,ori,lui,lw,sw,addi,sb);
or or3(MemtoReg,lw,lb);
or or4(RegWrite,lb,addi,sllv,add,sub,sll,ori,lui,lw,slt,jal);
or or5(MemWrite,sw,sb);
or or6(Branch,beq);
or or7(JEn,j,jal);
or or8(SllEn,sll);
or or9(ExtOp,lw,sw,addi,sb,lb,beq);
or or10(Jal,jal);
or or11(Jr,jr);
or or12(Byte,sb,lb);
assign ALUCtr = (add == 1'b1) ? 4'b0010 :
                (sub == 1'b1) ? 4'b0110 :
                (beq == 1'b1) ? 4'b0111 :
                (ori == 1'b1) ? 4'b0001 :
                (lui == 1'b1) ? 4'b0101 :
                (lw == 1'b1) ? 4'b0010 :
                (sw == 1'b1) ? 4'b0010 :
                (addi == 1'b1) ? 4'b0010 :
                (sll == 1'b1) ? 4'b1011 :
                (sllv == 1'b1) ? 4'b1011 :
                (slt == 1'b1) ? 4'b1001 :
                (sb == 1'b1) ? 4'b0010 :
                (lb == 1'b1) ? 4'b0010 :
                4'bxxxx;
endmodule