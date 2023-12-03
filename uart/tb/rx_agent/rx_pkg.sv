/*###################################################################*\
##              Package Name:  rx_pkg                                ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

package rx_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import param_pkg::*;

    `include "rx_agent_config.svh"
    `include "rx_sequence_item.svh"
    `include "rx_monitor.svh"
    `include "rx_agent.svh"
    
endpackage :rx_pkg