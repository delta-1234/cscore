`include "TnewChange.v"
module E_M(
    input clk,
    input reset,
    input en,
    input MemtoReg_E,
    input RegWrite_E,
    input MemWrite_E,
    input Jal_E,
    input Byte_E,
    input [31:0] PC_E,
    input [31:0] PC8_E,
    input [31:0] ALUResult,
    input [31:0] RD2_E,
    input [4:0] A1_E,
    input [4:0] A2_E,
    input [4:0] A3_E,
    input [1:0] Tnew_E,
    output reg MemtoReg_M,
    output reg RegWrite_M,
    output reg MemWrite_M,
    output reg Jal_M,
    output reg Byte_M,
    output reg [31:0] PC_M,
    output reg [31:0] PC8_M,
    output reg [31:0] aluR_M,
    output reg [31:0] RD2_M,
    output reg [4:0] A1_M,
    output reg [4:0] A2_M,
    output reg [4:0] A3_M,
    output reg [1:0] Tnew_M
);
wire [1:0] nextTnew;
TnewChange tc(.lastTnew(Tnew_E),.nextTnew(nextTnew));
always @(posedge clk) begin
    if(reset == 1'b1) begin
      MemtoReg_M <= 1'b0;
      RegWrite_M <= 1'b0;
      MemWrite_M <= 1'b0;
      Jal_M <= 1'b0;
      Byte_M <= 1'b0;
      PC_M <= 32'b0;
      PC8_M <= 32'b0;
      aluR_M <= 32'b0;
      RD2_M <= 32'b0;
      A1_M <= 5'b0;
      A2_M <= 5'b0;
      A3_M <= 5'b0;
      Tnew_M <= 2'b0;
    end
    else if(en == 1'b0) begin
      MemtoReg_M <= MemtoReg_M;
      RegWrite_M <= RegWrite_M;
      MemWrite_M <= MemWrite_M;
      Jal_M <= Jal_M;
      Byte_M <= Byte_M;
      PC_M <= PC_M;
      PC8_M <= PC8_M;
      aluR_M <= aluR_M;
      RD2_M <= RD2_M;
      A1_M <= A1_M;
      A2_M <= A2_M;
      A3_M <= A3_M;
      Tnew_M <= Tnew_M;
    end
    else begin
      MemtoReg_M <= MemtoReg_E;
      RegWrite_M <= RegWrite_E;
      MemWrite_M <= MemWrite_E;
      Jal_M <= Jal_E;
      Byte_M <= Byte_E;
      PC_M <= PC_E;
      PC8_M <= PC8_E;
      aluR_M <= ALUResult;
      RD2_M <= RD2_E;
      A1_M <= A1_E;
      A2_M <= A2_E;
      A3_M <= A3_E;
      Tnew_M <= nextTnew;
    end
end
endmodule