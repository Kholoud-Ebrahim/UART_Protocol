/*###################################################################*\
##              Class Name:  tx_agent_config                         ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class tx_agent_config extends uvm_object;
    `uvm_object_utils(tx_agent_config)

    function new (string name = "tx_agent_config");
        super.new(name);
    endfunction :new

    virtual tx_intf #(DWIDTH) tx_con_vif;
    uvm_active_passive_enum   is_active;

endclass :tx_agent_config