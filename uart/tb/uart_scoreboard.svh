`uvm_analysis_imp_decl(_tx)
`uvm_analysis_imp_decl(_rx)

class uart_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(uart_scoreboard)

    tx_sequence_item     tx_queue[$];
    rx_sequence_item     rx_queue[$];


    uvm_analysis_imp_tx   #(tx_sequence_item  , uart_scoreboard) tx_scb_imp;
    uvm_analysis_imp_rx   #(rx_sequence_item  , uart_scoreboard) rx_scb_imp;

    function new(string name = "uart_scoreboard", uvm_component parent);
        super.new(name, parent);
        tx_scb_imp   = new("tx_scb_imp", this);
        rx_scb_imp   = new("rx_scb_imp", this);
    endfunction :new

    function void write_tx(tx_sequence_item tx_item_f);
        tx_queue.push_front(tx_item_f);
    endfunction :write_tx

    function void write_rx(rx_sequence_item rx_item_f);
        rx_queue.push_front(rx_item_f);
    endfunction :write_rx

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            tx_sequence_item     tx_item;
            rx_sequence_item     rx_item;
            wait(tx_queue.size() != 0 && rx_queue.size() != 0);
            tx_item = tx_queue.pop_back();
            rx_item = rx_queue.pop_back();
            compare(tx_item, rx_item);
        end
                
    endtask :run_phase

    task compare(tx_sequence_item  tx_item, rx_sequence_item  rx_item);
        logic [DWIDTH-1:0] tx_in, rx_out;
        tx_in  = tx_item.p_data_tx;
        rx_out = rx_item.p_data_rx;

        COMPARE: assert(tx_in == rx_out)
            `uvm_info("COMPARE_PASSED", $sformatf("@%5t: tx_in=%0b   rx_out=%0b", $time, tx_in, rx_out), UVM_LOW)
        else
            `uvm_error("COMPARE_FAILED", $sformatf("@%5t: tx_in=%0b   rx_out=%0b", $time, tx_in,rx_out))
    endtask :compare
    
endclass :uart_scoreboard