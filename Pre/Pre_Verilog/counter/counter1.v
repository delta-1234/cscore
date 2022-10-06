module code(
    input Clk,
    input Reset,
    input Slt,
    input En,
    output reg [63:0] Output0,
    output reg [63:0] Output1
);
reg [63:0] cnt;//用于存储计数器1有效时钟周期
always @(posedge Clk) begin
    if(Reset == 1) begin
      Output0 <= 64'b0;
      Output1 <= 64'b0;
      cnt <= 64'b0;
    end
    else begin
      if(En == 1) begin
        if(Slt == 0) begin
          cnt <= cnt;
          Output0 <= Output0 + 64'b1;
        end
        else begin
          cnt <= cnt + 64'b1;
          if(cnt[1:0] == 2'b11) begin
            Output1 <= Output1 + 64'b1;
          end          
          else
          Output1 <= Output1;
        end
      end
      else begin
        Output0 <= Output0;
        Output1 <= Output1;
        cnt <= cnt;
      end
    end
end
endmodule