`timescale 1ns / 1ns



module MDRRegister(MDRIn, clk, MDRWrite, reset, MDROut);

  input unsigned [15:0] MDRIn;
  input clk;
  input MDRWrite;
  input reset;
  output reg unsigned [15:0] MDROut;
  

 

	always @(posedge clk, posedge reset) begin
	
		if(reset) begin
			MDROut = 0;
		end else if (MDRWrite) begin
			MDROut = MDRIn;
		end else begin
			MDROut = MDROut;
		end
	end		 




endmodule