`include "IFU.v"
`include "Controller.v"
`include "GRF.v"
`include "ALU.v"
`include "DM.v"
`include "Splitter.v"
module DataPath(
    input Clk,
    input Reset
);
//IFU连线
wire Branch,Jr;//输入
wire [31:0] Offset,A;//输入
wire [31:0] Instr,PC4,PC;//输出

//Splitter连线
wire [5:0] OpCode,Func;
wire [4:0] Rs,Rt,Rd,S;
wire [15:0] Imm;

//EXT连线
wire [31:0] Ext;

//Controller连线
wire RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,B,JEn,SllEn,ExtOp,Jal,Byte;
wire [3:0] ALUCtr;

//GRF连线
wire [4:0] Address1,Address2,WriteAddress;
wire [31:0] WriteData;
wire WriteEn;
wire [31:0] ReadData1,ReadData2;

//ALU连线
wire [31:0] SrcA,SrcB;
wire [3:0] ALUOp;
wire [31:0] ALUResult;
wire [31:0] Sll;

//DM连线
wire [31:0] Addr;
wire WE;
wire [31:0] WD;
wire [31:0] D;

//IFU
MUX1Bits2 mux1(1'b0,ALUResult[0],B,Branch); 
assign Offset = Ext;
assign A = ReadData1;
IFU ifu(Clk,Reset,Branch,Offset,JEn,Jr,A,Instr,PC4,PC);
//Splitter
Splitter sp(Instr,OpCode,Rs,Rt,Rd,S,Func,Imm);
//EXT
EXT16Op32 ext1(Imm,ExtOp,Ext);
//Controller
Controller ctr(OpCode,Func,RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,B,JEn,SllEn,ExtOp,ALUCtr,Jal,Jr,Byte);
//GRF
wire [4:0] a;
wire [31:0] b;
assign WriteEn = RegWrite;
assign Address1 = Rs;
assign Address2 = Rt;
MUX5Bits2 mux2(Rt,Rd,RegDst,a);
MUX5Bits2 mux3(a,5'h1f,Jal,WriteAddress);
MUX32Bits2 mux4(ALUResult,D,MemtoReg,b);
MUX32Bits2 mux5(b,PC4,Jal,WriteData);
GRF grf(Clk,Reset,Address1,Address2,WriteAddress,WriteData,WriteEn,PC,ReadData1,ReadData2);
//ALU
assign ALUOp = ALUCtr;
EXT5Zero32 ext2(S,Sll);
MUX32Bits2 mux6(ReadData1,Sll,SllEn,SrcA);
MUX32Bits2 mux7(ReadData2,Ext,ALUSrc,SrcB);
ALU alu(SrcA,SrcB,ALUOp,ALUResult);
//DM
assign WD = ReadData2;
assign WE = MemWrite;
assign Addr = ALUResult;
DM dm(Clk,Reset,Addr,WE,WD,Byte,PC,D);

endmodule