`timescale 1ns / 1ns



module ALUmux_B(
      op,
      B,
      C,
      D,
    muxOut
    );
     
  input[2:0] op;
  input[15:0] B;
  input[15:0] C;
  input[15:0] D;
     
  output reg[15:0] muxOut;



 //only 3 mux options and op 0 is hardwired to 2
 always @(op, B, C, D) begin // do we also need our mux to be sensitive to ABCDE here?
    case (op)
      0: muxOut = 2;
      1: muxOut = B;
      2: muxOut = C;
      3: muxOut = D;  
    endcase
  end



endmodule
