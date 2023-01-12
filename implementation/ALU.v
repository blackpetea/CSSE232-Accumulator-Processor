`timescale 1ns / 1ns

module ALU(
    A,
    B,
    op,
    ALUResult,
    ble,
    branchResult
    );
	 
input signed [15:0] A;
input signed [15:0] B;
input [2:0] op;


output reg signed[15:0] ALUResult;
output wire ble;
output wire branchResult;

  assign branchResult = (A==B);
  assign ble = (A<=B);	 
  always @(A, B, op) begin
      	
	case(op)
		0: begin //add
			ALUResult = A + B;
		end
		
		1: begin //sub
			ALUResult = A - B;
		end

	endcase 

end
endmodule
