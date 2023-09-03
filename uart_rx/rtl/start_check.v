module start_check (clk, rst, sampled_bit, start_check_en, start_error);
    input clk, rst, sampled_bit;
    input start_check_en;
    
    output reg start_error;
    
    always @(posedge clk, negedge rst) begin
        if(!rst)
            start_error <= 1'b0;
    
        else if (start_check_en)
            start_error <= sampled_bit; // if sampled bit is 1 so there is an error
    end
endmodule