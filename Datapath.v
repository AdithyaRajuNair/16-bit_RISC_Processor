`timescale 1ns / 1ps

module Datapath(
    input clk,
    input rst,
    input regwdst, ALUsrc, mem2reg, regw_en, memr, memw, b, jmp, hlt, imm, upd_flag,
    input [1:0] ALUop,
    input [15:0] instr,
    output reg [15:0] pc_current,
    output [15:0] mem_address,
    output [15:0] mem_write_data,
    input [15:0] memr_data,
    output [15:0] ALUout,
    output [3:0] opcode
);

    wire [15:0] pc2,pc_next;
    wire [2:0] inrw, inrwimm, inrr1, inrr2;
    wire [15:0] regr_data1, regr_data2, ext_imm, read_data1, read_datals, read_data2;
    wire [2:0] ALUctrl;
    wire zflag, nflag;
    wire [15:0] pc_j, pc_b, pc2_b, pc_hlt;
    wire [15:0] immdata;
    wire beq_ctrl, bne_ctrl, blt_ctrl, ble_ctrl, bgt_ctrl, bge_ctrl;
    wire bsel;
    reg [15:0] regw_data;

    // Initialize the PC
    initial begin
        pc_current <= 16'd0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_current <= 16'd0;
        end else begin
            pc_current <= pc_next;
        end
    end

    assign pc2 = pc_current + 16'd2;

    // Decode instruction
    assign inrwimm = (regwdst == 1'b1) ? instr[5:3] : instr[8:6];
    assign inrw = (imm == 1'b1) ? instr[11:9] : inrwimm;
    assign inrr1 = instr[11:9];
    assign inrr2 = instr[8:6];

    RegisterBank regs (
        .clk(clk),
        .regw_en(regw_en),
        .inrw(inrw),
        .regw_data(regw_data),
        .inrr1(inrr1),
        .regr_data1(regr_data1),
        .inrr2(inrr2),
        .regr_data2(regr_data2)
    );

    assign ext_imm = {{10{instr[5]}}, instr[5:0]};

    alu_control ALU_CU (
        .ALUOp(ALUop),
        .Opcode(instr[15:12]),
        .ALU_Cnt(ALUctrl)
    );

    assign read_data1 = (b == 1'b1) ? pc2 : regr_data1;
    assign read_datals = (ALUsrc == 1'b1) ? ext_imm : regr_data2;
    assign read_data2 = (b == 1'b1) ? ext_imm : read_datals;

    ALU alu_unit (
        .a(read_data1),
        .b(read_data2),
        .alu_control(ALUctrl),
        .upd_flag(upd_flag),
        .result(ALUout),
        .zero(zflag),
        .neg(nflag)
    );

    assign mem_address = ALUout;
    assign mem_write_data = regr_data2;

    assign pc_b = ALUout;
    assign beq_ctrl = b & zflag;
    assign bne_ctrl = b & ~zflag;
    assign blt_ctrl = b & nflag;
    assign ble_ctrl = b & (nflag | zflag);
    assign bgt_ctrl = b & (~nflag & ~zflag);
    assign bge_ctrl = b & ~nflag;

    MUX8x1 bselect (
        .d0(beq_ctrl),
        .d1(bne_ctrl),
        .d2(blt_ctrl),
        .d3(ble_ctrl),
        .d4(bgt_ctrl),
        .d5(bge_ctrl),
        .s(inrr1),
        .out(bsel)
    );

    assign pc2_b = (bsel == 1'b1) ? pc_b : pc2;
    assign pc_j = {pc2[15:13], {instr[11:0], 1'b0}};
    assign pc_hlt = (jmp == 1'b1) ? pc_j : pc2_b;
    assign pc_next = (hlt == 1'b1) ? pc_current : pc_hlt;

    assign immdata = {7'd0, instr[8:0]};

    always @(*) begin
        if (imm == 1'b1) begin
            regw_data = immdata;
        end else if (mem2reg == 1'b1) begin
            regw_data = memr_data;
        end else begin
            regw_data = ALUout;
        end
    end

    assign opcode = instr[15:12];

endmodule
