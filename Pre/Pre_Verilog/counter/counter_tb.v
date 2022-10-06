`timescale  1ns / 1ps
`include "counter.v"
module tb_code;

// code Parameters
parameter PERIOD  = 10;


// code Inputs
reg   Clk                                  = 0 ;
reg   Reset                                  = 0 ;
reg   Slt                                  = 0 ;
reg   En                                   = 0 ;

// code Outputs
wire  [63:0]  Output0                      ;
wire  [63:0]  Output1                      ;



code  u_code (
    .Clk                     ( Clk             ),
    .Reset                     ( Reset             ),
    .Slt                     ( Slt             ),
    .En                      ( En              ),

    .Output0                 ( Output0  [63:0] ),
    .Output1                 ( Output1  [63:0] )
);
always #5 Clk = ~Clk;
initial
begin
    $dumpfile("counter.vcd");
    $dumpvars;
    Reset = 1;
    #10
    Reset = 0;
    En = 1;
    #10
    Slt = 0;
    #10
    Slt = 1;
    #10 
    Slt = 1;
    #10
    Slt = 0;
    #10
    Slt = 1;
    #10
    Slt = 0;
    #10
    Slt = 1;
    #10 
    Slt = 1;
    #10
    Slt = 0;
    #10
    Slt = 1;
    #10
    Reset = 1; 
    #10   
    $finish;
end

endmodule