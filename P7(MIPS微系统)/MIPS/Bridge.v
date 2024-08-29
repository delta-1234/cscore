module Bridge(
    input [31:0] CPU_addr,   //地址
    input [31:0] CPU_wdata,  //CPU写的数据
    input [3 :0] CPU_byteen, //CPU按字节读写信号
    input [31:0] CPU_m_PC,   //CPU的M级PC
    output [31:0] CPU_rdata, //CPU读到的数据

    input [31:0] DM_rdata,   //DM读出数据
    output [31:0] DM_addr,   //DM读写地址
    output [3 :0] DM_byteen, //DM按字节读写使能
    output [31:0] DM_wdata,  //DM待写入数据
    output [31:0] DM_PC,     //DM所需PC输入

    input [31:0] TC0_rdata,  //TC0寄存器读出数据
    output [31:2] TC0_addr,  //计时器0寄存器地址
    output TC0_we,           //计时器0寄存器写使能
    output [31:0] TC0_wdata, //计时器0待写入数据

    input [31:0] TC1_rdata,  //TC1寄存器读出数据
    output [31:2] TC1_addr,  //计时器1寄存器地址
    output TC1_we,           //计时器1寄存器写使能
    output [31:0] TC1_wdata, //计时器1待写入数据

    output [31:0] Int_addr,  //中断发生器响应地址
    output [3 :0] Int_byteen //中断发生器字节使能信号
);
wire HitDM,HitTC0,HitTC1,HitInt;
assign HitDM = (CPU_addr[31:12] >= 20'h0000_0 && CPU_addr[31:12] <= 20'h0000_2);
assign HitTC0 = (CPU_addr[31:4] == 28'h0000_7f0 && CPU_addr[3:0] <= 4'hb);
assign HitTC1 = (CPU_addr[31:4] == 28'h0000_7f1 && CPU_addr[3:0] <= 4'hb);
assign HitInt = (CPU_addr[31:4] == 28'h0000_7f2 && CPU_addr[3:0] <= 4'h3);

assign DM_addr = (HitDM == 1'b1) ? CPU_addr : 32'bx;
assign DM_byteen = (HitDM == 1'b1) ? CPU_byteen : 4'bxxxx;
assign DM_wdata = (HitDM == 1'b1) ? CPU_wdata : 32'bx;
assign DM_PC = CPU_m_PC ;

assign TC0_addr = (HitTC0 == 1'b1) ? CPU_addr[31:2] : 30'bx;
assign TC0_we = (CPU_byteen != 4'b0 && HitTC0) ? 1'b1 : 1'b0;
assign TC0_wdata = (HitTC0 == 1'b1) ? CPU_wdata : 32'bx;

assign TC1_addr = (HitTC1 == 1'b1) ? CPU_addr[31:2] : 30'bx;
assign TC1_we = (CPU_byteen != 4'b0 && HitTC1) ? 1'b1 : 1'b0;
assign TC1_wdata = (HitTC1 == 1'b1) ? CPU_wdata : 32'bx;

assign Int_addr = (HitInt == 1'b1) ? CPU_addr : 32'bx;
assign Int_byteen = (HitInt == 1'b1) ? CPU_byteen : 4'bxxxx;

assign CPU_rdata = (HitDM == 1'b1) ? DM_rdata : 
                   (HitTC0 == 1'b1) ? TC0_rdata :
                   (HitTC1 == 1'b1) ? TC1_rdata :
                   (HitInt == 1'b1) ? 32'b0 :
                   32'bx;
endmodule