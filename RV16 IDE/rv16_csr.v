// rv16_csr.v
// Control and Status Register implementation
module rv16_csr (
    input wire clk,
    input wire rst_n,
    
    input wire [11:0] i_csr_addr,
    input wire [31:0] i_csr_wdata,
    input wire [2:0] i_csr_op,
    input wire i_csr_valid,
    
    output reg [31:0] o_csr_rdata,
    output reg o_csr_ready
);

    // CSR registers
    reg [31:0] mcycle, minstret, mstatus, mie, mtvec, mepc, mcause, mtval;
    reg [31:0] cycle_counter, instr_counter;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mcycle <= 32'h0;
            minstret <= 32'h0;
            mstatus <= 32'h0;
            mie <= 32'h0;
            mtvec <= 32'h0;
            mepc <= 32'h0;
            mcause <= 32'h0;
            mtval <= 32'h0;
            cycle_counter <= 32'h0;
            instr_counter <= 32'h0;
            o_csr_rdata <= 32'h0;
            o_csr_ready <= 1'b0;
        end else begin
            cycle_counter <= cycle_counter + 1;
            mcycle <= cycle_counter;
            
            if (i_csr_valid) begin
                case (i_csr_addr)
                    12'hC00: o_csr_rdata <= cycle_counter;     // cycle
                    12'hC02: o_csr_rdata <= instr_counter;     // instret
                    12'h300: o_csr_rdata <= mstatus;           // mstatus
                    12'h304: o_csr_rdata <= mie;               // mie
                    12'h305: o_csr_rdata <= mtvec;             // mtvec
                    12'h341: o_csr_rdata <= mepc;              // mepc
                    12'h342: o_csr_rdata <= mcause;            // mcause
                    12'h343: o_csr_rdata <= mtval;             // mtval
                    default: o_csr_rdata <= 32'h0;
                endcase
                
                case (i_csr_op)
                    3'b001: begin // CSRRW
                        case (i_csr_addr)
                            12'h300: mstatus <= i_csr_wdata;
                            12'h304: mie <= i_csr_wdata;
                            12'h305: mtvec <= i_csr_wdata;
                            12'h341: mepc <= i_csr_wdata;
                            12'h342: mcause <= i_csr_wdata;
                            12'h343: mtval <= i_csr_wdata;
                        endcase
                    end
                    3'b010: begin // CSRRS
                        case (i_csr_addr)
                            12'h300: mstatus <= mstatus | i_csr_wdata;
                            12'h304: mie <= mie | i_csr_wdata;
                        endcase
                    end
                    3'b011: begin // CSRRC
                        case (i_csr_addr)
                            12'h300: mstatus <= mstatus & ~i_csr_wdata;
                            12'h304: mie <= mie & ~i_csr_wdata;
                        endcase
                    end
                endcase
                
                o_csr_ready <= 1'b1;
            end else begin
                o_csr_ready <= 1'b0;
            end
        end
    end

endmodule
