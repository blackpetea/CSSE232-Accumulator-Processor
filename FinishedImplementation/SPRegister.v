`timescale 1ns / 1ns



module SPRegister(SPWrite, clk, ALUOut, reset, SPOut);

  input SPWrite;
  input clk;
  input unsigned [15:0] ALUOut;
  input reset;
  output reg unsigned [15:0] SPOut;
    

	 	always @(posedge clk, posedge reset) begin
	
		if(reset) begin
			SPOut = 1016;//sp start at 1016 // v0 at 1018, a1 at 1019 // v0 at 1019txt, a1 at 1020txt
		end else if (SPWrite) begin
			SPOut = ALUOut;
		end else begin
			SPOut = SPOut;
		end
	end		




endmodule