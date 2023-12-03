/*###################################################################*\
##              Package Name:   uart_pkg                             ##
##              Project Name: uart_tx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

package uart_pkg;
    import uvm_pkg::*;
    import param_pkg::*;
    `include "uvm_macros.svh"
    `include "uart_tx_sequence_item.svh"
    `include "uart_tx_base_sequence.svh"     
    `include "uart_tx_sequencer.svh"
    `include "uart_tx_driver.svh"    
    `include "uart_tx_monitor.svh"   
    `include "uart_tx_agent.svh"   
    `include "uart_tx_scoreboard.svh"   
    `include "uart_tx_coverage_collector.svh"     
    `include "uart_tx_environment.svh"   
    `include "uart_tx_test.svh" 
endpackage :uart_pkg