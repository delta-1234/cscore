module F_D(
    input clk,
    input reset,
    input Req,
    input Eret,
    input en,
    input [31:0] PC,
    input [31:0] PC8,
    input [31:0] instr,
    input [4 :0] Excode_F,
    input BD,
    output reg [31:0] PC_D,
    output reg [31:0] PC8_D,
    output reg [31:0] instr_D,
    output reg [4 :0] Excode_D,
    output reg BD_D
);
always @(posedge clk) begin
    if(reset == 1'b1) begin
      PC_D <= 32'h3000;
      PC8_D <= 32'b0;
      instr_D <= 32'b0;
      Excode_D <= 5'b0;
      BD_D <= 1'b0;
    end
    else if(Req == 1'b1) begin
      PC_D <= 32'h4180;
      PC8_D <= 32'b0;
      instr_D <= 32'b0;
      Excode_D <= 5'b0;
      BD_D <= 1'b0;
    end
    else if(Eret == 1'b1) begin
      PC_D <= PC_D;
      PC8_D <= 32'b0;
      instr_D <= 32'b0;
      Excode_D <= 5'b0;
      BD_D <= 1'b0;
    end
    else if(en == 1'b0) begin
      PC_D <= PC_D;
      PC8_D <= PC8_D;
      instr_D <= instr_D;
      Excode_D <= Excode_D;
      BD_D <= BD_D;
    end
    else begin
      PC_D <= PC;
      PC8_D <= PC8;
      instr_D <= instr;
      Excode_D <= Excode_F;
      BD_D <= BD;
    end
end
endmodule