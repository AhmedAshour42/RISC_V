module DataMemory (
    input wire clk,                // Clock signal
    input wire reset,              // Reset signal
    input wire [31:0] ALUresult,   // Address from ALU for memory access
    input wire [31:0] write_data,  // Data to write into memory
    input wire mem_write,          // Memory write enable
    output reg [31:0] ReadData     // Data read from memory
);

    // Define the memory as an array of 32 registers, each 32 bits wide
    reg [31:0] memory [0:31];

    // Synchronous write operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all memory locations to 0
            integer i;
            for (i = 0; i < 32; i = i + 1) begin
                memory[i] <= 32'b0;
            end
        end else if (mem_write) begin
            // Write data to the memory location specified by ALUresult
            memory[ALUresult] <= write_data;
        end
    end

    // Asynchronous read operation
    always @(*) begin
        // Read data from the memory location specified by ALUresult
        ReadData = memory[ALUresult];
    end

endmodule
