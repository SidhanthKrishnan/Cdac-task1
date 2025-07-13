// rv16c_expander.v
module rv16c_expander (
    input wire [15:0] i_compressed,
    input wire i_is_compressed,
    output reg [31:0] o_expanded
);

    always @(*) begin
        if (!i_is_compressed) begin
            o_expanded = {16'h0, i_compressed};
        end else begin
            case (i_compressed[1:0])
                2'b00: begin // Quadrant 0
                    case (i_compressed[15:13])
                        3'b000: // C.ADDI4SPN
                            o_expanded = {2'b00, i_compressed[10:7], i_compressed[12:11], 
                                        i_compressed[5], i_compressed[6], 2'b00, 5'd2, 
                                        3'b000, 2'b01, i_compressed[4:2], 7'b0010011};
                        3'b010: // C.LW
                            o_expanded = {5'b00000, i_compressed[5], i_compressed[12:10], 
                                        i_compressed[6], 2'b00, 2'b01, i_compressed[9:7], 
                                        3'b010, 2'b01, i_compressed[4:2], 7'b0000011};
                        3'b110: // C.SW
                            o_expanded = {5'b00000, i_compressed[5], i_compressed[12], 
                                        2'b01, i_compressed[4:2], 2'b01, i_compressed[9:7], 
                                        3'b010, i_compressed[11:10], i_compressed[6], 2'b00, 7'b0100011};
                        default: o_expanded = 32'h00000013; // NOP
                    endcase
                end
                2'b01: begin // Quadrant 1
                    case (i_compressed[15:13])
                        3'b000: // C.ADDI
                            o_expanded = {{{20{i_compressed[12]}}}, i_compressed[6:2], 
                                        i_compressed[11:7], 3'b000, i_compressed[11:7], 7'b0010011};
                        3'b010: // C.LI
                            o_expanded = {{{20{i_compressed[12]}}}, i_compressed[6:2], 
                                        5'd0, 3'b000, i_compressed[11:7], 7'b0010011};
                        3'b011: begin // C.LUI or C.ADDI16SP
                            if (i_compressed[11:7] == 5'd2) begin // C.ADDI16SP
                                o_expanded = {{{20{i_compressed[12]}}}, i_compressed[4:3], 
                                            i_compressed[5], i_compressed[2], i_compressed[6], 4'b0000,
                                            5'd2, 3'b000, 5'd2, 7'b0010011};
                            end else begin // C.LUI
                                o_expanded = {{{15{i_compressed[12]}}}, i_compressed[6:2], 
                                            i_compressed[11:7], 7'b0110111};
                            end
                        end
                        default: o_expanded = 32'h00000013; // NOP
                    endcase
                end
                2'b10: begin // Quadrant 2
                    case (i_compressed[15:13])
                        3'b000: // C.SLLI
                            o_expanded = {7'b0000000, i_compressed[6:2], i_compressed[11:7], 
                                        3'b001, i_compressed[11:7], 7'b0010011};
                        3'b010: // C.LWSP
                            o_expanded = {4'b0000, i_compressed[3:2], i_compressed[12], 
                                        i_compressed[6:4], 2'b00, 5'd2, 3'b010, 
                                        i_compressed[11:7], 7'b0000011};
                        3'b100: begin // C.JR, C.MV, C.JALR, C.ADD
                            if (i_compressed[12] == 1'b0) begin
                                if (i_compressed[6:2] == 5'b00000) begin // C.JR
                                    o_expanded = {12'h000, i_compressed[11:7], 3'b000, 
                                                5'b00000, 7'b1100111};
                                end else begin // C.MV
                                    o_expanded = {7'b0000000, i_compressed[6:2], 5'b00000, 
                                                3'b000, i_compressed[11:7], 7'b0110011};
                                end
                            end else begin
                                if (i_compressed[6:2] == 5'b00000) begin // C.JALR
                                    o_expanded = {12'h000, i_compressed[11:7], 3'b000, 
                                                5'b00001, 7'b1100111};
                                end else begin // C.ADD
                                    o_expanded = {7'b0000000, i_compressed[6:2], i_compressed[11:7], 
                                                3'b000, i_compressed[11:7], 7'b0110011};
                                end
                            end
                        end
                        default: o_expanded = 32'h00000013; // NOP
                    endcase
                end
                default: o_expanded = 32'h00000013; // NOP
            endcase
        end
    end

endmodule
