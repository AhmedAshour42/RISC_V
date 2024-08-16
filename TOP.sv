module TOP(
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    output wire [31:0] result    // Output result
);

    // Internal wires
    wire [31:0] pc, pc_next, pc_plus4, pc_target;
    wire [31:0] instruction;
    wire [1:0] result_src, imm_src;
    wire [2:0] alu_control;
    wire pc_src, mem_write, alu_src, reg_write;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] read_data1, read_data2, write_data;
    wire [31:0] imm_ext;
    wire [31:0] alu_result, src_b;
    wire zero;
    wire [31:0] read_data;

    // Assign addresses and control signals
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7];

    // Instantiate modules
    // PC Plus 4 Adder
    AdderPCPlus4 adder_pc_plus4 (
        .pc(pc),
        .pc_plus4(pc_plus4)
    );

    /* -------------------------------------------------------------------------- */
    /*                 // PC Target Adder with Immediate Extension                */
    /* -------------------------------------------------------------------------- */
    AdderPCPlus4ImmExt adder_pc_plus4_immext (
        .Pc(pc),
        .imm_ext(imm_ext),
        .pc_target(pc_target)
    );

    /* -------------------------------------------------------------------------- */
    /*                              // PC Multiplexer                             */
    /* -------------------------------------------------------------------------- */
    Mux2to1_PC mux_pc (
        .pc_plus4(pc_plus4),
        .pc_target(pc_target),
        .Pcsrc(pc_src),
        .Pc_next(pc_next)
    );

    /* -------------------------------------------------------------------------- */
    /*                             // Program Counter                             */
    /* -------------------------------------------------------------------------- */
    PC pc_reg (
        .clk(clk),
        .reset(reset),
        .Pc_next(pc_next),
        .PC(pc)
    );

    /* -------------------------------------------------------------------------- */
    /*                            // Instruction Memory                           */
    /* -------------------------------------------------------------------------- */
    instrMemory instr_mem(
        .Pc(pc),
        .instr(instruction)
    );

    /* -------------------------------------------------------------------------- */
    /*                               // Control Unit                              */
    /* -------------------------------------------------------------------------- */
    ControlUnit control_unit(
        .op(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .Zero(zero),
        .PCSrc(pc_src),
        .ResultSrc(result_src),
        .MemWrite(mem_write),
        .ALUControl(alu_control),
        .ALUSrc(alu_src),
        .ImmSrc(imm_src),
        .RegWrite(reg_write)
    );

    /* -------------------------------------------------------------------------- */
    /*                              // Register File                              */
    /* -------------------------------------------------------------------------- */
    RegisterFile reg_file(
        .clk(clk),
        .reset(reset),
        .read_addr1(rs1),
        .read_addr2(rs2),
        .write_addr(rd),
        .Result(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .reg_write(reg_write)
    );

    /* -------------------------------------------------------------------------- */
    /*                         // Immediate Extension Unit                        */
    /* -------------------------------------------------------------------------- */
    SignExtend imm_gen(
        .instr(instruction),
        .imm_src(imm_src),
        .imm_ext(imm_ext)
    );

    /* -------------------------------------------------------------------------- */
    /*                          // ALU Source Multiplexer                         */
    /* -------------------------------------------------------------------------- */
    Mux2to1_RG_f alu_src_mux (
        .ALUSrc(alu_src),
        .RD2(read_data2),
        .imm_ext(imm_ext),
        .SrcB(src_b)
    );

    /* -------------------------------------------------------------------------- */
    /*                                   // ALU                                   */
    /* -------------------------------------------------------------------------- */
    ALU alu(
        .secA(read_data1),
        .secB(src_b),
        .ALUControl(alu_control),
        .ALUResult(alu_result),
        .zero(zero)
    );

    /* -------------------------------------------------------------------------- */
    /*                               // Data Memory                               */
    /* -------------------------------------------------------------------------- */
    DataMemory data_mem(
        .clk(clk),
        .reset(reset),
        .ALUresult(alu_result),
        .write_data(read_data2),
        .ReadData(read_data),
        .mem_write(mem_write)
    );

    /* -------------------------------------------------------------------------- */
    /*                            // Result Multiplexer                           */
    /* -------------------------------------------------------------------------- */
    Mux3to1 result_mux(
        .ResultSrc(result_src),
        .ALU_Result(alu_result),
        .ReadData(read_data),
        .pc_plus4(pc_plus4),
        .Result(write_data)
    );

    /* ------------------------- // Assign output result ------------------------ */
    assign result = write_data;

endmodule
