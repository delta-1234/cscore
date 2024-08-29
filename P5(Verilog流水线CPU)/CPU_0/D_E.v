module D_E(
    input clk,
    input reset,
    input en,
    input ALUSrc,
    input MemtoReg,
    input RegWrite,
    input MemWrite,
    input [3:0] ALUOp,
    input Jal,
    input Byte,
    input [31:0] PC_D,
    input [31:0] PC4_D,
    input [31:0] RD1,
    input [31:0] RD2,
    input [31:0] EXT,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] A3,
    input [1:0] Tnew,
    output reg ALUSrc_E,
    output reg MemtoReg_E,
    output reg RegWrite_E,
    output reg MemWrite_E,
    output reg [3:0] ALUOp_E,
    output reg Jal_E,
    output reg Byte_E,
    output reg [31:0] PC_E,
    output reg [31:0] PC4_E,
    output reg [31:0] RD1_E,
    output reg [31:0] RD2_E,
    output reg [31:0] EXT_E,
    output reg [4:0] A1_E,
    output reg [4:0] A2_E,
    output reg [4:0] A3_E,
    output reg [1:0] Tnew_E
);
always @(posedge clk) begin
    if(reset == 1'b1) begin
      ALUSrc_E <= 1'b0;
      MemtoReg_E <= 1'b0;
      RegWrite_E <= 1'b0;
      MemWrite_E <= 1'b0;
      ALUOp_E <= 4'b0;
      Jal_E <= 1'b0;
      Byte_E <= 1'b0;
      PC_E <= 32'b0;
      PC4_E <= 32'b0;
      RD1_E <= 32'b0;
      RD2_E <= 32'b0;
      EXT_E <= 32'b0;
      A1_E <= 5'b0;
      A2_E <= 5'b0;
      A3_E <= 5'b0;
      Tnew_E <= 2'b0;
    end
    else if(en == 1'b0) begin
      ALUSrc_E <= ALUSrc_E;
      MemtoReg_E <= MemtoReg_E;
      RegWrite_E <= RegWrite_E;
      MemWrite_E <= MemWrite_E;
      ALUOp_E <= ALUOp_E;
      Jal_E <= Jal_E;
      Byte_E <= Byte_E;
      PC_E <= PC_E;
      PC4_E <= PC4_E;
      RD1_E <= RD1_E;
      RD2_E <= RD2_E;
      EXT_E <= EXT_E;
      A1_E <= A1_E;
      A2_E <= A2_E;
      A3_E <= A3_E;
      Tnew_E <= Tnew_E;
    end
    else begin
      ALUSrc_E <= ALUSrc;
      MemtoReg_E <= MemtoReg;
      RegWrite_E <= RegWrite;
      MemWrite_E <= MemWrite;
      ALUOp_E <= ALUOp;
      Jal_E <= Jal;
      Byte_E <= Byte;
      PC_E <= PC_D;
      PC4_E <= PC4_D;
      RD1_E <= RD1;
      RD2_E <= RD2;
      EXT_E <= EXT;
      A1_E <= rs;
      A2_E <= rt;
      A3_E <= A3;
      Tnew_E <= Tnew;
    end
end
endmodule