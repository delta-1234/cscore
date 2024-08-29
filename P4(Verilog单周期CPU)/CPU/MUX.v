module MUX8Bits4(
    input [7:0] In0,
    input [7:0] In1,
    input [7:0] In2,
    input [7:0] In3,
    input [1:0] Sel,
    output [7:0] Out
);
assign Out = (Sel == 2'b00) ? In0 :
             (Sel == 2'b01) ? In1 :
             (Sel == 2'b10) ? In2 :
             (Sel == 2'b11) ? In3 : 8'b0;
endmodule

module MUX1Bits2(
    input In0,
    input In1,
    input Sel,
    output Out
);
assign Out = (Sel == 1'b0) ? In0 :
             (Sel == 1'b1) ? In1 : 1'b0;
endmodule

module MUX5Bits2(
    input [4:0] In0,
    input [4:0] In1,
    input Sel,
    output [4:0] Out
);
assign Out = (Sel == 1'b0) ? In0 :
             (Sel == 1'b1) ? In1 : 5'b0;
endmodule

module MUX32Bits2(
    input [31:0] In0,
    input [31:0] In1,
    input Sel,
    output [31:0] Out
);
assign Out = (Sel == 1'b0) ? In0 :
             (Sel == 1'b1) ? In1 : 32'b0;
endmodule