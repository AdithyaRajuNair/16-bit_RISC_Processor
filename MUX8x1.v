module MUX8x1(out, d0, d1, d2, d3, d4, d5, d6, d7, s);
input wire d0, d1, d2, d3, d4, d5, d6, d7;
input wire [2:0] s;
output reg out;
always@(*)
begin
    case(s)
        3'b000: out=d0;
        3'b001: out=d1;
        3'b010: out=d2;
        3'b011: out=d3;
        3'b100: out=d4;
        3'b101: out=d5;
        3'b110: out=1'b0;
        3'b111: out=1'b0;
        default: out=1'b0;
    endcase
end
endmodule