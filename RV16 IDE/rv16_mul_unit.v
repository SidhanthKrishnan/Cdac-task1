// rv16_mul_unit.v
// 3-cycle 32-bit multiplier using partial products (pure Verilog version)

module rv16_mul_unit (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        start,
    input  wire [31:0] op_a,
    input  wire [31:0] op_b,
    output reg  [31:0] result,
    output reg         done,
    output reg         busy
);

    // FSM states as parameters (Verilog-compatible)
    parameter IDLE   = 2'd0;
    parameter CYCLE1 = 2'd1;
    parameter CYCLE2 = 2'd2;
    parameter DONE   = 2'd3;

    reg [1:0] state;

    // Internal registers
    reg [31:0] a_reg, b_reg;
    reg [31:0] p_low, p_mid;

    wire [15:0] a_lo = a_reg[15:0];
    wire [15:0] a_hi = a_reg[31:16];
    wire [15:0] b_lo = b_reg[15:0];
    wire [15:0] b_hi = b_reg[31:16];

    wire [31:0] mul_lo = a_lo * b_lo;
    wire [31:0] mul_m1 = a_lo * b_hi;
    wire [31:0] mul_m2 = a_hi * b_lo;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state  <= IDLE;
            result <= 32'b0;
            done   <= 1'b0;
            busy   <= 1'b0;
            a_reg  <= 32'b0;
            b_reg  <= 32'b0;
            p_low  <= 32'b0;
            p_mid  <= 32'b0;
        end else begin
            done <= 1'b0; // clear done by default

            case (state)
                IDLE: begin
                    if (start) begin
                        a_reg <= op_a;
                        b_reg <= op_b;
                        busy  <= 1'b1;
                        state <= CYCLE1;
                    end
                end

                CYCLE1: begin
                    p_low <= mul_lo;
                    state <= CYCLE2;
                end

                CYCLE2: begin
                    p_mid <= mul_m1 + mul_m2;
                    state <= DONE;
                end

                DONE: begin
                    result <= p_low + (p_mid << 16);
                    busy   <= 1'b0;
                    done   <= 1'b1;
                    state  <= IDLE;
                end
            endcase
        end
    end

endmodule
