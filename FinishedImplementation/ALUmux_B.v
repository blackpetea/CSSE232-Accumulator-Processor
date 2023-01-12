`timescale 1ns / 1ns



module ALUmux_B(
      op,
      B,
      C,
    muxOut
    );
     
  input[1:0] op;
  input[15:0] B;
  input[15:0] C;
     
  output reg[15:0] muxOut;



 //only 3 mux options and op 0 is hardwired to 2
 always @(op, B, C) begin 
    case (op)
      0: muxOut = 1;
      1: muxOut = B;
      2: muxOut = C;
    endcase
  end



endmodule