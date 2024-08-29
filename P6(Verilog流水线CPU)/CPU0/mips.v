`include "alu.v"
`include "controller.v"
`include "grf.v"
`include "splitter.v"
`include "F_D.v"
`include "D_E.v"
`include "E_M.v"
`include "M_W.v"
`include "hazardSolve.v"
`include "npc.v"
`include "MUX.v"
`include "EXT.v"
`include "multDiv.v"
module mips(
    input clk,
    input reset,
    input [31:0] i_inst_rdata,
    input [31:0] m_data_rdata,
    output [31:0] i_inst_addr,
    output [31:0] m_data_addr,
    output [31:0] m_data_wdata,
    output [3 :0] m_data_byteen,
    output [31:0] m_inst_addr,
    output w_grf_we,
    output [4:0] w_grf_addr,
    output [31:0] w_grf_wdata,
    output [31:0] w_inst_addr
);
/**** 连线 ****/
/**** F ****/
//ifu
wire en_PC;
wire B;
wire [31:0] offset,addr;
wire [31:0] instr,PC8;
reg [31:0] PC;
//NPC
wire [31:0] nextPC;

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
wire BeqEn,BneEn,JEn,ExtOp,Jal,Jr,Byte,Half;
wire Start,LOWrite,HIWrite,LORead,HIRead;
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
wire Jal_E,Byte_E,Half_E;
wire Start_E,LOWrite_E,HIWrite_E,LORead_E,HIRead_E;
wire [1:0] Tnew_E;
wire [3:0] ALUOp_E;
wire [31:0] PC_E,PC8_E,RD1_E,RD2_E;
wire [31:0] immEXT_E;
wire [4:0] A1_E,A2_E,A3_E;
//alu
wire [31:0] srcA,srcB;
wire [31:0] aluResult;
//乘除模块
wire Busy;
wire [31:0] LO,HI;
wire [31:0] aluR_E;

/**** M ****/
wire en_E;
wire MemtoReg_M,RegWrite_M,MemWrite_M;
wire Jal_M,Byte_M,Half_M;
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
MUX1Bits4 mux1(1'b0,beq,~beq,1'bx,{BneEn,BeqEn},B);
assign offset = immEXT;
assign addr = RD1_D;
npc NPC(B,offset,JEn,index,Jr,addr,PC,nextPC);
always @(posedge clk) begin
    if(reset == 1'b1) begin
      PC <= 32'h00003000;
    end
    else if(en_PC == 1'b0) begin
      PC <= PC;
    end
    else begin
      PC <= nextPC;
    end
end
assign PC8 = PC + 32'h8;
assign i_inst_addr = PC;
assign instr = i_inst_rdata;
//im IM(.PC(PC),.instr(instr));

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
    .BeqEn(BeqEn),
    .BneEn(BneEn),
    .JEn(JEn),
    .ExtOp(ExtOp),
    .ALUOp(ALUOp),
    .Jal(Jal),
    .Jr(Jr),
    .Byte(Byte),
    .Half(Half),
    .Start(Start),
    .LOWrite(LOWrite),
    .HIWrite(HIWrite),
    .LORead(LORead),
    .HIRead(HIRead),
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
D_E d_e(clk,reset_D|reset,en_D,ALUSrc,MemtoReg,RegWrite,MemWrite,ALUOp,Jal,Byte,Half,
Start,LOWrite,HIWrite,LORead,HIRead,
PC_D,PC8_D,RD1_D,RD2_D,immEXT,rs,rt,A3,Tnew,
ALUSrc_E,MemtoReg_E,RegWrite_E,MemWrite_E,ALUOp_E,Jal_E,Byte_E,Half_E,
Start_E,LOWrite_E,HIWrite_E,LORead_E,HIRead_E,
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
multDiv MultDiv(
    .clk(clk),
    .reset(reset),
    .Start(Start_E),
    .LOWrite(LOWrite_E),
    .HIWrite(HIWrite_E),
    .ALUOp(ALUOp_E),
    .D1(srcA),
    .D2(srcB),
    .Busy(Busy),
    .LO(LO),
    .HI(HI)
);
MUX32Bits4 mux13(aluResult,LO,HI,32'bx,{HIRead_E,LORead_E},aluR_E);

//EX/MEM级流水线寄存器
E_M e_m(clk,reset,en_E,MemtoReg_E,RegWrite_E,MemWrite_E,Jal_E,Byte_E,Half_E,
PC_E,PC8_E,aluR_E,temp3,A1_E,A2_E,A3_E,Tnew_E,
MemtoReg_M,RegWrite_M,MemWrite_M,Jal_M,Byte_M,Half_M,
PC_M,PC8_M,aluR_M,RD2_M,A1_M,A2_M,A3_M,Tnew_M);

//M
MUX32Bits2 mux10(RD2_M,WD,dmWDSel,dmWD);
assign m_data_addr = aluR_M;
assign m_data_wdata = (MemWrite_M == 1'b1) ? 
                      (Half_M == 1'b1) ? 
                      (m_data_addr[1] == 1'b1) ? {dmWD[15:0],16'b0} : {16'b0,dmWD[15:0]} :
                      (Byte_M == 1'b1) ?
                      (m_data_addr[1:0] == 2'b00) ? {24'b0,dmWD[7:0]} :
                      (m_data_addr[1:0] == 2'b01) ? {16'b0,dmWD[7:0],8'b0} :
                      (m_data_addr[1:0] == 2'b10) ? {8'b0,dmWD[7:0],16'b0} : {dmWD[7:0],24'b0} :
                      dmWD : 32'b0;
assign m_data_byteen = (MemWrite_M == 1'b1) ? 
                       (Half_M == 1'b1) ? 
                       (m_data_addr[1] == 1'b1) ? 4'b1100 : 4'b0011 :
                       (Byte_M == 1'b1) ?
                       (m_data_addr[1:0] == 2'b00) ? 4'b0001 :
                       (m_data_addr[1:0] == 2'b01) ? 4'b0010 :
                       (m_data_addr[1:0] == 2'b10) ? 4'b0100 : 4'b1000 :
                       4'b1111 : 4'b0000;
assign data = (Half_M == 1'b1) ? 
              (m_data_addr[1] == 1'b1) ? {{16{m_data_rdata[31]}},m_data_rdata[31:16]} : {{16{m_data_rdata[15]}},m_data_rdata[15:0]} :
              (Byte_M == 1'b1) ?
              (m_data_addr[1:0] == 2'b00) ? {{24{m_data_rdata[7]}},m_data_rdata[7:0]} :
              (m_data_addr[1:0] == 2'b01) ? {{24{m_data_rdata[15]}},m_data_rdata[15:8]} :
              (m_data_addr[1:0] == 2'b10) ? {{24{m_data_rdata[23]}},m_data_rdata[23:16]} : {{24{m_data_rdata[31]}},m_data_rdata[31:24]} :
              m_data_rdata;
/*dm DM(
    .clk(clk),
    .reset(reset),
    .addr(aluR_M),
    .WE(MemWrite_M),
    .WD(dmWD),
    .Byte(Byte_M),
    .PC(PC_M),
    .data(data)
);*/
assign m_inst_addr = PC_M;

//MEM/WB级流水线寄存器
M_W m_w(clk,reset,en_M,MemtoReg_M,RegWrite_M,Jal_M,
PC_M,PC8_M,aluR_M,data,A3_M,Tnew_M,
MemtoReg_W,RegWrite_W,Jal_W,
PC_W,PC8_W,aluR_W,data_W,A3_W,Tnew_W);

//W
MUX32Bits2 mux4(aluR_W,data_W,MemtoReg_W,temp1);
MUX32Bits2 mux5(temp1,PC8_W,Jal_W,WD);
assign w_grf_we = RegWrite_W;
assign w_grf_addr = A3_W;
assign w_grf_wdata = WD;
assign w_inst_addr = PC_W;

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
    .Start(Start),
    .LOWrite(LOWrite),
    .HIWrite(HIWrite),
    .LORead(LORead),
    .HIRead(HIRead),
    .Start_E(Start_E),
    .LOWrite_E(LOWrite_E),
    .HIWrite_E(HIWrite_E),
    .Busy_E(Busy),
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