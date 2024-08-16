module AdderPCPlus4ImmExt (
    input wire [31:0] Pc,           // Current PC value
    input wire [31:0] imm_ext,      // Immediate extended value
    output wire [31:0] pc_target    // PC + Immediate value
);
    assign pc_target = Pc + imm_ext; // Compute PC + Immediate value
endmodule
