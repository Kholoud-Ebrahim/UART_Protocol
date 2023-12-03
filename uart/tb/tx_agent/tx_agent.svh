/*###################################################################*\
##              Class Name:  tx_agent                                ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class tx_agent extends uvm_agent;
    `uvm_component_utils(tx_agent)

    tx_sequencer    tx_sqr;
    tx_driver       tx_drv;
    tx_monitor      tx_mon;

    tx_agent_config             tx_agnt_config;
    uvm_active_passive_enum     is_active;

    uvm_analysis_port #(tx_sequence_item) tx_mon2agnt_port;

    function new(string name = "tx_agent", uvm_component parent);
        super.new(name, parent);

        tx_mon2agnt_port = new("tx_mon2agnt_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(tx_agent_config)::get(this, "", "tx_config_name", tx_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get tx Agent Config from configuration database!")

        is_active = tx_agnt_config.is_active;

        if(is_active == UVM_ACTIVE) begin
            tx_sqr = tx_sequencer::type_id::create("tx_sqr", this);
            tx_drv = tx_driver::type_id::create("tx_drv", this);
        end
        tx_mon = tx_monitor::type_id::create("tx_mon", this);
    endfunction :build_phase

    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if(is_active == UVM_ACTIVE) begin
            tx_drv.seq_item_port.connect(tx_sqr.seq_item_export);
        end

        tx_mon.tx_mon_port.connect(tx_mon2agnt_port);
    endfunction :connect_phase
endclass :tx_agent