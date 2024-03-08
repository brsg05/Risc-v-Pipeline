`timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb
        begin
            case(Operation)
            4'b0000:        // ADD
                ALUResult = $signed(SrcA) + $signed(SrcB);
            4'b0001:        // SUB
                    ALUResult = $signed(SrcA) - $signed(SrcB);
            4'b1010:        // SLT
                    ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 1 : 0;
            4'b0100:        // XOR
                    ALUResult = SrcA ^ SrcB;
            4'b1000:        // AND
                    ALUResult = SrcA & SrcB;
            4'b0011:        // OR
                     ALUResult = SrcA | SrcB;
            4'b0110:        // SLLI
                    ALUResult = SrcA << SrcB;
            4'b1100:        // SRLI
                    ALUResult = SrcA >> SrcB;
            4'b0010:        // ADDI
                    ALUResult = $signed(SrcA) + SrcB;
            4'b0101:        // SRAI
                    ALUResult = $signed(SrcA) >>> (SrcB & 5'b11111);
            4'b1001:        // SLTI
                    ALUResult = ($signed(SrcA) < SrcB) ? 1 : 0;
            4'b0111:        //BEQ
                    ALUResult = (SrcA == SrcB) ? 1 : 0;
            4'b1110:        //BNE
                    ALUResult = (SrcA != SrcB) ? 1 : 0;
            4'b1011:        //BGE
                    ALUResult = ($signed(SrcA) >= $signed(SrcB)) ? 1 : 0;
            4'b1101:        //BLT
                    ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 1 : 0;
            4'b1111:        //LUI
                    ALUResult = SrcB;
            default:
                    ALUResult = 0;
            endcase
        end
endmodule