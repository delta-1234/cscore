`include "EXT.v"
`include "MUX.v"
module DM(
    input Clk,
    input Reset,
    input [31:0] Addr,
    input WE,
    input [31:0] WD,
    input Byte,
    input [31:0] PC,
    output [31:0] D
);
reg [31:0] DataRAM[0:4095];
wire [4:0] a;
wire [31:0] Op,b,wd1;
EXT2Zero5 ext(Addr[1:0],a);
assign b = 32'h000000ff << (a<<3'b011);
assign Op = 32'hffffffff ^ b;
assign wd1 = (DataRAM[Addr[13:2]] & Op) | (WD << (a<<3'b011));
wire [31:0] Data;
assign Data = (Byte == 1'b1) ? wd1 : WD;
integer i=0;
always @(posedge Clk) begin
    if(Reset == 1'b1) begin
      for(i=0;i<4096;i=i+1) begin
        DataRAM[i] <= 32'b0;
      end
    end
    else begin
      if(WE == 1'b1) begin
        $display("@%h: *%h <= %h", PC, Addr, Data);
        DataRAM[Addr[13:2]] <= Data;
      end
    end
end
wire [31:0] D1,D2;
wire [7:0] d;
assign D1 = DataRAM[Addr[13:2]];
MUX8Bits4 mux1(D1[7:0],D1[15:8],D1[23:16],D1[31:24],Addr[1:0],d);
EXT8Zero32 ext2(d,D2);
assign D = (Byte == 1'b1) ? D2 : D1;
endmodule