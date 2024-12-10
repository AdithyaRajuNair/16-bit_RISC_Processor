`timescale 1ns / 1ps

module RegisterBank(
    input clk,
    input rst,
    input regw_en,
    
    input [2:0] inrw,
    input [15:0] regw_data,
    
    input [2:0] inrr1,
    output [15:0] regr_data1,
    
    input [2:0] inrr2,
    output [15:0] regr_data2
    );
    
reg [15:0] reg_array [7:0];
integer i;

initial begin
for (i=0;i<8;i=i+1)
    reg_array[i] <= 16'd0;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 8; i = i + 1)
            reg_array[i] <= 16'd0;
    end else if (regw_en) begin
        reg_array[inrw] <= regw_data;
    end
end

assign regr_data1 = reg_array[inrr1];
assign regr_data2 = reg_array[inrr2];

endmodule
