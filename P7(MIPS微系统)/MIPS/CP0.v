`include "constant.v"
module CP0(
    input clk,
    input reset,
    input we,               //写使能信号
    input [4 :0] CP0_addr,  //写寄存器地址
    input [31:0] CP0_wdata, //CP0待写入数据
    output [31:0] CP0_rdata,//CP0读出数据

    input [31:0] VPC,       //受害PC
    input BDIn,             //是否是延迟槽指令
    input [4 :0] ExCode,    //异常类型
    input [5 :0] HWInt,     //中断信号输入
    input EXLClr,           //复位EXL
    output [31:0] EPCout,   //EPC的值
    output Req              //进入处理程序的请求
);
wire [31:0] SR,Cause;
reg [31:0] EPC;
reg [15:10] SR_IM;
reg SR_EXL,SR_IE;
reg Cause_BD;
reg [15:10] Cause_IP;
reg [6:2] Cause_ExCode;

assign SR = {16'b0,SR_IM,8'b0,SR_EXL,SR_IE};
assign Cause = {Cause_BD,15'b0,Cause_IP,3'b0,Cause_ExCode,2'b0};
always @(posedge clk) begin
    if(reset == 1'b1) begin
      SR_IM <= 6'b0;
      SR_EXL <= 1'b0;
      SR_IE <= 1'b0;
      Cause_BD <= 1'b0;
      Cause_IP <= 6'b0;
      Cause_ExCode <= 5'b0;
      EPC <= 32'b0;
    end
    else begin
      Cause_IP <= HWInt;
      //IE为1时，全局允许中断
      if(SR_IE == 1'b1 && SR_EXL == 1'b0 &&
        /*外部中断三种情况*/
        ((HWInt[0] == 1'b1 && SR_IM[10] == 1'b1) ||
        (HWInt[1] == 1'b1 && SR_IM[11] == 1'b1) ||
        (HWInt[2] == 1'b1 && SR_IM[12] == 1'b1))) begin
          SR_EXL <= 1'b1;
          Cause_BD <= BDIn;
          Cause_ExCode <= 5'b0;
          if(BDIn == 1'b1)
            EPC <= VPC - 32'd4;
          else
            EPC <= VPC;
      end
        /*内部异常*/
      else if(ExCode != 5'b0 && SR_EXL == 1'b0) begin
        Cause_BD <= BDIn;
        Cause_ExCode <= ExCode;
        SR_EXL <= 1'b1;
        if(BDIn == 1'b1)
          EPC <= VPC - 32'd4;
        else
          EPC <= VPC;
      end
      else if(we == 1'b1) begin
        if(EXLClr == 1'b1)
          SR_EXL <= 1'b0;
        else
          SR_EXL <= SR_EXL;
        if(CP0_addr == `SR) begin
          SR_IM <= CP0_wdata[15:10];
          SR_EXL <= CP0_wdata[1];
          SR_IE <= CP0_wdata[0];
        end
        else if(CP0_addr == `Cause) begin
          Cause_BD <= CP0_wdata[31];
          Cause_IP <= CP0_wdata[15:10];
          Cause_ExCode <= CP0_wdata[6:2];
        end
        else if(CP0_addr == `EPC)
          EPC <= CP0_wdata;
        else begin
          EPC <= EPC;
        end
      end
      else if(EXLClr == 1'b1) begin
        SR_EXL <= 1'b0;//复位EXL退出核心态
      end
    end
end
assign CP0_rdata = (CP0_addr == `SR) ? SR :
                   (CP0_addr == `Cause) ? Cause :
                   (CP0_addr == `EPC) ? EPC :
                   32'bx;
assign EPCout = EPC;
assign Req = (SR_IE == 1'b1 && SR_EXL == 1'b0) && 
             ((HWInt[0] == 1'b1 && SR_IM[10] == 1'b1) ||
              (HWInt[1] == 1'b1 && SR_IM[11] == 1'b1) ||
              (HWInt[2] == 1'b1 && SR_IM[12] == 1'b1)) ? 1'b1 : 
             (SR_EXL == 1'b0 && ExCode != 5'b0) ? 1'b1 :
              1'b0;
endmodule