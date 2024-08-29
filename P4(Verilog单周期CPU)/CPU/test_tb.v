`timescale  1ns / 1ps
`include "DataPath.v"

module tb_DataPath;

// mips Parameters
parameter PERIOD  = 10;


// mips Inputs
reg   Clk                                  = 0 ;
reg   Reset                                = 0 ;

// mips Outputs


DataPath  u_DataPath (
    .Clk                     ( Clk     ),
    .Reset                   ( Reset   )
);

always #1 Clk=~Clk;
initial
begin
    $dumpfile("test.vcd");
    $dumpvars;
    Clk=0;
    Reset = 1;
    #2
    Reset = 0;
    #10000
    $finish;
end

endmodule