module Data_Memory(
 input clk,
 input rst,
 input [15:0]   mem_access_addr,

 input [15:0] mem_write_data,
 input mem_write_en,
 input mem_read,
 
 output [15:0]   mem_read_data
);

reg [16 - 1:0] memory [8192 - 1:0];
integer f;
wire [15:0] ram_addr=mem_access_addr;
initial
 begin
  memory[0] <= 16'b0000000000000000;
 end
 
always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (f = 0; f < 8192; f = f + 1)
            memory[f] <= 16'd0;
    end else if (mem_write_en) begin
        memory[ram_addr] <= mem_write_data;
    end
end

assign mem_read_data = (mem_read==1'b1) ? memory[ram_addr]: 16'd0; 

endmodule