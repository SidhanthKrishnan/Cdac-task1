// rv16_instruction_align.v
// Handles alignment of 16-bit compressed and 32-bit standard instructions
module rv16_instruction_align (
    input wire clk,
    input wire rst_n,
    input wire [31:0] i_fetch_data,
    input wire i_fetch_valid,
    input wire [31:0] i_pc,
    
    output reg [31:0] o_aligned_instr,
    output reg o_instr_valid,
    output reg o_is_compressed,
    output reg [31:0] o_next_pc
);

    reg [15:0] instr_buffer;
    reg buffer_valid;
    reg pc_misaligned;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            instr_buffer <= 16'h0;
            buffer_valid <= 1'b0;
            pc_misaligned <= 1'b0;
            o_aligned_instr <= 32'h0;
            o_instr_valid <= 1'b0;
            o_is_compressed <= 1'b0;
            o_next_pc <= 32'h0;
        end else begin
            if (i_fetch_valid) begin
                // Check if PC is misaligned (bit 1 set)
                pc_misaligned <= i_pc[1];
                
                if (pc_misaligned && buffer_valid) begin
                    // Complete instruction from buffer and new fetch
                    o_aligned_instr <= {i_fetch_data[15:0], instr_buffer};
                    o_instr_valid <= 1'b1;
                    o_is_compressed <= 1'b0;
                    o_next_pc <= i_pc + 4;
                    
                    // Check if remaining data is compressed
                    if (i_fetch_data[17:16] != 2'b11) begin
                        instr_buffer <= i_fetch_data[31:16];
                        buffer_valid <= 1'b1;
                    end else begin
                        buffer_valid <= 1'b0;
                    end
                end else if (pc_misaligned) begin
                    // Start with upper 16 bits
                    if (i_fetch_data[17:16] != 2'b11) begin
                        // Compressed instruction in upper half
                        o_aligned_instr <= {16'h0, i_fetch_data[31:16]};
                        o_instr_valid <= 1'b1;
                        o_is_compressed <= 1'b1;
                        o_next_pc <= i_pc + 2;
                        buffer_valid <= 1'b0;
                    end else begin
                        // Need next fetch for full instruction
                        instr_buffer <= i_fetch_data[31:16];
                        buffer_valid <= 1'b1;
                        o_instr_valid <= 1'b0;
                    end
                end else begin
                    // PC is aligned
                    if (i_fetch_data[1:0] != 2'b11) begin
                        // Compressed instruction in lower half
                        o_aligned_instr <= {16'h0, i_fetch_data[15:0]};
                        o_instr_valid <= 1'b1;
                        o_is_compressed <= 1'b1;
                        o_next_pc <= i_pc + 2;
                        
                        // Check upper half
                        if (i_fetch_data[17:16] != 2'b11) begin
                            instr_buffer <= i_fetch_data[31:16];
                            buffer_valid <= 1'b1;
                        end else begin
                            buffer_valid <= 1'b0;
                        end
                    end else begin
                        // Full 32-bit instruction
                        o_aligned_instr <= i_fetch_data;
                        o_instr_valid <= 1'b1;
                        o_is_compressed <= 1'b0;
                        o_next_pc <= i_pc + 4;
                        buffer_valid <= 1'b0;
                    end
                end
            end else begin
                o_instr_valid <= 1'b0;
            end
        end
    end

endmodule
