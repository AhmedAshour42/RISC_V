module ControlUnit (
    input [6:0] op,               // 7-bit operation code
    input [2:0] funct3,           // Function code for R-type instructions
    input [6:0] funct7,           // Function code for R-type instructions (funct7)
    input Zero,                   // Zero flag from ALU
    output RegWrite,              // Register write enable
    output [1:0] ImmSrc,          // Immediate source
    output ALUSrc,                // ALU source select
    output MemWrite,              // Memory write enable
    output [1:0] ResultSrc,       // Result source select
    output PCSrc,                 // PC source for branch/jump
    output [2:0] ALUControl       // ALU control signal
);

    // Internal signals
    wire Branch, jump;            // Branch and jump signals
    wire [1:0] ALUOp;             // ALU operation code
    wire funct7_5 = funct7[5];    // Extract bit 5 of funct7
    wire op_5 = op[5];            // Extract bit 5 of op

    // Instantiate the main decoder
    ControlUnit_main_decoder main_decoder (
        .op(op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .jumb(jump),
        .ALUOp(ALUOp)
    );

    // Instantiate the ALU decoder
    ALUDecoder alu_decoder (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .op_5(op_5),
        .ALUControl(ALUControl)
    );

    // Instantiate the AND gate for PC source selection
    AND and_gate (
        .Zero(Zero),
        .Branch(Branch),
        .jump(jump),
        .PCsrc(PCSrc)
    );

endmodule
