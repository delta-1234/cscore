`include "alu.v"
`include "controller.v"
`include "dm.v"
`include "grf.v"
`include "ifu.v"
`include "splitter.v"
`include "F_D.v"
`include "D_E.v"
`include "E_M.v"
`include "M_W.v"
`include "hazardSolve.v"
module mips(
    input clk,
    input reset
);
/**** 连线 ****/
/**** F ****/
//ifu
wire en_PC;
wire B;
wire [31:0] offset,addr;
wire [31:0] instr,PC,PC8;

/**** D ****/
wire en_F;
wire [31:0] instr_D,PC_D,PC8_D;
//splitter
wire [5:0] opCode,func;
wire [4:0] rs,rt,rd;
wire [15:0] imm;
wire [25:0] index;
//controller
wire RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite;
wire Branch,JEn,ExtOp,Jal,Jr,Byte;
wire [1:0] rsTuse,rtTuse,Tnew;
wire [3:0] ALUOp;
//GRF
wire [31:0] RD1,RD2;
wire [4:0] A3;
wire [31:0] RD1_D,RD2_D;
//EXT
wire [31:0] immEXT;
//增加的比较器
wire beq;

/**** E ****/
wire en_D;
wire ALUSrc_E,MemtoReg_E,RegWrite_E,MemWrite_E;
wire Jal_E,Byte_E;
wire [1:0] Tnew_E;
wire [3:0] ALUOp_E;
wire [31:0] PC_E,PC8_E,RD1_E,RD2_E;
wire [31:0] immEXT_E;
wire [4:0] A1_E,A2_E,A3_E;
//alu
wire [31:0] srcA,srcB;
wire [31:0] aluResult;

/**** M ****/
wire en_E;
wire MemtoReg_M,RegWrite_M,MemWrite_M;
wire Jal_M,Byte_M;
wire [31:0] PC_M,PC8_M,aluR_M,RD2_M;
wire [4:0] A1_M,A2_M,A3_M;
wire [1:0] Tnew_M;
//dm
wire [31:0] data;
wire [31:0] dmWD;

/**** W ****/
wire en_M;
wire MemtoReg_W,RegWrite_W,Jal_W;
wire [31:0] PC_W,PC8_W,aluR_W,data_W;
wire [4:0] A3_W;
wire [1:0] Tnew_W;
//GRF
wire [31:0] WD;

/**** 冲突单元 ****/
wire reset_D;
wire [1:0] RD1_DSel,RD2_DSel;
wire [1:0] srcASel,srcBSel;
wire dmWDSel;

//其他
wire [31:0] temp1;
wire [4:0] temp2;
wire [31:0] temp3;

/**** dataPath ****/
//F
MUX1Bits2 mux1(1'b0,beq,Branch,B);
assign offset = immEXT;
assign addr = RD1_D;
ifu IFU(
    .clk(clk),
    .reset(reset),
    .en(en_PC),
    .B(B),
    .offset(offset),
    .J(JEn),
    .index(index),
    .Jr(Jr),
    .addr(addr),
    .instr(instr),//输出
    .PC8(PC8),
    .PC(PC)
);

//IF/ID级流水线寄存器
F_D f_d(clk,reset,en_F,PC,PC8,instr,
PC_D,PC8_D,instr_D);

//D
splitter Splitter(
    .instr(instr_D),
    .opCode(opCode),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .func(func),
    .imm(imm),
    .index(index)
);
controller Controller(
    .opCode(opCode),
    .func(func),
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .JEn(JEn),
    .ExtOp(ExtOp),
    .ALUOp(ALUOp),
    .Jal(Jal),
    .Jr(Jr),
    .Byte(Byte),
    .rsTuse(rsTuse),
    .rtTuse(rtTuse),
    .Tnew(Tnew)
);
//EXT
EXT16Op32 ext1(imm,ExtOp,immEXT);
//GRF
grf GRF(
    .clk(clk),//改为下跳沿触发，使其可以在同一个周期内读写
    .reset(reset),
    .A1(rs),
    .A2(rt),
    .A3(A3_W),
    .WD(WD),
    .WE(RegWrite_W),
    .PC(PC_W),
    .RD1(RD1),
    .RD2(RD2)
);
MUX32Bits4 mux11(RD1,PC8_E,aluR_M,PC8_M,RD1_DSel,RD1_D);
MUX32Bits4 mux12(RD2,PC8_E,aluR_M,PC8_M,RD2_DSel,RD2_D);
MUX5Bits2 mux6(rt,rd,RegDst,temp2);
MUX5Bits2 mux7(temp2,5'h1f,Jal,A3);
//比较器
assign beq = (RD1_D == RD2_D) ? 1'b1 : 1'b0;

//ID/EX级流水线寄存器
D_E d_e(clk,reset_D|reset,en_D,ALUSrc,MemtoReg,RegWrite,MemWrite,ALUOp,Jal,Byte,
PC_D,PC8_D,RD1_D,RD2_D,immEXT,rs,rt,A3,Tnew,
ALUSrc_E,MemtoReg_E,RegWrite_E,MemWrite_E,ALUOp_E,Jal_E,Byte_E,
PC_E,PC8_E,RD1_E,RD2_E,immEXT_E,A1_E,A2_E,A3_E,Tnew_E);

//E
MUX32Bits4 mux8(RD1_E,aluR_M,PC8_M,WD,srcASel,srcA);
MUX32Bits4 mux9(RD2_E,aluR_M,PC8_M,WD,srcBSel,temp3);
MUX32Bits2 mux3(temp3,immEXT_E,ALUSrc_E,srcB);
alu ALU(
    .srcA(srcA),
    .srcB(srcB),
    .ALUOp(ALUOp_E),
    .ALUResult(aluResult)
);

//EX/MEM级流水线寄存器
E_M e_m(clk,reset,en_E,MemtoReg_E,RegWrite_E,MemWrite_E,Jal_E,Byte_E,
PC_E,PC8_E,aluResult,temp3,A1_E,A2_E,A3_E,Tnew_E,
MemtoReg_M,RegWrite_M,MemWrite_M,Jal_M,Byte_M,
PC_M,PC8_M,aluR_M,RD2_M,A1_M,A2_M,A3_M,Tnew_M);

//M
MUX32Bits2 mux10(RD2_M,WD,dmWDSel,dmWD);
dm DM(
    .clk(clk),
    .reset(reset),
    .addr(aluR_M),
    .WE(MemWrite_M),
    .WD(dmWD),
    .Byte(Byte_M),
    .PC(PC_M),
    .data(data)
);

//MEM/WB级流水线寄存器
M_W m_w(clk,reset,en_M,MemtoReg_M,RegWrite_M,Jal_M,
PC_M,PC8_M,aluR_M,data,A3_M,Tnew_M,
MemtoReg_W,RegWrite_W,Jal_W,
PC_W,PC8_W,aluR_W,data_W,A3_W,Tnew_W);

//W
MUX32Bits2 mux4(aluR_W,data_W,MemtoReg_W,temp1);
MUX32Bits2 mux5(temp1,PC8_W,Jal_W,WD);

//**** 冲突单元 ****//
hazardSolve HS(
    .rsTuse(rsTuse),
    .rtTuse(rtTuse),
    .Tnew_E(Tnew_E),
    .Tnew_M(Tnew_M),
    .Tnew_W(Tnew_W),
    .rs(rs),
    .rt(rt),
    .A1_E(A1_E),
    .A2_E(A2_E),
    .A3_E(A3_E),
    .A1_M(A1_M),
    .A2_M(A2_M),
    .A3_M(A3_M),
    .A3_W(A3_W),
    .RegWrite_E(RegWrite_E),
    .RegWrite_M(RegWrite_M),
    .RegWrite_W(RegWrite_W),
    .Jal_M(Jal_M),
    .Jal_W(Jal_W),
    .en_PC(en_PC),//输出
    .en_F(en_F),
    .en_D(en_D),
    .en_E(en_E),
    .en_M(en_M),
    .RD1_DSel(RD1_DSel),
    .RD2_DSel(RD2_DSel),
    .reset_D(reset_D),
    .srcASel(srcASel),
    .srcBSel(srcBSel),
    .dmWDSel(dmWDSel)
);
endmodule