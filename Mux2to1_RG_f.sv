module Mux2to1_RG_f(
    input wire [31:0] RD2,         // Input 0 (Data from Register 2)
    input wire [31:0] imm_ext,      // Input 1 (Immediate value)
    input wire ALUSrc,             // ALU source selector
    output wire [31:0] SrcB        // Output (ALU input B)
);
    assign SrcB = ALUSrc ? imm_ext : RD2; // Select ALU input B
endmodule
