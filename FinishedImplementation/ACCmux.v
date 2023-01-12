`timescale 1ns / 1ns



module ACCmux(
	op,
	 A,
      B,
      C,
      D,
    muxOut
    );
     
  input[1:0] op; //acc source
  input[15:0] A; //ra out
  input[15:0] B; //inst register out (SE)
  input[15:0] C; //MDR out
  input[15:0] D; //ALU out 
     
  output reg[15:0] muxOut;



 always @(op, A, B, C, D) begin 
    case (op)
      0: muxOut = A;
      1: muxOut = B;
      2: muxOut = C;
      3: muxOut = D;   
    endcase
  end



endmodule