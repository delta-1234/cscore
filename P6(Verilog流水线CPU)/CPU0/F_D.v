module F_D(
    input clk,
    input reset,
    input en,
    input [31:0] PC,
    input [31:0] PC8,
    input [31:0] instr,
    output reg [31:0] PC_D,
    output reg [31:0] PC8_D,
    output reg [31:0] instr_D
);
always @(posedge clk) begin
    if(reset == 1'b1) begin
      PC_D <= 32'b0;
      PC8_D <= 32'b0;
      instr_D <= 32'b0;
    end
    else if(en == 1'b0) begin
      PC_D <= PC_D;
      PC8_D <= PC8_D;
      instr_D <= instr_D;
    end
    else begin
      PC_D <= PC;
      PC8_D <= PC8;
      instr_D <= instr;
    end
end
endmodule