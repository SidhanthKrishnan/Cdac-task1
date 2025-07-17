// rv16_alu.v (with fast MUL support)
module rv16_alu (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [31:0] i_operand_a,
    input  wire [31:0] i_operand_b,
    input  wire [3:0]  i_alu_op,
    input  wire        i_mul_enable,       // Enable MUL processing

    output reg  [31:0] o_result,
    output wire        o_zero,
    output reg         o_overflow,
    output reg         o_carry,
    output wire        o_busy,
    output wire        o_done
);

    // Registers for handling basic operations
    wire [32:0] add_result = {1'b0, i_operand_a} + {1'b0, i_operand_b};
    wire [32:0] sub_result = {1'b0, i_operand_a} - {1'b0, i_operand_b};
    assign o_zero = (o_result == 32'h0);

    // MUL Unit signals
    reg mul_start;
    wire [31:0] mul_result;
    wire mul_ready, mul_busy;

    // Instantiate multiplier
    rv16_mul_unit mul_unit (
        .clk(clk),
        .rst_n(rst_n),
        .start(mul_start),
        .op_a(i_operand_a),
        .op_b(i_operand_b),
        .result(mul_result),
        .done(mul_ready),
        .busy(mul_busy)
    );

    assign o_busy = mul_busy;
    assign o_done = mul_ready;

    always @(*) begin
        o_result = 32'h0;
        o_overflow = 1'b0;
        o_carry = 1'b0;
        mul_start = 1'b0;

        case (i_alu_op)
            4'b0000: begin o_result = add_result[31:0]; o_carry = add_result[32]; end
            4'b1000: begin o_result = sub_result[31:0]; o_carry = sub_result[32]; end
            4'b0001: o_result = i_operand_a << i_operand_b[4:0];
            4'b0010: o_result = ($signed(i_operand_a) < $signed(i_operand_b)) ? 32'h1 : 32'h0;
            4'b0011: o_result = (i_operand_a < i_operand_b) ? 32'h1 : 32'h0;
            4'b0100: o_result = i_operand_a ^ i_operand_b;
            4'b0101: o_result = i_operand_a >> i_operand_b[4:0];
            4'b1101: o_result = $signed(i_operand_a) >>> i_operand_b[4:0];
            4'b0110: o_result = i_operand_a | i_operand_b;
            4'b0111: o_result = i_operand_a & i_operand_b;
            
            4'b1010: begin // MUL
                mul_start = i_mul_enable;
                o_result  = mul_result;
            end

            default: o_result = 32'h0;
        endcase
    end
endmodule
