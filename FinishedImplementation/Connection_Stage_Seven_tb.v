//Q1. how to test spregister's value in this case?
//Q2. not working for negative number as alu result..


`timescale 1ns / 1ns
module Connection_Stage_Seven_tb();
  
  
  //inputs:--------------------------
  reg clk;
  reg reset;

//  reg [15:0] inputReg;
//  wire [15:0] outputReg;



  
Connection_Stage_Seven UUT
(
	.clk(clk) ,	// input  clk_sig
	.reset(reset) 	// input  reset_sig

//	.inputReg(inputReg) ,	// input [15:0] inputReg_sig
//	.outputReg(outputReg) // output [15:0] outputReg_sig

);


parameter HALF_PERIOD = 50;

initial begin 
clk = 0;
  forever begin #HALF_PERIOD clk = ~clk; end end
  
  
//---Expected Value Initialization section-----------------------------------



initial begin
  //Initialize inputs:
  clk = 0;
  reset = 1;
  #(2*HALF_PERIOD);
  
   reset = 0;
	 #(100*HALF_PERIOD);
  
  $display("at least no syntax bug now!!");
  
  
  

end 

endmodule 