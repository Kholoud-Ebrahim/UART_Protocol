interface rx_intf #(parameter DWIDTH = 8)(input bit clk_rx, rst);
    logic [DWIDTH-1:0] p_data_rx;
    logic data_valid_rx;

endinterface :rx_intf