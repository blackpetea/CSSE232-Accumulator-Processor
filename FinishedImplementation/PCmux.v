`timescale 1ns / 1ns



module PCmux(op, A, B, C, muxOut);
     
  input[1:0] op; //PCout
  input[15:0] A; //inst register out (SE)
  input[15:0] B; //RA out
  input[15:0] C; //ALU result
  
  output reg[15:0] muxOut;



 always @(op, A, B, C) begin 
    case (op)
      0: muxOut = A;
      1: muxOut = B;
      2: muxOut = C;
    endcase
  end



endmodule