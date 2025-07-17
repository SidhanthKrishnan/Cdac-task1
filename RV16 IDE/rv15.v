// rv16_decoder.v
// Decodes RISC-V instructions and generates control signals with MUL support
module rv16_decoder (
    input wire [31:0] i_instruction,
    input wire i_is_compressed,
    
    output reg [6:0] o_opcode,
    output reg [2:0] o_funct3,
    output reg [6:0] o_funct7,
    output reg [4:0] o_rs1,
    output reg [4:0] o_rs2,
    output reg [4:0] o_rd,
    output reg [31:0] o_immediate,
    
    // Control signals
    output reg o_reg_write,
    output reg o_mem_read,
    output reg o_mem_write,
    output reg o_branch,
    output reg o_jump,
    output reg o_alu_src,
    output reg [3:0] o_alu_op,
    output reg o_mem_to_reg,
    output reg [1:0] o_pc_src
);

    // Internal wires for expanded compressed instructions
    wire [31:0] expanded_instr;
    
    // Compressed instruction expander (from previous implementation)
    rv16c_expander expander (
        .i_compressed(i_instruction[15:0]),
        .i_is_compressed(i_is_compressed),
        .o_expanded(expanded_instr)
    );
    
    wire [31:0] decoded_instr = i_is_compressed ? expanded_instr : i_instruction;
    
    always @(*) begin
        // Default values
        o_opcode = decoded_instr[6:0];
        o_funct3 = decoded_instr[14:12];
        o_funct7 = decoded_instr[31:25];
        o_rs1 = decoded_instr[19:15];
        o_rs2 = decoded_instr[24:20];
        o_rd = decoded_instr[11:7];
        
        // Default control signals
        o_reg_write = 1'b0;
        o_mem_read = 1'b0;
        o_mem_write = 1'b0;
        o_branch = 1'b0;
        o_jump = 1'b0;
        o_alu_src = 1'b0;
        o_alu_op = 4'b0000;
        o_mem_to_reg = 1'b0;
        o_pc_src = 2'b00;
        o_immediate = 32'h0;
        
        case (o_opcode)
            7'b0110011: begin // R-type
                o_reg_write = 1'b1;
                o_alu_src = 1'b0;
                
                if (o_funct7 == 7'b0000001) begin
                    // M-extension instructions
                    case (o_funct3)
                        3'b000: o_alu_op = 4'b1010; // MUL (new)
                        // You can add more M-extension instructions here, e.g., DIV, MULH etc.
                        default: o_alu_op = 4'b0000; // Default, treat as ADD or NOP
                    endcase
                end
                else begin
                    // Regular R-type ALU operation mapping using funct7[5], funct3
                    o_alu_op = {o_funct7[5], o_funct3};
                end
            end
            
            7'b0010011: begin // I-type (immediate)
                o_reg_write = 1'b1;
                o_alu_src = 1'b1;
                o_alu_op = {1'b0, o_funct3};
                o_immediate = {{20{decoded_instr[31]}}, decoded_instr[31:20]};
            end
            
            7'b0000011: begin // Load
                o_reg_write = 1'b1;
                o_mem_read = 1'b1;
                o_alu_src = 1'b1;
                o_alu_op = 4'b0000; // ADD
                o_mem_to_reg = 1'b1;
                o_immediate = {{20{decoded_instr[31]}}, decoded_instr[31:20]};
            end
            
            7'b0100011: begin // Store
                o_mem_write = 1'b1;
                o_alu_src = 1'b1;
                o_alu_op = 4'b0000; // ADD
                o_immediate = {{20{decoded_instr[31]}}, decoded_instr[31:25], decoded_instr[11:7]};
            end
            
            7'b1100011: begin // Branch
                o_branch = 1'b1;
                o_alu_src = 1'b0;
                o_alu_op = {1'b1, o_funct3};
                o_pc_src = 2'b01;
                o_immediate = {{19{decoded_instr[31]}}, decoded_instr[31], decoded_instr[7], 
                              decoded_instr[30:25], decoded_instr[11:8], 1'b0};
            end
            
            7'b1101111: begin // JAL
                o_reg_write = 1'b1;
                o_jump = 1'b1;
                o_pc_src = 2'b10;
                o_immediate = {{11{decoded_instr[31]}}, decoded_instr[31], decoded_instr[19:12],
                              decoded_instr[20], decoded_instr[30:21], 1'b0};
            end
            
            7'b1100111: begin // JALR
                o_reg_write = 1'b1;
                o_jump = 1'b1;
                o_alu_src = 1'b1;
                o_alu_op = 4'b0000; // ADD
                o_pc_src = 2'b11;
                o_immediate = {{20{decoded_instr[31]}}, decoded_instr[31:20]};
            end
            
            7'b0110111: begin // LUI
                o_reg_write = 1'b1;
                o_immediate = {decoded_instr[31:12], 12'h0};
            end
            
            7'b0010111: begin // AUIPC
                o_reg_write = 1'b1;
                o_alu_src = 1'b1;
                o_alu_op = 4'b0000; // ADD
                o_immediate = {decoded_instr[31:12], 12'h0};
            end
            
            default: begin
                // NOP or unsupported instruction
            end
        endcase
    end

endmodule
