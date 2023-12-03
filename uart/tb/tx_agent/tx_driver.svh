/*###################################################################*\
##              Class Name:  tx_driver                               ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class tx_driver extends uvm_driver #(tx_sequence_item);
    `uvm_component_utils(tx_driver)

    tx_agent_config       tx_config;
    virtual tx_intf #(DWIDTH) tx_vif;
    tx_sequence_item      tx_item;
    function new (string name = "tx_driver", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(tx_agent_config)::get(this, "", "tx_config_name", tx_config)))
            `uvm_fatal(get_type_name(), "Cannot get tx Agent Config from configuration database!")

    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        tx_vif = tx_config.tx_con_vif;
    endfunction :connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            seq_item_port.get_next_item(tx_item);
            drive(tx_item);
            seq_item_port.item_done();
        end
    endtask :run_phase

    task drive(tx_sequence_item tx_item);
        wait((tx_vif.rst));

        @(negedge tx_vif.clk_tx);
        tx_vif.data_valid_tx  <= 1;
        tx_vif.p_data_tx      <= tx_item.p_data_tx;
        tx_vif.parity_en      <= tx_item.parity_en;
        tx_vif.parity_type    <= tx_item.parity_type;

        #(TXPERIOD);
        tx_vif.data_valid_tx  <= 0;
        
        if(tx_vif.parity_en)
            #((DWIDTH+4)*(TXPERIOD));  // start, data, parity, stop, 1 cycle after this
        else
            #((DWIDTH+3)*(TXPERIOD));  // start, data, stop, 1 cycle after this
    
    endtask :drive
endclass :tx_driver