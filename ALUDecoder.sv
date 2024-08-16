module ALUDecoder(
    input [1:0] ALUOp,          // ALU operation code
    input [2:0] funct3,         // Function code for R-type instructions
    input  funct7_5,            // Bit 5 of funct7 for R-type instructions
    input  op_5,                // Bit 5 of the operation code
    output reg [2:0] ALUControl // Control signal for the ALU (3-bit)
);

    always @(*) begin
        // Determine ALU control signal based on ALUOp and funct3
        case(ALUOp)
            2'b00: ALUControl = 3'b000; // ADD (for load and store instructions)
            2'b01: ALUControl = 3'b001; // SUB (for branch equal instructions)
            2'b10: begin
                case(funct3)
                    3'b000: begin
                        // Determine ALU operation based on funct7
                        if ({op_5, funct7_5} == 2'b11)
                            ALUControl = 3'b001; // SUB (if funct7 indicates subtraction)
                        else
                            ALUControl = 3'b000; // ADD (default for R-type instructions)
                    end
                    3'b010: ALUControl = 3'b101; // SLT (Set Less Than)
                    3'b110: ALUControl = 3'b011; // OR (Bitwise OR)
                    3'b111: ALUControl = 3'b010; // AND (Bitwise AND)
                    default: ALUControl = 3'b000; // Default to ADD
                endcase
            end
            default: ALUControl = 3'b000; // Default to ADD
        endcase
    end

endmodule
