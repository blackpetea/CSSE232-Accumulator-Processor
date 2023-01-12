`timescale 1ns / 1ns

module SignExtender(input [10:0] unextended, output wire [15:0] extended);

    assign extended = $signed(unextended);
    //extended[15:0] <= { {11{extend[10]}}, extend[10:0] };

endmodule
