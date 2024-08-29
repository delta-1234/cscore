`include "RDecode.v"
`include "IJDecode.v"
`include "OrLogic.v"
`default_nettype none
module Controller(
    input [5:0] OpCode,
    input [5:0] Func,
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
wire add,sub,sll,sllv,slt,jr;
wire ori,lw,sw,beq,lui,addi,j,jal,sb,lb;
wire En;
assign En = (OpCode == 6'b0) ? 1'b1 : 1'b0;
RDecode rdwcode(Func,En,add,sub,sll,sllv,slt,jr);
IJDecode ijdecode(OpCode,~En,ori,lw,sw,beq,lui,addi,j,jal,sb,lb);
OrLogic OR(add,sub,beq,ori,lui,lw,sw,addi,sll,sllv,slt,j,jal,jr,sb,lb,RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,Branch,JEn,SllEn,ExtOp,ALUCtr,Jal,Jr,Byte);

endmodule