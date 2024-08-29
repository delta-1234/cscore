module M_W(
    input clk,
    input reset,
    input en,
    input MemtoReg_M,
    input RegWrite_M,
    input Jal_M,
    input [31:0] PC_M,
    input [31:0] PC8_M,
    input [31:0] aluR_M,
    input [31:0] data,
    input [4:0] A3_M,
    input [1:0] Tnew_M,
    output reg MemtoReg_W,
    output reg RegWrite_W,
    output reg Jal_W,
    output reg [31:0] PC_W,
    output reg [31:0] PC8_W,
    output reg [31:0] aluR_W,
    output reg [31:0] data_W,
    output reg [4:0] A3_W,
    output reg [1:0] Tnew_W
);
wire [1:0] nextTnew;
TnewChange tc2(.lastTnew(Tnew_M),.nextTnew(nextTnew));
always @(posedge clk) begin
    if(reset == 1'b1) begin
      MemtoReg_W <= 1'b0;
      RegWrite_W <= 1'b0;
      Jal_W <= 1'b0;
      PC_W <= 32'h3000;
      PC8_W <= 32'b0;
      aluR_W <= 32'b0;
      data_W <= 32'b0;
      A3_W <= 5'b0;
      Tnew_W <= 2'b0;
    end
    else if(en == 1'b0) begin
      MemtoReg_W <= MemtoReg_W;
      RegWrite_W <= RegWrite_W;
      Jal_W <= Jal_W;
      PC_W <= PC_W;
      PC8_W <= PC8_W;
      aluR_W <= aluR_W;
      data_W <= data_W;
      A3_W <= A3_W;
      Tnew_W <= Tnew_W;
    end
    else begin
      MemtoReg_W <= MemtoReg_M;
      RegWrite_W <= RegWrite_M;
      Jal_W <= Jal_M;
      PC_W <= PC_M;
      PC8_W <= PC8_M;
      aluR_W <= aluR_M;
      data_W <= data;
      A3_W <= A3_M;
      Tnew_W <= nextTnew;
    end
end
endmodule