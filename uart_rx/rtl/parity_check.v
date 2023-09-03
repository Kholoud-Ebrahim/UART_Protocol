module parity_check #(parameter DWIDTH =8)(clk, rst, parity_type, parity_check_en, sampled_bit, p_data, parity_error);
    input clk, rst;
    input parity_type, parity_check_en, sampled_bit;
    input [DWIDTH-1:0] p_data;
    
    output reg parity_error;
    
    reg parity_bit;

    always @(posedge clk, negedge rst) begin
        if(!rst)
            parity_error <= 1'b0;
    
        else if (parity_check_en) begin
            if (parity_bit != sampled_bit)
                parity_error <= 1'b1;
            else
                parity_error <= 1'b0;
        end
    end
    
    always @(*) begin
        if (parity_check_en) begin
            case(parity_type)
                1'b0:    parity_bit = ^p_data;
                1'b1:    parity_bit = ~^p_data;
                default: parity_bit = 1'b0;
            endcase
        end
    end
endmodule