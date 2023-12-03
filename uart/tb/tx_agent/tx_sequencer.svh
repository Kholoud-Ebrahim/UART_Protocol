/*###################################################################*\
##              Class Name:  tx_sequencer                            ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class tx_sequencer  extends uvm_sequencer #(tx_sequence_item);
    `uvm_component_utils(tx_sequencer)

    // constructor
    function new(string name = "tx_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction :new
endclass :tx_sequencer