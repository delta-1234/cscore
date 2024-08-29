`include "NPC.v"
`include "IM.v"
module IFU(
    input Clk,
    input Reset,
    input Branch,
    input [31:0] Offset,
    input J,
    input Jr,
    input [31:0] A,
    output [31:0] Instr,
    output [31:0] PC4,
    output [31:0] PC
);
reg [31:0] pc;
wire [31:0] NextPC;
NPC npc(Branch,Offset,J,Instr[25:0],Jr,A,pc,NextPC);
always @(posedge Clk) begin
    if(Reset == 1'b1) begin
      pc <= 32'h00003000;
    end
    else begin
      pc <= NextPC;
    end
end
assign PC4 = pc + 32'h4;
assign PC = pc;
IM im(pc,Instr); 
endmodule