// rv16_ide_stage.v
// Top-level Instruction Decode Execute stage
module rv16_ide_stage (
    input wire clk,
    input wire rst_n,
    
    // From instruction fetch
    input wire [31:0] i_fetch_data,
    input wire i_fetch_valid,
    input wire [31:0] i_pc,
    
    // Memory interface
    output wire [31:0] o_mem_addr,
    output wire [31:0] o_mem_wdata,
    output wire o_mem_read,
    output wire o_mem_write,
    output wire [2:0] o_mem_size,
    input wire [31:0] i_mem_rdata,
    input wire i_mem_ready,
    
    // Branch/Jump control
    output wire [31:0] o_next_pc,
    output wire o_pc_update,
    
    // Pipeline control
    output wire o_stall,
    output wire o_flush
);

    // Internal signals
    wire [31:0] aligned_instr;
    wire instr_valid;
    wire is_compressed;
    wire [31:0] align_next_pc;
    
    // Decoder outputs
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] immediate;
    
    // Control signals
    wire reg_write, mem_read, mem_write, branch, jump, alu_src, mem_to_reg;
    wire [3:0] alu_op;
    wire [1:0] pc_src;
    
    // Register file signals
    wire [31:0] rs1_data, rs2_data;
    wire [31:0] rd_data;
    
    // ALU signals
    wire [31:0] alu_operand_a, alu_operand_b;
    wire [31:0] alu_result;
    wire alu_zero, alu_overflow, alu_carry;
    
    // Address generation
    wire [31:0] mem_addr;
    wire [31:0] next_pc;
    
    // Branch decision
    wire branch_taken;
    
    // CSR signals
    wire [11:0] csr_addr;
    wire [31:0] csr_wdata, csr_rdata;
    wire [2:0] csr_op;
    wire csr_valid, csr_ready;
    
    // Pipeline registers
    reg [31:0] execute_pc;
    reg [31:0] execute_instr;
    reg execute_valid;
    
    // Instruction alignment
    rv16_instruction_align align_unit (
        .clk(clk),
        .rst_n(rst_n),
        .i_fetch_data(i_fetch_data),
        .i_fetch_valid(i_fetch_valid),
        .i_pc(i_pc),
        .o_aligned_instr(aligned_instr),
        .o_instr_valid(instr_valid),
        .o_is_compressed(is_compressed),
        .o_next_pc(align_next_pc)
    );
    
    // Instruction decoder
    rv16_decoder decoder (
        .i_instruction(aligned_instr),
        .i_is_compressed(is_compressed),
        .o_opcode(opcode),
        .o_funct3(funct3),
        .o_funct7(funct7),
        .o_rs1(rs1),
        .o_rs2(rs2),
        .o_rd(rd),
        .o_immediate(immediate),
        .o_reg_write(reg_write),
        .o_mem_read(mem_read),
        .o_mem_write(mem_write),
        .o_branch(branch),
        .o_jump(jump),
        .o_alu_src(alu_src),
        .o_alu_op(alu_op),
        .o_mem_to_reg(mem_to_reg),
        .o_pc_src(pc_src)
    );
    
    // Register file
    rv16_register_file regfile (
        .clk(clk),
        .rst_n(rst_n),
        .i_rs1_addr(rs1),
        .i_rs2_addr(rs2),
        .o_rs1_data(rs1_data),
        .o_rs2_data(rs2_data),
        .i_rd_addr(rd),
        .i_rd_data(rd_data),
        .i_write_enable(reg_write && execute_valid)
    );
    
    // ALU
    assign alu_operand_a = rs1_data;
    assign alu_operand_b = alu_src ? immediate : rs2_data;
    
    rv16_alu alu (
        .i_operand_a(alu_operand_a),
        .i_operand_b(alu_operand_b),
        .i_alu_op(alu_op),
        .o_result(alu_result),
        .o_zero(alu_zero),
        .o_overflow(alu_overflow),
        .o_carry(alu_carry)
    );
    
    // Address generator
    rv16_address_gen addr_gen (
        .i_pc(execute_pc),
        .i_rs1_data(rs1_data),
        .i_immediate(immediate),
        .i_pc_src(pc_src),
        .i_branch_taken(branch_taken),
        .o_next_pc(next_pc),
        .o_mem_addr(mem_addr)
    );
    
    // CSR module
    assign csr_addr = immediate[11:0];
    assign csr_wdata = rs1_data;
    assign csr_op = funct3;
    assign csr_valid = (opcode == 7'b1110011) && execute_valid;
    
    rv16_csr csr_unit (
        .clk(clk),
        .rst_n(rst_n),
        .i_csr_addr(csr_addr),
        .i_csr_wdata(csr_wdata),
        .i_csr_op(csr_op),
        .i_csr_valid(csr_valid),
        .o_csr_rdata(csr_rdata),
        .o_csr_ready(csr_ready)
    );
    
    // Branch decision logic
    assign branch_taken = branch && (
        (funct3 == 3'b000 && alu_zero) ||      // BEQ
        (funct3 == 3'b001 && !alu_zero) ||     // BNE
        (funct3 == 3'b100 && alu_result[0]) || // BLT
        (funct3 == 3'b101 && !alu_result[0]) ||// BGE
        (funct3 == 3'b110 && alu_result[0]) || // BLTU
        (funct3 == 3'b111 && !alu_result[0])   // BGEU
    );
    
    // Write-back data selection
    assign rd_data = csr_valid ? csr_rdata :
                    mem_to_reg ? i_mem_rdata :
                    (jump || branch_taken) ? (execute_pc + 4) :
                    (opcode == 7'b0110111) ? immediate :  // LUI
                    (opcode == 7'b0010111) ? (execute_pc + immediate) : // AUIPC
                    alu_result;
    
    // Pipeline control
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            execute_pc <= 32'h0;
            execute_instr <= 32'h0;
            execute_valid <= 1'b0;
        end else if (!o_stall) begin
            execute_pc <= i_pc;
            execute_instr <= aligned_instr;
            execute_valid <= instr_valid;
        end
    end
    
    // Output assignments
    assign o_mem_addr = mem_addr;
    assign o_mem_wdata = rs2_data;
    assign o_mem_read = mem_read && execute_valid;
    assign o_mem_write = mem_write && execute_valid;
    assign o_mem_size = funct3; // Size encoding from funct3
    assign o_next_pc = next_pc;
    assign o_pc_update = (branch_taken || jump) && execute_valid;
    assign o_stall = (mem_read || mem_write) && !i_mem_ready;
    assign o_flush = o_pc_update;

endmodule
