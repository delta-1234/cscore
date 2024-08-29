module NPC(
    input B,
    input [31:0] Offset,
    input J,
    input [25:0] Index,
    input Jr,
    input [31:0] A,
    input [31:0] PC,
    output [31:0] NPC
);
assign NPC = (Jr == 1'b1) ? A :
            (J == 1'b1) ? {PC[31:28],Index,2'b00} :
            (B == 1'b1) ? (Offset << 5'h2) + PC + 32'h4 :
            PC + 32'h4;
endmodule