class rx_agent_config extends uvm_object;
    `uvm_object_utils(rx_agent_config)

    function new (string name = "rx_agent_config");
        super.new(name);
    endfunction :new

    virtual rx_intf #(DWIDTH) rx_con_vif;
    uvm_active_passive_enum   is_active;

endclass :rx_agent_config