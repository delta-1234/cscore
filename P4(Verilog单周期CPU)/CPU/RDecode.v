module RDecode(
    input [5:0] Func,
    input En,
    output add,
    output sub,
    output sll,
    output sllv,
    output slt,
    output jr
);
assign add = (En == 1'b1) ? ((Func == 6'b100000) ? 1'b1 : 1'b0) : 1'b0;
assign sub = (En == 1'b1) ? ((Func == 6'b100010) ? 1'b1 : 1'b0) : 1'b0;
assign sll = (En == 1'b1) ? ((Func == 6'b000000) ? 1'b1 : 1'b0) : 1'b0;
assign sllv = (En == 1'b1) ? ((Func == 6'b000100) ? 1'b1 : 1'b0) : 1'b0;
assign slt = (En == 1'b1) ? ((Func == 6'b101010) ? 1'b1 : 1'b0) : 1'b0;
assign jr = (En == 1'b1) ? ((Func == 6'b001000) ? 1'b1 : 1'b0) : 1'b0;
endmodule