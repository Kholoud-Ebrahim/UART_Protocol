class uart_env extends uvm_env;
    `uvm_component_utils(uart_env)
    
    tx_agent    tx_agnt;
    rx_agent    rx_agnt;

    uart_scoreboard          scb;

    uart_env_config        env_config;

    tx_agent_config          tx_config;
    rx_agent_config          rx_config;

    function new(string name = "uart_env", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        tx_agnt   = tx_agent  ::type_id::create("tx_agnt", this);
        rx_agnt   = rx_agent   ::type_id::create("rx_agnt", this);
        
        scb       = uart_scoreboard::type_id::create("scb", this);

        if(!(uvm_config_db #(uart_env_config)::get(this, "", "env_config_name", env_config)))
            `uvm_fatal(get_full_name(),"Cannot get Env Config from configuration database!")

        tx_config = tx_agent_config::type_id::create("tx_config");
        tx_config.tx_con_vif   = env_config.tx_env_vif;
        tx_config.is_active    = env_config.tx_env_is_active;
        uvm_config_db #(tx_agent_config)::set(this, "*", "tx_config_name", tx_config);
        
        rx_config  = rx_agent_config::type_id::create("rx_config");
        rx_config.rx_con_vif  = env_config.rx_env_vif;
        rx_config.is_active   = env_config.rx_env_is_active;
        uvm_config_db #(rx_agent_config)::set(this, "*", "rx_config_name",rx_config);

    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        tx_agnt.tx_mon2agnt_port.connect(scb.tx_scb_imp);
        rx_agnt.rx_mon2agnt_port.connect(scb.rx_scb_imp);

    endfunction :connect_phase
    
endclass :uart_env