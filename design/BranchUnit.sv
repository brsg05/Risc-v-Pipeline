`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC,
    input logic [31:0] Imm,
    input logic Branch,
    input logic Jump,  
    input logic JumpReg,
    input logic Halt,  
    input logic [31:0] AluResult,
    output logic [31:0] PC_Imm,
    output logic [31:0] PC_Four,
    output logic [31:0] BrPC,
    output logic PcSel
);

  //logic Branch_Sel;

  logic [31:0] PC_Full;

    assign PC_Full = {23'b0, Cur_PC};
    assign Branch_Sel = (Branch && AluResult[0]) || Jump;
    assign PC_Four = PC_Full + 32'b100;
    assign PcSel = Branch_Sel || Jump || Halt;

    always_comb begin

        case(JumpReg)
            1'b0: 
                PC_Imm = AluResult;
            1'b1:
                PC_Imm = PC_Full + Imm;
        endcase

        case(Branch_Sel)
            1'b0:   begin   case(Halt)
                                1'b0: BrPC = 32'b0;
                                1'b1: BrPC = PC_Full;
                            endcase
                    end
            1'b1: BrPC = PC_Imm;
        endcase
    end
  

endmodule
