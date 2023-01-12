`timescale 1ns / 1ns

module mux_5_tb;

  // Inputs
  reg [15:0] A;
  reg [15:0] B;

  reg op;


  // Outputs
  wire [15:0] muxOut;

  reg [15:0] muxOutExp;

  // Instantiate the Unit Under Test (UUT)
  IorDmux uut (
    .op(op), 
    .A(A), // inst
    .B(B), // data
    .muxOut(muxOut)
  );


  parameter HALF_PERIOD = 50;

  initial begin

    //init
    A = 0;
    B = 0;
    op = 0;


    #(2*HALF_PERIOD);

    //---------------------------TEST 1-------------------------------------
    op = 0; // testing Choosing A
    $display("Test1----------------------------.");
    repeat(10) begin
      A = $random;
      B = $random;

	  muxOutExp = A;

      #(2*HALF_PERIOD);

      if(muxOut != muxOutExp)begin // check muxOut
        $display("Test Failed!, Expected = %d, Actual = %d", muxOutExp, muxOut);
      end
      else begin
        $display("Test succeed!, Expected = %d, Actual = %d", muxOutExp, muxOut);
      end

    #(2*HALF_PERIOD);


  end
  end

endmodule