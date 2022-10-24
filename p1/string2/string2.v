module string2(
    input clk,
    input clr,
    input [7:0] in,
    output out
);
localparam s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7;
reg [2:0] state,next_state;
initial begin
  state = s0;
  next_state = s0;
end
//状态转移，组合逻辑
always @(*) begin
    case(state)
      s0 : begin
        if(in >= "0" && in <= "9")
        next_state = s1;
        else if(in == "(")
        next_state = s3;
        else
        next_state = s7;
      end
      s1 : begin
        if(in == "+" || in == "*")
        next_state = s2;
        else
        next_state = s7;
      end
      s2 : begin
        if(in >= "0" && in <= "9")
        next_state = s1;
        else if(in == "(")
        next_state = s3;
        else
        next_state = s7;
      end
      s3 : begin
        if(in >= "0" && in <= "9")
        next_state = s4;
        else
        next_state = s7;
      end
      s4 : begin
        if(in == ")")
        next_state = s5;
        else if(in == "+" || in == "*")
        next_state = s6;
        else
        next_state = s7;
      end
      s5 : begin
        if(in == "+" || in == "*")
        next_state = s2;
        else
        next_state = s7;
      end
      s6 : begin
        if(in >= "0" && in <= "9")
        next_state = s4;
        else
        next_state = s7;
      end
      s7 : begin
        next_state = s7;
      end
      default : ;
    endcase
end
//状态储存,注意异步复位
always @(posedge clk, posedge clr) begin
  if(clr == 1)
  state <= s0;
  else
  state <= next_state;
end
//输出逻辑
assign out = (state == s1) ? 1 :
            (state == s5) ? 1 : 0;
endmodule