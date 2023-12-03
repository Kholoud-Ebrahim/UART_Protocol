/*###################################################################*\
##              Interface Name:  uart_rx_intf                        ##
##              Project Name: uart_rx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

interface uart_rx_intf #(parameter DWIDTH = 8, PWIDTH =6)(input clk, rst);   
    logic s_data_rx;                           //Receiver input
    logic parity_type_rx, parity_en_rx;
    logic [PWIDTH-1:0]prescale_rx;

    logic [DWIDTH-1:0]p_data_rx;               //Receiver output
    logic data_valid_rx;
endinterface :uart_rx_intf