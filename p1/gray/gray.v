`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:04 10/05/2022 
// Design Name: 
// Module Name:    gray 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );
reg [3:0] state,next_state;
reg Over;
parameter s0 = 3'b000,s1 = 3'b001,s2 = 3'b011,s3 = 3'b010,s4 = 3'b110,
s5 = 3'b111,s6 = 3'b101,s7 = 3'b100;
always @(*) begin
	case(state)
		s0 : next_state = s1;
		s1 : next_state = s2;
		s2 : next_state = s3;
		s3 : next_state = s4;
		s4 : next_state = s5;
		s5 : next_state = s6;
		s6 : next_state = s7;
		s7 : next_state = s0;
		default :;
	endcase
end
always @(posedge Clk) begin
if(Reset == 1) begin
	state <= s0;
	Over <= 0;
end
else begin
	if(En == 1) begin
	state <= next_state;
	if(state == s7)
	Over <= 1;
	end
end
end
assign Output = state;
assign Overflow = (Over == 1) ? 1 : 0;
endmodule
