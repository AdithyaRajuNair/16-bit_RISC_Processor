module ALU(
 input  [15:0] a,  //src1
 input  [15:0] b,  //src2
 input  [2:0] alu_control, //function sel
 input  upd_flag,
 
 output reg [15:0] result,  //result 
 output reg zero,
 output reg lt
    );

always @(*)
begin 
 case(alu_control)
 3'b000: result = a + b; // add
 3'b001: result = a - b; // sub
 3'b010: result = ~a;   //not
 3'b011: result = a & b; // and
 3'b100: result = a | b; // or
 3'bXXX: result = a; // input1
 default:result = a + b; // add
 endcase
 
if (upd_flag)
begin
    zero = (result==16'd0) ? 1'b1: 1'b0;
    lt = (result[15]==1'b1) ? 1'b1: 1'b0;
end
 
end

endmodule