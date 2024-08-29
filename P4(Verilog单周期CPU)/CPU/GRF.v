module GRF(
    input Clk,
    input Reset,
    input [4:0] Address1,
    input [4:0] Address2,
    input [4:0] WriteAddress,
    input [31:0] WriteData,
    input WriteEn,
    input [31:0] PC,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);
reg [31:0] Register[0:31];
assign ReadData1 = Register[Address1];
assign ReadData2 = Register[Address2];
integer i=0;
always @(posedge Clk) begin
    if(Reset == 1'b1) begin
      for(i=0;i<32;i=i+1) begin
        if(i == 29)
        Register[i] <= 32'b2ffc;//$sp指针指向栈顶
        else
        Register[i] <= 32'b0;
      end
    end
    else begin
      if(WriteEn == 1'b1) begin
        $display("@%h: $%d <= %h", PC, WriteAddress, WriteData);
        if(WriteAddress == 5'b0)
        Register[0]<=32'b0;
        else
        Register[WriteAddress] <= WriteData;
      end
      else begin
        Register[0]=32'b0;
      end
    end
end
endmodule