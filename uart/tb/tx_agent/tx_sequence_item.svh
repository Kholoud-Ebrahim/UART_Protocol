class tx_sequence_item extends uvm_sequence_item;
    rand bit [DWIDTH-1:0] p_data_tx;  //transmitter input
    rand bit parity_en;
    rand bit parity_type;

    bit data_valid_tx;
    bit busy_tx; 

    `uvm_object_utils_begin(tx_sequence_item)
        `uvm_field_int(p_data_tx     , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(data_valid_tx , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(parity_en  , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(parity_type, UVM_DEFAULT | UVM_BIN)

        `uvm_field_int(busy_tx       , UVM_DEFAULT | UVM_BIN)
    `uvm_object_utils_end

    // constructor
    function new(string name ="tx_sequence_item");
        super.new(name);
    endfunction :new
    
endclass :tx_sequence_item