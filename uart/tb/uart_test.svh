class uart_test extends uvm_test;
    `uvm_component_utils (uart_test)

    uart_env          env;
    base_sequence     uart_seq;

    uart_env_config    env_config;

    uvm_active_passive_enum   tx_is_active; 
    uvm_active_passive_enum   rx_is_active; 

    virtual tx_intf   #(DWIDTH) tx_h_vif;
    virtual rx_intf   #(DWIDTH) rx_h_vif;

    // constructor
    function new(string name = "uart_test", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        env = uart_env::type_id::create("env", this);
        uart_seq = base_sequence::type_id::create("uart_seq");

        env_config = uart_env_config::type_id::create("env_config");

        if(!(uvm_config_db #(virtual tx_intf #(DWIDTH))::get(this, "", "tx_vif_name", tx_h_vif)))
            `uvm_fatal(get_full_name(),"Cannot get And VIF from configuration database!")

        if(!(uvm_config_db #(virtual rx_intf #(DWIDTH))::get(this, "", "rx_vif_name", rx_h_vif)))
            `uvm_fatal(get_full_name(),"Cannot get Or VIF from configuration database!")

        env_config.tx_env_vif   = tx_h_vif;
        env_config.rx_env_vif   = rx_h_vif;

        tx_is_active   = UVM_ACTIVE;
        rx_is_active   = UVM_PASSIVE;

        env_config.tx_env_is_active = tx_is_active;
        env_config.rx_env_is_active = rx_is_active;

        uvm_config_db #(uart_env_config)::set(this, "*", "env_config_name", env_config);
    endfunction :build_phase

    // run_phase
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)

        phase.raise_objection(this);
            repeat(100) begin
                uart_seq.start(env.tx_agnt.tx_sqr);
            end
	    #TXPERIOD;
        phase.drop_objection(this);

    endtask :run_phase

    //Printing the heirarchy of the TB components	
    function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology();
    endfunction :end_of_elaboration_phase
endclass :uart_test