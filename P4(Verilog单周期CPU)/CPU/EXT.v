module EXT16Op32(
    input [15:0] Imm,
    input Op,
    output [31:0] Ext
);
assign Ext = (Op == 1)? ((Imm[15] == 1'b1) ? {16'hffff,Imm} : {16'h0000,Imm} ):
            {16'h0000,Imm};
endmodule

module EXT2Zero5(
    input [1:0] Imm,
    output [4:0] Ext
);
assign Ext = {3'b0,Imm};
endmodule

module EXT8Zero32(
    input [7:0] Imm,
    output [31:0] Ext
);
assign Ext = {24'b0,Imm};
endmodule

module EXT5Zero32(
    input [4:0] Imm,
    output [31:0] Ext
);
assign Ext = {27'b0,Imm};
endmodule