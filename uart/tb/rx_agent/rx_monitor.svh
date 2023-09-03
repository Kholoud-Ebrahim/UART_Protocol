class rx_monitor extends uvm_monitor;
    `uvm_component_param_utils(rx_monitor)

    rx_sequence_item           rx_mon_item;
    virtual rx_intf #(DWIDTH)  rx_vif;
    rx_agent_config            rx_mon_config;
    
    uvm_analysis_port #(rx_sequence_item) rx_mon_port;

    // constructor
    function new(string name = "rx_monitor", uvm_component parent);
        super.new(name, parent);

        rx_mon_port = new("rx_mon_port", this);
    endfunction :new

    // build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(rx_agent_config)::get(this, "", "rx_config_name", rx_mon_config)))
            `uvm_fatal(get_type_name(), "Cannot get rx Agent Config from configuration database!")
    endfunction :build_phase

    // connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        rx_vif = rx_mon_config.rx_con_vif;
    endfunction :connect_phase

    // run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            wait((rx_vif.rst));

            @(posedge rx_vif.data_valid_rx);
            rx_mon_item = rx_sequence_item::type_id::create("rx_mon_item");
            rx_mon_item.p_data_rx = rx_vif.p_data_rx;
            rx_mon_item.print();
            rx_mon_port.write(rx_mon_item);
        end
    endtask :run_phase    
endclass :rx_monitor