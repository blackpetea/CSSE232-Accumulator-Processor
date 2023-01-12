//Do i need to worry about signed number in this component?
`timescale 1ns / 1ns

module SignExtender(
  //https://stackoverflow.com/questions/4176556/how-to-sign-extend-a-number-in-verilog
  input [10:0] unextended,//the msb bit is the sign bit
  output wire [15:0] extended 
);

    assign extended = $unsigned(unextended);
    //extended[15:0] <= { {11{extend[10]}}, extend[10:0] };

endmodule

//thing don't change: use assign, wire stuff
// thing change: use alwasys and register stuff
