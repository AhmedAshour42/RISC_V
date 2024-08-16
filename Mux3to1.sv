module Mux3to1(
    input wire [31:0] ReadData,    // Input 0 (Data from Memory)
    input wire [31:0] ALU_Result,  // Input 1 (ALU Result)
    input wire [31:0] pc_plus4,    // Input 2 (PC + 4)
    input wire [1:0] ResultSrc,    // Result source selector
    output reg [31:0] Result       // Output (Final Result)
);

    always @(*) begin
        case (ResultSrc)
            2'b00: Result = ALU_Result; // ALU Result
            2'b01: Result = ReadData;   // Data Memory Read Data
            2'b10: Result = pc_plus4;   // PC + 4
            default: Result = ALU_Result; // Default to ALU Result
        endcase
    end

endmodule
