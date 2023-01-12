`timescale 1ns / 1ns



module ALUmux_A(
      op,
      A,
      //B,
      C,
      D,
    muxOut
    );
     
  input[1:0] op;
  input[15:0] A;
  //input[15:0] B;
  input[15:0] C;
  input[15:0] D;
     
  output reg[15:0] muxOut;



  //case
always @(op, A, C, D) begin // do we also need our mux to be sensitive to ABCDE here?
    case (op)
      0: muxOut = A;
      1: muxOut = 8;
      2: muxOut = C;
      3: muxOut = D;  
    endcase
		 
  end

endmodule
