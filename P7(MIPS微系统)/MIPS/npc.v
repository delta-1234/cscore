module npc(
    input B,
    input [31:0] offset,
    input J,
    input [25:0] index,
    input Jr,
    input [31:0] addr,
    input [31:0] PC,
    output [31:0] NPC
);
assign NPC = (Jr == 1'b1) ? addr :
            (J == 1'b1) ? {PC[31:28],index,2'b00} :
            (B == 1'b1) ? (offset << 5'h2) + PC :
            PC + 32'h4;
endmodule