/*###################################################################*\
##              Class Name:   uart_tx_environment                    ##
##              Project Name: uart_tx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class uart_tx_environment  extends uvm_env;
    `uvm_component_utils (uart_tx_environment)
    
    uart_tx_agent              uart_tx_agnt;
    uart_tx_scoreboard         uart_tx_scb;
    uart_tx_coverage_collector uart_tx_cov;

    // constructor
    function new(string name = "uart_tx_environment", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        uart_tx_agnt = uart_tx_agent::type_id::create("uart_tx_agnt", this);
        uart_tx_scb  = uart_tx_scoreboard::type_id::create("uart_tx_scb", this);
        uart_tx_cov  = uart_tx_coverage_collector::type_id::create("uart_tx_cov", this);
    endfunction :build_phase

    // connect_phase
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        uart_tx_agnt.uart_tx_mon.uart_mon_port.connect(uart_tx_scb.uart_scb_imp);
        uart_tx_agnt.uart_tx_mon.uart_mon_port.connect(uart_tx_cov.uart_cov_imp);
    endfunction :connect_phase

endclass :uart_tx_environment