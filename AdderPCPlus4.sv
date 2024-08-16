module AdderPCPlus4 (
    input wire [31:0] pc,           // Current PC value
    output wire [31:0] pc_plus4     // PC + 4 result
);
    assign pc_plus4 = pc + 4;        // Compute PC + 4
endmodule
