//~ `New testbench
`timescale  1ns / 1ps
`include "multDiv.v"
module tb_multDiv;

// multDiv Parameters
parameter PERIOD  = 10;


// multDiv Inputs
reg   clk                                  = 0 ;
reg   reset                                = 0 ;
reg   Start                                = 0 ;
reg   [3:0]  ALUOp                         = 0 ;
reg   [31:0]  D1                           = 0 ;
reg   [31:0]  D2                           = 0 ;

// multDiv Outputs
wire  Busy                                 ;
wire  [31:0]  LO                           ;
wire  [31:0]  HI                           ;


multDiv  u_multDiv (
    .clk                     ( clk           ),
    .reset                   ( reset         ),
    .Start                   ( Start         ),
    .ALUOp                   ( ALUOp  [3:0]  ),
    .D1                      ( D1     [31:0] ),
    .D2                      ( D2     [31:0] ),

    .Busy                    ( Busy          ),
    .LO                      ( LO     [31:0] ),
    .HI                      ( HI     [31:0] )
);
always #5 clk = ~clk;
initial
begin
    $dumpfile("z_test.vcd");
    $dumpvars;
    clk = 1;
    reset = 1;
    #10
    reset = 0;
    Start = 1;
    ALUOp = 4'b1111;
    D1 = 32'hffff_ffff;
    D2 = 32'h2;
    #10
    Start = 0;
    ALUOp = 4'b0;
    #200;
    $finish;
end

endmodule