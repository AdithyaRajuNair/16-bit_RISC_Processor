`timescale 1ns / 1ps

module alu_control( ALU_Cnt, ALUOp, Opcode);
 output reg[2:0] ALU_Cnt;
 input [1:0] ALUOp;
 input [3:0] Opcode;
 wire [5:0] ALUControlIn;
 assign ALUControlIn = {ALUOp,Opcode};
 always @(ALUControlIn)
 casex (ALUControlIn)
   6'b10xxxx: ALU_Cnt=3'b000;
   6'b01xxxx: ALU_Cnt=3'b001;
   6'b000000: ALU_Cnt=3'b000;
   6'b000001: ALU_Cnt=3'b001;
   6'b000010: ALU_Cnt=3'b010;
   6'b000011: ALU_Cnt=3'b011;
   6'b000100: ALU_Cnt=3'b100;
   default: ALU_Cnt=3'bXXX;
  endcase
endmodule