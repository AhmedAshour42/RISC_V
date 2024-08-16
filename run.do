vlib work
vlog -sv TOP.sv TOP_Tb.sv AdderPCPlus4.sv AdderPCPlus4ImmExt.sv Mux2to1_PC.sv PC.sv instrMemory.sv ControlUnit.sv RegisterFile.sv Mux2to1_RG_f.sv ALU.sv DataMemory.sv Mux3to1.sv AND.sv
vlog TOP_Tb.sv
vsim -voptargs=+acc work.TOP_Tb

add wave -position insertpoint  \
sim:/TOP_Tb/clk \
sim:/TOP_Tb/reset
add wave -position insertpoint  \
sim:/TOP_Tb/dut/adder_pc_plus4/pc \
sim:/TOP_Tb/dut/adder_pc_plus4/pc_plus4
add wave -position insertpoint  \
sim:/TOP_Tb/dut/adder_pc_plus4_immext/imm_ext \
sim:/TOP_Tb/dut/adder_pc_plus4_immext/pc_target
add wave -position insertpoint  \
sim:/TOP_Tb/dut/instr_mem/instr
add wave -position insertpoint  \
sim:/TOP_Tb/dut/instr_mem/instr
add wave -position insertpoint  \
sim:/TOP_Tb/dut/control_unit/op \
sim:/TOP_Tb/dut/control_unit/funct3 \
sim:/TOP_Tb/dut/control_unit/funct7 \
sim:/TOP_Tb/dut/control_unit/Zero \
sim:/TOP_Tb/dut/control_unit/RegWrite \
sim:/TOP_Tb/dut/control_unit/ImmSrc \
sim:/TOP_Tb/dut/control_unit/ALUSrc \
sim:/TOP_Tb/dut/control_unit/MemWrite \
sim:/TOP_Tb/dut/control_unit/ResultSrc \
sim:/TOP_Tb/dut/control_unit/PCSrc \
sim:/TOP_Tb/dut/control_unit/ALUControl \
sim:/TOP_Tb/dut/control_unit/Branch \
sim:/TOP_Tb/dut/control_unit/jump \
sim:/TOP_Tb/dut/control_unit/ALUOp \
sim:/TOP_Tb/dut/control_unit/funct7_5 \
sim:/TOP_Tb/dut/control_unit/op_5
add wave -position insertpoint  \
sim:/TOP_Tb/dut/reg_file/read_addr1 \
sim:/TOP_Tb/dut/reg_file/read_addr2 \
sim:/TOP_Tb/dut/reg_file/write_addr \
sim:/TOP_Tb/dut/reg_file/Result \
sim:/TOP_Tb/dut/reg_file/reg_write \
sim:/TOP_Tb/dut/reg_file/read_data1 \
sim:/TOP_Tb/dut/reg_file/read_data2
add wave -position insertpoint  \
sim:/TOP_Tb/dut/alu/secA \
sim:/TOP_Tb/dut/alu/secB \
sim:/TOP_Tb/dut/alu/ALUControl \
sim:/TOP_Tb/dut/alu/ALUResult \
sim:/TOP_Tb/dut/alu/zero
add wave -position insertpoint  \
sim:/TOP_Tb/dut/data_mem/ALUresult \
sim:/TOP_Tb/dut/data_mem/write_data \
sim:/TOP_Tb/dut/data_mem/mem_write \
sim:/TOP_Tb/dut/data_mem/ReadData
add wave -position insertpoint  \
sim:/TOP_Tb/dut/result_mux/ResultSrc \
sim:/TOP_Tb/dut/result_mux/Result
run -all
