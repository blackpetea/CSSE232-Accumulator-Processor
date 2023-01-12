`timescale 1ns / 1ns



module InstRegister(IRIn, clk, IRWrite, reset, IROPOut, IROut);

  input IRWrite;
  input unsigned [15:0] IRIn;
  input clk;
  input reset;
  output reg unsigned [15:5] IROut;
  output reg unsigned [4:0] IROPOut;
  

	always @(posedge clk, posedge reset) begin
	
		if(reset) begin
			IROut = 0;
			IROPOut = 0;
		end else if (IRWrite) begin
			IROut = IRIn[15:5];
         IROPOut = IRIn[4:0];
		end else begin
			IROut = IROut;
			IROPOut = IROPOut;
		end
	end	



endmodule