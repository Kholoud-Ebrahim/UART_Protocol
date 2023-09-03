class uart_tx_base_sequence  extends uvm_sequence #(uart_tx_sequence_item);
    `uvm_object_utils(uart_tx_base_sequence)

    uart_tx_sequence_item tx_item;
    // constructor
    function new(string name = "uart_tx_base_sequence");
        super.new(name);
    endfunction :new

    // body
    task body ();
        tx_item = uart_tx_sequence_item ::type_id::create("tx_item");
        start_item(tx_item);
        assert(tx_item.randomize());
        finish_item(tx_item);
    endtask :body

endclass :uart_tx_base_sequence
