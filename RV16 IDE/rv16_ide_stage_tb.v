`timescale 1ns / 1ps

module rv16_ide_stage_tb;

    // Clock and reset
    reg clk;
    reg rst_n;

    // Instruction fetch interface
    reg [31:0] i_fetch_data;
    reg i_fetch_valid;
    reg [31:0] i_pc;

    // Memory interface
    wire [31:0] o_mem_addr;
    wire [31:0] o_mem_wdata;
    wire o_mem_read;
    wire o_mem_write;
    wire [2:0] o_mem_size;
    reg [31:0] i_mem_rdata;
    reg i_mem_ready;

    // Branch/Jump control
    wire [31:0] o_next_pc;
    wire o_pc_update;

    // Pipeline control
    wire o_stall, o_flush;

    // Instantiate the module under test
    rv16_ide_stage uut (
        .clk(clk),
        .rst_n(rst_n),
        .i_fetch_data(i_fetch_data),
        .i_fetch_valid(i_fetch_valid),
        .i_pc(i_pc),
        .o_mem_addr(o_mem_addr),
        .o_mem_wdata(o_mem_wdata),
        .o_mem_read(o_mem_read),
        .o_mem_write(o_mem_write),
        .o_mem_size(o_mem_size),
        .i_mem_rdata(i_mem_rdata),
        .i_mem_ready(i_mem_ready),
        .o_next_pc(o_next_pc),
        .o_pc_update(o_pc_update),
        .o_stall(o_stall),
        .o_flush(o_flush)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset sequence
    initial begin
        rst_n = 0;
        i_fetch_valid = 0;
        i_fetch_data = 32'b0;
        i_pc = 32'h0;
        i_mem_rdata = 32'b0;
        i_mem_ready = 1;
        #20;
        rst_n = 1;
    end

    // Instruction encoding (RISC-V I-type & R-type)
    localparam ADD_INSTR = 32'b0000000_00010_00001_000_00011_0110011; // add x3, x1, x2
    localparam SUB_INSTR = 32'b0100000_00010_00001_000_00011_0110011; // sub x3, x1, x2
    localparam MUL_INSTR = 32'b0000001_00010_00001_000_00011_0110011; // mul x3, x1, x2
    localparam AND_INSTR = 32'b0000000_00010_00001_111_00011_0110011; // and x3, x1, x2
    localparam OR_INSTR  = 32'b0000000_00010_00001_110_00011_0110011; // or x3, x1, x2
    localparam LW_INSTR  = 32'b000000000100_00001_010_00011_0000011;  // lw x3, 4(x1)
    localparam SW_INSTR  = 32'b0000000_00011_00001_010_00100_0100011; // sw x3, 4(x1)

    // Simulate instruction memory
    reg [31:0] instr_mem [0:15];

    initial begin
        instr_mem[0] = ADD_INSTR;
        instr_mem[1] = SUB_INSTR;
        instr_mem[2] = MUL_INSTR;
        instr_mem[3] = LW_INSTR;
        instr_mem[4] = MUL_INSTR;
        instr_mem[5] = SW_INSTR;
        instr_mem[6] = OR_INSTR;
        instr_mem[7] = MUL_INSTR;
        instr_mem[8] = AND_INSTR;
    end

    reg [31:0] pc_hold;
    integer instr_index;

    always @(posedge clk) begin
        if (!rst_n) begin
            pc_hold <= 0;
            i_fetch_valid <= 0;
            instr_index <= 0;
        end else if (!o_stall) begin
            i_pc <= pc_hold;
            if (instr_index < 9) begin
                i_fetch_data <= instr_mem[instr_index];
                i_fetch_valid <= 1;
                $display("Cycle %0t: Fetching instr[%0d] = %h", $time, instr_index, instr_mem[instr_index]);
                pc_hold <= pc_hold + 4;
                instr_index <= instr_index + 1;
            end else begin
                i_fetch_valid <= 0;
            end
        end
    end

    // Pipeline tracking
    integer cycle_count = 0;

    always @(posedge clk) begin
        cycle_count = cycle_count + 1;
        if (cycle_count == 1)
            $display("Starting comprehensive instruction test...");

        if (o_stall)
            $display("Cycle %0d: Pipeline stalled", cycle_count);

        if (o_pc_update)
            $display("Cycle %0d: PC updated to %h", cycle_count, o_next_pc);

        if (!o_stall && instr_index >= 9 && cycle_count > 20)
            $finish;
    end

endmodule
