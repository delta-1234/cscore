`include "define.v"
module cpu_checker(
    input clk,
    input reset,
    input [7:0] char,
    output reg [1:0] format_type
);
reg flag;
reg [5:0] state;
always @(posedge clk) begin
    if(reset == 1'b1) begin
      flag <= 1'b0;
      state <= `s0;
      format_type <= 2'b00;
    end
    else begin
      case(state)
      `s0 : begin
        format_type <= 2'b00;
        flag <= 1'b0;
        if(char == "^")
        state <= `s1;
        else
        state <= `s0;
      end
      `s1 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9")
        state <= `s2;
        else
        state <= `s0;
      end
      `s2 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9")
        state <= `s3;
        else if(char == "@")
        state <= `s6;
        else
        state <= `s0;
      end
      `s3 : begin
        if(char == "^")
        state <= `s1;
        else if(char == "@")
        state <= `s6;
        else if(char >= "0" && char <= "9")
        state <= `s4;
        else
        state <= `s0;
      end
      `s4 : begin
        if(char == "^")
        state <= `s1;
        else if(char == "@")
        state <= `s6;
        else if(char >= "0" && char <= "9")
        state <= `s5;
        else
        state <= `s0;
      end
      `s5 : begin
        if(char == "^")
        state <= `s1;
        else if(char == "@")
        state <= `s6;
        else
        state <= `s0;
      end
      `s6 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s7;
        else
        state <= `s0;
      end
      `s7 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s8;
        else
        state <= `s0;
      end
      `s8 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s9;
        else
        state <= `s0;        
      end
      `s9 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s10;
        else
        state <= `s0;        
      end
      `s10 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s11;
        else
        state <= `s0;         
      end
      `s11 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s12;
        else
        state <= `s0;          
      end
      `s12 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s13;
        else
        state <= `s0;
      end
      `s13 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s14;
        else
        state <= `s0;
      end
      `s14 : begin
        if(char == "^")
        state <= `s1;
        else if(char == ":")
        state <= `s15;
        else
        state <= `s0;
      end
      `s15 : begin
        if(char == "^")
        state <= `s1;
        else if(char == " ")
        state <= `s15;
        else if(char == "$") begin
          state <= `s16;
          flag <= 1'b0;
        end
        else if(char == "*") begin
          state <= `s33;
          flag <= 1'b1;
        end
        else
        state <= `s0;
      end
      `s16 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9")
        state <= `s17;
        else
        state <= `s0;
      end
      `s17 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9")
        state <= `s18;
        else if(char == " ")
        state <= `s21;
        else if(char == "<")
        state <= `s22;
        else
        state <= `s0;
      end
      `s18 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9")
        state <= `s19;
        else if(char == " ")
        state <= `s21;
        else if(char == "<")
        state <= `s22;
        else
        state <= `s0;        
      end
      `s19 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9")
        state <= `s20;
        else if(char == " ")
        state <= `s21;
        else if(char == "<")
        state <= `s22;
        else
        state <= `s0;
      end
      `s20 : begin
        if(char == "^")
        state <= `s1;
        else if(char == " ")
        state <= `s21;
        else if(char == "<")
        state <= `s22;
        else
        state <= `s0;
      end
      `s21 : begin
        if(char == "^")
        state <= `s1;
        else if(char == " ")
        state <= `s21;
        else if(char == "<")
        state <= `s22;
        else
        state <= `s0;
      end
      `s22 : begin
        if(char == "=")
        state <= `s23;
        else if(char == "^")
        state <= `s1;
        else
        state <= `s0;
      end
      `s23 : begin
        if(char == "^")
        state <= `s1;
        else if(char == " ")
        state <= `s23;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s24;
        else
        state <= `s0;
      end
      `s24 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s25;
        else
        state <= `s0;        
      end
      `s25 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s26;
        else
        state <= `s0;         
      end
      `s26 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s27;
        else
        state <= `s0; 
      end
      `s27 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s28;
        else
        state <= `s0; 
      end
      `s28 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s29;
        else
        state <= `s0; 
      end
      `s29 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s30;
        else
        state <= `s0; 
      end
      `s30 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s31;
        else
        state <= `s0; 
      end
      `s31 : begin
        if(char == "^")
        state <= `s1;
        else if(char == "#") begin
          state <= `s0;
          if(flag == 1'b0)
          format_type <= 2'b01;
          else
          format_type <= 2'b10;
        end
        else
        state <= `s0;
      end
      `s33 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s34;
        else
        state <= `s0;
      end
      `s34 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s35;
        else
        state <= `s0;        
      end
      `s35 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s36;
        else
        state <= `s0;
      end
      `s36 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s37;
        else
        state <= `s0;
      end
      `s37 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s38;
        else
        state <= `s0;
      end
      `s38 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s39;
        else
        state <= `s0;
      end
      `s39 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s40;
        else
        state <= `s0;
      end
      `s40 : begin
        if(char == "^")
        state <= `s1;
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))
        state <= `s41;
        else
        state <= `s0;
      end
      `s41 : begin
        if(char == "^")
        state <= `s1;
        else if(char == " ")
        state <= `s21;
        else if(char == "<")
        state <= `s22;
      end
      endcase
    end
end
endmodule