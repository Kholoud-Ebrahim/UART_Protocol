/*###################################################################*\
##              Module Name:  data_sampling                          ##
##              Project Name: uart_rx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

module data_sampling #(parameter PWIDTH =6)(clk, rst, prescale, edge_counter, data_sampling_en, rx_in, sampled_bit);
    input clk, rst;
    input [PWIDTH-1:0] prescale, edge_counter;
    input data_sampling_en;
    input rx_in;
    
    output reg sampled_bit;

    wire [PWIDTH-1:0]num_samples;
    reg [PWIDTH-1:0]counter, ones, zeros;
    
    assign num_samples = ( prescale >> 2 ) +1; 
    
    always@(posedge clk or negedge rst) begin
        if(!rst)
            counter <= 0;
        else if(data_sampling_en) begin
            if((edge_counter >= num_samples) && (counter != num_samples))
                counter <= counter +1;
             else
                counter <= 0;
            end
    end
    
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            ones        <= 0;
            zeros       <= 0;
            sampled_bit <= 0;
        end
        else if(data_sampling_en) begin
            if((edge_counter >= num_samples) && (counter != num_samples)) begin
                if(rx_in)
                    ones <= ones +1;
                else
                    zeros <= zeros +1;
            end
            else begin
                if(ones > zeros) begin
                    sampled_bit <= 1'b1; // the sampled bit is one
                    ones        <= 0;
                    zeros       <= 0;
                end
                else begin
                    sampled_bit <= 1'b0; // the sampled bit is zero
                    ones        <= 0;
                    zeros       <= 0;
                end
            end
        end
    end
endmodule