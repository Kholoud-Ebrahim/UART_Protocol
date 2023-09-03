class uart_tx_driver  extends uvm_driver #(uart_tx_sequence_item);
    `uvm_component_utils(uart_tx_driver)

    uart_tx_sequence_item  drv_tx_item;
    virtual uart_tx_intf#(DWIDTH)   uart_tx_vif;

    // constructor
    function new(string name = "uart_tx_driver", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    // build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(virtual uart_tx_intf#(DWIDTH))::get(this, "*", "uart_tx_vif", uart_tx_vif))
            `uvm_fatal(get_type_name(), "Couldn't get handle to vif")
    endfunction :build_phase

    // run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            seq_item_port.get_next_item(drv_tx_item);

	    wait(uart_tx_vif.rst);

            wait(! uart_tx_vif.busy_tx);
            repeat(2) @(posedge uart_tx_vif.clk)begin
                uart_tx_vif.p_data_tx      <= drv_tx_item.p_data_tx;
                uart_tx_vif.parity_en_tx   <= drv_tx_item.parity_en_tx;
                uart_tx_vif.parity_type_tx <= drv_tx_item.parity_type_tx;
            end
            @(posedge uart_tx_vif.clk)
                uart_tx_vif.data_valid_tx  <= 1'b1;

            @(posedge uart_tx_vif.clk)
                uart_tx_vif.data_valid_tx  <= 1'b0;

            seq_item_port.item_done();

            repeat(3)
            @(posedge uart_tx_vif.clk);       
        end
    endtask :run_phase
endclass :uart_tx_driver