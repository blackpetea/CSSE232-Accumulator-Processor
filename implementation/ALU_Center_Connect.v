module ALU_Center_Connect (
//connecting two ALU_Source_mux, ALU, ALUOut, SpRegister

input CLK,
// input [(10-1):0]PC,
// input [(16-1):0]dataIn,
input reset, 


//inputs from ALU_Source_A_Mux:-----------------------------------
input[1:0] ASA_op;
input[15:0] ASA_A;
input[15:0] ASA_C;
input[15:0] ASA_D;
     


//inputs from ALU_Source_B_Mux:-----------------------------------
input[1:0] ASB_op;
input[15:0] ASB_B;
input[15:0] ASB_C;
input[15:0] ASB_D;
     


//inputs for other control signals:-----------------------------------
input ALUOutWrite;
input[2:0] ALU_op; 
input SpWrite;

//outputs:
output[15:0] reg ALUOutOut;
output wire BranchResult;
output wire BLEResult; 

);

//wires:-----------------------------------

wire [15:0] ASA_out; //wire from ALUSrcA_mux to ALU
wire [15:0] ASB_out; //wire from ALUSrcB_mux to ALU
reg [15:0] ALUResult_reg; // reg from ALU to ALUOut 
wire [15:0] SP_out; // wire from sp register to ALUSrcB_mux

//instantiations:

ALUmux_A ASAM(.op(ASA_op), .A(ASA_A), .C(ASA_C), .D(ASA_D), .muxOut(ASA_out));

ALUmux_B ASBM(.op(ASB_op), .B(ASB_B), .C(ASB_C), .D(ASB_D), .muxOut(ASB_out));

ALU ALU(.A(ASA_out), .B(ASB_out), .op(ALU_op), .ALUResult(ALUResult_reg), .ble(BLEResult), .branchResult(BranchResult));

ALUOut AOut(.ALUOutWrite(ALUOutWrite), .clk(CLK), .ALUOutIn(ALUResult_reg), .ALUOutOut(ALUOutOut), .reset(reset));
    
SPRegister SPR(.SPWrite(SpWrite), .clk(CLK), .ALUOut(ALUOutOut), .reset(reset), .SPOut(SP_Out));



endmodule
