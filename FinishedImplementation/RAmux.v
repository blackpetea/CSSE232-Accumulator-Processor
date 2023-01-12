`timescale 1ns / 1ns



module RAmux(op, A, B, muxOut);
     
  input op;
  input [15:0] A; //ACC out
  input [15:0] B; //PC out
     
  output reg [15:0] muxOut;



 always @(op, A, B) begin 
    case (op)
      0: muxOut = A; //from acc
      1: muxOut = B; //from pc 
    endcase
  end



endmodule