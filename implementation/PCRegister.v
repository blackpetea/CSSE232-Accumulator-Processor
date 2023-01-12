`timescale 1ns / 1ns

module PCRegister(
    PCIn,
    clk,
    PCWrite,
	reset,
  	PCOut
    );

	 
  input unsigned [15:0] PCIn;
  input clk;
  input PCWrite;
  input reset;
  output reg unsigned [15:0] PCOut;

	always @(reset) begin
		if(reset) begin
			PCOut = 0;
		end	
	end
	
	always @(posedge clk) begin
      if(PCWrite) begin
			PCOut = PCIn;
		end else begin
			PCOut = PCOut;
		end
	end		


endmodule
