`include "rDecode.v"
`include "ijDecode.v"
`include "orLogic.v"
module controller(
    input [5:0] opCode,
    input [5:0] func,
    output RegDst,//为1时写入寄存器为rd
    output ALUSrc,//为1时将立即数送至ALU
    output MemtoReg,//为1时将内存写入寄存器
    output RegWrite,//为1时需要写GRF
    output MemWrite,//为1时需要写dm
    output Branch,//为1时beq跳转
    output JEn,//为1时j跳转
    output ExtOp,//为1时对imm进行有符号扩展
    output [3:0] ALUOp,//ALU功能选择
    output Jal,//jal跳转
    output Jr,//jr跳转
    output Byte,//为1时按字节存储
    output [1:0] rsTuse,
    output [1:0] rtTuse,
    output [1:0] Tnew
);
wire add,sub,sllv,slt,jr;
wire ori,lw,sw,beq,lui,addi,j,jal,sb,lb;
wire en;
assign en = (opCode == 6'b0) ? 1'b1 : 1'b0;
rDecode RDecode(func,en,add,sub,sllv,slt,jr);
ijDecode IJDecode(opCode,~en,ori,lw,sw,beq,lui,addi,j,jal,sb,lb);
orLogic OR(add,sub,beq,ori,lui,lw,sw,addi,sllv,slt,j,jal,jr,sb,lb,RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,Branch,JEn,ExtOp,ALUOp,Jal,Jr,Byte);
assign rsTuse = (j|jal) ? 2'bxx : (add|sub|sllv|slt|ori|lui|addi|lw|sw|lb|sb);
assign rtTuse = (ori|lui|addi|lw|lb|jr|j|jal) ? 2'bxx : (add|sub|sllv|slt) + sw + sw + sb + sb;
//assign rtTuse = (add|sub|sllv|slt) + sw + sw + sb + sb;
assign Tnew = (add|sub|sllv|slt|ori|lui|addi) + lw + lw + lb + lb;
endmodule