`timescale  1ns / 1ps
`include "BlockChecker.v"
module tb_BlockChecker;

// BlockChecker Parameters
parameter PERIOD  = 10;


// BlockChecker Inputs
reg   clk                                  = 0 ;
reg   reset                                = 0 ;
reg   [7:0]  in                            = 0 ;

// BlockChecker Outputs
wire  result                               ;



BlockChecker  u_BlockChecker (
    .clk                     ( clk           ),
    .reset                   ( reset         ),
    .in                      ( in      [7:0] ),

    .result                  ( result        )
);
always #5 clk = ~clk;
initial
begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    reset = 1;
    in = ",";
    #2
    reset = 0;
    #8
    in = "e";
    #10
    in = "n";
    #10
    in = "d";
    #10
    in = "d";
    #10
    in = "e";
    #10
    in = "n";
    #10
    in = "d";
    #10
    in = "s";
    #10
    in = " ";
    #10
    in = "B";
    #10
    in = "E";
    #10
    in = "g";
    #10
    in = "I";
    #10
    in = "n";
    #10
    in = ".";
    #10
    in = "B";
    #10
    in = "E";
    #10
    in = "g";
    #10
    in = "I";
    #10
    in = "n";
    #10
    in = ".";
    #10
    in = "E";
    #10
    in = "n";
    #10
    in = "d";
    #10
    in = ".";
    #10
    in = ",";
    #10
    in = "e";
    #10
    in = "n";
    #10
    in = "d";
    #10
    in = " ";
    #100
    $finish;
end

endmodule