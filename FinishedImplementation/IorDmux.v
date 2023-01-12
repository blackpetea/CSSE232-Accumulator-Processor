`timescale 1ns / 1ns

module IorDmux(op, A, B, muxOut);
     
  input op;
  input[15:0] A; //Data
  input[15:0] B; //Instruction
     
  output reg[15:0] muxOut;



 always @(op, A, B) begin 
    case (op)
      0: muxOut = A; //ALUout Register
      1: muxOut = B; //from PC
    endcase
  end



endmodule