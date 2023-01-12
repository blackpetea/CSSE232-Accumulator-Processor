`timescale 1ns / 1ns

module SignExtender_tb;

	// Inputs
  reg signed [10:0] unextended;


	// Outputs
  wire [15:0] extended;
  
  
  reg [15:0] extendedExp;
  

  
	// Instantiate the Unit Under Test (UUT)
  SignExtender uut (
    .unextended(unextended),
    .extended(extended)
	);
  
  	
	parameter HALF_PERIOD = 50;
  
  
	initial begin
      
      	//init
      	$dumpfile("dump.vcd");
      $dumpvars(1, SignExtender_tb);
      unextended = 0;
//       extended = 0;//???? do i need to worry about this? can't set it to zero
      extendedExp = 0;



      
      	#(2*HALF_PERIOD);
      
        //---------------------------TEST 1-------------------------------------
      

      $display("Test1 unsigned extension.");
      	begin
          unextended = 10'b0110011011;
          extendedExp = 16'b0000000110011011;
  		  
			#(2*HALF_PERIOD);
          
          if(extended != extendedExp)begin // check SE output
            $display("Error for SE!!!, Actual = %d, Expected = %d", extended, extendedExp);
          end
          else begin
            $display("Test1 Correct!, Actual = %d, Expected = %d", extended, extendedExp);
          end
        end

      	#(2*HALF_PERIOD);
		//---------------------------TEST 2-------------------------------------
          
      $display("Test2 signed extension.");
      	begin
          unextended = 10'b1110011011;
          extendedExp = 16'b1111111110011011;
  		  
			#(2*HALF_PERIOD);
          
          if(extended != extendedExp)begin // check SE output
            $display("Error for SE!!!, Actual = %d, Expected = %d", extended, extendedExp);
          end
          else begin
            $display("Test2 Correct!, Actual = %d, Expected = %d", extended, extendedExp);
          end
        end

      	#(2*HALF_PERIOD);
      	
      	

	end
      
endmodule