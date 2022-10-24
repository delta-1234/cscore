module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output reg result
);
reg [55:0] word;
reg [55:0] next_word;
reg [7:0] temp;
integer j = 0;
always @(*) begin
    if(in >= "A" && in <= "Z") begin
      temp = "a" + in - "A";
    end
    else begin
      temp = in;
    end
    next_word = (word << 8) + temp;
end
always @(posedge clk or posedge reset) begin
  if(reset == 1) begin
    word <= {48'b0," "};
    j <= 0;
    result <= 1;
  end
  else begin
    word <= next_word;

    if(next_word[39:0] == {"b","e","g","i","n"} && !(next_word[47:40] >= "a" && next_word[47:40] <= "z")) begin
      if(j>=0) begin
        j <= j + 1;
        result <= 0;
      end
    end
    else if(next_word [55:48] >= "a" && next_word[55:48] <= "z" && next_word[47:8] == {"b","e","g","i","n"})
      j <= j;
    else if(next_word[47:8] == {"b","e","g","i","n"} && next_word[7:0] >= "a" && next_word[7:0] <= "z") begin
      if(j>=0) begin
        j <= j - 1;
        result <= (j == 1) ? 1 : 0;
      end
    end
    else if(next_word[23:0] == {"e","n","d"} && !(next_word[31:24] >= "a" && next_word[31:24] <= "z")) begin
      j <= j - 1;
      result <= (j == 1) ? 1 : 0;
    end
    else if(next_word[39:32] >= "a" && next_word[39:32] <= "z" && next_word[31:8] == {"e","n","d"})
      j <= j;
    else if(next_word[31:8] == {"e","n","d"} && next_word[7:0] >= "a" && next_word[7:0] <= "z") begin
      j <= j + 1;
      result <= (j == -1) ? 1 : 0;
    end
  end
end
endmodule