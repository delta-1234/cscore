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
    output BeqEn,//为1时beq跳转
    output BneEn,//为1时bne跳转
    output JEn,//为1时j跳转
    output ExtOp,//为1时对imm进行有符号扩展
    output [3:0] ALUOp,//ALU功能选择
    output Jal,//jal跳转
    output Jr,//jr跳转
    output Byte,//为1时按字节存储
    output Half,//为1时按半字存储
    output Start,//启动乘除法器信号
    output LOWrite,//写LO寄存器
    output HIWrite,//写HI寄存器
    output LORead,//读LO寄存器
    output HIRead,//读HI寄存器
    output [1:0] rsTuse,//计算当前指令的rsTuse
    output [1:0] rtTuse,
    output [1:0] Tnew//计算当前指令的Tnew作为初始值传给ID/EX级
);
wire add,sub,sllv,slt,jr,andR,orR,sltu;
wire ori,lw,sw,beq,lui,addi,j,jal,sb,lb,andi,sh,lh,bne;
wire mult,multu,div,divu,mfhi,mflo,mthi,mtlo;
wire en;
assign en = (opCode == 6'b0) ? 1'b1 : 1'b0;
rDecode RDecode(func,en,add,sub,sllv,slt,jr,andR,orR,sltu,
mult,multu,div,divu,mfhi,mflo,mthi,mtlo);
ijDecode IJDecode(opCode,~en,ori,lw,sw,beq,lui,addi,j,jal,sb,lb,andi,sh,lh,bne);
orLogic OR(add,sub,beq,ori,lui,lw,sw,addi,sllv,slt,j,jal,jr,sb,lb,andR,orR,sltu,andi,sh,lh,bne,
mult,multu,div,divu,mfhi,mflo,mthi,mtlo,
RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,BeqEn,BneEn,JEn,ExtOp,ALUOp,Jal,Jr,Byte,Half,
Start,LOWrite,HIWrite,LORead,HIRead);

assign rsTuse = (j|jal|mfhi|mflo) ? 2'bxx : 
(add|sub|sllv|slt|ori|lui|addi|lw|sw|lb|sb|andR|orR|sltu|andi|sh|lh|
mult|multu|div|divu|mthi|mtlo);

assign rtTuse = (ori|lui|addi|lw|lb|jr|j|jal|andi|lh|mthi|mtlo|mthi|mtlo) ? 2'bxx : 
(add|sub|sllv|slt|andR|orR|sltu|mult|multu|div|divu) + sw + sw + sb + sb + sh + sh;

assign Tnew = (add|sub|sllv|slt|ori|lui|addi|andR|orR|sltu|andi|mfhi|mflo)
 + lw + lw + lb + lb + lh + lh;
endmodule