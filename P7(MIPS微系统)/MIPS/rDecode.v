module rDecode(
    input [5:0] func,
    input en,
    output add,
    output sub,
    output sllv,
    output slt,
    output jr,
    output andR,
    output orR,
    output sltu,
    output mult,
    output multu,
    output div,
    output divu,
    output mfhi,
    output mflo,
    output mthi,
    output mtlo,
    output syscall
);
assign add = (en == 1'b1) ? ((func == 6'b100000) ? 1'b1 : 1'b0) : 1'b0;
assign sub = (en == 1'b1) ? ((func == 6'b100010) ? 1'b1 : 1'b0) : 1'b0;
assign sllv = (en == 1'b1) ? ((func == 6'b000100) ? 1'b1 : 1'b0) : 1'b0;
assign slt = (en == 1'b1) ? ((func == 6'b101010) ? 1'b1 : 1'b0) : 1'b0;
assign jr = (en == 1'b1) ? ((func == 6'b001000) ? 1'b1 : 1'b0) : 1'b0;
assign andR = (en == 1'b1) ? ((func == 6'b100100) ? 1'b1 : 1'b0) : 1'b0;
assign orR = (en == 1'b1) ? ((func == 6'b100101) ? 1'b1 : 1'b0) : 1'b0;
assign sltu = (en == 1'b1) ? ((func == 6'b101011) ? 1'b1 : 1'b0) : 1'b0;
assign mult = (en == 1'b1) ? ((func == 6'b011000) ? 1'b1 : 1'b0) : 1'b0;
assign multu = (en == 1'b1) ? ((func == 6'b011001) ? 1'b1 : 1'b0) : 1'b0;
assign div = (en == 1'b1) ? ((func == 6'b011010) ? 1'b1 : 1'b0) : 1'b0;
assign divu = (en == 1'b1) ? ((func == 6'b011011) ? 1'b1 : 1'b0) : 1'b0;
assign mfhi = (en == 1'b1) ? ((func == 6'b010000) ? 1'b1 : 1'b0) : 1'b0;
assign mflo = (en == 1'b1) ? ((func == 6'b010010) ? 1'b1 : 1'b0) : 1'b0;
assign mthi = (en == 1'b1) ? ((func == 6'b010001) ? 1'b1 : 1'b0) : 1'b0;
assign mtlo = (en == 1'b1) ? ((func == 6'b010011) ? 1'b1 : 1'b0) : 1'b0;
assign syscall = (en == 1'b1) ? ((func == 6'b001100) ? 1'b1 : 1'b0) : 1'b0;
endmodule