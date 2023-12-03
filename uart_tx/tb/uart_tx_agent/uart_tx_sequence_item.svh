/*###################################################################*\
##              Class Name:   uart_tx_sequence_item                  ##
##              Project Name: uart_tx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class uart_tx_sequence_item extends uvm_sequence_item;
    rand bit [DWIDTH-1:0]p_data_tx;  //transmitter input
    rand bit parity_en_tx;
    rand bit parity_type_tx;

    bit data_valid_tx;
    bit s_data_tx;                 //transmitter output
    bit busy_tx; 

    `uvm_object_utils_begin(uart_tx_sequence_item)
        `uvm_field_int(p_data_tx     , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(data_valid_tx , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(parity_en_tx  , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(parity_type_tx, UVM_DEFAULT | UVM_BIN)

        `uvm_field_int(s_data_tx     , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(busy_tx       , UVM_DEFAULT | UVM_BIN)
    `uvm_object_utils_end

    // constructor
    function new(string name ="uart_tx_sequence_item");
        super.new(name);
    endfunction :new
    
endclass :uart_tx_sequence_item