/*###################################################################*\
##              Class Name:  rx_agent                                ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class rx_agent extends uvm_agent;
    `uvm_component_utils(rx_agent)

    
    rx_monitor      rx_mon;

    rx_agent_config             rx_agnt_config;
    uvm_active_passive_enum     is_active;

    uvm_analysis_port #(rx_sequence_item) rx_mon2agnt_port;

    function new(string name = "rx_agent", uvm_component parent);
        super.new(name, parent);

        rx_mon2agnt_port = new("rx_mon2agnt_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(rx_agent_config)::get(this, "", "rx_config_name", rx_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get rx Agent Config from configuration database!")

        is_active = rx_agnt_config.is_active;

        
        rx_mon = rx_monitor::type_id::create("rx_mon", this);
    endfunction :build_phase

    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);


        rx_mon.rx_mon_port.connect(rx_mon2agnt_port);
    endfunction :connect_phase
endclass :rx_agent