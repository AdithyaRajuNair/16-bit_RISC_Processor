`timescale 1ns / 1ps

module ControlUnit(
    input [3:0] opcode,
    output reg[1:0] ALUop,
    output reg regwdst,ALUsrc,mem2reg,regw_en,memr,memw,b,jmp,hlt,imm,upd_flag
    );
    
always @(*)
begin
    case(opcode)
    4'b0000:    //ADD
        begin
            regwdst = 1'b1;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b1;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    4'b0001:    //SUB
        begin
            regwdst = 1'b1;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b1;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    4'b0010:    //NOT
        begin
            regwdst = 1'b1;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b1;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    4'b0011:    //AND
        begin
            regwdst = 1'b1;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b1;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    4'b0100:    //OR
        begin
            regwdst = 1'b1;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b1;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    4'b0101:    //LOAD
        begin
            regwdst = 1'b0;
            ALUsrc = 1'b1;
            mem2reg = 1'b1;
            regw_en = 1'b1;
            memr = 1'b1;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b10;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    4'b0110:    //STORE
        begin
            regwdst = 1'b0;
            ALUsrc = 1'b1;
            mem2reg = 1'b0;
            regw_en = 1'b0;
            memr = 1'b0;
            memw = 1'b1;
            b = 1'b0;
            ALUop = 2'b10;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    4'b0111:    //MOV
        begin
            regwdst = 1'b0;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b1;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    4'b1000:    //MOVi
        begin
            regwdst = 1'b0;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b1;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b1;
            upd_flag = 1'b0;
        end
    4'b1001:    //JUMP
        begin
            regwdst = 1'b0;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b0;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b1;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end

    4'b1100:    //CMP
        begin
            regwdst = 1'b0;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b0;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b01;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b1;
        end
    4'b1101:    //B
        begin
            regwdst = 1'b0;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b0;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b1;
            ALUop = 2'b10;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end

    4'b1111:    //HLT
        begin
            regwdst = 1'b0;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b0;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b0;
            hlt = 1'b1;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    default:
        begin
            regwdst = 1'b0;
            ALUsrc = 1'b0;
            mem2reg = 1'b0;
            regw_en = 1'b0;
            memr = 1'b0;
            memw = 1'b0;
            b = 1'b0;
            ALUop = 2'b00;
            jmp = 1'b0;
            hlt = 1'b0;
            imm = 1'b0;
            upd_flag = 1'b0;
        end
    endcase
end
endmodule
