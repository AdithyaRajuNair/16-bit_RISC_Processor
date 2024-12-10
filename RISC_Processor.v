`timescale 1ns / 1ps

module RISC_Processor(
    input clk,
    input rst,
    output wire [15:0] ALUout 
);

    wire regwdst, ALUsrc, mem2reg, regw_en, memr, memw, b, jmp, hlt, imm, upd_flag;
    wire [1:0] ALUop;
    wire [3:0] opcode;

    wire [15:0] pc_current;
    wire [15:0] instr;
    wire [15:0] memr_data;
    wire [15:0] mem_address;
    wire [15:0] mem_write_data;

    Instruction_Memory instruction_memory (
        .pc(pc_current),
        .instruction(instr)
    );

    Data_Memory data_memory (
        .clk(clk),
        .rst(rst),
        .mem_access_addr(mem_address),
        .mem_write_data(mem_write_data),
        .mem_write_en(memw),
        .mem_read(memr),
        .mem_read_data(memr_data)
    );

    Datapath datapath (
        .clk(clk),
        .rst(rst),
        .regwdst(regwdst),
        .ALUsrc(ALUsrc),
        .mem2reg(mem2reg),
        .regw_en(regw_en),
        .memr(memr),
        .memw(memw),
        .b(b),
        .jmp(jmp),
        .hlt(hlt),
        .imm(imm),
        .upd_flag(upd_flag),
        .ALUop(ALUop),
        .instr(instr),
        .pc_current(pc_current),
        .mem_address(mem_address),
        .mem_write_data(mem_write_data),
        .memr_data(memr_data),
        .ALUout(ALUout),
        .opcode(opcode)
    );

    ControlUnit control_unit (
        .opcode(opcode),
        .regwdst(regwdst),
        .ALUsrc(ALUsrc),
        .mem2reg(mem2reg),
        .regw_en(regw_en),
        .memr(memr),
        .memw(memw),
        .b(b),
        .jmp(jmp),
        .hlt(hlt),
        .imm(imm),
        .upd_flag(upd_flag),
        .ALUop(ALUop)
    );
    
endmodule
