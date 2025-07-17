// rv16_mul_unit_fast.v
// 3-4 cycle 32-bit multiplier using one 16x16 multiplier (matching RV16 paper's "fast" multiplier)

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

    // FSM states
    parameter IDLE   = 3'd0;
    parameter MUL_LO = 3'd1;
    parameter MUL_M1 = 3'd2;
    parameter MUL_M2 = 3'd3;
    parameter DONE   = 3'd4;

    reg [2:0] state;

    // Internal registers
    reg [31:0] a_reg, b_reg;
    reg [31:0] accum;
    reg [31:0] temp;
    reg [1:0] cycle_cnt;

    wire [15:0] a_lo = a_reg[15:0];
    wire [15:0] a_hi = a_reg[31:16];
    wire [15:0] b_lo = b_reg[15:0];
    wire [15:0] b_hi = b_reg[31:16];

    reg  [15:0] mul_a, mul_b;
    wire [31:0] mul_result = mul_a * mul_b;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= IDLE;
            result  <= 32'b0;
            done    <= 1'b0;
            busy    <= 1'b0;
            a_reg   <= 32'b0;
            b_reg   <= 32'b0;
            accum   <= 32'b0;
            temp    <= 32'b0;
            cycle_cnt <= 2'b00;
        end else begin
            done <= 1'b0; // default

            case (state)
                IDLE: begin
                    if (start) begin
                        a_reg <= op_a;
                        b_reg <= op_b;
                        busy  <= 1'b1;
                        cycle_cnt <= 2'd0;
                        accum <= 32'd0;
                        state <= MUL_LO;
                    end
                end

                MUL_LO: begin
                    mul_a <= a_lo;
                    mul_b <= b_lo;
                    temp  <= mul_result;  // store p_low
                    state <= MUL_M1;
                end

                MUL_M1: begin
                    mul_a <= a_lo;
                    mul_b <= b_hi;
                    accum <= mul_result; // m1
                    state <= MUL_M2;
                end

                MUL_M2: begin
                    mul_a <= a_hi;
                    mul_b <= b_lo;
                    accum <= accum + mul_result; // m1 + m2
                    state <= DONE;
                end

                DONE: begin
                    result <= temp + (accum << 16);
                    done   <= 1'b1;
                    busy   <= 1'b0;
                    state  <= IDLE;
                end
            endcase
        end
    end

endmodule
