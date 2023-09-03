class tx_monitor extends uvm_monitor;
    `uvm_component_param_utils(tx_monitor)

    tx_sequence_item           tx_mon_item;
    virtual tx_intf #(DWIDTH)  tx_vif;
    tx_agent_config            tx_mon_config;
    
    uvm_analysis_port #(tx_sequence_item) tx_mon_port;

    // constructor
    function new(string name = "tx_monitor", uvm_component parent);
        super.new(name, parent);

        tx_mon_port = new("tx_mon_port", this);
    endfunction :new

    // build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(tx_agent_config)::get(this, "*", "tx_config_name", tx_mon_config)))
            `uvm_fatal(get_type_name(), "Cannot get tx Agent Config from configuration database!")
    endfunction :build_phase

    // connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        tx_vif = tx_mon_config.tx_con_vif;
    endfunction :connect_phase

    // run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            wait((tx_vif.rst));

            @(posedge tx_vif.busy_tx);
                tx_mon_item = tx_sequence_item::type_id::create("tx_mon_item");
                tx_mon_item.p_data_tx      = tx_vif.p_data_tx;
                tx_mon_item.data_valid_tx  = tx_vif.data_valid_tx;
                tx_mon_item.parity_en      = tx_vif.parity_en;
                tx_mon_item.parity_type    = tx_vif.parity_type;

                tx_mon_item.busy_tx        = tx_vif.busy_tx; 

                tx_mon_item.print();
                tx_mon_port.write(tx_mon_item);
        end
    endtask :run_phase
endclass :tx_monitor