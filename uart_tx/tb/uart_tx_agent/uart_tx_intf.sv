/*###################################################################*\
##              Interface Name:   uart_tx_intf                       ##
##              Project Name: uart_tx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

interface uart_tx_intf #(parameter DWIDTH = 8)(input clk, rst);

    logic [DWIDTH-1:0]p_data_tx;    //transmitter input
    logic data_valid_tx;
    logic parity_en_tx, parity_type_tx;

    logic s_data_tx;               //transmitter output
    logic busy_tx;
endinterface :uart_tx_intf