timescale 1ns / 1ns



module ALUOutRegister(ALUOutWrite, clk, ALUResult, reset, ALUOutOut);

  input ALUOutWrite
  input clk;
  input reg signed [15:0] ALUOutIn;
  input reset;
  output reg signed [15:0] ALUOutOut;
  



   always @(reset) begin
        if(reset) begin
            ALUResult = 0;
        end    
    end
    
    always @(posedge clk) begin
      if(ALUOutWrite) begin
            ALUOutOut = ALUOutIn;
        end 
    end        




endmodule
