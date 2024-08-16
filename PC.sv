module PC (
    input clk,             // Clock signal
    input reset,           // Reset signal
    input [31:0] Pc_next,  // Input address
    output reg [31:0] PC   // Output address
);
    // On every positive edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset PC to 0 on reset signal
            PC <= 32'b0;
        end else begin
            PC <= Pc_next; // Update PC
        end
    end
endmodule
