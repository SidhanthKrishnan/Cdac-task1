// rv16_address_gen.v
// Address generation for PC and memory operations
module rv16_address_gen (
    input wire [31:0] i_pc,
    input wire [31:0] i_rs1_data,
    input wire [31:0] i_immediate,
    input wire [1:0] i_pc_src,
    input wire i_branch_taken,
    
    output reg [31:0] o_next_pc,
    output reg [31:0] o_mem_addr
);

    always @(*) begin
        // Memory address calculation
        o_mem_addr = i_rs1_data + i_immediate;
        
        // Next PC calculation
        case (i_pc_src)
            2'b00: // PC + 4 (normal)
                o_next_pc = i_pc + 4;
            2'b01: // Branch
                o_next_pc = i_branch_taken ? (i_pc + i_immediate) : (i_pc + 4);
            2'b10: // JAL
                o_next_pc = i_pc + i_immediate;
            2'b11: // JALR
                o_next_pc = (i_rs1_data + i_immediate) & ~32'h1;
            default:
                o_next_pc = i_pc + 4;
        endcase
    end

endmodule
