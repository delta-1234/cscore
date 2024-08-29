`define aluAnd 4'b0000
`define aluOr 4'b0001
`define aluAdd 4'b0010
`define aluLui 4'b0101
`define aluSub 4'b0110
`define aluBeq 4'b0111 
`define aluLess 4'b1001 
`define aluLessU 4'b1010 
`define aluSll 4'b1011
`define aluMult 4'b1100
`define aluDiv 4'b1101 
`define aluMultU 4'b1110
`define aluDivU 4'b1111  

`define SR 5'd12
`define Cause 5'd13
`define EPC 5'd14

`define Int 5'd0
`define AdEL 5'd4
`define AdES 5'd5
`define Syscall 5'd8
`define RI 5'd10
`define Ov 5'd12