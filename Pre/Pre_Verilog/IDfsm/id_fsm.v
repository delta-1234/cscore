module id_fsm(
    input [7:0] char,
    input clk,
    output reg out
);
reg [7:0] id[1023:0];
integer i = 0;                                        
integer j;
always @(posedge clk) begin
      id[i] <= char;
      if(out == 1'b1) begin
        if(char >= "0" && char <= "9") 
            out <= 1'b1;
        else
            out <= 1'b0;
      end
      else begin
        if(char >= "0" && char <= "9") begin
            for(j = i - 1;j != -1 && id[j]>= "0" && id[j] <= "9";j = j - 1);
            if(j == -1)
                out <= 1'b0;
            else if((id[j] >= "a" && id[j] <="z")||(id[j] >= "A" && id[j] <="Z"))
                out <= 1'b1;
            else
                out <= 1'b0;
        end
        else
            out <= 1'b0;
      end
    i = i + 1;
end
endmodule