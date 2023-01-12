timescale 1ns / 1ns



module MDRRegister(MDRIn, clk, MDRWrite, reset, MDROut);

  input reg unsigned [15:0] MDRIn;
  input clk;
  input MDRWrite;
  input reset;
  output reg unsigned [15:0] MDROut;
  



   always @(reset) begin
        if(reset) begin
            MDRIn = 0;
        end    
    end
    
    always @(posedge clk) begin
      if(MDRWrite) begin
            MDROut = MDRIn;
        end 
    end        




endmodule