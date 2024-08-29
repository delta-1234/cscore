`default_nettype none
`include "DataPath.v"
module mips(
    input clk,
    input reset
);
DataPath dp(clk,reset);
endmodule