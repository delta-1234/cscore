`include "define.v"
module cpu_checker(
    input clk,
    input reset,
    input [7:0] char,
    input [15:0] freq,
    output reg [1:0] format_type,
    output reg [3:0] error_code
);
reg flag;
reg [5:0] state;
reg [15:0] tim;
reg [31:0] pc;
reg [31:0] addr;
reg [15:0] grf;
reg t;
reg p;
reg a;
reg g;
integer i;
integer x;
always @(posedge clk) begin
    if(reset == 1'b1) begin
      flag <= 1'b0;
      state <= `s0;
      format_type <= 2'b00;
      error_code <= 4'b0000;
      tim <= 16'h0000;
      pc <= 32'h00000000;
      addr <= 32'h00000000;
      grf <= 16'h0000;
      t <= 1'b0;
      p <= 1'b0;
      a <= 1'b0;
      g <= 1'b0;
    end
    else begin
      case(state)
      `s0 : begin
        format_type <= 2'b00;
        flag <= 1'b0;
        error_code <= 4'b0000;
        tim <= 16'h0000;
        pc <= 32'h00000000;
        addr <= 32'h00000000;
        grf <= 16'h0000;
        t <= 1'b0;
        p <= 1'b0;
        a <= 1'b0;
        g <= 1'b0;
        if(char == "^")
        state <= `s1;
        else
        state <= `s0;
      end
      `s1 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s2;
          tim <= (tim << 3) + (tim << 1) + (char - "0");
        end
        else
        state <= `s0;
      end
      `s2 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s3;
          tim <= (tim << 3) + (tim << 1) + (char - "0");
        end
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
        else if(char >= "0" && char <= "9") begin
          state <= `s4;
          tim <= (tim << 3) + (tim << 1) + (char - "0");
        end
        else
        state <= `s0;
      end
      `s4 : begin
        if(char == "^")
        state <= `s1;
        else if(char == "@")
        state <= `s6;
        else if(char >= "0" && char <= "9") begin
          state <= `s5;
          tim <= (tim << 3) + (tim << 1) + (char - "0");
        end
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
        else if(char >= "0" && char <= "9") begin
          state <= `s7;
          pc <= (pc << 4) + (char - "0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s7;
          pc <= (pc << 4) + (char - "a") + 10;          
        end
        else
        state <= `s0;
      end
      `s7 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s8;
          pc <= (pc << 4) + (char - "0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s8;
          pc <= (pc << 4) + (char - "a") + 10;          
        end
        else
        state <= `s0;
      end
      `s8 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s9;
          pc <= (pc << 4) + (char - "0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s9;
          pc <= (pc << 4) + (char - "a") + 10;          
        end
        else
        state <= `s0;        
      end
      `s9 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s10;
          pc <= (pc << 4) + (char - "0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s10;
          pc <= (pc << 4) + (char - "a") + 10;          
        end
        else
        state <= `s0;        
      end
      `s10 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s11;
          pc <= (pc << 4) + (char - "0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s11;
          pc <= (pc << 4) + (char - "a") + 10;          
        end
        else
        state <= `s0;         
      end
      `s11 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s12;
          pc <= (pc << 4) + (char - "0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s12;
          pc <= (pc << 4) + (char - "a") + 10;          
        end
        else
        state <= `s0;          
      end
      `s12 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s13;
          pc <= (pc << 4) + (char - "0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s13;
          pc <= (pc << 4) + (char - "a") + 10;          
        end
        else
        state <= `s0;
      end
      `s13 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s14;
          pc <= (pc << 4) + (char - "0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s14;
          pc <= (pc << 4) + (char - "a") + 10;          
        end
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
        else if(char == 8'd42) begin
          state <= `s33;
          flag <= 1'b1;
        end
        else
        state <= `s0;
      end
      `s16 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s17;
          grf <= (grf << 3) + (grf << 1) + (char - "0");
        end
        else
        state <= `s0;
      end
      `s17 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s18;
          grf <= (grf << 3) + (grf << 1) + (char - "0");
        end
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
        else if(char >= "0" && char <= "9") begin
          state <= `s19;
          grf <= (grf << 3) + (grf << 1) + (char - "0");
        end
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
        else if(char >= "0" && char <= "9") begin
          state <= `s20;
          grf <= (grf << 3) + (grf << 1) + (char - "0");
        end
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
        else if((char >= "0" && char <= "9")||(char >= "a" && char <= "f")) begin
          
          if(freq == 2) t <= 1'b0;
          else if(freq == 4) begin
            if(tim[0:0]==1'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if(freq == 8) begin
            if(tim[1:0]==2'b00)
            t<=1'b0;
            else
            t<=1'b1;            
          end
          else if(freq == 16) begin
            if(tim[2:0]==3'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if(freq == 32) begin
            if(tim[3:0]==4'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if(freq == 64) begin
            if(tim[4:0]==5'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if(freq == 128) begin
            if(tim[5:0]==6'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if(freq == 256) begin
            if(tim[6:0]==7'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if(freq == 512) begin
            if(tim[7:0]==8'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if(freq == 1024) begin
            if(tim[8:0]==9'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if (freq == 2048) begin
            if(tim[9:0]==10'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if(freq == 4096) begin
            if(tim[10:0]==11'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else if(freq == 8192) begin
            if(tim[11:0]==12'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          else begin
            if(tim[12:0]==13'b0)
            t<=1'b0;
            else
            t<=1'b1;
          end
          if(pc>=32'h00003000&&pc<=32'h00004fff&&pc[1:0]==2'b00)
          p<=1'b0;
          else
          p<=1'b1;
          if(addr>=32'h00000000&&addr<=32'h00002fff&&addr[1:0]==2'b00)
          a<=1'b0;
          else
          a<=1'b1;
          if(grf>=0&&grf<=31)
          g<=1'b0;
          else
          g<=1'b1;          
        state <= `s31;
        end
        else
        state <= `s0; 
      end
      `s31 : begin
        if(char == "^")
        state <= `s1;
        else if(char == "#") begin
          state <= `s0;
          if(flag == 1'b0) begin
            format_type <= 2'b01; 
            error_code <= t + (p<<1) + (g<<3);
            end
          else begin
            format_type <= 2'b10;
            error_code <= t + (p<<1) + (a<<2);
          end
        end
        else
        state <= `s0;
      end
      `s33 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s34;
          addr <= (addr << 4) + (char -"0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s34;
          addr <= (addr << 4) + (char -"a") + 10;          
        end
        else
        state <= `s0;
      end
      `s34 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s35;
          addr <= (addr << 4) + (char -"0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s35;
          addr <= (addr << 4) + (char -"a") + 10;          
        end
        else
        state <= `s0;        
      end
      `s35 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s36;
          addr <= (addr << 4) + (char -"0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s36;
          addr <= (addr << 4) + (char -"a") + 10;          
        end
        else
        state <= `s0;
      end
      `s36 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s37;
          addr <= (addr << 4) + (char -"0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s37;
          addr <= (addr << 4) + (char -"a") + 10;          
        end
        else
        state <= `s0;
      end
      `s37 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s38;
          addr <= (addr << 4) + (char -"0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s38;
          addr <= (addr << 4) + (char -"a") + 10;          
        end
        else
        state <= `s0;
      end
      `s38 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s39;
          addr <= (addr << 4) + (char -"0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s39;
          addr <= (addr << 4) + (char -"a") + 10;          
        end
        else
        state <= `s0;
      end
      `s39 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s40;
          addr <= (addr << 4) + (char -"0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s40;
          addr <= (addr << 4) + (char -"a") + 10;          
        end
        else
        state <= `s0;
      end
      `s40 : begin
        if(char == "^")
        state <= `s1;
        else if(char >= "0" && char <= "9") begin
          state <= `s41;
          addr <= (addr << 4) + (char -"0");
        end
        else if(char >= "a" && char <= "f") begin
          state <= `s41;
          addr <= (addr << 4) + (char -"a") + 10;          
        end
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
      default : ;
      endcase
    end
end
endmodule