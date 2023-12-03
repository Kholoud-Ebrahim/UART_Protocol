/*###################################################################*\
##              Class Name:   uart_tx_agent                          ##
##              Project Name: uart_tx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class uart_tx_agent extends uvm_agent;
    `uvm_component_utils(uart_tx_agent)

    uart_tx_sequencer uart_tx_sqr;
    uart_tx_driver    uart_tx_drv;
    uart_tx_monitor   uart_tx_mon;

    // constructor
    function new(string name = "uart_tx_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    // build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        uart_tx_sqr = uart_tx_sequencer::type_id::create("uart_tx_sqr", this);
        uart_tx_drv = uart_tx_driver   ::type_id::create("uart_tx_drv", this);
        uart_tx_mon = uart_tx_monitor  ::type_id::create("uart_tx_mon", this);
    endfunction :build_phase

    // connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        uart_tx_drv.seq_item_port.connect(uart_tx_sqr.seq_item_export);
    endfunction :connect_phase
endclass :uart_tx_agent