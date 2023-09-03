class uart_tx_test extends uvm_test;
    `uvm_component_utils (uart_tx_test)

    
    uart_tx_environment    uart_tx_env;
    uart_tx_base_sequence  uart_tx_seq;

    // constructor
    function new(string name = "uart_tx_test", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        uart_tx_env = uart_tx_environment::type_id::create("uart_tx_env", this);
        uart_tx_seq = uart_tx_base_sequence::type_id::create("uart_tx_seq");
    endfunction :build_phase

    // run_phase
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)

        phase.raise_objection(this);
            repeat(100) begin
                uart_tx_seq.start(uart_tx_env.uart_tx_agnt.uart_tx_sqr);
            end
	    #PERIOD;
        phase.drop_objection(this);

    endtask :run_phase
endclass :uart_tx_test