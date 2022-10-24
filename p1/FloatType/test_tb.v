`timescale  1ns / 1ps
`include "VoterPlus.v"
module tb_VoterPlus;

// VoterPlus Parameters
parameter PERIOD  = 10;


// VoterPlus Inputs
reg   clk                                  = 0 ;
reg   reset                                = 0 ;
reg   [31:0]  np                           = 0 ;
reg   [7:0]  vip                           = 0 ;
reg   vvip                                 = 0 ;

// VoterPlus Outputs
wire  [7:0]  result                        ;


VoterPlus  u_VoterPlus (
    .clk                     ( clk            ),
    .reset                   ( reset          ),
    .np                      ( np      [31:0] ),
    .vip                     ( vip     [7:0]  ),
    .vvip                    ( vvip           ),

    .result                  ( result  [7:0]  )
);
always #5 clk = ~clk;
initial
begin
    $dumpfile("test.vcd");
    $dumpvars;
    reset = 1;
    #2
    reset = 0;
    np = 32'hfffffff0;
    vip = 8'b1101_0101;
    vvip = 0;
    #3;
    #5;
    np = 32'h000f;
    vip = 8'b0010_1010;
    vvip = 1;
    #100;
    $finish;
end

endmodule