`timescale 1ns/1ns  

import uvm_pkg::*;
`include "uvm_macros.svh"

import param_pkg::*;
import uart_pkg::*;

module uart_top;
    bit clk_tx, clk_rx, rst;

    tx_intf #(DWIDTH) tx_vif (clk_tx, rst);
    rx_intf #(DWIDTH) rx_vif (clk_rx, rst);
    uart #(DWIDTH, PWIDTH, PRESCALE) dut(
            .clk_tx(clk_tx), 
            .clk_rx(clk_rx), 
            .rst(rst), 
            .p_data_tx(tx_vif.p_data_tx), 
            .data_valid_tx(tx_vif.data_valid_tx), 
            .parity_en(tx_vif.parity_en), 
            .parity_type(tx_vif.parity_type), 
            .busy_tx(tx_vif.busy_tx), 
            .p_data_rx(rx_vif.p_data_rx), 
            .data_valid_rx(rx_vif.data_valid_rx)
    );

    initial begin
        uvm_config_db #(virtual tx_intf #(DWIDTH))::set(null, "*", "tx_vif_name", tx_vif);
        uvm_config_db #(virtual rx_intf #(DWIDTH))::set(null, "*", "rx_vif_name", rx_vif);
        
        run_test();
    end

    initial begin
        rst = 0; #(TXPERIOD*2); rst = 1;
    end

    initial begin
        $timeformat (-9, 0," ns", 16);
        forever begin
            #(TXPERIOD/2.0);  clk_tx = ~clk_tx;
        end
    end

    initial begin
        forever begin
            #(RXPERIOD/2.0);  clk_rx = ~clk_rx;
        end
    end
endmodule :uart_top