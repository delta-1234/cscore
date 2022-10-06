module code(
    input Clk,
    input Reset,
    input Slt,
    input En,
    output reg [63:0] Output0,
    output reg [63:0] Output1
);
integer cnt;
always @(posedge Clk) begin
    if(Reset == 1) begin
      Output0 <= 64'b0;
      Output1 <= 64'b0;
      cnt = 0;
    end
    else begin
      if(En == 1) begin
        if(Slt == 0)
        Output0 <= Output0 + 64'b1;
        else begin
          cnt = cnt + 1;
          if(cnt % 4 == 0) begin
            cnt = 0;
            Output1 <= Output1 + 64'b1;
          end          
          else
          Output1 <= Output1;
        end
      end
      else begin
        Output0 <= Output0;
        Output1 <= Output1;
      end
    end
end
endmodule