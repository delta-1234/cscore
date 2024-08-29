module D_E(
    input clk,
    input reset,
    input Req,
    input stall,
    input en,
    input ALUSrc,
    input MemtoReg,
    input RegWrite,
    input MemWrite,
    input [3:0] ALUOp,
    input Jal,
    input Byte,
    input Half,
    input Start,
    input LOWrite,
    input HIWrite,
    input LORead,
    input HIRead,
    input CP0Read,
    input CP0Write,
    input [31:0] PC_D,
    input [31:0] PC4_D,
    input [31:0] RD1,
    input [31:0] RD2,
    input [31:0] EXT,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [4:0] A3,
    input [1:0] Tnew,
    input [4:0] newEx_D,
    input BD_D,
    input Eret,
    output reg ALUSrc_E,
    output reg MemtoReg_E,
    output reg RegWrite_E,
    output reg MemWrite_E,
    output reg [3:0] ALUOp_E,
    output reg Jal_E,
    output reg Byte_E,
    output reg Half_E,
    output reg Start_E,
    output reg LOWrite_E,
    output reg HIWrite_E,
    output reg LORead_E,
    output reg HIRead_E,
    output reg CP0Read_E,
    output reg CP0Write_E,
    output reg [31:0] PC_E,
    output reg [31:0] PC4_E,
    output reg [31:0] RD1_E,
    output reg [31:0] RD2_E,
    output reg [31:0] EXT_E,
    output reg [4:0] A1_E,
    output reg [4:0] A2_E,
    output reg [4:0] rd_E,
    output reg [4:0] A3_E,
    output reg [1:0] Tnew_E,
    output reg [4:0] ExCode_E,
    output reg BD_E,
    output reg Eret_E
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
      Half_E <= 1'b0;
      Start_E <= 1'b0;
      LOWrite_E <= 1'b0;
      HIWrite_E <= 1'b0;
      LORead_E <= 1'b0;
      HIRead_E <= 1'b0;
      CP0Read_E <= 1'b0;
      CP0Write_E <= 1'b0;
      PC_E <= 32'h3000;
      PC4_E <= 32'b0;
      RD1_E <= 32'b0;
      RD2_E <= 32'b0;
      EXT_E <= 32'b0;
      A1_E <= 5'b0;
      A2_E <= 5'b0;
      rd_E <= 5'b0;
      A3_E <= 5'b0;
      Tnew_E <= 2'b0;
      ExCode_E <= 5'b0;
      BD_E <= 1'b0;
      Eret_E <= 1'b0;
    end
    else if(Req == 1'b1) begin
      ALUSrc_E <= 1'b0;
      MemtoReg_E <= 1'b0;
      RegWrite_E <= 1'b0;
      MemWrite_E <= 1'b0;
      ALUOp_E <= 4'b0;
      Jal_E <= 1'b0;
      Byte_E <= 1'b0;
      Half_E <= 1'b0;
      Start_E <= 1'b0;
      LOWrite_E <= 1'b0;
      HIWrite_E <= 1'b0;
      LORead_E <= 1'b0;
      HIRead_E <= 1'b0;
      CP0Read_E <= 1'b0;
      CP0Write_E <= 1'b0;
      PC_E <= 32'h4180;
      PC4_E <= 32'b0;
      RD1_E <= 32'b0;
      RD2_E <= 32'b0;
      EXT_E <= 32'b0;
      A1_E <= 5'b0;
      A2_E <= 5'b0;
      rd_E <= 5'b0;
      A3_E <= 5'b0;
      Tnew_E <= 2'b0;
      ExCode_E <= 5'b0;
      BD_E <= 1'b0;
      Eret_E <= 1'b0;
    end
    else if(stall == 1'b1) begin
      ALUSrc_E <= 1'b0;
      MemtoReg_E <= 1'b0;
      RegWrite_E <= 1'b0;
      MemWrite_E <= 1'b0;
      ALUOp_E <= 4'b0;
      Jal_E <= 1'b0;
      Byte_E <= 1'b0;
      Half_E <= 1'b0;
      Start_E <= 1'b0;
      LOWrite_E <= 1'b0;
      HIWrite_E <= 1'b0;
      LORead_E <= 1'b0;
      HIRead_E <= 1'b0;
      CP0Read_E <= 1'b0;
      CP0Write_E <= 1'b0;
      PC_E <= PC_D;//stall的时候应该保留PC
      PC4_E <= 32'b0;
      RD1_E <= 32'b0;
      RD2_E <= 32'b0;
      EXT_E <= 32'b0;
      A1_E <= 5'b0;
      A2_E <= 5'b0;
      rd_E <= 5'b0;
      A3_E <= 5'b0;
      Tnew_E <= 2'b0;
      ExCode_E <= newEx_D;
      BD_E <= BD_D;
      Eret_E <= 1'b0;
    end
    else if(en == 1'b0) begin
      ALUSrc_E <= ALUSrc_E;
      MemtoReg_E <= MemtoReg_E;
      RegWrite_E <= RegWrite_E;
      MemWrite_E <= MemWrite_E;
      ALUOp_E <= ALUOp_E;
      Jal_E <= Jal_E;
      Byte_E <= Byte_E;
      Half_E <= Half_E;
      Start_E <= Start_E;
      LOWrite_E <= LOWrite_E;
      HIWrite_E <= HIWrite_E;
      LORead_E <= LORead_E;
      HIRead_E <= HIRead_E;
      CP0Read_E <= CP0Read_E;
      CP0Write_E <= CP0Write_E;
      PC_E <= PC_E;
      PC4_E <= PC4_E;
      RD1_E <= RD1_E;
      RD2_E <= RD2_E;
      EXT_E <= EXT_E;
      A1_E <= A1_E;
      A2_E <= A2_E;
      rd_E <= rd_E;
      A3_E <= A3_E;
      Tnew_E <= Tnew_E;
      ExCode_E <= ExCode_E;
      BD_E <= BD_E;
      Eret_E <= Eret_E;
    end
    else begin
      ALUSrc_E <= ALUSrc;
      MemtoReg_E <= MemtoReg;
      RegWrite_E <= RegWrite;
      MemWrite_E <= MemWrite;
      ALUOp_E <= ALUOp;
      Jal_E <= Jal;
      Byte_E <= Byte;
      Half_E <= Half;
      Start_E <= Start;
      LOWrite_E <= LOWrite;
      HIWrite_E <= HIWrite;
      LORead_E <= LORead;
      HIRead_E <= HIRead;
      CP0Read_E <= CP0Read;
      CP0Write_E <= CP0Write;
      PC_E <= PC_D;
      PC4_E <= PC4_D;
      RD1_E <= RD1;
      RD2_E <= RD2;
      EXT_E <= EXT;
      A1_E <= rs;
      A2_E <= rt;
      rd_E <= rd;
      A3_E <= A3;
      Tnew_E <= Tnew;
      ExCode_E <= newEx_D;
      BD_E <= BD_D;
      Eret_E <= Eret;
    end
end
endmodule