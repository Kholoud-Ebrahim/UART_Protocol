/*###################################################################*\
##              Class Name:  base_sequence                           ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class base_sequence  extends uvm_sequence #(tx_sequence_item);
    `uvm_object_utils(base_sequence)

    tx_sequence_item   tx_item;

    // constructor
    function new(string name = "base_sequence");
        super.new(name);
    endfunction :new

    // body
    task body ();
        tx_item = tx_sequence_item ::type_id::create("tx_item");
        start_item(tx_item);
        assert(tx_item.randomize());
        finish_item(tx_item);
    endtask :body

endclass :base_sequence