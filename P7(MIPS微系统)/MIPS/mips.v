`include "CPU.v"
`include "TC.v"
`include "Bridge.v"
module mips(
    input clk,                    // 时钟信号
    input reset,                  // 同步复位信号
    input interrupt,              // 外部中断信号
    output [31:0] macroscopic_pc, // 宏观 PC

    output [31:0] i_inst_addr,    // IM 读取地址（取指 PC）
    input  [31:0] i_inst_rdata,   // IM 读取数据

    output [31:0] m_data_addr,    // DM 读写地址
    input  [31:0] m_data_rdata,   // DM 读取数据
    output [31:0] m_data_wdata,   // DM 待写入数据
    output [3 :0] m_data_byteen,  // DM 字节使能信号

    output [31:0] m_int_addr,     // 中断发生器待写入地址
    output [3 :0] m_int_byteen,   // 中断发生器字节使能信号

    output [31:0] m_inst_addr,    // M 级 PC

    output w_grf_we,              // GRF 写使能信号
    output [4 :0] w_grf_addr,     // GRF 待写入寄存器编号
    output [31:0] w_grf_wdata,    // GRF 待写入数据

    output [31:0] w_inst_addr     // W 级 PC
);
wire [31:0] CPU_addr,CPU_wdata,CPU_m_PC;
wire [3:0] CPU_byteen;
wire [31:0] CPU_rdata;
wire [31:0] TC0_rdata,TC0_wdata,TC1_rdata,TC1_wdata;
wire [31:2] TC0_addr,TC1_addr;
wire TC0_we,TC1_we;
wire TC0_Req;
wire TC1_Req;
CPU cpu(
    .clk(clk),
    .reset(reset),

    .interrupt(interrupt),
    .TC0_int(TC0_Req),
    .TC1_int(TC1_Req),
    .macroscopic_pc(macroscopic_pc),

    .i_inst_rdata(i_inst_rdata),
    .i_inst_addr(i_inst_addr),

    .m_data_rdata(CPU_rdata),   //系统桥传输过来数据
    .m_data_addr(CPU_addr),     //给到系统桥
    .m_data_wdata(CPU_wdata),   //给到系统桥
    .m_data_byteen(CPU_byteen), //给到系统桥
    .m_inst_addr(CPU_m_PC),     //给到系统桥

    .w_grf_we(w_grf_we),
    .w_grf_addr(w_grf_addr),
    .w_grf_wdata(w_grf_wdata),
    .w_inst_addr(w_inst_addr)
);

Bridge bridge(
    .CPU_addr(CPU_addr),
    .CPU_wdata(CPU_wdata),
    .CPU_byteen(CPU_byteen),
    .CPU_m_PC(CPU_m_PC),
    .CPU_rdata(CPU_rdata),

    .DM_rdata(m_data_rdata),
    .DM_addr(m_data_addr),
    .DM_byteen(m_data_byteen),
    .DM_wdata(m_data_wdata),
    .DM_PC(m_inst_addr),

    .TC0_rdata(TC0_rdata),
    .TC0_addr(TC0_addr),
    .TC0_we(TC0_we),
    .TC0_wdata(TC0_wdata),

    .TC1_rdata(TC1_rdata),
    .TC1_addr(TC1_addr),
    .TC1_we(TC1_we),
    .TC1_wdata(TC1_wdata),

    .Int_addr(m_int_addr),
    .Int_byteen(m_int_byteen)
);

TC TC0(
    .clk(clk),
    .reset(reset),
    .Addr(TC0_addr),
    .WE(TC0_we),
    .Din(TC0_wdata),
    .Dout(TC0_rdata),
    .IRQ(TC0_Req)
);

TC TC1(
    .clk(clk),
    .reset(reset),
    .Addr(TC1_addr),
    .WE(TC1_we),
    .Din(TC1_wdata),
    .Dout(TC1_rdata),
    .IRQ(TC1_Req)
);
endmodule