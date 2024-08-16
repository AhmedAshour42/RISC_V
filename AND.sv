module AND (
    input Zero,    // Zero flag from ALU
    input Branch,  // Branch control signal
    input jump,    // Jump control signal
    output PCsrc   // PC source for branch or jump
);

    wire out; // Intermediate signal for branch and zero logic

    // Compute the intermediate signal 'out' as the logical AND of Zero and Branch
    assign out = Zero & Branch;

    // Compute PCsrc as the logical OR of 'out' and jump
    assign PCsrc = out | jump;

endmodule
