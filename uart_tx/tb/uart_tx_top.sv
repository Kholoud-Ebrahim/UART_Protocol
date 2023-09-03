`timescale 1ns/100ps
// 200 MHz clk frequency == 5 ns clk time period 
import uvm_pkg::*;
import param_pkg::*;
import uart_pkg::*;

module uart_tx_top;
    bit clk, rst;

    uart_tx_intf#(DWIDTH) uart_tx_vif (.clk(clk), .rst(rst));
    uart_tx #(DWIDTH)rtl_tx(
            .clk(clk), 
            .rst(rst), 
            .p_data(uart_tx_vif.p_data_tx), 
            .data_valid(uart_tx_vif.data_valid_tx), 
            .parity_en(uart_tx_vif.parity_en_tx), 
            .parity_type(uart_tx_vif.parity_type_tx), 
            .s_data(uart_tx_vif.s_data_tx), 
            .busy(uart_tx_vif.busy_tx)
    );

    initial begin
        clk =0;
        forever begin  
            #(PERIOD/2.0);  clk = ~clk;    
        end
    end

    initial begin
        rst =0;
        #(PERIOD*2); rst =1;
    end

    initial begin
        run_test("uart_tx_test");
    end

    initial begin
        uvm_config_db #(virtual uart_tx_intf #(DWIDTH))::set(null, "*", "uart_tx_vif", uart_tx_vif);
    end

endmodule :uart_tx_top
