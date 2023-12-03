/*###################################################################*\
##              Module Name:  uart                                   ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

module uart #(parameter DWIDTH = 8, PWIDTH =6, PRESCALE = 8)
    (clk_tx, clk_rx, rst, p_data_tx, data_valid_tx, parity_en, parity_type, busy_tx, p_data_rx, data_valid_rx);
    
    input clk_tx, clk_rx, rst;
    input [DWIDTH-1:0] p_data_tx;  
    input data_valid_tx;
    input parity_en, parity_type;   
    output busy_tx;
    output [DWIDTH-1:0] p_data_rx;
    output data_valid_rx;

    wire s_data;

    uart_tx #(DWIDTH) tx(
        .clk(clk_tx), 
        .rst(rst), 
        .p_data(p_data_tx), 
        .data_valid(data_valid_tx), 
        .parity_en(parity_en), 
        .parity_type(parity_type), 
        .s_data(s_data), 
        .busy(busy_tx)
    );
    uart_rx #(DWIDTH, PWIDTH) rx(
        .clk(clk_rx), 
        .rst(rst), 
        .s_data(s_data), 
        .parity_type(parity_type), 
        .parity_en(parity_en), 
        .prescale(PRESCALE), 
        .p_data(p_data_rx), 
        .data_valid(data_valid_rx)
    );
endmodule