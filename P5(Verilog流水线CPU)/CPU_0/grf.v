module grf(
    input clk,
    input reset,
    input [4:0] A1,//第一个读地址
    input [4:0] A2,//第二个读地址
    input [4:0] A3,//写地址
    input [31:0] WD,//写入数据
    input WE,//写使能
    input [31:0] PC,//当前PC输入
    output [31:0] RD1,//第一个读出数据
    output [31:0] RD2//第二个读出数据
);
reg [31:0] register[0:31];
assign RD1 = register[A1];
assign RD2 = register[A2];
integer i=0;
always @(posedge clk) begin
    if(reset == 1'b1) begin
      for(i=0;i<32;i=i+1) begin
        register[i] <= 32'b0;
      end
    end
end
always @(negedge clk) begin//下跳沿写入
    if(WE == 1'b1) begin
      $display("%d@%h: $%d <= %h", $time, PC, A3, WD);
      if(A3 == 5'b0)
      register[0] <= 32'b0;
      else
      register[A3] <= WD;
    end
    else begin
      register[0] <= 32'b0;
    end
end
endmodule