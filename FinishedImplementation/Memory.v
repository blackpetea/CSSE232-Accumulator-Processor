

module Memory 
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=10)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input MemWrite, clk,
  output [(DATA_WIDTH-1):0] MemOut

//	input [15: 0] inputReg,
//	output[15: 0] outputReg
);
	//we: write enabled
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[0:2**ADDR_WIDTH-1];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	initial begin
		$readmemh("memory.txt", ram);
	end
	
	always @ (negedge clk)
	begin
	
		// Write
      if (MemWrite)
			ram[addr] <= data;

		addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign MemOut = ram[addr_reg];

endmodule
