// rv16_alu.v
// Arithmetic Logic Unit for RV16
module rv16_alu (
    input wire [31:0] i_operand_a,
    input wire [31:0] i_operand_b,
    input wire [3:0] i_alu_op,
    
    output reg [31:0] o_result,
    output wire o_zero,
    output reg o_overflow,
    output reg o_carry
);

    wire [32:0] add_result;
    wire [32:0] sub_result;
    
    assign add_result = {1'b0, i_operand_a} + {1'b0, i_operand_b};
    assign sub_result = {1'b0, i_operand_a} - {1'b0, i_operand_b};
    assign o_zero = (o_result == 32'h0);
    
    always @(*) begin
        o_overflow = 1'b0;
        o_carry = 1'b0;
        
        case (i_alu_op)
            4'b0000: begin // ADD
                o_result = add_result[31:0];
                o_carry = add_result[32];
                o_overflow = (i_operand_a[31] == i_operand_b[31]) && (o_result[31] != i_operand_a[31]);
            end
            
            4'b1000: begin // SUB
                o_result = sub_result[31:0];
                o_carry = sub_result[32];
                o_overflow = (i_operand_a[31] != i_operand_b[31]) && (o_result[31] != i_operand_a[31]);
            end
            
            4'b0001: // SLL
                o_result = i_operand_a << i_operand_b[4:0];
                
            4'b0010: // SLT
                o_result = ($signed(i_operand_a) < $signed(i_operand_b)) ? 32'h1 : 32'h0;
                
            4'b0011: // SLTU
                o_result = (i_operand_a < i_operand_b) ? 32'h1 : 32'h0;
                
            4'b0100: // XOR
                o_result = i_operand_a ^ i_operand_b;
                
            4'b0101: // SRL
                o_result = i_operand_a >> i_operand_b[4:0];
                
            4'b1101: // SRA
                o_result = $signed(i_operand_a) >>> i_operand_b[4:0];
                
            4'b0110: // OR
                o_result = i_operand_a | i_operand_b;
                
            4'b0111: // AND
                o_result = i_operand_a & i_operand_b;
                
            // Branch comparisons
            4'b1000: // BEQ
                o_result = (i_operand_a == i_operand_b) ? 32'h1 : 32'h0;
                
            4'b1001: // BNE
                o_result = (i_operand_a != i_operand_b) ? 32'h1 : 32'h0;
                
            4'b1100: // BLT
                o_result = ($signed(i_operand_a) < $signed(i_operand_b)) ? 32'h1 : 32'h0;
                
            4'b1101: // BGE
                o_result = ($signed(i_operand_a) >= $signed(i_operand_b)) ? 32'h1 : 32'h0;
                
            4'b1110: // BLTU
                o_result = (i_operand_a < i_operand_b) ? 32'h1 : 32'h0;
                
            4'b1111: // BGEU
                o_result = (i_operand_a >= i_operand_b) ? 32'h1 : 32'h0;
                
            default:
                o_result = 32'h0;
        endcase
    end

endmodule
