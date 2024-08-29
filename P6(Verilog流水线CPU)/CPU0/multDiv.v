`include "constant.v"
module multDiv(
    input clk,
    input reset,
    input Start,//启动乘除法信号
    input LOWrite,//写LO寄存器
    input HIWrite,//写HI寄存器
    input [3:0] ALUOp,//模式选择
    input [31:0] D1,//第一个数据
    input [31:0] D2,//第二个数据
    output reg Busy,//表示正在进行乘除运算
    output reg [31:0] LO,//LO寄存器输出
    output reg [31:0] HI//HI寄存器输出
);
integer count;
reg [63:0] result;
wire [63:0] t3,t4;
assign t3 = {{32{D1[31]}},D1};
assign t4 = {{32{D2[31]}},D2};
always @(posedge clk) begin
    if(reset == 1'b1) begin
      Busy <= 1'b0;
      LO <= 32'b0;
      HI <= 32'b0;
      count <= -1;
      result <= 64'b0;
    end
    else if(LOWrite == 1'b1) begin
      LO <= D1;
    end
    else if(HIWrite == 1'b1) begin
      HI <= D1;
    end
    else if(Start == 1'b1) begin
      Busy <= 1'b1;
      if(ALUOp == `aluMult) begin
        count <= 4;
        result <= $signed(t3) * $signed(t4);
      end
      else if(ALUOp == `aluDiv) begin
        count <= 9;
        if(D2 != 32'b0) begin
          result[31:0] <= $signed($signed(D1) / $signed(D2));
          result[63:32] <= $signed(D1) % $signed(D2);
        end
        else
            result <= 64'bx;
      end
      else if(ALUOp == `aluMultU) begin
        count <= 4;
        result <= {32'b0,D1}*{32'b0,D2};
      end
      else if(ALUOp == `aluDivU) begin
        count <= 9;
        if(D2 != 32'b0) begin
          result[31:0] <= {1'b0,D1}/{1'b0,D2};
          result[63:32] <= {1'b0,D1}%{1'b0,D2};
        end
        else
            result <= 64'bx;
      end
      else begin
        count <= -1;
      end
    end
    else if(count != 0) begin
      count <= count - 1;
    end
    else if(count == 0) begin
      Busy <= 1'b0;
      LO <= result[31:0];
      HI <= result[63:32];
      count <= -1;
    end
    else
        count <= count;
end
endmodule