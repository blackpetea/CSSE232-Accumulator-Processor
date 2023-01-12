`timescale 1ns / 1ns



module RAmux_2(
		op,
		A,
      B,
    muxOut
    );
     
  input[0] op;
  input[15:0] A; //ACC out
  input[15:0] B; //PC out
     
  output reg[15:0] muxOut;



 always @(op, A, B) begin // do we also need our mux to be sensitive to ABCDE here?
    case (op)
      0: muxOut = A; 
      1: muxOut = B;   
    endcase
  end



endmodule
