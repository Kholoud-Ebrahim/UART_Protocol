/*###################################################################*\
##              Class Name:   uart_tx_monitor                        ##
##              Project Name: uart_tx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class uart_tx_monitor extends uvm_monitor;
    `uvm_component_param_utils(uart_tx_monitor)

    uart_tx_sequence_item  mon_tx_item;
    virtual uart_tx_intf #(DWIDTH)  uart_tx_vif;
    
    uvm_analysis_port #(uart_tx_sequence_item) uart_mon_port;

    // constructor
    function new(string name = "uart_tx_monitor", uvm_component parent);
        super.new(name, parent);

        uart_mon_port = new("uart_mon_port", this);
    endfunction :new

    // build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(virtual uart_tx_intf#(DWIDTH))::get(this, "*", "uart_tx_vif", uart_tx_vif))
            `uvm_fatal(get_type_name(), "Couldn't get handle to vif")
    endfunction :build_phase

    // run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            @(posedge uart_tx_vif.clk);
                mon_tx_item = uart_tx_sequence_item::type_id::create("mon_tx_item");
                mon_tx_item.p_data_tx      = uart_tx_vif.p_data_tx;
                mon_tx_item.data_valid_tx  = uart_tx_vif.data_valid_tx;
                mon_tx_item.parity_en_tx   = uart_tx_vif.parity_en_tx;
                mon_tx_item.parity_type_tx = uart_tx_vif.parity_type_tx;

                mon_tx_item.s_data_tx      = uart_tx_vif.s_data_tx;
                mon_tx_item.busy_tx        = uart_tx_vif.busy_tx;
            
            uart_mon_port.write(mon_tx_item);
        end
    endtask :run_phase
endclass :uart_tx_monitor