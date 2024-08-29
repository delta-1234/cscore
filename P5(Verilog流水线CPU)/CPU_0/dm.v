`include "EXT.v"
`include "MUX.v"
module dm(
    input clk,
    input reset,
    input [31:0] addr,//地址输入
    input WE,//写使能
    input [31:0] WD,//写入数据
    input Byte,//是否按字节读写
    input [31:0] PC,//当前PC输入
    output [31:0] data//读出数据
);
reg [31:0] dataRAM[0:4095];
wire [4:0] a;
wire [31:0] Op,b,wd1;
EXT2Zero5 ext(addr[1:0],a);
assign b = 32'h000000ff << (a<<3'b011);
assign Op = 32'hffffffff ^ b;
assign wd1 = (dataRAM[addr[13:2]] & Op) | (WD << (a<<3'b011));
wire [31:0] writeData;
assign writeData = (Byte == 1'b1) ? wd1 : WD;
integer i=0;
always @(posedge clk) begin
    if(reset == 1'b1) begin
      for(i=0;i<4096;i=i+1) begin
        dataRAM[i] <= 32'b0;
      end
    end
    else begin
      if(WE == 1'b1) begin
        $display("%d@%h: *%h <= %h", $time, PC, addr, writeData);
        dataRAM[addr[13:2]] <= writeData;
      end
    end
end
wire [31:0] D1,D2;
wire [7:0] d;
assign D1 = dataRAM[addr[13:2]];
MUX8Bits4 mux1(D1[7:0],D1[15:8],D1[23:16],D1[31:24],addr[1:0],d);
EXT8Zero32 ext2(d,D2);
assign data = (Byte == 1'b1) ? D2 : D1;
endmodule