`timescale 1ns / 1ns



module RARegister(RAWrite, clk, RAIn, reset, RAOut);

  input RAWrite;
  input clk;
  input unsigned [15:0] RAIn;
  input reset;
  output reg unsigned [15:0] RAOut;
  

  
    
	always @(posedge clk, posedge reset) begin
	
		if(reset) begin
			RAOut = 0;
		end else if (RAWrite) begin
			RAOut = RAIn;
		end else begin
			RAOut = RAOut;
		end
	end	



endmodule