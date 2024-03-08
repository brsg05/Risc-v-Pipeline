`timescale 1ns / 1ps

module ALUController (
    //Inputs
    input logic [1:0] ALUOp,  // 2-bit opcode field from the Controller --00: LW/SW/AUIPC; 01:Branch; 10: Rtype/Itype; 11:JAL/LUI
    input logic [6:0] Funct7,  // bits 25 to 31 of the instruction
    input logic [2:0] Funct3,  // bits 12 to 14 of the instruction

    //Output
    output logic [3:0] Operation  // operation selection for ALU
);

always_comb
    begin
        case (ALUOp)
            2'b01: begin
                   case(Funct3)
                        3'b000: Operation = 4'b0111; //BEQ
                        3'b001: Operation = 4'b1110; //BNE
                        3'b001: Operation = 4'b1011; //BGE
                        3'b100: Operation = 4'b1101; //BLT
                    endcase
            end
            2'b10: begin 
                        case (Funct3)
                        3'b000: begin
                            case (Funct7)
                                7'b0000000: Operation = 4'b0000; //ADD
                                7'b0100000: Operation = 4'b0001; // SUB 
                                default: Operation = 4'b0010; // ADDI
                            endcase
                            end
                        3'b001: begin
                                    case(Funct7)
                                        default: Operation = 4'b0110; // slli
                                endcase
                                end
                        3'b010: begin  
                                    case(Funct7)
                                        7'b0000000: Operation = 4'b1010; //slt
                                        default: Operation = 4'b1001;//slti
                                    endcase
                                    end
                        3'b100: begin
                                    case(Funct7)
                                        default: Operation = 4'b0100; //XOR
                                    endcase
                                end
                        3'b110: begin
                                    case(Funct7)
                                        default: Operation = 4'b0011; //or
                                    endcase
                                end
                        3'b111: begin
                                    case(Funct7)
                                        default: Operation = 4'b1000; //and
                                    endcase
                                end
                        3'b101: begin
                                    case(Funct7)
                                        7'b0100000: Operation = 4'b0101; //srai
                                        7'b0000000: Operation = 4'b1100; //srli
                                    endcase
                                end
                        endcase;    
                    end
            2'b11: begin case(Funct3)
                            3'b000: Operation = 4'b0000;
                            default: Operation = 4'b1111;
                        endcase
                    end
            default: Operation = 4'b0000;
    endcase
end

endmodule