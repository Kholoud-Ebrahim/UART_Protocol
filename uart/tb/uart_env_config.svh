class uart_env_config extends uvm_object;
    `uvm_object_utils(uart_env_config)

    tx_agent_config          tx_env_config;
    rx_agent_config          rx_env_config;
    
    uvm_active_passive_enum  tx_env_is_active;
    uvm_active_passive_enum  rx_env_is_active;
    
    virtual tx_intf  #(DWIDTH) tx_env_vif;
    virtual rx_intf  #(DWIDTH) rx_env_vif;
    
    function new(string name = "uart_env_config");
        super.new(name);
    endfunction :new
endclass :uart_env_config