module TOP_Tb;

    reg clk;
    reg reset;
    wire [31:0] result;
    integer iteration; // Counter for iterations

    // Instantiate the DUT (Device Under Test)
    TOP dut (
        .clk(clk),
        .reset(reset),
        .result(result)
    );

    // Clock generation
    always begin
        #1 clk = ~clk; // 100MHz clock
    end

    // Task to display register file contents
    task display_registers;
        integer i, k;
        begin
            // Display register file contents
            for (i = 0; i < 32; i = i + 1) begin
                $display("R%d = %d", i, dut.reg_file.regfile[i]);
            end
            // Display data memory contents
            for (k = 0; k < 32; k = k + 1) begin
                $display("Memory[%d] = %d", k, dut.data_mem.memory[k]);
            end
        end
    endtask

    // Initial setup
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        iteration = 0;

        // Release reset after some time
        #2 reset = 0;

        repeat(16) begin
            #2;
            iteration = iteration + 1;
            $display("Register file and Memory contents %0d:", iteration);
            // Display register file and memory contents
            display_registers();
        end

        // End simulation
        $stop;
    end

endmodule
