`timescale 1ns / 1ns

module Control_Unit (     
							     clk,
                          reset,
                          ASAmux_op,
                          ASBmux_op,
                     	  ALUOutWrite,
								  ALU_op,
                          ACCWrite,
                          ACCmux_op,
                          RAWrite,
                          RAmux_op,
                          MDRWrite,
								  IRWrite,
                          PCmux_op,
                          PCWrite,
                          IorDMux_op,
                          MemWrite,
								  BLEControl,
								  BNEControl,
								  BEQControl,
                          BranchResult,
                          BLEResult,
								  SPWrite,
								  opcode,
                          );
  


  output  [1:0] ASAmux_op;
  output  [1:0] ASBmux_op;
  output  ALUOutWrite;
  output  [2:0] ALU_op;
  output  ACCWrite;
  output  [1:0] ACCmux_op;
  output  RAWrite;
  output  RAmux_op;
  output  MDRWrite;
  output  IRWrite;
  output  [1:0] PCmux_op;
  output  PCWrite;
  output  [1:0] IorDMux_op;
  output  MemWrite;
  output  SPWrite;
  
  
  reg  [4:0] current_state;//5 bit for 32, we have 20 states
  reg  [4:0] next_state;

   reg [1:0] ASAmux_op;
   reg [1:0] ASBmux_op;
   reg ALUOutWrite;
   reg [2:0] ALU_op;
   reg ACCWrite;
   reg [1:0] ACCmux_op;
   reg RAWrite;
   reg RAmux_op;
   reg MDRWrite;
   reg IRWrite;
   reg [1:0] PCmux_op;
   reg PCWrite;
   reg [1:0] IorDMux_op;
   reg MemWrite;
	output reg BEQControl;
	output reg BNEControl;
	output reg BLEControl;
   reg SPWrite;
	
//	output reg inputWrite;
//	output reg outputWrite;
  
  
  
  input BranchResult;
  input BLEResult;
  input [4:0] opcode;
  input clk;
  input reset;


   //state definitions
  parameter    blk1 = 0;
  parameter    blk2 = 1;
  parameter    jal1 = 2;
  parameter    stackGet1 = 3;
  parameter 	stackSet1 = 21;
  parameter    stackGet2 = 4;
  parameter    addi1 = 5;
  parameter    addi2 = 6;
  parameter    Branch1 = 7;
  parameter    Branch2 = 8;
  parameter    BranchBEQ3 = 9;
  parameter    BranchBNE3 = 23;
  parameter    BranchBLE3 = 24;
  parameter    spInit1 = 10;
  parameter    spRelease1 = 12;
  parameter    stackAddSub1 = 13;
  parameter    stackAdd2 = 14;
  parameter    stackSub2 = 15;
  parameter    stackAddSub3 = 16;
  parameter    jra1 = 17;
  parameter    accgetra1 = 18;
  parameter    ragetacc = 19;
  parameter    accseti = 20;
  
  //assign PCWrite = (BLEControl & BLEResult) | (BNEControl & !BranchResult) | (BranchResult & BEQControl) | PCWrite;
  
   //register calculation
  always @ (posedge clk, posedge reset)
     begin
       if (reset)
          current_state = blk1;
        else 
          current_state = next_state;
     end


   //OUTPUT signals for each state (depends on current state)
   always @ (current_state)
     begin
        //Reset all signals that cannot be don't cares

        MemWrite = 0; 
        IRWrite = 0; 
        PCWrite = 0;
        ACCWrite = 0;
        SPWrite = 0;
        ALUOutWrite = 0;
        RAWrite = 0;
        MDRWrite = 0;
		  ASAmux_op = 0;
		  ASBmux_op = 0;
		  ALU_op = 0;
		  ACCmux_op = 0;
		  RAmux_op = 0;
		  PCmux_op = 0;
		  IorDMux_op = 0;
		  BLEControl = 0;
		  BNEControl = 0;
		  BEQControl = 0;
		 
		  
        case (current_state)
//only changing states that need to be different other than 0;          
          blk1:
            begin
              IorDMux_op = 1; // fetch instruction
				 IRWrite = 1;
              PCWrite = 1;
              PCmux_op = 2; //from ALU
				
            end 
                         
          blk2:
            begin
               ASAmux_op = 2; // imme
               ASBmux_op = 2;  // sp
					ALUOutWrite = 1; //vvv
            end
        
          jal1:
            begin
              RAWrite = 1;
              RAmux_op = 1;
              PCWrite = 1;
            end
        
          stackSet1:
            begin
               MemWrite = 1;
					IorDMux_op = 0;//not sure about this one !!!!!!!!!!!!!!!!check
            end
				
			 stackGet1:
            begin
					MDRWrite = 1;
					IorDMux_op = 0;//vvv
            end
        
		    stackGet2:
            begin
               ACCWrite = 1;
					ACCmux_op = 2;
            end
				
          addi1:
            begin
               ASAmux_op = 2;
					ASBmux_op = 1;
					ALUOutWrite = 1; //VVV
            end
		  
		  	addi2:
            begin
					ACCWrite = 1;
					ACCmux_op = 3;
            end
				
		  Branch1:
            begin
					ASAmux_op = 1;
					ASBmux_op = 2;
					ALUOutWrite = 1;
            end
			
		  Branch2:
            begin
					MDRWrite = 1;
					IorDMux_op = 0;
            end
				
				
			
			BranchBEQ3:
            begin
					BEQControl = 1;
					ASAmux_op = 3;
					ASBmux_op = 1;
            end
				
			BranchBNE3:
            begin
					BNEControl = 1;
					ASAmux_op = 3;
					ASBmux_op = 1;
            end
				
			BranchBLE3:
            begin
					BLEControl = 1;
					ASAmux_op = 3;
					ASBmux_op = 1;
            end        
		  
		  	spInit1:
            begin
					ASAmux_op = 2;
					ASBmux_op = 2;
					ALU_op = 2;
					ALUOutWrite = 1;
            end
				
			
		  spRelease1:
            begin
					SPWrite = 1;
            end
				
		  stackAddSub1:
            begin
					MDRWrite = 1;
					
            end
				
		  stackSub2:
            begin
					ASAmux_op = 3;
					ASBmux_op = 1;
					ALUOutWrite = 1;
					ALU_op = 2;
            end
				
		  stackAdd2:
            begin
					ASAmux_op = 3;
					ASBmux_op = 1;
					ALUOutWrite = 1;
					ALU_op = 0;
            end
				
		  stackAddSub3:
            begin
					ACCWrite = 1;
					ACCmux_op = 3;
            end
			
		  jra1:
            begin
					PCWrite = 1;
					PCmux_op = 1;
            end
				
		  accgetra1:
            begin
					ACCWrite = 1;
					//ACCmux_op = 1;
            end
				
		  ragetacc:
            begin
					RAWrite = 1;
            end
		  accseti:
            begin
					ACCWrite = 1;
					ACCmux_op = 1;
            end
        
          default:
            begin $display ("not implemented"); end
          
        endcase
     end
                
   //NEXT STATE calculation (depends on current state and opcode)       
   always @ (current_state, next_state, opcode)
     begin   	  

        $display("The current state is %d", current_state);
        
        case (current_state)
          
          blk1:
            begin
               next_state = blk2;
               $display("In Fetch, the next_state is %d", next_state);
            end
				
				
         //cases only for decode stage
          blk2: 
            begin       
               $display("The opcode is %d", opcode);
               case (opcode)
                 0:
                   begin
                      next_state = stackSet1;
                      $display("The next state is stackSet1");
                   end
                 1:
                   begin
                      next_state = stackGet1;
                      $display("The next state is stackSet1");
                   end
                 2:
                   begin
                      next_state = accseti;
                      $display("The next state is accseti");
                   end
					  3:
                   begin
                      next_state = stackAddSub1;
                      $display("The next state is stackAddSub1 (stackadd)");
                   end
                 4:
                  begin next_state = addi1;
                      $display("The next state is addi1");
                   end
					  5:
                   begin
                      next_state = stackAddSub1;
                      $display("The next state is stackAddSub1 (stacksub)");
                   end
                 6:
                   begin
                      next_state = Branch1;
                      $display("The next state is Branch1");
                   end
                 7:
                   begin
                      next_state = Branch1;
                      $display("The next state is Branch1");
                   end
                 8:
                   begin
                      next_state = Branch1;
                      $display("The next state is Bran+ch1");
                   end
                 9:
                   begin next_state = jal1;
                      $display("The next state is jal1");
                   end
					  10:
                   begin
                      next_state = spInit1;
                      $display("The next state is spInit1");
                   end
                 11:
                   begin
                      next_state = spRelease1;
                      $display("The next state is spRelease1");
                   end
                 12:
                   begin
                      next_state = jra1;
                      $display("The next state is jra1");
                   end
                 13:
                   begin
                      next_state = accgetra1;
                      $display("The next state is accgetra1");
                   end
                 14:
                   begin next_state = ragetacc ;
                      $display("The next state is ragetacc");
                   end
						 
               default:
                   begin 
                      $display(" Wrong opcode %d ", opcode);  
                      next_state = blk1; 
                   end
               endcase 
				end
          
			 
          jal1:
            begin
               next_state = blk1;
               $display("In jal1, the next_state is %d", next_state);
            end
          
			 //going to stack get set states in order
          stackSet1:
            begin
               next_state = blk1;
               $display("In stackSet1, the next_state is %d", next_state);
            end
			 stackGet1:
            begin
               next_state = stackGet2;
               $display("In stackGet1, the next_state is %d", next_state);
            end
				
          stackGet2:
            begin
               next_state = blk1;
               $display("In stackGet2, the next_state is %d", next_state);
            end 
			
          addi1:
            begin
               next_state = addi2;
               $display("In addi1, the next_state is %d", next_state);
            end
				
			 addi2:
            begin
               next_state = blk1;
               $display("In addi2, the next_state is %d", next_state);
            end
          
          Branch1:
            begin
               next_state = Branch2;
               $display("In Branch1, the next_state is %d", next_state);
            end
				
			 Branch2:
                begin       
                $display("The opcode is %d", opcode);
                case (opcode)
                 
                  6:
                     begin
                         next_state = BranchBNE3;
                         $display("The next state is BranchBNE3");
                     end
                  7:
                     begin
                         next_state = BranchBEQ3;
                         $display("The next state is BranchBEQ3");
                     end
                     
                  8:
                     begin
                         next_state = BranchBLE3;
                         $display("The next state is BranchBLE3");
                     end
                    
                        
                    default:
                        begin
                            $display(" Not implemented!");
                            next_state = blk1;
                        end
                endcase     
            end
            
             BranchBNE3:
            begin
               next_state = blk1;
               $display("In BranchBNE3, the next_state is %d", next_state);
            end
                
            BranchBLE3:
            begin
               next_state = blk1;
               $display("In BranchBLE3, the next_state is %d", next_state);
            end
                
            BranchBEQ3:
            begin
               next_state = blk1;
               $display("In BranchBEQ3, the next_state is %d", next_state);
            end       
				
			 
				
			 spInit1:
            begin
               next_state = spRelease1;
               $display("In spInit1, the next_state is %d", next_state);
            end
          
			 spRelease1:
            begin
               next_state = blk1;
               $display("In spRelease1, the next_state is %d", next_state);
            end
				
			 jra1:
            begin
               next_state = blk1;
               $display("In jra1, the next_state is %d", next_state);
            end
				
			 accseti:
            begin
               next_state = blk1;
               $display("In accseti, the next_state is %d", next_state);
            end
				
			 accgetra1:
            begin
               next_state = blk1;
               $display("In accgetra1, the next_state is %d", next_state);
            end
				
			 ragetacc:
            begin
               next_state = blk1;
               $display("In ragetacc, the next_state is %d", next_state);
            end
			
			 stackAddSub1:
					begin       
               $display("The opcode is %d", opcode);
               case (opcode)
                
                 3:
                   begin
                      next_state = stackAdd2;
                      $display("The next state is stackAdd2");
                   end
                 5:
                   begin
                      next_state = stackSub2;
                      $display("The next state is stackSub2");
                   end
						
							
						default:
							begin
								$display(" Not implemented!");
								next_state = blk1;
							end
					endcase	 
				end
						
			 stackAdd2:
            begin
               next_state = stackAddSub3;
               $display("In stackAdd2, the next_state is %d", next_state);
            end
				
			 stackSub2:
            begin
               next_state = stackAddSub3;
               $display("In stackSub2, the next_state is %d", next_state);
            end
				
			 stackAddSub3:
            begin
               next_state = blk1;
               $display("In stackAddSub3, the next_state is %d", next_state);
            end
			 
          default:
            begin
               $display(" Not implemented!");
               next_state = blk1;
            end
          
        endcase
        
        $display("After the tests, the next_state is %d", next_state);
                
     end

	  endmodule