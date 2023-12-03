/*###################################################################*\
##              Class Name:   uart_tx_sequencer                      ##
##              Project Name: uart_tx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class uart_tx_sequencer  extends uvm_sequencer #(uart_tx_sequence_item);
    `uvm_component_utils(uart_tx_sequencer)

    // constructor
    function new(string name = "uart_tx_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction :new
endclass :uart_tx_sequencer