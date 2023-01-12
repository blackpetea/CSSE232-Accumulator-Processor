timescale 1ns / 1ns



module ACCRegister(ACCIn, clk, ACCWrite, reset, ACCOut);

  input reg unsigned [15:0] ACCIn;
  input clk;
  input ACCWrite;
  input reset;
  output reg unsigned [15:0] ACCOut;
  



   always @(reset) begin
        if(reset) begin
            ACCIn = 0;
        end    
    end
    
    always @(posedge clk) begin
      if(ACCWrite) begin
            ACCOut = ACCIn;
        end 
    end        




endmodule