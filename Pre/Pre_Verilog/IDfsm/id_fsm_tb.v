`timescale  1ns / 1ps
`include "id_fsm.v"
module tb_id_fsm;

// id_fsm Parameters
parameter PERIOD  = 10;


// id_fsm Inputs
reg   [7:0]  char                          = 0 ;
reg   clk                                  = 0 ;

// id_fsm Outputs
wire  out                                  ;


id_fsm  u_id_fsm (
    .char                    ( char  [7:0] ),
    .clk                     ( clk         ),

    .out                     ( out         )
);
always #5 clk = ~clk;
initial
begin
    $dumpfile("id_fsm.vcd");
    $dumpvars;
    #10
    char = "1";//a
    #10
    char = "2";//b
    #10
    char = 99;//c
    #10
    char = 100;//d
    #10
    char = 49;//1
    #10
    char = 50;//2
    #10
    char = 51;//3
    #10
    char = 58;//:
    #10
    $finish;
end

endmodule