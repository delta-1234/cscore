`include "npc.v"
`include "im.v"
module ifu(
    input clk,
    input reset,
    input en,//阻塞PC
    input B,//beq跳转信号且为1时需要跳转
    input [31:0] offset,//beq跳转偏移量
    input J,//j跳转信号
    input [25:0] index,//j跳转地址
    input Jr,//jr跳转信号
    input [31:0] addr,//jr跳转地址
    output [31:0] instr,//指令输出
    output [31:0] PC8,//当前PC+8输出
    output reg [31:0] PC//当前PC输出
);
wire [31:0] nextPC;
npc NPC(B,offset,J,index,Jr,addr,PC,nextPC);
always @(posedge clk) begin
    if(reset == 1'b1) begin
      PC <= 32'h00003000;
    end
    else if(en == 1'b0) begin
      PC <= PC;
    end
    else begin
      PC <= nextPC;
    end
end
assign PC8 = PC + 32'h8;
im IM(.PC(PC),.instr(instr));
endmodule