// rv16_register_file.v
// 32 x 32-bit register file with dual read ports
module rv16_register_file (
    input wire clk,
    input wire rst_n,
    
    // Read ports
    input wire [4:0] i_rs1_addr,
    input wire [4:0] i_rs2_addr,
    output reg [31:0] o_rs1_data,
    output reg [31:0] o_rs2_data,
    
    // Write port
    input wire [4:0] i_rd_addr,
    input wire [31:0] i_rd_data,
    input wire i_write_enable
);

    reg [31:0] registers [31:0];
    integer i;
    
    // Initialize registers
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'h0;
        end
    end
    
    // Combinational read
    always @(*) begin
        o_rs1_data = (i_rs1_addr == 5'h0) ? 32'h0 : registers[i_rs1_addr];
        o_rs2_data = (i_rs2_addr == 5'h0) ? 32'h0 : registers[i_rs2_addr];
    end
    
    // Synchronous write
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'h0;
            end
        end else begin
            if (i_write_enable && i_rd_addr != 5'h0) begin
                registers[i_rd_addr] <= i_rd_data;
            end
        end
    end

endmodule
