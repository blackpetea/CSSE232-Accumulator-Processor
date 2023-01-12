`timescale 1ns / 1ns



module ALUOutRegister(ALUOutWrite, clk, ALUOutIn, reset, ALUOutOut);

  input ALUOutWrite;
  input clk;
  input signed [15:0] ALUOutIn;
  input reset;
  output reg signed [15:0] ALUOutOut;
  
    
	 
	 	always @(posedge clk, posedge reset) begin
	
		if(reset) begin
			ALUOutOut = 0;
		end else if (ALUOutWrite) begin
			ALUOutOut = ALUOutIn;
		end else begin
			ALUOutOut = ALUOutOut;
		end
	end		





endmodule