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
        forever #5 clk = ~clk; // 100 MHz clock
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

    // Simple instruction memory (only provide MUL instruction at PC=0)
    localparam MUL_INSTR = 32'b0000001_00010_00001_000_00011_0110011; 
    // encodes: mul x3, x1, x2 (funct7=0000001, rs2=2, rs1=1, rd=3, opcode=0110011)

    reg [31:0] pc_hold;

    always @(posedge clk) begin
        if (!rst_n) begin
            pc_hold <= 0;
            i_fetch_valid <= 0;
        end else if (!o_stall) begin
            i_pc <= pc_hold;
            if (pc_hold == 32'h0) begin
                i_fetch_data <= MUL_INSTR;
                i_fetch_valid <= 1;
            end else begin
                i_fetch_valid <= 0;
            end
            pc_hold <= pc_hold + 4;
        end
    end

    // Monitor pipeline stalls due to MUL multi-cycle op
    integer cycle_count = 0;

    always @(posedge clk) begin
        cycle_count = cycle_count + 1;
        if (cycle_count == 1)
            $display("Starting MUL test...");
        if (o_stall)
            $display("Cycle %0d: Pipeline stalled (likely MUL in progress)", cycle_count);
        if (o_pc_update)
            $display("Cycle %0d: PC updated to %h", cycle_count, o_next_pc);
        if (!o_stall && cycle_count > 5)
            $finish;  // end simulation after some cycles post MUL
    end

    // After simulation ends, check register file x3 value (assumed available via debug or separate logic)
    // You could add a readback port to register file for checking the result

endmodule
