/*###################################################################*\
##              Package Name:  tx_pkg                                ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

package tx_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import param_pkg::*;

    `include "tx_agent_config.svh"
    `include "tx_sequence_item.svh"
    `include "tx_sequencer.svh"
    `include "tx_driver.svh"
    `include "tx_monitor.svh"
    `include "tx_agent.svh"
    
endpackage :tx_pkg