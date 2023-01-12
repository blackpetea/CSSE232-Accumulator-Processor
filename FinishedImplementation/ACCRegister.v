`timescale 1ns / 1ns



module ACCRegister(ACCIn, clk, ACCWrite, reset, ACCOut);

  input unsigned [15:0] ACCIn;
  input clk;
  input ACCWrite;
  input reset;
  output reg unsigned [15:0] ACCOut;
  

	always @(posedge clk, posedge reset) begin
	
		if(reset) begin
			ACCOut = 0;
		end else if (ACCWrite) begin
			ACCOut = ACCIn;
		end else begin
			ACCOut = ACCOut;
		end
	end		 




endmodule