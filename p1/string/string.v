`timescale 1ns / 1ps
module expr(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );
reg [1:0] state,next_state;
parameter s0 = 2'b00,s1 = 2'b01, s2 = 2'b10,s3 = 2'b11;
initial begin
state = s0;
next_state = s0;
end
always @(*) begin
	case(state)
		s0 : begin
			if(in >= "0" && in <= "9")
			next_state = s1;
			else
			next_state = s3;
		end
		s1 : begin
			if(in == "+" || in == "*")
			next_state = s2;
			else
			next_state = s3;
		end
		s2 : begin
			if(in >= "0" && in <= "9")
			next_state = s1;
			else
			next_state = s3;
		end
		s3 : next_state = s3;
		default :;
		endcase
end
always @(posedge clk or posedge clr) begin
	if(clr == 1)
	state <= s0;
	else
	state <= next_state;
end
assign out = (clr == 1) ? 0 : 
				(state == s1) ? 1 : 0;
endmodule
