/*###################################################################*\
##              Class Name:  rx_sequence_item                        ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class rx_sequence_item extends uvm_sequence_item;
    bit [DWIDTH-1:0] p_data_rx;
    bit data_valid_rx;

    `uvm_object_utils_begin(rx_sequence_item)
        `uvm_field_int(p_data_rx     , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(data_valid_rx , UVM_DEFAULT | UVM_BIN)
    `uvm_object_utils_end

    // constructor
    function new(string name ="rx_sequence_item");
        super.new(name);
    endfunction :new
    
endclass :rx_sequence_item