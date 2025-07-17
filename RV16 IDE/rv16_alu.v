// rv16_alu.v
// ALU with multi-cycle "fast" 3-step MUL support for RV16

module rv16_alu (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [31:0] i_operand_a,
    input  wire [31:0] i_operand_b,
    input  wire [3:0]  i_alu_op,
    input  wire        i_mul_start,
    output reg  [31:0] o_result,
    output wire        o_zero,
    output reg         o_overflow,
    output reg         o_carry,
    output wire        o_mul_busy,
    output wire        o_mul_done
);

    // Basic ALU arithmetic
    wire [32:0] add_result = {1'b0, i_operand_a} + {1'b0, i_operand_b};
    wire [32:0] sub_result = {1'b0, i_operand_a} - {1'b0, i_operand_b};
    assign o_zero = (o_result == 32'h0);

    // Internal MUL handshake and result
    reg mul_start_r;
    wire mul_start_pulse;
    wire [31:0] mul_result;
    wire mul_done, mul_busy;

    // Pulse generator for MUL start (one cycle only)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            mul_start_r <= 1'b0;
        else
            mul_start_r <= i_mul_start;
    end
    assign mul_start_pulse = i_mul_start & ~mul_start_r;

    // Instantiate multi-cycle 3-step MUL unit
    rv16_mul_unit mul_unit (
        .clk(clk),
        .rst_n(rst_n),
        .start(mul_start_pulse),
        .op_a(i_operand_a),
        .op_b(i_operand_b),
        .result(mul_result),
        .done(mul_done),
        .busy(mul_busy)
    );

    assign o_mul_busy = mul_busy;
    assign o_mul_done = mul_done;

    // Main ALU operation
    always @(*) begin
        o_result = 32'h0;
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
            4'b0001: o_result = i_operand_a << i_operand_b[4:0]; // SLL
            4'b0010: o_result = ($signed(i_operand_a) < $signed(i_operand_b)) ? 32'h1 : 32'h0; // SLT
            4'b0011: o_result = (i_operand_a < i_operand_b) ? 32'h1 : 32'h0; // SLTU
            4'b0100: o_result = i_operand_a ^ i_operand_b; // XOR
            4'b0101: o_result = i_operand_a >> i_operand_b[4:0]; // SRL
            4'b1101: o_result = $signed(i_operand_a) >>> i_operand_b[4:0]; // SRA
            4'b0110: o_result = i_operand_a | i_operand_b; // OR
            4'b0111: o_result = i_operand_a & i_operand_b; // AND
            4'b1010: o_result = mul_result; // MUL (multi-cycle)
            default: o_result = 32'h0;
        endcase
    end

endmodule
