module hazardSolve(
    input [1:0] rsTuse,
    input [1:0] rtTuse,
    input [1:0] Tnew_E,
    input [1:0] Tnew_M,
    input [1:0] Tnew_W,
    input [4:0] rs,//GRF的A1
    input [4:0] rt,//GRF的A2
    input [4:0] A1_E,
    input [4:0] A2_E,
    input [4:0] A3_E,
    input [4:0] A1_M,
    input [4:0] A2_M,
    input [4:0] A3_M,
    input [4:0] A3_W,
    input RegWrite_E,
    input RegWrite_M,
    input RegWrite_W,
    input Jal_M,
    input Jal_W,
    output en_PC,//阻塞时冻结PC
    output en_F,//阻塞时冻结F_D级
    output en_D,
    output en_E,
    output en_M,
    output reset_D,//清空ID/EX级流水线值
    output [1:0] RD1_DSel,
    output [1:0] RD2_DSel,
    output [1:0] srcASel,//srcA转发选择
    output [1:0] srcBSel,//srcB转发选择
    output dmWDSel//dm写入数据转发选择
);
wire stallRs,stallRt;
wire stall;
//rs四种情况需要阻塞
assign stallRs = 
        ((rsTuse == 2'b00) & (Tnew_E == 2'b01) & (rs == A3_E) & (rs != 5'b0) & RegWrite_E) |
        ((rsTuse == 2'b00) & (Tnew_E == 2'b10) & (rs == A3_E) & (rs != 5'b0) & RegWrite_E) |
        ((rsTuse == 2'b01) & (Tnew_E == 2'b10) & (rs == A3_E) & (rs != 5'b0) & RegWrite_E) |
        ((rsTuse == 2'b00) & (Tnew_M == 2'b01) & (rs == A3_M) & (rs != 5'b0) & RegWrite_M);
//rt有四种情况需要阻塞
assign stallRt = 
        ((rtTuse == 2'b00) & (Tnew_E == 2'b01) & (rt == A3_E) & (rt != 5'b0) & RegWrite_E) |
        ((rtTuse == 2'b00) & (Tnew_E == 2'b10) & (rt == A3_E) & (rt != 5'b0) & RegWrite_E) |
        ((rtTuse == 2'b01) & (Tnew_E == 2'b10) & (rt == A3_E) & (rt != 5'b0) & RegWrite_E) |
        ((rtTuse == 2'b00) & (Tnew_M == 2'b01) & (rt == A3_M) & (rt != 5'b0) & RegWrite_M);
assign stall = stallRs | stallRt;
assign en_PC = ~stall;
assign en_F = ~stall;
assign reset_D = stall;
assign en_D = 1'b1;
assign en_E = 1'b1;
assign en_M = 1'b1;
//转发
//D
assign RD1_DSel = (rs == A3_E && rs != 5'b0 && Tnew_E == 2'b0 && RegWrite_E) ? 2'b01 :
                  (rs == A3_M && rs != 5'b0 && Tnew_M == 2'b0 && RegWrite_M && !Jal_M) ? 2'b10 :
                  (rs == A3_M && rs != 5'b0 && Tnew_M == 2'b0 && RegWrite_M && Jal_M) ? 2'b11 :
                  2'b00;
assign RD2_DSel = (rt == A3_E && rt != 5'b0 && Tnew_E == 2'b0 && RegWrite_E) ? 2'b01 :
                  (rt == A3_M && rt != 5'b0 && Tnew_M == 2'b0 && RegWrite_M && !Jal_M) ? 2'b10 :
                  (rt == A3_M && rt != 5'b0 && Tnew_M == 2'b0 && RegWrite_M && Jal_M) ? 2'b11 :
                  2'b00;
//E
assign srcASel = (A1_E == A3_M && A1_E != 5'b0 && Tnew_M == 2'b0 && RegWrite_M && !Jal_M) ? 2'b01 ://优先选择M级数据
                 (A1_E == A3_M && A1_E != 5'b0 && Tnew_M == 2'b0 && RegWrite_M && Jal_M) ? 2'b10 :
                 (A1_E == A3_W && A1_E != 5'b0 && Tnew_W == 2'b0 && RegWrite_W) ? 2'b11 :
                 2'b00;
assign srcBSel = (A2_E == A3_M && A2_E != 5'b0 && Tnew_M == 2'b0 && RegWrite_M && !Jal_M) ? 2'b01 :
                 (A2_E == A3_M && A2_E != 5'b0 && Tnew_M == 2'b0 && RegWrite_M && Jal_M) ? 2'b10 :
                 (A2_E == A3_W && A2_E != 5'b0 && Tnew_W == 2'b0 && RegWrite_W) ? 2'b11 :
                 2'b00;
//M
assign dmWDSel = (A2_M == A3_W && A2_M != 5'b0 && Tnew_W == 2'b0 && RegWrite_W) ? 1'b1 : 1'b0;
endmodule