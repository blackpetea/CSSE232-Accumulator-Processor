`timescale 1ns / 1ns

module ALU_tb;

	// Inputs
	reg signed [15:0] A;
	reg signed [15:0] B;
	reg [2:0] op;


	// Outputs
  	wire [15:0] ALUResult;
	wire ble;
	wire branchResult;
  
  	reg [15:0] ALUOutExp;
  	reg	branchResultExp;
  	reg	bleExp;
  
  	integer error = 0;
  
	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.A(A), 
		.B(B), 
		.op(op), 

      	.ALUResult(ALUResult), 
      	.ble(ble), 
      	.branchResult(branchResult)
	);
  
  	
	parameter HALF_PERIOD = 50;
  
	initial begin
      
      	//init
      	$dumpfile("dump.vcd");
      	$dumpvars(1, ALU_tb);
      	A = 0;
      	B = 0;
      	op = 0;
      	error = 0;

      
      	#(2*HALF_PERIOD);
      
        //---------------------------TEST 1-------------------------------------
      	op = 0; // testing add
        $display("Test1 ALU add.");
      	repeat(15) begin
        	A = $random;
          	B = $random;
          
          	ALUOutExp = A + B;
          	branchResultExp = A == B;
          
          	bleExp = A <= B ? 1 : 0;
			#(2*HALF_PERIOD);
          
          if(ALUResult != ALUOutExp)begin // check ALU output
            $display("Error when adding A = %d and B = %d, Expected = %d, Actual = %d", A, B, ALUOutExp, ALUResult);
            error = error + 1;
          end
          
          if(branchResultExp != branchResult)begin // check branch result for bne and beq
            $display("Error with branchResult, Expected : %d, Actual : %d", branchResultExp, branchResult);
            error = error + 1;
          end
          
          if(bleExp != ble)begin	// check ble
            $display("Error with ble, Expected : %d, Actual : %d", bleExp, ble);
            error = error + 1;
          end

        end
      	if(error == 0) $display("No error in ALU add");
        else $display("Found %d errors in ALU add", error);
      	#(2*HALF_PERIOD);
		//---------------------------TEST 2-------------------------------------
      	op = 1; // testing sub
      	error = 0;//error reset --?????????? is it ok to reset error like this?
      	$display("Test2 ALU sub.");
      	repeat(15) begin
        	A = $random;
          	B = $random;
          
          	ALUOutExp = A - B;
          	branchResultExp = A == B;
          
          	bleExp = A <= B ? 1 : 0;
			#(2*HALF_PERIOD);
          
          if(ALUResult != ALUOutExp)begin // check ALU output
            $display("Error when subtracting A = %d and B = %d, Expected = %d, Actual = %d", A, B, ALUOutExp, ALUResult);
            error = error + 1;
          end
          
          if(branchResultExp != branchResult)begin // check branch result for bne and beq
            $display("Error with branchResult, Expected : %d, Actual : %d", branchResultExp, branchResult);
            error = error + 1;
          end
          
          if(bleExp != ble)begin	// check ble
            $display("Error with ble, Expected : %d, Actual : %d", bleExp, ble);
            error = error + 1;
          end

        end
      if(error == 0) $display("No error in ALU sub");
      	else $display("Found %d errors in ALU sub", error);

      #(2*HALF_PERIOD);
      //$display("A=%d, B=%d, ble=%d, branchResult=%d, ALUResult=%d", A, B, ble, branchResult,ALUResult);
      	

	end
      
endmodule
