timescale 1ns / 1ns



module SPRegister(SPWrite, clk, ALUOut, reset, SPOut);

  input SPWrite
  input clk;
  input reg unsigned [15:0] ALUOut;
  input reset;
  output reg unsigned [15:0] SPOut;
  



   always @(reset) begin
        if(reset) begin
            SPOut = 0;
        end    
    end
    
    always @(posedge clk) begin
      if(SPWrite) begin
            SPOut = ALUOut;
        end 
    end        




endmodule