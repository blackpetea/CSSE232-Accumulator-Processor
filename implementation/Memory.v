/*********************************************************/
// MODULE:      memory
//
// FILE NAME:   memory.v
// VERSION:     1.0
// DATE:        Created 21 Nov 2004
// AUTHOR:      J.P. Mellor
//
// DESCRIPTION: This module defines memory similar to ipcore
//              generated distributed memory, but which is easier
//              to load programs and data into.
//
/*********************************************************/
module amemory16x1k(WriteData, 
                    MemData, //DataOut
                    Address,
                    Write,
                    CLK);
   
   // Definitions
`define MEM_DEPTH 1024
`define MEM_WIDTH 16
`define ADDR_SIZE 10

   // Inputs
   input [`ADDR_SIZE-1:0] Address; //from mux
   input [`MEM_WIDTH-1:0] WriteData; //Data in //have to figure out how big of data we are writing
   input                  Write; //MemWrite from control
   input                  CLK;

   // Outputs
   output [`MEM_WIDTH-1:0] MemData;

   // Signals
   wire [`MEM_WIDTH-1:0] MemData;

   // The memory
   reg [`MEM_WIDTH-1:0] mem [`MEM_DEPTH-1:0];

   initial
     begin
        $readmemh("memory.dat", mem, 0, `MEM_DEPTH-1);
     end
   
   assign MemData = mem[Address];

   // Operations
   always @ (posedge CLK)
     begin
	if (Write)
          mem[Address] <= WriteData;
     end
   
endmodule
