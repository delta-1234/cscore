`include "constant.v"
module alu(
    input [31:0] srcA,      //第一个操作数
    input [31:0] srcB,      //第二个操作数
    input [3:0] ALUOp,      //ALU功能选择
    output [31:0] ALUResult,//ALU输出结果
    output overflow         //结果是否溢出
);
wire [63:0] temp;
assign temp = (ALUOp == `aluAdd) ? {{32{srcA[31]}},srcA} + {{32{srcB[31]}},srcB} :
              (ALUOp == `aluSub) ? {{32{srcA[31]}},srcA} - {{32{srcB[31]}},srcB} :
              64'b0;
assign ALUResult = (ALUOp == `aluAnd) ? srcA & srcB :
                   (ALUOp == `aluOr) ? srcA | srcB :
                   (ALUOp == `aluAdd) ? temp[31:0] :
                   (ALUOp == 4'b0011) ? ~srcA & srcB :
                   (ALUOp == 4'b0100) ? srcA & ~srcB :
                   (ALUOp == `aluLui) ? {srcB[15:0],srcA[15:0]} :
                   (ALUOp == `aluSub) ? temp[31:0] :
                   (ALUOp == `aluBeq) ? ((srcA == srcB)?32'b1:32'b0) :
                   (ALUOp == 4'b1000) ? srcB >> srcA :
                   (ALUOp == `aluLess) ? (($signed(srcA) < $signed(srcB))?32'b1:32'b0) :
                   (ALUOp == `aluLessU) ? (({1'b0,srcA} < {1'b0,srcB})?32'b1:32'b0) :
                   (ALUOp == `aluSll) ? srcB << srcA : 
                   32'b0;
assign overflow = (temp[32] != temp[31]) ? 1'b1 : 1'b0;
endmodule