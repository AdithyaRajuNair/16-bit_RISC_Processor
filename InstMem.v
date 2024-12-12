module Instruction_Memory(
 input[15:0] pc,
 output[15:0] instruction
);

 reg [16 - 1:0] memory [100 - 1:0];
 wire [14 : 0] rom_addr = pc[15 : 1];
 initial
 begin
    memory[0] <= 16'b0000000000000000;    //FIB
    memory[1] <= 16'b1000101000000001;    //movi r5<-#1
    memory[2] <= 16'b1000001000000001;    //movi r1<-#1
    memory[3] <= 16'b1000010000000001;    //movi r2<-#1
    memory[4] <= 16'b1000111000001100;    //movi r7<-#12 number of elements
    memory[5] <= 16'b0110110001000000;    //str M[r6]<-r1
    memory[6] <= 16'b0000110101110000;    //add r6<-r6+r5
    memory[7] <= 16'b0000001010011000;    //add r3<-r2+r1
    memory[8] <= 16'b0111010001000000;    //mov r1<-r2
    memory[9] <= 16'b0111011010000000;    //mov r2<-r3
    memory[10] <= 16'b0001111101111000;   //sub r7<-r7-r5
    memory[11] <= 16'b1100111000000000;   //cmp r7,r0
    memory[12] <= 16'b1101001111110000;   //b pc<-pc+2-16 if z!=1
    memory[13] <= 16'b1111000000000000;   //halt
 end
 assign instruction =  memory[rom_addr]; 

endmodule
