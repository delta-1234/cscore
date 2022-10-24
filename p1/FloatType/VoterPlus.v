module VoterPlus(
	input clk,
	input reset,
	input [31:0] np,
	input [7:0] vip,
	input vvip,
	output reg [7:0] result
);
reg [31:0] np_state;
reg [7:0] vip_state;
reg vvip_state;
integer count = 0,i;
always @(posedge clk,posedge reset) begin
	if(reset == 1) begin
	  np_state <= 0;
	  vip_state <= 0;
	  vvip_state <= 0;
	  count <= 0;
	  result <= 0;
	end
	else begin
	  for(i = 0;i < 32;i = i + 1) begin
		if(np[i] == 1 && np_state[i] == 0) begin
		  np_state[i] = 1;
		  count = count + 1;
		end
	  end
	  for(i = 0;i < 8;i = i + 1) begin
		if(vip[i] == 1 && vip_state[i] == 0) begin
		  vip_state[i] = 1;
		  count = count + 4;
		end
	  end
	  if(vvip == 1 && vvip_state == 0) begin
		vvip_state = 1;
		count = count + 16;
	  end
	  result <= count;
	end
end

endmodule
