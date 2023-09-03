interface tx_intf #(parameter DWIDTH = 8)(input bit clk_tx, rst);
    logic [DWIDTH-1:0] p_data_tx;  
    logic data_valid_tx;
    logic parity_en, parity_type;   
    logic busy_tx;

endinterface :tx_intf