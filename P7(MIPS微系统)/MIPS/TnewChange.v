module TnewChange(
    input [1:0] lastTnew,
    output [1:0] nextTnew
);
assign nextTnew = (lastTnew == 2'b0) ? 2'b0 : lastTnew - 1;
endmodule