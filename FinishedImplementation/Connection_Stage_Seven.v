`timescale 1ns / 1ns



module Connection_Stage_Seven (
//connecting two ALU_Source_mux, ALU, ALUOut, SpRegister

  input clk,
  input reset

//inputs as control signals:-----------------------------------



  
//  input [15:0] inputReg, // input for the whole program
//  
//  output wire [15:0] outputReg //output for the whole program

);

//wires:-----------------------------------

  wire [15:0] ASA_out; //wire from ALUSrcA_mux to ALU
  wire [15:0] ASB_out; //wire from ALUSrcB_mux to ALU
  wire [15:0] ALUResult_out; // wire from ALU to ALUOut 
  wire [15:0] ALUOut_out; // wire out from ALUOutRegister
  wire [15:0] SP_out; // wire from sp register to ALUSrcB_mux
  wire [15:0] ACC_out; //wire out from ACC
  wire [15:0] ACCmux_out; //wire from ACCmux to ACCRegister
  wire [15:0] RA_out; //wire out from RA
  wire [15:0] RAmux_out; // wire out from RAmux
  wire [15:0] MDR_out; //wire out from MDRRegister
  wire [15:0] SE_out; //wire out from SE
  wire [10:0] IR_out; //wire out from InstRegister
  wire [15:0] PCmux_out; //wire out from PCmux
  wire [15:0] PC_out; //wire out from PCRegister
  wire [15:0] IorDmux_out; //wire out from IorDmux
  wire [15:0] Mem_out; //wire out from Memory
  
  //control signals
  wire [1:0] ASAmux_op;
  wire [1:0] ASBmux_op;
  wire [2:0] ALU_op;
  wire ALUOutWrite;
  wire SPWrite;
  wire ACCWrite;
  wire [1:0] ACCmux_op;
  wire RAWrite;
  wire RAmux_op;
  wire MDRWrite;
  wire IRWrite;
  wire PCWrite;
  wire [1:0] PCmux_op;
  wire IorDmux_op;
  wire MemWrite;

  
  
  wire [4:0] IROPOut;
  wire BLEResult;
  wire BranchResult;
  
  wire BEQControl;
  wire BLEControl;
  wire BNEControl;
  wire PCWrite2;

  

//instantiations:
  assign PCWrite2 = (BLEControl & BLEResult) | (BNEControl & !BranchResult) | (BranchResult & BEQControl) | PCWrite;

  ALUmux_A ASAM(.op(ASAmux_op), .A(PC_out), .C(SE_out), .D(MDR_out), .muxOut(ASA_out));
  ALUmux_B ASBM(.op(ASBmux_op), .B(ACC_out), .C(SP_out), .muxOut(ASB_out));
  ALU ALU(.A(ASA_out), .B(ASB_out), .op(ALU_op), .ALUResult(ALUResult_out), .ble(BLEResult), .branchResult(BranchResult));

  ALUOutRegister AOut(.ALUOutWrite(ALUOutWrite), .clk(clk), .ALUOutIn(ALUResult_out), .ALUOutOut(ALUOut_out), .reset(reset));

  SPRegister SPR(.SPWrite(SPWrite), .clk(clk), .ALUOut(ALUOut_out), .reset(reset), .SPOut(SP_out));

  ACCRegister ACCR(.ACCIn(ACCmux_out), .clk(clk), .ACCWrite(ACCWrite), .reset(reset), .ACCOut(ACC_out));
  ACCmux ACCM(.op(ACCmux_op), .A(RA_out), .B(SE_out), .C(MDR_out), .D(ALUOut_out), .muxOut(ACCmux_out));
  
  RARegister RAR(.RAWrite(RAWrite), .clk(clk), .RAIn(RAmux_out), .reset(reset), .RAOut(RA_out));
  RAmux RAM(.op(RAmux_op), .A(ACC_out), .B(PC_out), .muxOut(RAmux_out));
  
  MDRRegister MDRR(.MDRIn(Mem_out), .clk(clk), .MDRWrite(MDRWrite), .reset(reset), .MDROut(MDR_out));
  
  InstRegister IR(.IRIn(Mem_out), .clk(clk), .IRWrite(IRWrite), .reset(reset), .IROPOut(IROPOut), .IROut(IR_out));
  SignExtender SE(.unextended(IR_out), .extended(SE_out));
  
  PCRegister PCR(.PCIn(PCmux_out), .clk(clk), .PCWrite(PCWrite2), .reset(reset), .PCOut(PC_out));
  PCmux PCM(.op(PCmux_op), .A(SE_out), .B(RA_out), .C(ALUResult_out), .muxOut(PCmux_out));
  
  IorDmux IDM(.op(IorDmux_op), .A(ALUOut_out), .B(PC_out), .muxOut(IorDmux_out));
  Memory MEM(.data(ACC_out), .addr(IorDmux_out), .clk(clk), .MemOut(Mem_out), .MemWrite(MemWrite));
  
  Control_Unit  CU(.clk(clk), .reset(reset), 
                          .ASAmux_op(ASAmux_op),
                          .ASBmux_op(ASBmux_op),
                     	  .ALUOutWrite(ALUOutWrite),
								  .ALU_op(ALU_op),
                          .ACCWrite(ACCWrite),
                          .ACCmux_op(ACCmux_op),
                          .RAWrite(RAWrite),
                          .RAmux_op(RAmux_op),
                          .MDRWrite(MDRWrite),
								  .IRWrite(IRWrite),
                          .PCmux_op(PCmux_op),
                          .PCWrite(PCWrite),
                          .IorDMux_op(IorDmux_op),
                          .MemWrite(MemWrite),
                          .BranchResult(BranchResult),
                          .BLEResult(BLEResult),
								  .SPWrite(SPWrite),
								  .opcode(IROPOut),
								  .BEQControl(BEQControl),
								  .BNEControl(BNEControl),
								  .BLEControl(BLEControl)
                          );
  

endmodule