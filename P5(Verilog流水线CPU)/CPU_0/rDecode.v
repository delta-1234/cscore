module rDecode(
    input [5:0] func,
    input en,
    output add,
    output sub,
    output sllv,
    output slt,
    output jr
);
assign add = (en == 1'b1) ? ((func == 6'b100000) ? 1'b1 : 1'b0) : 1'b0;
assign sub = (en == 1'b1) ? ((func == 6'b100010) ? 1'b1 : 1'b0) : 1'b0;
assign sllv = (en == 1'b1) ? ((func == 6'b000100) ? 1'b1 : 1'b0) : 1'b0;
assign slt = (en == 1'b1) ? ((func == 6'b101010) ? 1'b1 : 1'b0) : 1'b0;
assign jr = (en == 1'b1) ? ((func == 6'b001000) ? 1'b1 : 1'b0) : 1'b0;
endmodule