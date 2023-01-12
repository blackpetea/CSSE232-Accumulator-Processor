`timescale 1ns / 1ns
module PCRegister_tb;

	// Inputs
	reg [15:0] PCIn;
	reg clk;
	reg reset;
	reg PCWrite;


	// Outputs
	wire [15:0] PCOut;

	// Instantiate uut
	PCRegister uut (
		.PCIn(PCIn), 
		.clk(clk),
        .reset(reset),
		.PCWrite(PCWrite), 
		.PCOut(PCOut)
	);
	
parameter HALF_PERIOD = 50;

initial begin 
clk = 0;
forever begin #HALF_PERIOD clk = ~clk; end end
	
	reg [15:0] PCOutExp;
	
	initial begin
		// Initialize Inputs
		PCIn = 0;
		clk = 0;
		PCWrite = 0;
		reset = 0;


		#(2*HALF_PERIOD);
        
		//--------------------Test 1--------------------
		
		
		PCWrite = 1;
		PCIn = 16'b011;

		PCOutExp = 16'b011;

		#(2*HALF_PERIOD);

		begin
			
			#(2*HALF_PERIOD);
          if(PCOutExp != PCOut) begin $display(" Failed!!! Actual = %d, Expected = %d", PCOut, PCOutExp); end
          else begin $display(" Successful!!! Actual = %d, Expected = %d", PCOut, PCOutExp); end
		end
		
		#(2*HALF_PERIOD);
		
		$display("Tests finished");

	end
      
endmodule