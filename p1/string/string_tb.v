`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:51:27 10/05/2022
// Design Name:   string
// Module Name:   /home/co-eda/string/string_tb.v
// Project Name:  string
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: string
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module string_tb;

	// Inputs
	reg clk;
	reg clr;
	reg [7:0] in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	string uut (
		.clk(clk), 
		.clr(clr), 
		.in(in), 
		.out(out)
	);
always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		in = "1";
		#10
		in = "+";
		#10
		in = "2";
		#10
		in = "*";
		#10
		in = "*";
		#10
		in = "3";
		#30
		clr = 1;
		#10
		clr = 0;
		in = "1";
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

