`timescale  1ns / 1ps
`include "string2.v"
module tb_string2;

// string2 Parameters
parameter PERIOD  = 10;


// string2 Inputs
reg   clk                                  = 0 ;
reg   clr                                  = 0 ;
reg   [7:0]  in                            = 0 ;

// string2 Outputs
wire  out                                  ;


string2  u_string2 (
    .clk                     ( clk        ),
    .clr                     ( clr        ),
    .in                      ( in   [7:0] ),

    .out                     ( out        )
);

always #5 clk = ~clk;
initial
begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    clr = 0;
    in = "1";
    #2
    clr = 0;
    #8
    in = "+";
    #10
    in = "(";
    #10
    in = "1";
    #10
    in = "+";
    #10
    in = "2";
    #10
    in = "*";
    #10
    in = "1";
    #10
    in = "+";
    #10
    in = "2";
    #10
    in = ")";
    #10
    in = "*";
    #10
    in = "(";
    #10
    in = "3";
    #10
    in = ")";
    #10;
    $finish;
end

endmodule